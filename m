Return-Path: <dedekind1@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08F15B6EE8
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2011 20:56:51 +1000 (EST)
Received: by gyd5 with SMTP id 5so3552644gyd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2011 03:56:47 -0700 (PDT)
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Date: Mon, 22 Aug 2011 13:58:33 +0300
In-Reply-To: <4E4EA70B.9050203@freescale.com>
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
	<4E4E2571.20409@parrot.com> <4E4EA70B.9050203@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314010719.2644.114.camel@sauron>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	LiuShuo <b35362@freescale.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	Matthieu CASTET <matthieu.castet@parrot.com>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-08-19 at 13:10 -0500, Scott Wood wrote:
> On 08/19/2011 03:57 AM, Matthieu CASTET wrote:
> > LiuShuo a écrit :
> >> 于 2011年08月19日 01:00, Matthieu CASTET 写道:
> >>> b35362@freescale.com a écrit :
> >>>> From: Liu Shuo<b35362@freescale.com>
> >>>>
> >>>> Freescale FCM controller has a 2K size limitation of buffer RAM. In order
> >>>> to support the Nand flash chip whose page size is larger than 2K bytes,
> >>>> we divide a page into multi-2K pages for MTD layer driver. In that case,
> >>>> we force to set the page size to 2K bytes. We convert the page address of
> >>>> MTD layer driver to a real page address in flash chips and a column index
> >>>> in fsl_elbc driver. We can issue any column address by UA instruction of
> >>>> elbc controller.
> >>>>
> >>> Why do you need to do that ?
> >>>
> >>> When mtd send you a 4k page, why can't you write it by 2*2k pages write ?
> >> 1. It's easy to implement.
> >> 2. We don't need to move the data in buffer more times, because we
> >> want to use the HW_ECC.
> >>
> >> In flash chip per Page:
> >> ----------------------------------------------------------------
> >> | first data | first oob | second data | second oob |
> >> ----------------------------------------------------------------
> > How the bad block marker are handled with this remapping ?
> 
> It has to be migrated prior to first use (this needs to be documented,
> and ideally a U-Boot command provided do do this), or else special
> handling would be needed when building the BBT.  The only way around
> this would be to do ECC in software, and do the buffering needed to let
> MTD treat it as a 4K chip.

It really feels like a special hack which would better not go to
mainline - am I the only one with such feeling? If yes, probably I am
wrong...

-- 
Best Regards,
Artem Bityutskiy
