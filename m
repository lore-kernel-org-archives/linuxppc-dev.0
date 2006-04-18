Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 310EC679F0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 19:56:28 +1000 (EST)
Date: Tue, 18 Apr 2006 11:56:23 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ppc64-soft-reset-fixes
Message-ID: <20060418095623.GA12192@suse.de>
References: <4443D738.3040704@us.ibm.com>
	<20060417231235.36546cb6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060417231235.36546cb6.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Apr 17, Andrew Morton wrote:

> David Wilder <dwilder@us.ibm.com> wrote:
> >
> >  - For the crash scenario, when a CPU hangs with interrupts disabled and 
> >  the other CPUs panic or user invoked kdump boot using sysrq-c. In this 
> >  case, the hung CPU can not be stopped and causes the kdump boot not 
> >  successful. This case can be treated as complete system hang and asks 
> >  the user to activate soft-reset if all secondary CPUs are not stopped.
> 
> It breaks `make allmodconfig':
> 
> arch/powerpc/kernel/built-in.o(.toc+0x2a00): In function `PPC64_CACHES':
> : undefined reference to `kexec_crash_image'

This change requires another patch.

It also breaks ppc32, this line is included in misc_32.S:

static inline void crash_kexec_secondary(struct pt_regs *regs) { }

Maybe the whole block should be look like that, compile tested on ppc32,
ppc64 and iseries:

---
 include/asm-powerpc/kexec.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.16/include/asm-powerpc/kexec.h
===================================================================
--- linux-2.6.16.orig/include/asm-powerpc/kexec.h
+++ linux-2.6.16/include/asm-powerpc/kexec.h
@@ -31,9 +31,8 @@
 #define KEXEC_ARCH KEXEC_ARCH_PPC
 #endif
 
-#ifdef CONFIG_KEXEC
-
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_KEXEC
 #ifdef __powerpc64__
 /*
  * This function is responsible for capturing register states if coming
@@ -124,9 +123,9 @@ extern void default_machine_crash_shutdo
 
 extern void machine_kexec_simple(struct kimage *image);
 extern void crash_kexec_secondary(struct pt_regs *regs);
-#endif /* ! __ASSEMBLY__ */
 #else
 static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 #endif /* CONFIG_KEXEC */
+#endif /* ! __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_KEXEC_H */
