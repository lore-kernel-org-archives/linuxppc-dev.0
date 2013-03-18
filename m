Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17B8C2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 09:12:48 +1100 (EST)
Date: Mon, 18 Mar 2013 17:12:37 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
To: Johannes Berg <johannes@sipsolutions.net>
References: <1363232178-29938-1-git-send-email-dongsheng.wang@freescale.com>
 <1363250273.4833.1.camel@jlt4.sipsolutions.net> <1363279961.28440.4@snotra>
 <1363360926.8656.5.camel@jlt4.sipsolutions.net>
In-Reply-To: <1363360926.8656.5.camel@jlt4.sipsolutions.net> (from
 johannes@sipsolutions.net on Fri Mar 15 10:22:06 2013)
Message-ID: <1363644757.27435.16@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/15/2013 10:22:06 AM, Johannes Berg wrote:
> On Thu, 2013-03-14 at 11:52 -0500, Scott Wood wrote:
> > > > +#ifdef CONFIG_PPC_BOOK3S_64
> > > >  	/* can't use RESTORE_SPECIAL(MSR) */
> > > >  	ld	r0, SL_MSR(r11)
> > > >  	mtmsrd	r0, 0
> > >
> > > Unfortunately, I forgot the reason for this comment, and didn't =20
> put a
> > > better one (almost 6 years ago!!)
>=20
> > If it's because book3s needs mtmsrd instead of mtmsr, that doesn't
> > apply to booke.
>=20
> Indeed, looking at the code again now that seems pretty obvious.
>=20
> Looking at the patch again, I'd be a little concerned about the lack =20
> of
> cache flushing, seems a bit odd but I'm sure you know what you're =20
> doing
> (and I don't know book3e at all, and hardly remember book3s -- or even
> that name...) :-)

Could you elaborate on why book3s flushes the way it does?  What's =20
special about the first 32 MiB?  If it's to cover kernel code, why =20
would that be changing from what's already there?

-Scott=
