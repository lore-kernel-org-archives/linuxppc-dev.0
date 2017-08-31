Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLJ5j9HzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:08 +1000 (AEST)
In-Reply-To: <20170719065912.19183-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [v2, 1/3] powerpc/powernv: handle the platform error reboot in
 ppc_md.restart
Message-Id: <3xjgLJ2myxz9t1t@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-19 at 06:59:10 UTC, Nicholas Piggin wrote:
> Unrecovered MCE and HMI errors are sent through a special restart OPAL
> call to log the platform error. The downside is that they don't go
> through normal Linux crash paths, so they don't give much information
> to the Linux console.
> 
> Change this by providing a special crash function which does some of
> the console flushing from the panic() path before calling firmware to
> reboot.
> 
> The downside of this is a little more code to execute before reaching
> the firmware reboot. However in practice, it's critical to get the
> Linux console messages output in order to debug a problem. So this is
> a desirable tradeoff.
> 
> Note on the implementation: It is difficult to plumb a custom reboot
> handler into the panic path, because panic does a little bit too much
> work. For example, it will try to delay with the timebase, but that
> may be corrupted in some cases resulting in a hang without reaching
> the platform reboot. Another problem is that panic can invoke the
> crash dump code which is not what we want in the case of a hardware
> platform error. Long-term the best solution will be to rework the
> panic path so it can be suitable for this kind of panic, but for now
> we just duplicate a bit of the code.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b746e3e01e70d23ef53dcde1203ab7

cheers
