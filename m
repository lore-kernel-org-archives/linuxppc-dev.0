Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 45E1747545
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 03:23:07 +1100 (EST)
Date: Tue, 16 Dec 2008 19:23:05 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] powerpc: Make default kexec/crash_kernel ops implicit
Message-ID: <20081216162305.GB21749@oksana.dev.rtsoft.ru>
References: <20081216162217.GA3885@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081216162217.GA3885@oksana.dev.rtsoft.ru>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes need for each platform to specify default kexec and
crash kernel ops, thus effectively adds a working kexec support for most
boards.

Platforms that can't cope with default ops will explode in some weird
way (a hang or reboot is most likely), which means that the board's
kexec support should be fixed or blacklisted via dummy _prepare callback
returning -ENOSYS.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/kernel/machine_kexec.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 037ade7..4f797c0 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -22,6 +22,8 @@ void machine_crash_shutdown(struct pt_regs *regs)
 {
 	if (ppc_md.machine_crash_shutdown)
 		ppc_md.machine_crash_shutdown(regs);
+	else
+		default_machine_crash_shutdown(regs);
 }
 
 /*
@@ -33,11 +35,8 @@ int machine_kexec_prepare(struct kimage *image)
 {
 	if (ppc_md.machine_kexec_prepare)
 		return ppc_md.machine_kexec_prepare(image);
-	/*
-	 * Fail if platform doesn't provide its own machine_kexec_prepare
-	 * implementation.
-	 */
-	return -ENOSYS;
+	else
+		return default_machine_kexec_prepare(image);
 }
 
 void machine_kexec_cleanup(struct kimage *image)
@@ -54,13 +53,11 @@ void machine_kexec(struct kimage *image)
 {
 	if (ppc_md.machine_kexec)
 		ppc_md.machine_kexec(image);
-	else {
-		/*
-		 * Fall back to normal restart if platform doesn't provide
-		 * its own kexec function, and user insist to kexec...
-		 */
-		machine_restart(NULL);
-	}
+	else
+		default_machine_kexec(image);
+
+	/* Fall back to normal restart if we're still alive. */
+	machine_restart(NULL);
 	for(;;);
 }
 
-- 
1.5.6.5
