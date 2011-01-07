Return-Path: <anton@samba.org>
Date: Fri, 7 Jan 2011 14:54:58 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/8] powerpc/kexec: Remove ppc_md.machine_kexec_cleanup
Message-ID: <20110107145458.3d47b7e8@kryten>
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


No one uses ppc_md.machine_kexec_cleanup, so remove it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/machdep.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/machdep.h	2011-01-07 12:51:46.682161055 +1100
+++ powerpc.git/arch/powerpc/include/asm/machdep.h	2011-01-07 12:51:51.352308248 +1100
@@ -249,9 +249,6 @@ struct machdep_calls {
 	 */
 	int (*machine_kexec_prepare)(struct kimage *image);
 
-	/* Called to handle any machine specific cleanup on image */
-	void (*machine_kexec_cleanup)(struct kimage *image);
-
 	/* Called to perform the _real_ kexec.
 	 * Do NOT allocate memory or fail here. We are past the point of
 	 * no return.
Index: powerpc.git/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/machine_kexec.c	2010-12-13 22:52:03.975251680 +1100
+++ powerpc.git/arch/powerpc/kernel/machine_kexec.c	2011-01-07 12:51:51.352308248 +1100
@@ -65,8 +65,6 @@ int machine_kexec_prepare(struct kimage
 
 void machine_kexec_cleanup(struct kimage *image)
 {
-	if (ppc_md.machine_kexec_cleanup)
-		ppc_md.machine_kexec_cleanup(image);
 }
 
 void arch_crash_save_vmcoreinfo(void)
