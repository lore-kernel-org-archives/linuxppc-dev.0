Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqvB48FpzDqgw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:25:42 +1000 (AEST)
In-Reply-To: <20170613130557.26315-5-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [04/13] powerpc/64s: msgclr when handling doorbell exceptions
Message-Id: <3wrqvB2GWmz9sDC@ozlabs.org>
Date: Mon, 19 Jun 2017 22:25:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-13 at 13:05:48 UTC, Nicholas Piggin wrote:
> msgsnd doorbell exceptions are cleared when the doorbell interrupt is
> taken. However if a doorbell exception causes a system reset interrupt
> wake from power saving state, the message is not cleared. Processing
> the doorbell from the system reset interrupt requires msgclr to avoid
> taking the exception again.
> 
> Testing this plus the previous wakup direct patch gives:
> 
>                                 original         wakeup direct     msgclr
> Different threads, same core:   315k/s           264k/s            345k/s
> Different cores:                235k/s           242k/s            242k/s
> 
> Net speedup is +10% for same core, and +3% for different core.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a9af97aa0a12c30178dd7ad9af8887

cheers
