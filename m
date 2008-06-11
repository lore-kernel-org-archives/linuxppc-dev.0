Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/cell: disable ptcal in case of kdump reboot
Date: Wed, 11 Jun 2008 18:28:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806111828.59043.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ibm,cbe-start-ptcal rtas call transfers ownership
of a memory range to the hardware in order to do
periodic memory interface recalibration.
When we do a kexec, we need to get this page back,
so we don't step on the new kernel's toes.
We used to do this correctly in case of a user triggered
kexec, but not for kdump.

This patch disables ptcal from the cell specific
machine_crash_shutdown() callback. I also needed
to fix the pseries code that tries to install its
default_machine_crash_shutdown() code independent
of what machine we're running on.

The fix has been verified by Akira Tsukamoto, the
original reporter of the problem.

Acked-by: Akira Tsukamoto <akirat@rd.scei.sony.co.jp>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/ras.c      |    6 ++++++
 arch/powerpc/platforms/cell/ras.h      |    1 +
 arch/powerpc/platforms/cell/setup.c    |    2 +-
 arch/powerpc/platforms/pseries/kexec.c |    2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/ras.c b/arch/powerpc/platforms/cell/ras.c
index 655704a..21b313d 100644
--- a/arch/powerpc/platforms/cell/ras.c
+++ b/arch/powerpc/platforms/cell/ras.c
@@ -226,6 +226,12 @@ static int cbe_ptcal_notify_reboot(struct notifier_block *nb,
 	return cbe_ptcal_disable();
 }
 
+void cbe_machine_crash_shutdown(struct pt_regs *regs)
+{
+	cbe_ptcal_disable();
+	return default_machine_crash_shutdown(regs);
+}
+
 static struct notifier_block cbe_ptcal_reboot_notifier = {
 	.notifier_call = cbe_ptcal_notify_reboot
 };
diff --git a/arch/powerpc/platforms/cell/ras.h b/arch/powerpc/platforms/cell/ras.h
index eb7ee54..d1401f9 100644
--- a/arch/powerpc/platforms/cell/ras.h
+++ b/arch/powerpc/platforms/cell/ras.h
@@ -5,5 +5,6 @@ extern void cbe_system_error_exception(struct pt_regs *regs);
 extern void cbe_maintenance_exception(struct pt_regs *regs);
 extern void cbe_thermal_exception(struct pt_regs *regs);
 extern void cbe_ras_init(void);
+extern void cbe_machine_crash_shutdown(struct pt_regs *regs);
 
 #endif /* RAS_H */
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index ab721b5..b555030 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -292,6 +292,6 @@ define_machine(cell) {
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
+	.machine_crash_shutdown	= cbe_machine_crash_shutdown,
 #endif
 };
diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index e9dd5fe..53cbd53 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -70,4 +70,4 @@ static int __init pseries_kexec_setup(void)
 
 	return 0;
 }
-__initcall(pseries_kexec_setup);
+machine_device_initcall(pseries, pseries_kexec_setup);
-- 
1.5.4.3
