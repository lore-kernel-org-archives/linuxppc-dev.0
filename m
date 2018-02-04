Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYz8h6Q31zDqD6
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 16:01:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v4.4 backport 13/16] powerpc/pseries: Query hypervisor for RFI
 flush settings
Date: Sun,  4 Feb 2018 16:00:07 +1100
Message-Id: <20180204050010.13669-14-mpe@ellerman.id.au>
In-Reply-To: <20180204050010.13669-1-mpe@ellerman.id.au>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Neuling <mikey@neuling.org>

commit 8989d56878a7735dfdb234707a2fee6faf631085 upstream.

A new hypervisor call is available which tells the guest settings
related to the RFI flush. Use it to query the appropriate flush
instruction(s), and whether the flush is required.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 36df46eaba24..dd2545fc9947 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -499,6 +499,39 @@ static void __init find_and_init_phbs(void)
 	of_pci_check_probe_only();
 }
 
+static void pseries_setup_rfi_flush(void)
+{
+	struct h_cpu_char_result result;
+	enum l1d_flush_type types;
+	bool enable;
+	long rc;
+
+	/* Enable by default */
+	enable = true;
+
+	rc = plpar_get_cpu_characteristics(&result);
+	if (rc == H_SUCCESS) {
+		types = L1D_FLUSH_NONE;
+
+		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
+			types |= L1D_FLUSH_MTTRIG;
+		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
+			types |= L1D_FLUSH_ORI;
+
+		/* Use fallback if nothing set in hcall */
+		if (types == L1D_FLUSH_NONE)
+			types = L1D_FLUSH_FALLBACK;
+
+		if (!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
+			enable = false;
+	} else {
+		/* Default to fallback if case hcall is not available */
+		types = L1D_FLUSH_FALLBACK;
+	}
+
+	setup_rfi_flush(types, enable);
+}
+
 static void __init pSeries_setup_arch(void)
 {
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
@@ -515,7 +548,9 @@ static void __init pSeries_setup_arch(void)
 
 	fwnmi_init();
 
-	/* By default, only probe PCI (can be overriden by rtas_pci) */
+	pseries_setup_rfi_flush();
+
+	/* By default, only probe PCI (can be overridden by rtas_pci) */
 	pci_add_flags(PCI_PROBE_ONLY);
 
 	/* Find and initialize PCI host bridges */
-- 
2.14.1
