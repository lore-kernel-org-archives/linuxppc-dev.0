Return-Path: <groeck7@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39E1E1A001B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 02:48:41 +1000 (EST)
Received: by mail-pa0-f42.google.com with SMTP id et14so56359pad.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 09:48:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl: Add support for pci(e) machine check exception
 on E500MC / E5500
Date: Mon, 29 Sep 2014 09:48:32 -0700
Message-Id: <1412009312-7400-1-git-send-email-linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <groeck@juniper.net>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>,
 Jojy G Varghese <jojyv@juniper.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jojy G Varghese <jojyv@juniper.net>

For E500MC and E5500, a machine check exception in pci(e) memory space
crashes the kernel.

Testing shows that the MCAR(U) register is zero on a MC exception for the
E5500 core. At the same time, DEAR register has been found to have the
address of the faulty load address during an MC exception for this core.

This fix changes the current behavior to fixup the result register
and instruction pointers in the case of a load operation on a faulty
PCI address.

The changes are:
- Added the hook to pci machine check handing to the e500mc machine check
  exception handler.
- For the E5500 core, load faulting address from SPRN_DEAR register.
  As mentioned above, this is necessary because the E5500 core does not
  report the fault address in the MCAR register.

Cc: Scott Wood <scottwood@freescale.com>
Signed-off-by: Jojy G Varghese <jojyv@juniper.net>
[Guenter Roeck: updated description]
Signed-off-by: Guenter Roeck <groeck@juniper.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/kernel/traps.c   | 3 ++-
 arch/powerpc/sysdev/fsl_pci.c | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0dc43f9..ecb709b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -494,7 +494,8 @@ int machine_check_e500mc(struct pt_regs *regs)
 	int recoverable = 1;
 
 	if (reason & MCSR_LD) {
-		recoverable = fsl_rio_mcheck_exception(regs);
+		recoverable = fsl_rio_mcheck_exception(regs) ||
+			fsl_pci_mcheck_exception(regs);
 		if (recoverable == 1)
 			goto silent_out;
 	}
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index c507767..bdb956b 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1021,6 +1021,11 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 #endif
 	addr += mfspr(SPRN_MCAR);
 
+#ifdef CONFIG_E5500_CPU
+	if (mfspr(SPRN_EPCR) & SPRN_EPCR_ICM)
+		addr = PFN_PHYS(vmalloc_to_pfn((void *)mfspr(SPRN_DEAR)));
+#endif
+
 	if (is_in_pci_mem_space(addr)) {
 		if (user_mode(regs)) {
 			pagefault_disable();
-- 
1.9.1
