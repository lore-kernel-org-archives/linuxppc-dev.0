Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64D1CB7BDE
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 00:36:57 +1100 (EST)
In-Reply-To: <20091030173749.GA855@loki.buserror.net>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
	<OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
	<20091030171607.GA781@loki.buserror.net>
	<20091030173749.GA855@loki.buserror.net>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFD5642C2D.808C2FF1-ONC1257663.004A341C-C1257663.004A6C26@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 3 Nov 2009 14:32:53 +0100
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

Scott Wood <scottwood@freescale.com> wrote on 30/10/2009 18:37:49:
>
> On Fri, Oct 30, 2009 at 12:16:07PM -0500, Scott Wood wrote:
> > On Sat, Oct 17, 2009 at 02:01:38PM +0200, Joakim Tjernlund wrote:
> > > +     mfspr r10, SPRN_SRR0
> > >       DO_8xx_CPU6(0x3780, r3)
> > >       mtspr SPRN_MD_EPN, r10
> > >       mfspr r11, SPRN_M_TWB   /* Get level 1 table entry address */
> > > -     lwz   r11, 0(r11)   /* Get the level 1 entry */
> > > +     cmplwi      cr0, r11, 0x0800
> > > +     blt-  3f      /* Branch if user space */
> > > +     lis   r11, swapper_pg_dir@h
> > > +     ori   r11, r11, swapper_pg_dir@l
> > > +     rlwimi      r11, r11, 0, 2, 19
> >
> > That rlwimi is a no-op -- I think you meant to use a different register
> > here?
> >
> > > +3:   lwz   r11, 0(r11)   /* Get the level 1 entry */
> > >       DO_8xx_CPU6(0x3b80, r3)
> > >       mtspr SPRN_MD_TWC, r11   /* Load pte table base address */
> > >       mfspr r11, SPRN_MD_TWC   /* ....and get the pte address */
> > >       lwz   r11, 0(r11)   /* Get the pte */
> > >       /* concat physical page address(r11) and page offset(r10) */
> > >       rlwimi      r11, r10, 0, 20, 31
> >
> > But r10 here contains SRR0 from above, and this is a data TLB error.
>
> Never mind that last one, forgot that you'd be wanting to load the
> instruction. :-P
>
> But the rlwimi is what's causing the machine checks.  I replaced it with:
> rlwinm   r11, r11, 0, 0x3ffff000
> rlwimi   r11, r10, 22, 0xffc
>
> and things seem to work.  You could probably replace the rlwinm by
> subtracting PAGE_OFFSET from swapper_pg_dir instead.

Just guessing here, do you mean:
	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@h
	ori	r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
	rlwimi	r11, r10, 22, 0xffc
or
	lis	r11, swapper_pg_dir@h
	ori	r11, r11, swapper_pg_dir@l
	subis	r11, r11 PAGE_OFFSET
	rlwimi	r11, r10, 22, 0xffc

 Jocke
