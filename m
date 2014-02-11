Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C99D92C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 13:45:53 +1100 (EST)
Message-ID: <1392086660.3996.50.camel@pasglop>
Subject: Re: [PATCH v2] powerpc ticket locks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Torsten Duwe <duwe@lst.de>
Date: Tue, 11 Feb 2014 13:44:20 +1100
In-Reply-To: <20140210155217.GF2107@lst.de>
References: <20140207165801.GC2107@lst.de>
 <1392001823.3996.21.camel@pasglop> <20140210155217.GF2107@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Linus, Al, a question for you down there about lockref "ref" size)

On Mon, 2014-02-10 at 16:52 +0100, Torsten Duwe wrote:

> What if I squeeze the bits a little?
> 4k vCPUs, and 256 physical, as a limit to stay within 32 bits?
> At the cost that unlock may become an ll/sc operation again.
> I could think about a trick against that.
> But alas, hw_cpu_id is 16 bit, which makes a lookup table neccessary :-/
> 
> Doing another round of yields for lockrefs now doesn't
> sound so bad any more.

So, the ticketpair has to be 16:16 so we can avoid the atomic on unlock

That leaves us with 32 bits to put the ref and the owner. The question
is how big the ref really has to be and can we have a reasonable failure
mode if it overflows ?

If we limit ourselves to, for example, 16-bit for the ref in lockref,
then we can have the second 32-bit split between the owner and the ref.

If we limit ourselves to 4k CPUs, then we get 4 more bits of ref ...

So the question is, is it reasonable to have the ref smaller than
32-bit...

Cheers,
Ben.
