Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E07167B17
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 01:59:09 +1000 (EST)
Date: Wed, 8 Jun 2005 06:01:36 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050608090136.GA2593@logos.cnet>
References: <20050601165054.GA2607@logos.cnet>
	<1117680392.31082.16.camel@gaston>
	<20050602170245.GA7456@logos.cnet>
	<1117750262.31082.73.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1117750262.31082.73.camel@gaston>
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

On Fri, Jun 03, 2005 at 08:11:01AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2005-06-02 at 14:02 -0300, Marcelo Tosatti wrote:
> > Hi Ben,
> > 
> > On Thu, Jun 02, 2005 at 12:46:32PM +1000, Benjamin Herrenschmidt wrote:
> > > On Wed, 2005-06-01 at 13:50 -0300, Marcelo Tosatti wrote:
> > > 
> > > Hrm... removing a PCMCIA card triggers mchecks ? that is bad... With
> > > "proper" PCMCIA controllers, those are swallowed properly when the card
> > > is removed. The eating of the machine check is a bit too hackish to my
> > > taste... Better is to "not do that" by making sure the legacy crap isn't
> > > trying  to tap unexisting ports, but then, if PCMCIA is also a
> > > problem... 
> > 
> > Well, cardmgr calls the driver's shutdown/close routine as soon as 
> > the card is removed. Some of those methods write to IO registers in
> > the process (eg net/pcmcia/pcnet_cs.c). 
> > 
> > I dont see any elegant change that could be done in PCMCIA.
> 
> I know, the thing is, on platforms with a "classical" PCI<->PCMCIA
> bridge, the bridge will not issue machine checks when the card is
> removed. I don't know if that is possible with your HW setup, I suppose
> you are hooking PCMCIA directly to the CPU IO bus ...

I think the PCMCIA bus is hooked directly to the CPU, yes.

> > One possibility that comes to mind would be to enforce the rule 
> > that drivers should not writeout in case of a removal event,
> 
> They can't know, they get the removal even too late. The driver may be
> in the middle of writing when you remove the card. If there is no HW way
> to prevent the machine check, then you'll need software recovery.
> 
> > but that does not sound feasible to me: It just looks too messy, 
> > however I have no good argument against it.
> > 
> > Well, its restricted to 8xx (maybe 32-bit PPC) with PCMCIA, so its
> > just not worth the trouble?
> 
> Hehe... dunno.
> 
> > Hmmm... I'll look that up. My limited testing on HW in question does not 
> > exhibit longer MCE delays than "twi/isync/nop" sequence - actually, it is 
> > always triggered during the IO access instruction itself. 
> 
> I suppose the 8xx may actually be quite synchronous on IOs then...
> 
> > Where can I find information about write posting on 8xx? Is there a
> > term for it used in PPC documentation? I can't find anything...
> 
> Well, do you have a store queue ? What does the 8xx manual says about
> ordering & queueing of non cacheable loads & stores ? Maybe the chip is
> fully synchronous on IOs ?

It seems so, yes.

Section 6.1 of MPC860UM.pdf:

"All exceptions associated with memory are implemented as precise, which
means that a load/store instruction is not complete until all possible
error indications are sampled from the load/store bus.
This also imples that a store or nonspeculative load instruction is 
not issued to the load/store bus until all previous instructions have
completed."

I'll prepare a new patch reflecting this information, thanks again 
Ben.
