Return-Path: <anton@samba.org>
Date: Fri, 7 Jan 2011 14:55:36 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 3/8] powerpc/kexec: Remove ppc_md.machine_kexec
Message-ID: <20110107145536.77a9b0c5@kryten>
In-Reply-To: <20110107145255.72cf30ba@kryten>
References: <20110107145255.72cf30ba@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


No one uses ppc_md.machine_kexec, so remove it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/machdep.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/machdep.h	2011-01-07 12:51:51.352308248 +1100
+++ powerpc.git/arch/powerpc/include/asm/machdep.h	2011-01-07 12:51:54.082394288 +1100
@@ -248,12 +248,6 @@ struct machdep_calls {
 	 * claims to support kexec.
 	 */
 	int (*machine_kexec_prepare)(struct kimage *image);
-
-	/* Called to perform the _real_ kexec.
-	 * Do NOT allocate memory or fail here. We are past the point of
-	 * no return.
-	 */
-	void (*machine_kexec)(struct kimage *image);
 #endif /* CONFIG_KEXEC */
 
 #ifdef CONFIG_SUSPEND
Index: powerpc.git/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/machine_kexec.c	2011-01-07 12:51:51.352308248 +1100
+++ powerpc.git/arch/powerpc/kernel/machine_kexec.c	2011-01-07 12:51:54.082394288 +1100
@@ -85,10 +85,7 @@ void arch_crash_save_vmcoreinfo(void)
  */
 void machine_kexec(struct kimage *image)
 {
-	if (ppc_md.machine_kexec)
-		ppc_md.machine_kexec(image);
-	else
-		default_machine_kexec(image);
+	default_machine_kexec(image);
 
 	/* Fall back to normal restart if we're still alive. */
 	machine_restart(NULL);
