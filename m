Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22B581A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 14:38:35 +1100 (AEDT)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1/2] powerpc/powernv: Add OPAL IPMI interface
Message-Id: <1415245107.292477.247308883750.1.gpush@pablo>
In-Reply-To: <1415245107.292153.444216242273.0.gpush@pablo>
To: <openipmi-developer@lists.sourceforge.net>, Corey Minyard <minyard@acm.org>,
 linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 06 Nov 2014 11:38:27 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent OPAL firmare adds a couple of functions to send and receive IPMI
messages:

  https://github.com/open-power/skiboot/commit/b2a374da

This change updates the token list and wrappers to suit, and adds the
platform devices for any IPMI interfaces.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/include/asm/opal.h                |   17 +++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 ++
 arch/powerpc/platforms/powernv/opal.c          |   14 ++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9124b0e..5d073e5 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -154,6 +154,8 @@ struct opal_sg_list {
 #define OPAL_HANDLE_HMI				98
 #define OPAL_REGISTER_DUMP_REGION		101
 #define OPAL_UNREGISTER_DUMP_REGION		102
+#define OPAL_IPMI_SEND				107
+#define OPAL_IPMI_RECV				108
 
 #ifndef __ASSEMBLY__
 
@@ -452,6 +454,17 @@ struct opal_msg {
 	__be64 params[8];
 };
 
+enum {
+	OPAL_IPMI_MSG_FORMAT_VERSION_1 = 1,
+};
+
+struct opal_ipmi_msg {
+	uint8_t		version;
+	uint8_t		netfn;
+	uint8_t		cmd;
+	uint8_t		data[];
+};
+
 struct opal_machine_check_event {
 	enum OpalMCE_Version	version:8;	/* 0x00 */
 	uint8_t			in_use;		/* 0x01 */
@@ -963,6 +976,10 @@ int64_t opal_handle_hmi(void);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
+int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
+		uint64_t msg_len);
+int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
+		uint64_t *msg_len);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e9e2450..f463068 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -250,3 +250,5 @@ OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
 OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CXL_MODE);
+OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
+OPAL_CALL(opal_ipmi_recv,			OPAL_IPMI_RECV);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index b642b05..c2f873e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -623,6 +623,16 @@ static void __init opal_dump_region_init(void)
 		pr_warn("DUMP: Failed to register kernel log buffer. "
 			"rc = %d\n", rc);
 }
+
+static void opal_ipmi_init(struct device_node *opal_node)
+{
+	struct device_node *np;
+
+	for_each_child_of_node(opal_node, np)
+		if (of_device_is_compatible(np, "ibm,opal-ipmi"))
+			of_platform_device_create(np, NULL, NULL);
+}
+
 static int __init opal_init(void)
 {
 	struct device_node *np, *consoles;
@@ -686,6 +696,8 @@ static int __init opal_init(void)
 		opal_msglog_init();
 	}
 
+	opal_ipmi_init(opal_node);
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
@@ -721,6 +733,8 @@ void opal_shutdown(void)
 
 /* Export this so that test modules can use it */
 EXPORT_SYMBOL_GPL(opal_invalid_call);
+EXPORT_SYMBOL_GPL(opal_ipmi_send);
+EXPORT_SYMBOL_GPL(opal_ipmi_recv);
 
 /* Convert a region of vmalloc memory to an opal sg list */
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
