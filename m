Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8EFC679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 07:49:53 +1000 (EST)
Date: Thu, 2 Jun 2005 14:02:45 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050602170245.GA7456@logos.cnet>
References: <20050601165054.GA2607@logos.cnet>
	<1117680392.31082.16.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1117680392.31082.16.camel@gaston>
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] handle access to non-present IO ports on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Thu, Jun 02, 2005 at 12:46:32PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2005-06-01 at 13:50 -0300, Marcelo Tosatti wrote:
> 
> Hrm... removing a PCMCIA card triggers mchecks ? that is bad... With
> "proper" PCMCIA controllers, those are swallowed properly when the card
> is removed. The eating of the machine check is a bit too hackish to my
> taste... Better is to "not do that" by making sure the legacy crap isn't
> trying  to tap unexisting ports, but then, if PCMCIA is also a
> problem... 

Well, cardmgr calls the driver's shutdown/close routine as soon as 
the card is removed. Some of those methods write to IO registers in
the process (eg net/pcmcia/pcnet_cs.c). 

I dont see any elegant change that could be done in PCMCIA.

One possibility that comes to mind would be to enforce the rule 
that drivers should not writeout in case of a removal event, 
but that does not sound feasible to me: It just looks too messy, 
however I have no good argument against it.

Well, its restricted to 8xx (maybe 32-bit PPC) with PCMCIA, so its
just not worth the trouble?

> > 1) why does the current PowerMac version covers only inb() and not outb() ?  
> > I had to add outb() exception table entries for 8xx.
> 
> Not sure, maybe historical loss ? :) You should CC paulus
> 
> > 2) Is the same wanted for other embedded PPC's? 
> 
> It's up to you. It slows down those IOs, but on the other hand, inX/outX
> aren't supposed to be very common anymore, at least not with "fast"
> devices, and the IO itself is usually an order of magnitude slower than
> doing those syncs...
> 
> > 3) How to make the misc.S exception entries and additional instructions 
> > selectable only on the platform who need it? #ifdef does not sound 
> > a good idea. 
> > 
> > Nevermind the "#ifdef CONFIG_ALL_PPC" crap - that needs to be done
> > properly.
> > 
> > 
> > Index: arch/ppc/kernel/misc.S
> > ===================================================================
> > RCS file: /mnt/test1/tslinux_mv21/linux-216/arch/ppc/kernel/misc.S,v
> > retrieving revision 1.2
> > diff -u -r1.2 misc.S
> > --- arch/ppc/kernel/misc.S	22 Oct 2003 19:34:30 -0000	1.2
> > +++ arch/ppc/kernel/misc.S	1 Jun 2005 17:59:30 -0000
> > @@ -736,8 +736,23 @@
> >  	subi	r4,r4,1
> >  	blelr-
> >  00:	lbz	r5,0(r3)
> > -	eieio
> > -	stbu	r5,1(r4)
> > +01:	eieio
> > +02:	stbu	r5,1(r4)
> > +03:	twi 0, r5, 0
> > +04:	isync
> > +05:	nop
> 
> Hrm... the "twi/isync" stuff is not valid for a store. The reason for
> doing twi here is to trigger a data dependency on the result of the load
> (to make sure the load actually happens) and the isync to make sure that
> twi has actually completed. For stores, you are stuffed... either your
> HW don't do machine checks on stores, 

Does not sound a like a good idea :)

> or you put a sync here and "hope"
> you don't have write posting along the IO chain that would cause your
> machine check to arrive too late...

Hmmm... I'll look that up. My limited testing on HW in question does not 
exhibit longer MCE delays than "twi/isync/nop" sequence - actually, it is 
always triggered during the IO access instruction itself. 

Where can I find information about write posting on 8xx? Is there a
term for it used in PPC documentation? I can't find anything...

Thanks!
