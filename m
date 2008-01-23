Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8447DE1E6
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 05:42:11 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JHkY3-00010P-V2
	for linuxppc-dev@ozlabs.org; Wed, 23 Jan 2008 12:42:08 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4 v4] POWERPC: Add _nmask_and_or_msr() declartion to
	asm-powerpc/system.h
Date: Wed, 23 Jan 2008 12:42:07 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JHkY3-00010P-V2@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Prevents miscellaneous users from declaring it locally.

Signed-off-by: Jon Loeliger <jdl@freecale.com>
---
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2 --
 include/asm-powerpc/system.h                      |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index a2c04b9..d4f8bf5 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -53,8 +53,6 @@
 
 #define MPC7448HPC2_PCI_CFG_PHYS 0xfb000000
 
-extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
-
 int mpc7448_hpc2_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn)
 {
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index 87be8c3..bc9739d 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -169,6 +169,8 @@ extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern int die(const char *, struct pt_regs *, long);
 extern void _exception(int, struct pt_regs *, int, unsigned long);
+extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
+
 #ifdef CONFIG_BOOKE_WDT
 extern u32 booke_wdt_enabled;
 extern u32 booke_wdt_period;
-- 
1.5.4.rc0
