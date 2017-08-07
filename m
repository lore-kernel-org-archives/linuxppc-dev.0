Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQvGp2V9gzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:41:54 +1000 (AEST)
In-Reply-To: <57ed82bcd92cd4d0af7ae5113710d597a331c433.1500631040.git.ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v3,
 1/2] powernv/powerpc:Save/Restore additional SPRs for stop4 cpuidle
Message-Id: <3xQvGp1NXbz9tWT@ozlabs.org>
Date: Mon,  7 Aug 2017 20:41:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-21 at 10:41:37 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The stop4 idle state on POWER9 is a deep idle state which loses
> hypervisor resources, but whose latency is low enough that it can be
> exposed via cpuidle.
> 
> Until now, the deep idle states which lose hypervisor resources (eg:
> winkle) were only exposed via CPU-Hotplug.  Hence currently on wakeup
> from such states, barring a few SPRs which need to be restored to
> their older value, rest of the SPRS are reinitialized to their values
> corresponding to that at boot time.
> 
> When stop4 is used in the context of cpuidle, we want these additional
> SPRs to be restored to their older value, to ensure that the context
> on the CPU coming back from idle is same as it was before going idle.
> 
> In this patch, we define a SPR save area in PACA (since we have used
> up the volatile register space in the stack) and on POWER9, we restore
> SPRN_PID, SPRN_LDBAR, SPRN_FSCR, SPRN_HFSCR, SPRN_MMCRA, SPRN_MMCR1,
> SPRN_MMCR2 to the values they had before entering stop.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e1c1cfed54326fd2b17c78f0c85092

cheers
