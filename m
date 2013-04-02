Return-Path: <B40534@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F02B52C00EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 16:28:50 +1100 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Johannes Berg
 <johannes@sipsolutions.net>
Subject: RE: [PATCH] powerpc: add Book E support to 64-bit hibernation
Date: Tue, 2 Apr 2013 05:28:40 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259ED9C2E@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1363949917.8238.25.camel@jlt4.sipsolutions.net> (from
 johannes@sipsolutions.net on Fri Mar 22 05:58:37 2013)
 <1363990490.24790.12@snotra>
In-Reply-To: <1363990490.24790.12@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi scott & Johannes,

Thanks for reviewing.

@scott, About this patch, could you please help ack this patch?

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Saturday, March 23, 2013 6:15 AM
> To: Johannes Berg
> Cc: Wang Dongsheng-B40534; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
>=20
> On 03/22/2013 05:58:37 AM, Johannes Berg wrote:
> > On Tue, 2013-03-19 at 17:16 -0500, Scott Wood wrote:
> >
> > > > > I wonder about kernel modules, though flushing 32 MiB wouldn't
> > be
> > > > > adequate there.
> > > >
> > > > Good question, but would they be running? You have to have
> > everything
> > > > built in that you need to load the image? Or maybe not, with the
> > > > userspace image restoration that became possible at some point...
> > >
> > > Is that all that's being restored in this step, or would we be
> > loading
> > > all modules that were loaded before suspend (as they're normally not
> > > swappable)?  I'm not too familiar with what gets saved where.
> >
> > Yes, they would be restored since full memory is restored, but the
> > kernel doing the restore hasn't typically had a chance to load
> > modules.
> > Although with uswsusp there probably are ways it can already have.
>=20
> If we're loading executable code that wasn't there before[1], we need to
> flush -- but there's no reason why modules would only be in the lower 32
> MiB.
>=20
> -Scott
>=20
> [1] within the resume process, not before suspend
