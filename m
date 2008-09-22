Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33924DDF3F
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 07:42:07 +1000 (EST)
Message-Id: <200809222141.m8MLfVHX031273@imap1.linux-foundation.org>
Subject: [patch 1/1] powerpc: convert CONFIG_PPC_MERGE to CONFIG_PPC for
	legacy io checks
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Mon, 22 Sep 2008 14:41:31 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>

Now that arch/ppc is dead CONFIG_PPC_MERGE is always defined for all
powerpc platforms and we want to get rid of CONFIG_PPC_MERGE use
CONFIG_PPC instead.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/floppy.c           |    2 +-
 drivers/char/ipmi/ipmi_si_intf.c |    2 +-
 drivers/i2c/busses/i2c-pca-isa.c |    2 +-
 drivers/input/serio/i8042-io.h   |    2 +-
 drivers/pnp/isapnp/core.c        |    2 +-
 drivers/pnp/pnpbios/core.c       |    4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff -puN drivers/block/floppy.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks drivers/block/floppy.c
--- a/drivers/block/floppy.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks
+++ a/drivers/block/floppy.c
@@ -4165,7 +4165,7 @@ static int __init floppy_init(void)
 	int i, unit, drive;
 	int err, dr;
 
-#if defined(CONFIG_PPC_MERGE)
+#if defined(CONFIG_PPC)
 	if (check_legacy_ioport(FDC1))
 		return -ENODEV;
 #endif
diff -puN drivers/char/ipmi/ipmi_si_intf.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks drivers/char/ipmi/ipmi_si_intf.c
--- a/drivers/char/ipmi/ipmi_si_intf.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks
+++ a/drivers/char/ipmi/ipmi_si_intf.c
@@ -2695,7 +2695,7 @@ static __devinit void default_find_bmc(v
 	for (i = 0; ; i++) {
 		if (!ipmi_defaults[i].port)
 			break;
-#ifdef CONFIG_PPC_MERGE
+#ifdef CONFIG_PPC
 		if (check_legacy_ioport(ipmi_defaults[i].port))
 			continue;
 #endif
diff -puN drivers/i2c/busses/i2c-pca-isa.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks drivers/i2c/busses/i2c-pca-isa.c
--- a/drivers/i2c/busses/i2c-pca-isa.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks
+++ a/drivers/i2c/busses/i2c-pca-isa.c
@@ -126,7 +126,7 @@ static int __devinit pca_isa_probe(struc
 
 	dev_info(dev, "i/o base %#08lx. irq %d\n", base, irq);
 
-#ifdef CONFIG_PPC_MERGE
+#ifdef CONFIG_PPC
 	if (check_legacy_ioport(base)) {
 		dev_err(dev, "I/O address %#08lx is not available\n", base);
 		goto out;
diff -puN drivers/input/serio/i8042-io.h~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks drivers/input/serio/i8042-io.h
--- a/drivers/input/serio/i8042-io.h~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks
+++ a/drivers/input/serio/i8042-io.h
@@ -67,7 +67,7 @@ static inline int i8042_platform_init(vo
  * On some platforms touching the i8042 data register region can do really
  * bad things. Because of this the region is always reserved on such boxes.
  */
-#if defined(CONFIG_PPC_MERGE)
+#if defined(CONFIG_PPC)
 	if (check_legacy_ioport(I8042_DATA_REG))
 		return -ENODEV;
 #endif
diff -puN drivers/pnp/isapnp/core.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks
+++ a/drivers/pnp/isapnp/core.c
@@ -1012,7 +1012,7 @@ static int __init isapnp_init(void)
 		printk(KERN_INFO "isapnp: ISA Plug & Play support disabled\n");
 		return 0;
 	}
-#ifdef CONFIG_PPC_MERGE
+#ifdef CONFIG_PPC
 	if (check_legacy_ioport(_PIDXR) || check_legacy_ioport(_PNPWRP))
 		return -EINVAL;
 #endif
diff -puN drivers/pnp/pnpbios/core.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c~powerpc-convert-config_ppc_merge-to-config_ppc-for-legacy-io-checks
+++ a/drivers/pnp/pnpbios/core.c
@@ -519,7 +519,7 @@ static int __init pnpbios_init(void)
 {
 	int ret;
 
-#if defined(CONFIG_PPC_MERGE)
+#if defined(CONFIG_PPC)
 	if (check_legacy_ioport(PNPBIOS_BASE))
 		return -ENODEV;
 #endif
@@ -577,7 +577,7 @@ static int __init pnpbios_thread_init(vo
 {
 	struct task_struct *task;
 
-#if defined(CONFIG_PPC_MERGE)
+#if defined(CONFIG_PPC)
 	if (check_legacy_ioport(PNPBIOS_BASE))
 		return 0;
 #endif
_
