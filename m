Return-Path: <anton@samba.org>
Date: Fri, 7 Jan 2011 14:54:15 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 1/8] powerpc: Move all ppc_md kexec function pointers together
Message-ID: <20110107145415.4fa304eb@kryten>
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


Move all the kexec handlers together.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/machdep.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/machdep.h	2011-01-07 12:50:52.020438276 +1100
+++ powerpc.git/arch/powerpc/include/asm/machdep.h	2011-01-07 12:51:46.682161055 +1100
@@ -118,9 +118,6 @@ struct machdep_calls {
 	 * If for some reason there is no irq, but the interrupt
 	 * shouldn't be counted as spurious, return NO_IRQ_IGNORE. */
 	unsigned int	(*get_irq)(void);
-#ifdef CONFIG_KEXEC
-	void		(*kexec_cpu_down)(int crash_shutdown, int secondary);
-#endif
 
 	/* PCI stuff */
 	/* Called after scanning the bus, before allocating resources */
@@ -237,6 +234,8 @@ struct machdep_calls {
 	void (*machine_shutdown)(void);
 
 #ifdef CONFIG_KEXEC
+	void (*kexec_cpu_down)(int crash_shutdown, int secondary);
+
 	/* Called to do the minimal shutdown needed to run a kexec'd kernel
 	 * to run successfully.
 	 * XXX Should we move this one out of kexec scope?
