Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW0B0rjZzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:33:14 +1100 (AEDT)
In-Reply-To: <20170317051320.7069-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: fix idle wakeup potential to clobber registers
Message-Id: <3vnW0B0JDsz9s7v@ozlabs.org>
Date: Tue, 21 Mar 2017 22:33:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-17 at 05:13:20 UTC, Nicholas Piggin wrote:
> We concluded there may be a window where the idle wakeup code could
> get to pnv_wakeup_tb_loss (which clobbers non-volatile GPRs), but the
> hardware may set SRR1[46:47] to 01b (no state loss) which would
> result in the wakeup code failing to restore non-volatile GPRs.
> 
> I was not able to trigger this condition with trivial tests on
> real hardware or simulator, but the ISA (at least 2.07) seems to
> allow for it, and Gautham says that it can happen if there is an
> exception pending when the sleep/winkle instruction is executed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6d98ce0be541d4a3cfbb52cd75072c

cheers
