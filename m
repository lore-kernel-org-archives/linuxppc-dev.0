Return-Path: <benh@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1670B7D37
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jan 2010 08:33:28 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o0ULXR4s025914
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jan 2010 08:33:27 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0ULSYn11708246
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jan 2010 08:28:34 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0ULXRgA004954
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jan 2010 08:33:27 +1100
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers
	through extended ptrace interface
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
In-Reply-To: <20100130204409.GE5675@nowhere>
References: <20100124191830.GB14075@in.ibm.com>
	<1264365121.3601.43.camel@pasglop>  <20100130204409.GE5675@nowhere>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 31 Jan 2010 08:33:25 +1100
Message-ID: <1264887205.8287.5.camel@pasglop>
Mime-Version: 1.0
Cc: shaggy@linux.vnet.ibm.com, David Gibson <dwg@au1.ibm.com>,
	prasad@linux.vnet.ibm.com, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> We have one field for addr, one for len and one for the memory access
> type.
> 
> I think that those three are enough to express breakpoint ranges.
> Basically a breakpoint range is a breakpoint that can have a high
> len.
> 
> I've looked at the G2 PowerPc core breakpoint implementation, just to
> face one of such tricky examples.

BookE has a richer semantic. We have watchpoints with data value compare
for example, we also have instruction value compare for breakpoints, and
a few other niceties. There's also subtle differences between what
processor variants support.

 .../...

> > I'd rather have this more dedicated and more complete interface merged
> > for gdb's sake, and in a second step look at unifying.
> 
> 
> Perhaps. Supporting ptrace breakpoints should be an easy first
> step as it's basically the responsibility of the user to fill
> the registers, but it's a pretty limited scope work, especially you
> won't have perf support.

But we can add it later. 

> > I believe that the generic breakpoint infrastructure should not be the
> > mid-layer. IE. It cannot be made in any clean shape of form, to express
> > all of the subtle features that a given architecture or platform can
> > support and as such would always be inferior to a dedicated one.
> 
> 
> Actually I think the current interface already does, as I explained
> above.
> 
> What is broken for any other architectures than x86 is the set
> of constraints, but I can easily move it to the arch, unless
> I find a good generic solution (or a cool combination between
> both).

Again, this is all "can do" vs. "already done and working". May I point
you to Linus recent rant against magic infrastructures that try to do
everything and do nothing right ? :-) I much prefer starting with
something dedicated that does exactly what is expected, have that
upstream (and in that regard the patches are good for the next merge
window) and -then- maybe look at how some of it could be re-used for
perf.

> Not at all. It's an attempt to make a generic interface that can
> exploit at best _each_ arch specific features. 

That reminds me of the justifications for utrace :-) It might well be
but I very much doubt that is possible. In any case, it doesn't appear
to be there yet. So let's just get that stuff in so we have our
interface finally working, and we can look at doing fancy things with
perf in a second pass.

> Other than the set
> of constraints that I'm going to rework, the generic interface is powerful
> enough to host what I've seen in term of cpu breakpoints implementations
> for now. But if it's actually not and I'm missing other cases, please
> report it to me.
> 
> The reason that makes the current generic constraints x86
> oriented only is that I've only x86 boxes at home and I needed
> to make a first shot without knowing anything about other archs
> constraints, but in the long term, our motivations (Prasad's and mines)
> are definetely not archX-centric.

Cheers,
Ben.
