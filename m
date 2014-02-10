Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C9132C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 13:55:07 +1100 (EST)
Message-ID: <1392000853.3996.13.camel@pasglop>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Musta <tommusta@gmail.com>
Date: Mon, 10 Feb 2014 13:54:13 +1100
In-Reply-To: <52F3E255.5050906@gmail.com>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
 <20140206180826.GI5002@laptop.programming.kicks-ass.net>
 <52F3E255.5050906@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Torsten Duwe <duwe@lst.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-02-06 at 13:28 -0600, Tom Musta wrote:
> My read is consistent with Torsten's ... this looks like a bad idea.
> 
> Look at the RTL for sthcx. on page 692 (Power ISA V2.06) and you will
> see this:
> 
> if RESERVE then
>   if RESERVE_LENGTH = 2 then
>      ...
>   else
>      undefined_case <- 1
> else
>   ...
> 
> A legal implementation might never perform the store.

This is an area where we definitely want to check with the implementors
and if the implementations happen to do what we want (they likely do),
get the architecture changed for future chips and use it anyway.

There's a a *significant* benefit in avoiding an atomic operation in the
unlock case .

The reservation mechanism being based on a granule that is generally a
cache line, I doubt implementations will ever check the actual access
size, but we need to double check.

Cheers,
Ben.
