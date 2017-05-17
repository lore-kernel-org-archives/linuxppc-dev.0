Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSTfy3kblzDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 19:34:34 +1000 (AEST)
In-Reply-To: <20170508071627.21851-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Gustavo Bueno Romero <gromero@br.ibm.com>, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com,
 Breno Leitao <brenohl@br.ibm.com>
Subject: Re: [1/2] powerpc/tm: Fix FP and VMX register corruption
Message-Id: <3wSTfy2wh7z9s7w@ozlabs.org>
Date: Wed, 17 May 2017 19:34:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-08 at 07:16:26 UTC, Michael Neuling wrote:
> In this commit:
>   commit dc3106690b20305c3df06b42456fe386dd632ac9
>   Author: Cyril Bur <cyrilbur@gmail.com>
>   powerpc: tm: Always use fp_state and vr_state to store live registers
> 
> A section of code was removed that copied the current state to
> checkpointed state.  This should not have been removed.
> 
> When an FP unavailable is taken inside a transaction, we need to abort
> the transaction. This is because at the time of the tbegin, the FP
> state is bogus so the state stored in the checkpointed registers is
> incorrect. To fix this, we treclaim (to get the checkpointed GPRs) and
> then copy the thread_struct FP live state into the checkpointed
> state. We then trecheckpoint so that the FP state is correctly
> restored into the CPU.
> 
> The coping of the FP registers from live to checkpointed is what was
> missing.
> 
> This simplifies the logic slightly from the original patch.
> tm_reclaim_thread() will now always write the checkpointed FP
> state. Either the checkpointed FP statte will be written as part of
> the actual treclaim (in tm.S), or it'll be a copy of the live
> state. Which one we use is based on MSR[FP] from userspace.
> 
> Similarly for VMX.
> 
> CC: <stable@vger.kernel.org> # 4.9+
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: cyrilbur@gmail.com

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f48e91e87e67b56bef63393d1a02c6

cheers
