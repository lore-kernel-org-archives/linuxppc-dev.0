Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A24F61A08E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 16:24:40 +1100 (AEDT)
Message-ID: <1423718679.24302.3.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/3] powerpc: Don't force ENOSYS as error on syscall
 fail
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Date: Thu, 12 Feb 2015 16:24:39 +1100
In-Reply-To: <1423643778-32525-2-git-send-email-bogdan.purcareata@freescale.com>
References: <1423643778-32525-1-git-send-email-bogdan.purcareata@freescale.com>
 <1423643778-32525-2-git-send-email-bogdan.purcareata@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, pmoore@redhat.com, paulus@samba.org,
 strosake@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-11 at 08:36 +0000, Bogdan Purcareata wrote:
> In certain scenarios - e.g. seccomp filtering with ERRNO as default action -
> the system call fails for other reasons than the syscall not being available.
> The seccomp filter can be configured to store a user-defined error code on
> return from a blacklisted syscall. Don't always set ENOSYS on
> do_syscall_trace_enter failure.
> 
> v2:
> - move setting ENOSYS as errno from the syscall entry assembly to
>   do_syscall_trace_enter, only in the specific case

> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 194e46d..0111e04 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -269,7 +269,6 @@ syscall_dotrace:
>  	b	.Lsyscall_dotrace_cont
>  
>  syscall_enosys:
> -	li	r3,-ENOSYS
>  	b	syscall_exit


This still looks wrong to me.

On 64 bit we do:

	CURRENT_THREAD_INFO(r11, r1)
	ld	r10,TI_FLAGS(r11)
	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
	bne	syscall_dotrace
.Lsyscall_dotrace_cont:
	cmpldi	0,r0,NR_syscalls
	bge-	syscall_enosys
...

syscall_enosys:
	li	r3,-ENOSYS
	b	.Lsyscall_exit


Your patch removes the load of ENOSYS.

Which means if we're not doing syscall tracing, and we get an out-of-bounds
syscall number, we'll return with something random on r3. Won't we?

The 32-bit code looks more or less similar, although the label has a different
name.

cheers
