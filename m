Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EE22B6EEE
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 08:49:10 +1100 (EST)
In-Reply-To: <4B046248.7060101@freescale.com>
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091116210009.GA5113@loki.buserror.net>
	<20091116212741.GA10968@loki.buserror.net>
	<OF8A8D1539.83855DA3-ONC1257670.007D4AD1-C1257670.007DC74A@transmode.se>
	<4B01F0EB.70707@freescale.com>
	<OF735CB2F5.65B4E3F3-ONC1257671.002BB41C-C1257671.002C5E4F@transmode.se>
	<4B046248.7060101@freescale.com>
Subject: Re: [PATCH 00/10] Fix 8xx MMU/TLB
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFD94AE350.813F1695-ONC1257672.007719B8-C1257672.00778BD4@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 18 Nov 2009 22:45:45 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 18/11/2009 22:08:24:
>
> Joakim Tjernlund wrote:
> > Scott Wood <scottwood@freescale.com> wrote on 17/11/2009 01:40:11:
> >> No...  I only meant that the ITLB pinning got rid of the boot hang.
> >>
> >> When I mentioned the EFAULTs before you said, "No surprise as the it
> >> seems like the DAR decoding is broken."  I thought you meant you'd found
> >> a bug and fixed it in this respin.
> >
> > Oh, there seems to be a misunderstanding here :)
> > Lets go back a bit, you said some time ago:
> > /Quote
> >>> +3:   lwz   r11, 0(r11)       /* Get the level 1 entry */
> >>>       DO_8xx_CPU6(0x3b80, r3)
> >>>       mtspr SPRN_MD_TWC, r11       /* Load pte table base address */
> >>>       mfspr r11, SPRN_MD_TWC       /* ....and get the pte address */
> >>>       lwz   r11, 0(r11)       /* Get the pte */
> >>>       /* concat physical page address(r11) and page offset(r10) */
> >>>       rlwimi      r11, r10, 0, 20, 31
> >> But r10 here contains SRR0 from above, and this is a data TLB error.
> >
> > Never mind that last one, forgot that you'd be wanting to load the
> > instruction. :-P
> >
> > But the rlwimi is what's causing the machine checks.  I replaced it with:
> > rlwinm       r11, r11, 0, 0x3ffff000
> > rlwimi       r11, r10, 22, 0xffc
> >
> > and things seem to work.  You could probably replace the rlwinm by
> > subtracting PAGE_OFFSET from swapper_pg_dir instead.
> > /End Quote
> >
> > I read this as now everything is working, but I guess I misunderstood?
> > You still have EFAULT here?
>
> Ah, that one -- I don't recall whether it was fully working back then, or
> whether I just didn't notice the EFAULTs and was commenting more on the machine
> checks going away.
>
> In the current patchset, it's "8xx: start using dcbX instructions in various

Yeah, those are the ones that will trigger a dcbX TLB fault,
copy_tofrom_user would be my guess. Perhaps I missed something
in the conversions? That is, maybe some of these routines are plain wrong now for
8xx due to some other bug?
A small test program in user space doing some dcbX insn could shed some light?
