Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEC6F1A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 13:19:20 +1000 (AEST)
Date: Wed, 16 Sep 2015 22:18:54 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>, Scott Wood <scottwood@freescale.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
Message-ID: <20150917031854.GA31437@gate.crashing.org>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
 <1442458212.8456.2.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442458212.8456.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 17, 2015 at 12:50:12PM +1000, Michael Ellerman wrote:
> On Wed, 2015-09-16 at 21:54 -0400, Steven Rostedt wrote:
> > This could be a symptom and not the problem. What the above shows is
> > that ftrace tried to convert the mcount at change_protection but what
> > it expected was there wasn't. Unfortunately, it doesn't state exactly
> > what it wants (that would take a arch specific function to do that, and
> > this is in generic code). But what it found was "74 66 74 70", which I
> > have no idea what type of command that is.
> 
> This is big endian, so I think that's:
> 
>   andis.  r6,r3,29808
> 
> Which is feasible.

It also says "tftp", which is intriguing if nothing else :-)


Segher
