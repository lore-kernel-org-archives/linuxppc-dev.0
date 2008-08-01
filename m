Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0DD2EDDF1B
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 00:14:18 +1000 (EST)
Date: Fri, 1 Aug 2008 18:14:16 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/8] powerpc: make default kexec/crash_kernel ops implicit
Message-ID: <20080801141416.GB1161@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080801141306.GA29127@polina.dev.rtsoft.ru>
Cc: Paul Mackerras <paulus@samba.org>
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
way, which means that the board's kexec support should be fixed or
blacklisted via dummy _prepare callback returning -ENOSYS.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/kernel/machine_kexec.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index a625673..ac42cfb 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -22,6 +22,8 @@ void machine_crash_shutdown(struct pt_regs *regs)
 {
 	if (ppc_md.machine_crash_shutdown)
 		ppc_md.machine_crash_shutdown(regs);
+	else
+		return default_machine_crash_shutdown(regs);
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
@@ -54,13 +53,10 @@ void machine_kexec(struct kimage *image)
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
+	/* Fall back to normal restart if we're still alive. */
+	machine_restart(NULL);
 	for(;;);
 }
 
-- 
1.5.5.4
