Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltwf2Z39zDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:09 +1000 (AEST)
In-Reply-To: <20180726124244.13993-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org, npiggin@gmail.com
Subject: Re: powerpc/64s: Make rfi_flush_fallback a little more robust
Message-Id: <41ltwY3F3Hz9s9F@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-26 at 12:42:44 UTC, Michael Ellerman wrote:
> Because rfi_flush_fallback runs immediately before the return to
> userspace it currently runs with the user r1 (stack pointer). This
> means if we oops in there we will report a bad kernel stack pointer in
> the exception entry path, eg:
> 
>   Bad kernel stack pointer 7ffff7150e40 at c0000000000023b4
>   Oops: Bad kernel stack pointer, sig: 6 [#1]
>   LE SMP NR_CPUS=32 NUMA PowerNV
>   Modules linked in:
>   CPU: 0 PID: 1246 Comm: klogd Not tainted 4.18.0-rc2-gcc-7.3.1-00175-g0443f8a69ba3 #7
>   NIP:  c0000000000023b4 LR: 0000000010053e00 CTR: 0000000000000040
>   REGS: c0000000fffe7d40 TRAP: 4100   Not tainted  (4.18.0-rc2-gcc-7.3.1-00175-g0443f8a69ba3)
>   MSR:  9000000002803031 <SF,HV,VEC,VSX,FP,ME,IR,DR,LE>  CR: 44000442  XER: 20000000
>   CFAR: c00000000000bac8 IRQMASK: c0000000f1e66a80
>   GPR00: 0000000002000000 00007ffff7150e40 00007fff93a99900 0000000000000020
>   ...
>   NIP [c0000000000023b4] rfi_flush_fallback+0x34/0x80
>   LR [0000000010053e00] 0x10053e00
> 
> Although the NIP tells us where we were, and the TRAP number tells us
> what happened, it would still be nicer if we could report the actual
> exception rather than barfing about the stack pointer.
> 
> We an do that fairly simply by loading the kernel stack pointer on
> entry and restoring the user value before returning. That way we see a
> regular oops such as:
> 
>   Unrecoverable exception 4100 at c00000000000239c
>   Oops: Unrecoverable exception, sig: 6 [#1]
>   LE SMP NR_CPUS=32 NUMA PowerNV
>   Modules linked in:
>   CPU: 0 PID: 1251 Comm: klogd Not tainted 4.18.0-rc3-gcc-7.3.1-00097-g4ebfcac65acd-dirty #40
>   NIP:  c00000000000239c LR: 0000000010053e00 CTR: 0000000000000040
>   REGS: c0000000f1e17bb0 TRAP: 4100   Not tainted  (4.18.0-rc3-gcc-7.3.1-00097-g4ebfcac65acd-dirty)
>   MSR:  9000000002803031 <SF,HV,VEC,VSX,FP,ME,IR,DR,LE>  CR: 44000442  XER: 20000000
>   CFAR: c00000000000bac8 IRQMASK: 0
>   ...
>   NIP [c00000000000239c] rfi_flush_fallback+0x3c/0x80
>   LR [0000000010053e00] 0x10053e00
>   Call Trace:
>   [c0000000f1e17e30] [c00000000000b9e4] system_call+0x5c/0x70 (unreliable)
> 
> Note this shouldn't make the kernel stack pointer vulnerable to a
> meltdown attack, because it should be flushed from the cache before we
> return to userspace. The user r1 value will be in the cache, because
> we load it in the return path, but that is harmless.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/78ee9946371f5848ddfc88ab1a4386

cheers
