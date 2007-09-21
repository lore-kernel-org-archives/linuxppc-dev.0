Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B054DDEAB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 16:48:35 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8L6m5SA016367
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 16:48:05 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8L6pdbU114956
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 16:51:39 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8L7lm49010720
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 17:47:48 +1000
Date: Fri, 21 Sep 2007 16:47:32 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: 44x bug: funny TLB writes?
Message-ID: <20070921064732.GB13740@localhost.localdomain>
References: <1190345652.25483.6.camel@basalt>
	<20070921054218.GA13470@localhost.localdomain>
	<1190356714.25483.19.camel@basalt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1190356714.25483.19.camel@basalt>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 01:38:34AM -0500, Hollis Blanchard wrote:
> On Fri, 2007-09-21 at 15:42 +1000, David Gibson wrote:
> > On Thu, Sep 20, 2007 at 10:34:12PM -0500, Hollis Blanchard wrote:
> > > I seem to have come across a strange bug while doing KVM development. It
> > > seems that the final tlbwe in finish_tlb (head_44x.S) is actually
> > > leaking RPN bits into the "attribute" word.
> > > 
> > > When I set a breakpoint there and press enter on the serial console, I
> > > see r12=ef600703, which is the physical address of the UART on this chip
> > > (440EP), plus the correct permission bits at the bottom.
> > > 
> > > Am I crazy? I'm not really looking to step through that assembly right
> > > now... Clearly (current) hardware is just ignoring these errant writes,
> > > but it should be fixed.
> > 
> > A quick glance at the code suggests this is indeed wrong.  Hurrah.
> > Another reason to rewrite the 44x tlb miss handling.
> 
> Just a quick fix would be fine too... ;)

I suppose.

> I'm just glad it's not a KVM bug, because when I dumped the TLB state
> and saw bizarre values I was getting really worried.
> 
> > PS.  "errant" and "error" are not cognate, even if the chip doc
> > writers think so...
> 
> According to Merriam Webster, errant 2c is "c : behaving wrongly <an
> errant child>", so I'm OK with it.

Good heavens.  No such usage mentioned in the Shorter OED, only as in
"knight errant".  You Americans and your strange language :-p.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
