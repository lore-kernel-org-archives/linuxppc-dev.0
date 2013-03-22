Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BABC2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 09:15:00 +1100 (EST)
Date: Fri, 22 Mar 2013 17:14:50 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1363949917.8238.25.camel@jlt4.sipsolutions.net> (from
 johannes@sipsolutions.net on Fri Mar 22 05:58:37 2013)
Message-ID: <1363990490.24790.12@snotra>
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

On 03/22/2013 05:58:37 AM, Johannes Berg wrote:
> On Tue, 2013-03-19 at 17:16 -0500, Scott Wood wrote:
>=20
> > > > I wonder about kernel modules, though flushing 32 MiB wouldn't =20
> be
> > > > adequate there.
> > >
> > > Good question, but would they be running? You have to have =20
> everything
> > > built in that you need to load the image? Or maybe not, with the
> > > userspace image restoration that became possible at some point...
> >
> > Is that all that's being restored in this step, or would we be =20
> loading
> > all modules that were loaded before suspend (as they're normally not
> > swappable)?  I'm not too familiar with what gets saved where.
>=20
> Yes, they would be restored since full memory is restored, but the
> kernel doing the restore hasn't typically had a chance to load =20
> modules.
> Although with uswsusp there probably are ways it can already have.

If we're loading executable code that wasn't there before[1], we need =20
to flush -- but there's no reason why modules would only be in the =20
lower 32 MiB.

-Scott

[1] within the resume process, not before suspend=
