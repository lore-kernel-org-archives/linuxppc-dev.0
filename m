Return-Path: <adlai@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5AB2F2C02F4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 09:34:04 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <adlai@linux.vnet.ibm.com>;
 Tue, 14 Aug 2012 17:34:01 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5BFAB1FF003D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 17:33:34 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7ENX7mp103884
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 17:33:23 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7ENYAsn026746
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 17:34:10 -0600
Message-ID: <1344987297.4430.27.camel@footlong>
Subject: [PATCH V3 2/3] PPC64: Add support for instantiating SML from Open
 Firmware
From: Ashley Lai <adlai@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 14 Aug 2012 18:34:57 -0500
In-Reply-To: <1344986638.4430.22.camel@footlong>
References: <1344986638.4430.22.camel@footlong>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, adlai@linux.vnet.ibm.com,
 linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
 adlai@us.ibm.com, key@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch instantiate Stored Measurement Log (SML) and put the
log address and size in the device tree.

Signed-off-by: Ashley Lai <adlai@us.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |   62 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 0794a30..e144498 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1624,6 +1624,63 @@ static void __init prom_instantiate_rtas(void)
 
 #ifdef CONFIG_PPC64
 /*
+ * Allocate room for and instantiate Stored Measurement Log (SML)
+ */
+static void __init prom_instantiate_sml(void)
+{
+	phandle ibmvtpm_node;
+	ihandle ibmvtpm_inst;
+	u32 entry = 0, size = 0;
+	u64 base;
+
+	prom_debug("prom_instantiate_sml: start...\n");
+
+	ibmvtpm_node = call_prom("finddevice", 1, 1, ADDR("/ibm,vtpm"));
+	prom_debug("ibmvtpm_node: %x\n", ibmvtpm_node);
+	if (!PHANDLE_VALID(ibmvtpm_node))
+		return;
+
+	ibmvtpm_inst = call_prom("open", 1, 1, ADDR("/ibm,vtpm"));
+	if (!IHANDLE_VALID(ibmvtpm_inst)) {
+		prom_printf("opening vtpm package failed (%x)\n", ibmvtpm_inst);
+		return;
+	}
+
+	if (call_prom_ret("call-method", 2, 2, &size,
+			  ADDR("sml-get-handover-size"),
+			  ibmvtpm_inst) != 0 || size == 0) {
+		prom_printf("SML get handover size failed\n");
+		return;
+	}
+
+	base = alloc_down(size, PAGE_SIZE, 0);
+	if (base == 0)
+		prom_panic("Could not allocate memory for sml\n");
+
+	prom_printf("instantiating sml at 0x%x...", base);
+
+	if (call_prom_ret("call-method", 4, 2, &entry,
+			  ADDR("sml-handover"),
+			  ibmvtpm_inst, size, base) != 0 || entry == 0) {
+		prom_printf("SML handover failed\n");
+		return;
+	}
+	prom_printf(" done\n");
+
+	reserve_mem(base, size);
+
+	prom_setprop(ibmvtpm_node, "/ibm,vtpm", "linux,sml-base",
+		     &base, sizeof(base));
+	prom_setprop(ibmvtpm_node, "/ibm,vtpm", "linux,sml-size",
+		     &size, sizeof(size));
+
+	prom_debug("sml base     = 0x%x\n", base);
+	prom_debug("sml size     = 0x%x\n", (long)size);
+
+	prom_debug("prom_instantiate_sml: end...\n");
+}
+
+/*
  * Allocate room for and initialize TCE tables
  */
 static void __init prom_initialize_tce_table(void)
@@ -2916,6 +2973,11 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 		prom_instantiate_opal();
 #endif
 
+#ifdef CONFIG_PPC64
+	/* instantiate sml */
+	prom_instantiate_sml();
+#endif
+
 	/*
 	 * On non-powermacs, put all CPUs in spin-loops.
 	 *
-- 
1.7.1
