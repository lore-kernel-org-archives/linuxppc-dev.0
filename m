Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73D5D2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 08:10:57 +1100 (EST)
Date: Tue, 19 Mar 2013 16:10:45 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1363726534.8336.37.camel@jlt4.sipsolutions.net> (from
 johannes@sipsolutions.net on Tue Mar 19 15:55:34 2013)
Message-ID: <1363727445.16671.30@snotra>
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

On 03/19/2013 03:55:34 PM, Johannes Berg wrote:
> On Mon, 2013-03-18 at 17:12 -0500, Scott Wood wrote:
>=20
> > Could you elaborate on why book3s flushes the way it does?  What's
> > special about the first 32 MiB?  If it's to cover kernel code, why
> > would that be changing from what's already there?
>=20
> I was going to say I have no idea, but looking at it again ... this is
> in the *resume* code, not the suspend code as I'd assumed, and on =20
> resume
> I guess I felt it was safer to not assume it didn't change, since it
> could be a slightly different kernel that loaded and restored the
> hibernation image?

Wouldn't that be doomed for other reasons?

I wonder about kernel modules, though flushing 32 MiB wouldn't be =20
adequate there.

> It should be the same one, so I guess it should be
> exactly the same code, but I guess I wanted to make sure there wasn't
> anything weird there. As for why it'd be 32 MiB? No idea. Although =20
> that
> really ought to flush all your possible caches anyway, I guess.

It's not a displacement flush (i.e. you don't do a separate load pass =20
first) -- it just flushes lines if they happen to be present, and =20
leaves alone anything outside that range.  Given that you just finished =20
copying a bunch of data, most likely what's in the cache is the last =20
bit of data you copied.

-Scott=
