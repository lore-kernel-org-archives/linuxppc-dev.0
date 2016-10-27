Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4Pzg0GmnzDt3Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 22:38:55 +1100 (AEDT)
In-Reply-To: <20161013021714.6624-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: powerpc/64s: relocation,
 register save fixes for system reset interrupt
Message-Id: <3t4Pzf6KdDz9rxw@ozlabs.org>
Date: Thu, 27 Oct 2016 22:38:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-13-10 at 02:17:14 UTC, Nicholas Piggin wrote:
> This patch does a couple of things. First of all, powernv immediately
> explodes when running a relocated kernel, because the system reset
> exception for handling sleeps does not do correct relocated branches.
> 
> Secondly, the sleep handling code trashes the condition and cfar
> registers, which we would like to preserve for debugging purposes (for
> non-sleep case exception).
> 
> This patch changes the exception to use the standard format that saves
> registers before any tests or branches are made. It adds the test for
> idle-wakeup as an "extra" to break out of the normal exception path.
> Then it branches to a relocated idle handler that calls the various
> idle handling functions.
> 
> After this patch, POWER8 CPU simulator now boots powernv kernel that is
> running at non-zero.
> 
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fb479e44a9e240a23c2d208c2ace23

cheers
