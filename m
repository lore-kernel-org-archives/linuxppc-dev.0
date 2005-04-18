Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AAE8467A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 08:27:48 +1000 (EST)
Date: Mon, 18 Apr 2005 15:27:46 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Lawrence E. Bakst" <ml@iridescent.org>
Message-ID: <20050418222746.GF25352@gate.ebshome.net>
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
	<c3d0340b0504151609397d73f7@mail.gmail.com>
	<p06210211be8997487f7c@mail.iridescent.org>
	<20050418172532.GB25352@gate.ebshome.net>
	<p06210215be89c5d708df@mail.iridescent.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p06210215be89c5d708df@mail.iridescent.org>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Interrupt prioritization on linux for ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 18, 2005 at 01:54:44PM -0700, Lawrence E. Bakst wrote:
> I'd point out that your own statements were pretty general to start 
> off with. 

Sure, because I wasn't the one who needed critical IRQs :). It really 
works this way: people who need some new facility either implement it 
themselves and submit patch or present their case which can, in 
theory, motivate someone else to implement this.

So far _none_ of the people whining about absence of critical IRQs did 
either.

Things like "It'd be nice to have this" aren't good enough :)


> I would have liked to elaborate but unfortunately the work 
> is an ongoing research effort for a client under NDA so I can't say 
> very much.

Nice.

> 
> >Also, it'd be nice if you explained how you dealt with infrastructure
> >problems I mentioned in my previous e-mail.
> 
> We didn't deal with them as we have a kind of special case. I am not 
> trying to minimize the importance of that issue in the general case.
> 
> >
> >Answering your question about "real time interrupt latency
> >constraints", I have to ask what _exact_ latencies you need, and why
> >do you think Linux can provide hard real-time guarantees?
> 
> We are trying to get to an interrupt response time of substantially 
> less than what you mention below. In this case "substantially" means 
> between 2 and 3 decimal orders of magnitude.

Are you really sure that Linux on 440GX is a good platform for 
microsecond or less IRQ latency? At this speeds, you have to worry 
about TLB misses, cache issues, etc. 

> The only point I was trying to make is that the critical interrupt 
> facility was useful to us. That was it. It's not clear to me that 
> within the constraints of how Linux works, the various 
> infrastructure issues, as well as politics, that it could be made 
> useful to others in a generalized form.

IMO, it'd be nice to have something like super-high-priority IRQs for 
some specific tasks in the kernel. However, this needs some generic 
support first, to be useful. Also, not all CPUs have something like 
Critical interrupts, so maybe simple IRQ virtualization will be more 
generic approach.

So far, I see one use for critical interrupts, which doesn't require 
such generic support - make all IRQS critical, so we can use some 
basic prioritization and vector generation.

-- 
Eugene
