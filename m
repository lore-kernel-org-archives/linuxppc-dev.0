Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2BBBDDDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:35:37 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48MXutl024538
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 18:33:56 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48NZWds521940
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:35:32 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48NZW1E031307
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:35:32 -0400
Date: Tue, 8 May 2007 18:35:32 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/4] powerpc: EEH: capture and log pci state on error
Message-ID: <20070508233532.GR4452@austin.ibm.com>
References: <20070508230952.GN4452@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508230952.GN4452@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


If an EEH event is observed, capture PCI config space info about 
the device, wrap it up and pass it to the event logger.  This
pach just slots in the basic logging function. A later patch
will provide for more through data gathering. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |   43 +++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

Index: linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc7-mm2.orig/arch/powerpc/platforms/pseries/eeh.c	2007-04-26 15:37:32.000000000 -0500
+++ linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh.c	2007-04-26 16:19:28.000000000 -0500
@@ -100,6 +100,9 @@ static unsigned char slot_errbuf[RTAS_ER
 static DEFINE_SPINLOCK(slot_errbuf_lock);
 static int eeh_error_buf_size;
 
+#define EEH_PCI_REGS_LOG_LEN 4096
+static unsigned char pci_regs_buf[EEH_PCI_REGS_LOG_LEN];
+
 /* System monitoring statistics */
 static unsigned long no_device;
 static unsigned long no_dn;
@@ -115,7 +118,8 @@ static unsigned long slot_resets;
 /* --------------------------------------------------------------- */
 /* Below lies the EEH event infrastructure */
 
-void eeh_slot_error_detail (struct pci_dn *pdn, int severity)
+static void rtas_slot_error_detail(struct pci_dn *pdn, int severity,
+                                   char *driver_log, size_t loglen)
 {
 	int config_addr;
 	unsigned long flags;
@@ -133,7 +137,8 @@ void eeh_slot_error_detail (struct pci_d
 	rc = rtas_call(ibm_slot_error_detail,
 	               8, 1, NULL, config_addr,
 	               BUID_HI(pdn->phb->buid),
-	               BUID_LO(pdn->phb->buid), NULL, 0,
+	               BUID_LO(pdn->phb->buid),
+	               virt_to_phys(driver_log), loglen,
 	               virt_to_phys(slot_errbuf),
 	               eeh_error_buf_size,
 	               severity);
@@ -144,6 +149,40 @@ void eeh_slot_error_detail (struct pci_d
 }
 
 /**
+ * gather_pci_data - copy assorted PCI config space registers to buff
+ * @pdn: device to report data for
+ * @buf: point to buffer in which to log
+ * @len: amount of room in buffer
+ *
+ * This routine captures assorted PCI configuration space data,
+ * and puts them into a buffer for RTAS error logging.
+ */
+static size_t gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
+{
+	u32 cfg;
+	int n = 0;
+
+	n += scnprintf(buf+n, len-n, "%s\n", pdn->node->name);
+	rtas_read_config(pdn, PCI_VENDOR_ID, 4, &cfg);
+	n += scnprintf(buf+n, len-n, "dev/vend:%x\n", cfg);
+	rtas_read_config(pdn, PCI_COMMAND, 4, &cfg);
+	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
+
+	return n;
+}
+
+void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
+{
+	size_t loglen = 0;
+	memset(pci_regs_buf, 0, EEH_PCI_REGS_LOG_LEN);
+
+	rtas_pci_enable(pdn, EEH_THAW_MMIO);
+	loglen = gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
+
+	rtas_slot_error_detail(pdn, severity, pci_regs_buf, loglen);
+}
+
+/**
  * read_slot_reset_state - Read the reset state of a device node's slot
  * @dn: device node to read
  * @rets: array to return results in
