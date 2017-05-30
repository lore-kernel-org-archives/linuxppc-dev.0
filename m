Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcNZG42FzzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 16:12:54 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id n23so15621700pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 23:12:54 -0700 (PDT)
Date: Tue, 30 May 2017 16:12:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] powernv:idle: Decouple Timebase restore & Per-core
 SPRs restore
Message-ID: <20170530161238.08a8abe3@roar.ozlabs.ibm.com>
In-Reply-To: <d83df78bd8693f9a9814eb7b1d95537f663e47ea.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
 <d83df78bd8693f9a9814eb7b1d95537f663e47ea.1494585671.git.ego@linux.vnet.ibm.com>
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

On Tue, 16 May 2017 14:19:44 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On POWER8, in case of
>    -  nap: both timebase and hypervisor state is retained.
>    -  fast-sleep: timebase is lost. But the hypervisor state is retained.
>    -  winkle: timebase and hypervisor state is lost.
> 
> Hence, the current code for handling exit from a idle state assumes
> that if the timebase value is retained, then so is the hypervisor
> state. Thus, the current code doesn't restore per-core hypervisor
> state in such cases.
> 
> But that is no longer the case on POWER9 where we do have stop states
> in which timebase value is retained, but the hypervisor state is
> lost. So we have to ensure that the per-core hypervisor state gets
> restored in such cases.
> 
> Fix this by ensuring that even in the case when timebase is retained,
> we explicitly check if we are waking up from a deep stop that loses
> per-core hypervisor state (indicated by cr4 being eq or gt), and if
> this is the case, we restore the per-core hypervisor state.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 4898d67..afd029f 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -731,13 +731,14 @@ timebase_resync:
>  	 * Use cr3 which indicates that we are waking up with atleast partial
>  	 * hypervisor state loss to determine if TIMEBASE RESYNC is needed.
>  	 */
> -	ble	cr3,clear_lock
> +	ble	cr3,.Ltb_resynced
>  	/* Time base re-sync */
>  	bl	opal_resync_timebase;
>  	/*
> -	 * If waking up from sleep, per core state is not lost, skip to
> -	 * clear_lock.
> +	 * If waking up from sleep (POWER8), per core state
> +	 * is not lost, skip to clear_lock.
>  	 */
> +.Ltb_resynced:
>  	blt	cr4,clear_lock
>  
>  	/*

It's more that timebase was not lost, rather than resynced.
Can we just do a 'bgtl cr3,opal_resync_timebase'?

I guess cr4 branch will never be true on POWER9... I think
pnv_wakeup_tb_loss is going to end up clearer being split
into two between isa 207 and 300. But that can wait until
after POWER9 is working properly.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
