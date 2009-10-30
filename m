Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FCFBB7C47
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 04:37:28 +1100 (EST)
Date: Fri, 30 Oct 2009 12:37:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
Message-ID: <20091030173749.GA855@loki.buserror.net>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
	<OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
	<20091030171607.GA781@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091030171607.GA781@loki.buserror.net>
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

On Fri, Oct 30, 2009 at 12:16:07PM -0500, Scott Wood wrote:
> On Sat, Oct 17, 2009 at 02:01:38PM +0200, Joakim Tjernlund wrote:
> > +     mfspr r10, SPRN_SRR0
> >       DO_8xx_CPU6(0x3780, r3)
> >       mtspr SPRN_MD_EPN, r10
> >       mfspr r11, SPRN_M_TWB	/* Get level 1 table entry address */
> > -     lwz   r11, 0(r11)	/* Get the level 1 entry */
> > +     cmplwi      cr0, r11, 0x0800
> > +     blt-  3f		/* Branch if user space */
> > +     lis   r11, swapper_pg_dir@h
> > +     ori   r11, r11, swapper_pg_dir@l
> > +     rlwimi      r11, r11, 0, 2, 19
> 
> That rlwimi is a no-op -- I think you meant to use a different register
> here?
> 
> > +3:   lwz   r11, 0(r11)	/* Get the level 1 entry */
> >       DO_8xx_CPU6(0x3b80, r3)
> >       mtspr SPRN_MD_TWC, r11	/* Load pte table base address */
> >       mfspr r11, SPRN_MD_TWC	/* ....and get the pte address */
> >       lwz   r11, 0(r11)	/* Get the pte */
> >       /* concat physical page address(r11) and page offset(r10) */
> >       rlwimi      r11, r10, 0, 20, 31
> 
> But r10 here contains SRR0 from above, and this is a data TLB error.

Never mind that last one, forgot that you'd be wanting to load the
instruction. :-P

But the rlwimi is what's causing the machine checks.  I replaced it with:
rlwinm	r11, r11, 0, 0x3ffff000
rlwimi	r11, r10, 22, 0xffc

and things seem to work.  You could probably replace the rlwinm by
subtracting PAGE_OFFSET from swapper_pg_dir instead.

-Scott
