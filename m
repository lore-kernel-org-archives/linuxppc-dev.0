Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2D82B7B7C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:04:51 +1100 (EST)
In-Reply-To: <4B01F0EB.70707@freescale.com>
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091116210009.GA5113@loki.buserror.net>
	<20091116212741.GA10968@loki.buserror.net>
	<OF8A8D1539.83855DA3-ONC1257670.007D4AD1-C1257670.007DC74A@transmode.se>
	<4B01F0EB.70707@freescale.com>
Subject: Re: [PATCH 00/10] Fix 8xx MMU/TLB
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF735CB2F5.65B4E3F3-ONC1257671.002BB41C-C1257671.002C5E4F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 17 Nov 2009 09:04:37 +0100
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



Scott Wood <scottwood@freescale.com> wrote on 17/11/2009 01:40:11:

> From:
>
> Scott Wood <scottwood@freescale.com>
>
> To:
>
> Joakim Tjernlund <joakim.tjernlund@transmode.se>
>
> Cc:
>
> "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Rex Feany <RFeany@mrv.com>
>
> Date:
>
> 17/11/2009 01:40
>
> Subject:
>
> Re: [PATCH 00/10] Fix 8xx MMU/TLB
>
> Joakim Tjernlund wrote:
> > Scott Wood <scottwood@freescale.com> wrote on 16/11/2009 22:27:41:
> >> On Mon, Nov 16, 2009 at 03:00:09PM -0600, Scott Wood wrote:
> >>> On Sun, Nov 15, 2009 at 06:09:27PM +0100, Joakim Tjernlund wrote:
> >>>> [I used the wrong branch, this will hopefully not conflict]
> >>>>
> >>>> This is hopfully the last iteration of the series.
> >>>> Rex & Scott, please test and signoff.
> >>>> Changes since last version:
> >>>>  - Added mandatory pinning of iTLB
> >>>>  - Added "DTLB Miss cleanup"
> >>> I still get the EFAULTs.
> >
> > umm, this worked before this series with your own
> > version, right?
>
> No...  I only meant that the ITLB pinning got rid of the boot hang.
>
> When I mentioned the EFAULTs before you said, "No surprise as the it
> seems like the DAR decoding is broken."  I thought you meant you'd found
> a bug and fixed it in this respin.

Oh, there seems to be a misunderstanding here :)
Lets go back a bit, you said some time ago:
/Quote
> > +3:   lwz   r11, 0(r11)		 /* Get the level 1 entry */
> >       DO_8xx_CPU6(0x3b80, r3)
> >       mtspr SPRN_MD_TWC, r11		 /* Load pte table base address */
> >       mfspr r11, SPRN_MD_TWC		 /* ....and get the pte address */
> >       lwz   r11, 0(r11)		 /* Get the pte */
> >       /* concat physical page address(r11) and page offset(r10) */
> >       rlwimi      r11, r10, 0, 20, 31
>
> But r10 here contains SRR0 from above, and this is a data TLB error.

Never mind that last one, forgot that you'd be wanting to load the
instruction. :-P

But the rlwimi is what's causing the machine checks.  I replaced it with:
rlwinm		 r11, r11, 0, 0x3ffff000
rlwimi		 r11, r10, 22, 0xffc

and things seem to work.  You could probably replace the rlwinm by
subtracting PAGE_OFFSET from swapper_pg_dir instead.
/End Quote

I read this as now everything is working, but I guess I misunderstood?
You still have EFAULT here?
