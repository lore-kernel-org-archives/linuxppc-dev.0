Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wy94C3FFvzDr3R
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 14:36:59 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id f127so6709868pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:36:59 -0700 (PDT)
Date: Wed, 28 Jun 2017 14:36:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] powernv:idle: Clear r12 on wakeup from stop lite
Message-ID: <20170628143646.5e92bcb5@roar.ozlabs.ibm.com>
In-Reply-To: <1498612609-13677-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1498612609-13677-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
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

On Wed, 28 Jun 2017 06:46:49 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> pnv_wakeup_noloss expects R12 to contain SRR1 value to determine if
> the wakeup reason is an HMI in CHECK_HMI_INTERRUPT.
> 
> When we wakeup with ESL=0, SRR1 will not contain the wakeup reason, so
> there is no point setting R12 to SRR1.
> 
> However, we don't set R12 at all and R12 contains garbage, and still
> being used to check HMI assuming that it had SRR1. causing the
> OPAL msglog to be filled with the following print:
> 	HMI: Received HMI interrupt: HMER = 0x0040000000000000
> 
> This patch clears R12 after waking up from stop with ESL=EC=0, so that
> we don't accidentally enter the HMI handler in pnv_wakeup_noloss if
> the R12[42:45] corresponds to HMI as wakeup reason.
> 
> Bug existed prior to "commit 9d29250136f6 ("powerpc/64s/idle: Avoid SRR
> usage in idle sleep/wake paths")  but was never hit in practice
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Fixes: 9d29250136f6 ("powerpc/64s/idle: Avoid SRR usage in idle
> sleep/wake paths")

Thanks guys, appreciate you finding and fixing my bug :)

I think this looks like the best fix. Really minor nitpick but you
could adjust the line widths on the comment slightly (mpe might do
that when merging).

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


> ---
>  arch/powerpc/kernel/idle_book3s.S | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 1ea14b9..34794fd 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -256,6 +256,21 @@ power_enter_stop:
>  	bne	 .Lhandle_esl_ec_set
>  	IDLE_STATE_ENTER_SEQ(PPC_STOP)
>  	li	r3,0  /* Since we didn't lose state, return 0 */
> +	/*
> +	 * pnv_wakeup_noloss expects R12 to contain SRR1 value
> +	 * to determine if the wakeup reason is an HMI in
> +	 * CHECK_HMI_INTERRUPT.
> +	 *
> +	 * However, when we wakeup with ESL=0,
> +	 * SRR1 will not contain the wakeup reason,
> +	 * so there is no point setting R12 to SRR1.
> +	 *
> +	 * Further, we clear R12 here, so that we
> +	 * don't accidentally enter the HMI
> +	 * in pnv_wakeup_noloss if the
> +	 * R12[42:45] == WAKE_HMI.
> +	 */
> +	li	r12, 0
>  	b 	pnv_wakeup_noloss
>  
>  .Lhandle_esl_ec_set:
