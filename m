Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1fl40y57zDsPC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 22:04:32 +1000 (AEST)
In-Reply-To: <20170922033221.31609-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <nicholas.piggin@gmail.com>
Subject: Re: [v3] powerpc: Handle MCE on POWER9 with only DSISR bit 33 set
Message-Id: <3y1fl36stCz9tXn@ozlabs.org>
Date: Tue, 26 Sep 2017 22:04:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-22 at 03:32:21 UTC, Michael Neuling wrote:
> On POWER9 DD2.1 and below, it's possible for a paste instruction to
> cause a Machine Check Exception (MCE) where only DSISR bit 33 is
> set. This will result in the MCE handler seeing an unknown event,
> which triggers linux to crash.
> 
> We change this by detecting unknown events caused by load/stores in
> the MCE handler and marking them as handled so that we no longer
> crash.
> 
> An MCE that occurs like this is spurious, so we don't need to do
> anything in terms of servicing it. If there is something that needs to
> be serviced, the CPU will raise the MCE again with the correct DSISR
> so that it can be serviced properly.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com
> Acked-by: Balbir SIngh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d8bd9f3f0925d22726de159531bfe3

cheers
