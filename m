Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqvG4mmmzDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:25:46 +1000 (AEST)
In-Reply-To: <20170613130557.26315-8-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [07/13] powerpc/64s: idle avoid SRR usage in idle sleep/wake paths
Message-Id: <3wrqvG2sDSz9sBR@ozlabs.org>
Date: Mon, 19 Jun 2017 22:25:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-13 at 13:05:51 UTC, Nicholas Piggin wrote:
> Idle code now always runs at the 0xc... effective address whether
> in real or virtual mode. This means rfid can be ditched, along
> with a lot of SRR manipulations.
> 
> In the wakeup path, carry SRR1 around in r12. Use mtmsrd to change
> MSR states as required.
> 
> This also balances the return prediction for the idle call, by
> doing blr rather than rfid to return to the idle caller.
> 
> On POWER9, 2-process context switch on different cores, with snooze
> disabled, increases performance by 2%.

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9d29250136f60438fc0839871bae0a

cheers
