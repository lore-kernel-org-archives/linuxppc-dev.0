Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C1DDFDDE9C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:02:54 +1000 (EST)
Date: Tue, 4 Sep 2007 21:09:45 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [POWERPC] pasemi: Move pasemi_idle_init() to late_initcall()
Message-ID: <20070905020945.GF25900@lixom.net>
References: <20070905020733.GA25900@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905020733.GA25900@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit 6a30bd1e2160e921a8fb051b472dfaf068f4f386
Author: Olof Johansson <olof@lixom.net>
Date:   Tue Sep 4 21:53:30 2007 -0500

    [POWERPC] pasemi: Move pasemi_idle_init() to late_initcall()
    
    Move pasemi_idle_init() to be a late_initcall instead of being called from
    setup_arch(). This way the cpufreq driver has a chance to initialize and
    save away the boot time astate before we go to idle for the first time.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/idle.c b/arch/powerpc/platforms/pasemi/idle.c
index 3c962d5..d8e1fcc 100644
--- a/arch/powerpc/platforms/pasemi/idle.c
+++ b/arch/powerpc/platforms/pasemi/idle.c
@@ -72,8 +72,11 @@ static int pasemi_system_reset_exception(struct pt_regs *regs)
 	return 1;
 }
 
-void __init pasemi_idle_init(void)
+static int __init pasemi_idle_init(void)
 {
+	if (!machine_is(pasemi))
+		return -ENODEV;
+
 #ifndef CONFIG_PPC_PASEMI_CPUFREQ
 	printk(KERN_WARNING "No cpufreq driver, powersavings modes disabled\n");
 	current_mode = 0;
@@ -82,7 +85,10 @@ void __init pasemi_idle_init(void)
 	ppc_md.system_reset_exception = pasemi_system_reset_exception;
 	ppc_md.power_save = modes[current_mode].entry;
 	printk(KERN_INFO "Using PA6T idle loop (%s)\n", modes[current_mode].name);
+
+	return 0;
 }
+late_initcall(pasemi_idle_init);
 
 static int __init idle_param(char *p)
 {
diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 6fd2fe7..516acab 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -10,8 +10,6 @@ extern void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
 
 extern void __init alloc_iobmap_l2(void);
 
-extern void __init pasemi_idle_init(void);
-
 /* Power savings modes, implemented in asm */
 extern void idle_spin(void);
 extern void idle_doze(void);
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index fe9a5d6..5ddf40a 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -115,8 +115,6 @@ void __init pas_setup_arch(void)
 	/* Remap SDC register for doing reset */
 	/* XXXOJN This should maybe come out of the device tree */
 	reset_reg = ioremap(0xfc101100, 4);
-
-	pasemi_idle_init();
 }
 
 static int __init pas_setup_mce_regs(void)
