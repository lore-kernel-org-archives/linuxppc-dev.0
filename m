Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyKGW20yZzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 11:46:43 +1000 (AEST)
In-Reply-To: <1504180061-32345-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Pavithra Prakash <pavirampu@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/powernv: Clear LPCR[PECE1] via stop-api only for deep
 state offline
Message-Id: <3xyKGW0mggz9s78@ozlabs.org>
Date: Thu, 21 Sep 2017 11:46:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-31 at 11:47:41 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via
> stop-api only on Hotplug") clears the PECE1 bit of the LPCR via
> stop-api during CPU-Hotplug to prevent wakeup due to a decrementer on
> an offlined CPU which is in a deep stop state.
> 
> In the case where the stop-api support is found to be lacking, the
> commit 785a12afdb4a ("powerpc/powernv/idle: Disable LOSE_FULL_CONTEXT
> states when stop-api fails") disables deep states that lose hypervisor
> context. Thus in this case, the offlined CPU will be put to some
> shallow idle state.
> 
> However, we currently unconditionally clear the PECE1 in LPCR via
> stop-api during CPU-Hotplug even when deep states are disabled due to
> stop-api failure.
> 
> Fix this by clearing PECE1 of LPCR via stop-api during CPU-Hotplug
> *only* when the offlined CPU will be put to a deep state that loses
> hypervisor context.
> 
> Fixes: commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via
> stop-api only on Hotplug")
> 
> Reported-by: Pavithra Prakash <pavirampu@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Tested-by: Pavithra Prakash <pavrampu@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/5d298baa41883fc421acfd932799c0

cheers
