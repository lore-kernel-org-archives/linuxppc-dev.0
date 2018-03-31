Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CxXl70JFzF1sd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:46:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/3] powerpc/64s/idle: POWER9 ESL=0 stop avoid
 save/restore overhead
In-Reply-To: <20171117140807.22105-4-npiggin@gmail.com>
References: <20171117140807.22105-1-npiggin@gmail.com>
 <20171117140807.22105-4-npiggin@gmail.com>
Date: Sat, 31 Mar 2018 22:46:44 +1100
Message-ID: <87r2o05uxn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> When stop is executed with EC=ESL=0, it appears to execute like a
> normal instruction (resuming from NIP when woken by interrupt). So all
> the save/restore handling can be avoided completely. In particular NV
> GPRs do not have to be saved, and MSR does not have to be switched
> back to kernel MSR.
>
> So move the test for EC=ESL=0 sleep states out to power9_idle_stop,
> and return directly to the caller after stop in that case. The mtspr
> to PSSCR is moved to the top of power9_offline_stop just so it matches
> power9_idle_stop.
>
> This improves performance for ping-pong benchmark with the stop0_lite
> idle state by 2.54% for 2 threads in the same core, and 2.57% for
> different cores.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S     | 43 +++++++++++------------------------
>  arch/powerpc/platforms/powernv/idle.c |  7 +++++-
>  2 files changed, 19 insertions(+), 31 deletions(-)
>
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 07a306173c5a..6243da99b26c 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -324,31 +324,8 @@ enter_winkle:
>  /*
>   * r3 - PSSCR value corresponding to the requested stop state.
>   */
> -power_enter_stop:
> -/*
> - * Check if we are executing the lite variant with ESL=EC=0
> - */
> -	andis.   r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
> +power_enter_stop_esl:
>  	clrldi   r3,r3,60 /* r3 = Bits[60:63] = Requested Level (RL) */
> -	bne	 .Lhandle_esl_ec_set
> -	PPC_STOP
> -	li	r3,0  /* Since we didn't lose state, return 0 */

Sorry this clashed with Paul's force-SMT4 patches which I needed to
merge to enable TM workarounds.

Can you rebase?

cheers
