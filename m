Return-Path: <dedekind1@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10C72B6F71
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2011 21:04:39 +1000 (EST)
Received: by ywb3 with SMTP id 3so1657150ywb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2011 04:04:36 -0700 (PDT)
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 25 Aug 2011 14:06:28 +0300
In-Reply-To: <4E527C91.6080009@freescale.com>
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
	<4E4E2571.20409@parrot.com> <4E4EA70B.9050203@freescale.com>
	<1314010719.2644.114.camel@sauron> <4E527C91.6080009@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314270393.18988.41.camel@sauron>
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

On Mon, 2011-08-22 at 10:58 -0500, Scott Wood wrote:
> On 08/22/2011 05:58 AM, Artem Bityutskiy wrote:
> > On Fri, 2011-08-19 at 13:10 -0500, Scott Wood wrote:
> >> On 08/19/2011 03:57 AM, Matthieu CASTET wrote:
> >>> How the bad block marker are handled with this remapping ?
> >>
> >> It has to be migrated prior to first use (this needs to be documented,
> >> and ideally a U-Boot command provided do do this), or else special
> >> handling would be needed when building the BBT.  The only way around
> >> this would be to do ECC in software, and do the buffering needed to let
> >> MTD treat it as a 4K chip.
> > 
> > It really feels like a special hack which would better not go to
> > mainline - am I the only one with such feeling? If yes, probably I am
> > wrong...
> 
> While the implementation is (of necessity) a hack, the feature is
> something that multiple people have been asking for (it's not a special
> case for a specific user).  They say 2K chips are getting more difficult
> to obtain.  It doesn't change anything for people using 512/2K chips,
> and (in its current form) doesn't introduce significant complexity to
> the driver.  I'm not sure how maintaining it out of tree would be a
> better situation for anyone.

I am just afraid that (a) other drivers will do this (b) this will start
causing various weird bug-reports...

-- 
Best Regards,
Artem Bityutskiy
