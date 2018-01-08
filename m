Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFhHG4YxWzF0Px
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 03:55:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
 npiggin@gmail.com, anton@samba.org, mikey@neuling.org, oohall@gmail.com,
 paulus@samba.org
Subject: [PATCH 10/11] powerpc/pseries: Query hypervisor for RFI flush settings
Date: Tue,  9 Jan 2018 03:54:52 +1100
Message-Id: <20180108165453.26066-10-mpe@ellerman.id.au>
In-Reply-To: <20180108165453.26066-1-mpe@ellerman.id.au>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Neuling <mikey@neuling.org>

A new hypervisor call is available which tells the guest settings
related to the RFI flush. Use it to query the appropriate flush
instruction(s), and whether the flush is required.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 28b286df0e91..db76963e693d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -459,6 +459,39 @@ static void __init find_and_init_phbs(void)
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
@@ -476,6 +509,8 @@ static void __init pSeries_setup_arch(void)
 
 	fwnmi_init();
 
+	pseries_setup_rfi_flush();
+
 	/* By default, only probe PCI (can be overridden by rtas_pci) */
 	pci_add_flags(PCI_PROBE_ONLY);
 
-- 
2.14.3
