Return-Path: <anton@ozlabs.org>
Date: Fri, 13 Oct 2006 11:41:00 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Never panic when taking altivec exceptions from userspace
Message-ID: <20061013014100.GA16029@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


At the moment we rely on a cpu feature bit or a firmware property to
detect altivec. If we dont have either of these and the cpu does in fact
support altivec we can cause a panic from userspace.

It seems safer to always send a signal if we manage to get an 0xf20
exception from userspace.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d9f10f2..5ed4c2c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -900,14 +900,13 @@ void kernel_fp_unavailable_exception(str
 
 void altivec_unavailable_exception(struct pt_regs *regs)
 {
-#if !defined(CONFIG_ALTIVEC)
 	if (user_mode(regs)) {
 		/* A user program has executed an altivec instruction,
 		   but this kernel doesn't support altivec. */
 		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 		return;
 	}
-#endif
+
 	printk(KERN_EMERG "Unrecoverable VMX/Altivec Unavailable Exception "
 			"%lx at %lx\n", regs->trap, regs->nip);
 	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
