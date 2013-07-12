Return-Path: <matthltc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D3522C0350
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 06:44:03 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <matthltc@linux.vnet.ibm.com>;
 Fri, 12 Jul 2013 14:44:00 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AA6C819D8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 14:43:46 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6CKhubJ149468
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 14:43:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6CKhuOS017772
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 14:43:56 -0600
Date: Thu, 11 Jul 2013 17:34:45 -0700
From: Matt Helsley <matthltc@linux.vnet.ibm.com>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/math-emu: move the flush FPU state function
 into do_mathemu
Message-ID: <20130712003445.GC14599@us.ibm.com>
References: <1373545315-9219-1-git-send-email-haokexin@gmail.com>
 <1373545315-9219-2-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373545315-9219-2-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 11, 2013 at 08:21:54PM +0800, Kevin Hao wrote:
> By doing this we can make sure that the FPU state is only flushed to
> the thread struct when it is really needed.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/kernel/traps.c  | 9 ---------
>  arch/powerpc/math-emu/math.c | 9 +++++++++
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index bf33c22..58a8065 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1131,15 +1131,6 @@ void __kprobes program_check_exception(struct pt_regs *regs)
>  	 * instruction or only on FP instructions, whether there is a
>  	 * pattern to occurrences etc. -dgibson 31/Mar/2003
>  	 */
> -
> -	/*
> -	 * If we support a HW FPU, we need to ensure the FP state
> -	 * if flushed into the thread_struct before attempting
> -	 * emulation
> -	 */
> -#ifdef CONFIG_PPC_FPU
> -	flush_fp_to_thread(current);
> -#endif
>  	switch (do_mathemu(regs)) {
>  	case 0:
>  		emulate_single_step(regs);
> diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
> index 3fe8e35..18ce6a7 100644
> --- a/arch/powerpc/math-emu/math.c
> +++ b/arch/powerpc/math-emu/math.c
> @@ -420,6 +420,15 @@ do_mathemu(struct pt_regs *regs)
>  		goto illegal;
>  	}
> 
> +	/*
> +	 * If we support a HW FPU, we need to ensure the FP state
> +	 * if flushed into the thread_struct before attempting

As long as you're moving the comment you could fix up the spelling
error: s/if/is/

Cheers,
	-Matt Helsley
