Return-Path: <srs0=qdnh=kq=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gGky2LSMzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 12:01:46 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41gGky1P5Yz8tPq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 12:01:46 +1000 (AEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41gGkx151Fz9s0R
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2018 12:01:44 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id x5-v6so9985536pgp.7
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 19:01:44 -0700 (PDT)
Date: Wed, 1 Aug 2018 12:01:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
Subject: Re: [PATCH] powerpc/64s: Make rfi_flush_fallback a little more robust
Message-ID: <20180801120137.3ae1bc8d@roar.ozlabs.ibm.com>
In-Reply-To: <20180726124244.13993-1-mpe@ellerman.id.au>
References: <20180726124244.13993-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Jul 2018 22:42:44 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

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

Yeah that's a lot nicer, thanks.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/kernel/exceptions-64s.S | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index f7cc12aa3dc6..a6fa85916273 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1518,6 +1518,8 @@ TRAMP_REAL_BEGIN(stf_barrier_fallback)
>  TRAMP_REAL_BEGIN(rfi_flush_fallback)
>  	SET_SCRATCH0(r13);
>  	GET_PACA(r13);
> +	std	r1,PACA_EXRFI+EX_R12(r13)
> +	ld	r1,PACAKSAVE(r13)
>  	std	r9,PACA_EXRFI+EX_R9(r13)
>  	std	r10,PACA_EXRFI+EX_R10(r13)
>  	std	r11,PACA_EXRFI+EX_R11(r13)
> @@ -1552,12 +1554,15 @@ TRAMP_REAL_BEGIN(rfi_flush_fallback)
>  	ld	r9,PACA_EXRFI+EX_R9(r13)
>  	ld	r10,PACA_EXRFI+EX_R10(r13)
>  	ld	r11,PACA_EXRFI+EX_R11(r13)
> +	ld	r1,PACA_EXRFI+EX_R12(r13)
>  	GET_SCRATCH0(r13);
>  	rfid
>  
>  TRAMP_REAL_BEGIN(hrfi_flush_fallback)
>  	SET_SCRATCH0(r13);
>  	GET_PACA(r13);
> +	std	r1,PACA_EXRFI+EX_R12(r13)
> +	ld	r1,PACAKSAVE(r13)
>  	std	r9,PACA_EXRFI+EX_R9(r13)
>  	std	r10,PACA_EXRFI+EX_R10(r13)
>  	std	r11,PACA_EXRFI+EX_R11(r13)
> @@ -1592,6 +1597,7 @@ TRAMP_REAL_BEGIN(hrfi_flush_fallback)
>  	ld	r9,PACA_EXRFI+EX_R9(r13)
>  	ld	r10,PACA_EXRFI+EX_R10(r13)
>  	ld	r11,PACA_EXRFI+EX_R11(r13)
> +	ld	r1,PACA_EXRFI+EX_R12(r13)
>  	GET_SCRATCH0(r13);
>  	hrfid
>  
