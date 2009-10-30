Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3720CB7BD1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 11:52:41 +1100 (EST)
In-Reply-To: <20091030001228.GA29259@loki.buserror.net>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
	<OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
	<20091030001228.GA29259@loki.buserror.net>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF47ED3DAA.117F9DD6-ONC125765F.0004813F-C125765F.0004B780@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 30 Oct 2009 01:51:31 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 30/10/2009 01:12:28:
>
> On Sat, Oct 17, 2009 at 02:01:38PM +0200, Joakim Tjernlund wrote:
> > Joakim Tjernlund/Transmode wrote on 17/10/2009 13:24:18:
> > >
> > > Rex Feany <RFeany@mrv.com> wrote on 16/10/2009 22:25:41:
> > > >
> > > > Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):
> > > >
> > > > > Right, it is the pte table walk that is blowing up.
> > > > > I just noted that 2.6 lacks a tophys() call in its table walk
> > > > > so I removed that one(there is one more tophys call but I don't think
> > > > > it should be removed).
> > > > > Try this addon patch:
> > > >
> > > > no difference
> >
> > > OK, thinking a bit more, this part should not be executed as
> > > copy_tofrom_user executes in kernel space.
> > >
> > > Any chance you can stick a HW breakpoint on FixupDAR?
> > > Perhaps there is something different with kernel
> > > virtual address to phys address?
> > > A simple topys() works in 2.4, but perhaps not in 2.6?
> > > this is the part of interest:
> > > FixupDAR: /* Entry point for dcbx workaround. */
> > >  /* fetch instruction from memory. */
> > >  mfspr r10, SPRN_SRR0
> > >  andis. r11, r10, 0x8000
> > >  tophys  (r11, r10)
> > >  beq- 139b  /* Branch if user space address */
> > > 140: lwz r11,0(r11)
> >
> > Probably better to walk the kernel page table too. Does this
> > make a difference(needs the tophys() patch I posted earlier):
>
> After applying by hand (whitespace damage), I get this and a bunch more:

OK, please send your diff to head_8xx.S. Maybe I can spot an
error, otherwise you will have to set a hw BP on fixDAR and step
through it.

 Jocke
