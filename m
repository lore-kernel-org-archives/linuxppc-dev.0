Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <102d4cdd8493017c104fda0dccc513bce056430c.1230024187.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/iseries: Kexec is known not to work on iseries
Date: Tue, 23 Dec 2008 20:23:18 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The non-zero return from the prepare callback is returned by sys_kexec_load()
to userspace, indicating that kexec is not supported on the machine.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/iseries/setup.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 70b688c..24519b9 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/kdev_t.h>
+#include <linux/kexec.h>
 #include <linux/major.h>
 #include <linux/root_dev.h>
 #include <linux/kernel.h>
@@ -638,6 +639,13 @@ static int __init iseries_probe(void)
 	return 1;
 }
 
+#ifdef CONFIG_KEXEC
+static int iseries_kexec_prepare(struct kimage *image)
+{
+	return -ENOSYS;
+}
+#endif
+
 define_machine(iseries) {
 	.name			= "iSeries",
 	.setup_arch		= iSeries_setup_arch,
@@ -658,6 +666,9 @@ define_machine(iseries) {
 	.probe			= iseries_probe,
 	.ioremap		= iseries_ioremap,
 	.iounmap		= iseries_iounmap,
+#ifdef CONFIG_KEXEC
+	.machine_kexec_prepare	= iseries_kexec_prepare,
+#endif
 	/* XXX Implement enable_pmcs for iSeries */
 };
 
-- 
1.5.3.7.1.g4e596e
