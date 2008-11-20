Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 40F42DDDEA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 03:49:04 +1100 (EST)
Subject: Re: times(2) sys call bug?
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081120103733.6f347180@zod.rchland.ibm.com>
References: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
	<20081120103733.6f347180@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 20 Nov 2008 17:49:01 +0100
Message-Id: <1227199742.5224.99.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-11-20 at 10:37 -0500, Josh Boyer wrote:
> On Thu, 20 Nov 2008 16:09:16 +0100
> "Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:
> 
> > Why does the below program end up reporting -1
> > multiple seconds when times() wrap:
> 
> http://sources.redhat.com/bugzilla/show_bug.cgi?id=5209
> 
> josh

I see, but this is a new ppc kernel bug I think.
This little hack changes the kernel sys call handling in an crude
way and then it works. Apperently the kernel thinks is an error if the
syscall returns a value between -_LAST_ERRNO and -1.
Perhaps a known bug?

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 1cbbf70..72effde 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -278,7 +278,8 @@ ret_from_syscall:
        SYNC
        MTMSRD(r10)
        lwz     r9,TI_FLAGS(r12)
-       li      r8,-_LAST_ERRNO
+       //li    r8,-_LAST_ERRNO
+       li      r8,-2
        andi.   r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
        bne-    syscall_exit_work
        cmplw   0,r3,r8
