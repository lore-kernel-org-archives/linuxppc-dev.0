Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 437D52C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 09:16:41 +1100 (EST)
Date: Tue, 19 Mar 2013 17:16:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1363728127.8336.39.camel@jlt4.sipsolutions.net> (from
 johannes@sipsolutions.net on Tue Mar 19 16:22:07 2013)
Message-ID: <1363731391.16671.32@snotra>
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

On 03/19/2013 04:22:07 PM, Johannes Berg wrote:
> On Tue, 2013-03-19 at 16:10 -0500, Scott Wood wrote:
>=20
> > > I was going to say I have no idea, but looking at it again ... =20
> this is
> > > in the *resume* code, not the suspend code as I'd assumed, and on
> > > resume
> > > I guess I felt it was safer to not assume it didn't change, since =20
> it
> > > could be a slightly different kernel that loaded and restored the
> > > hibernation image?
> >
> > Wouldn't that be doomed for other reasons?
>=20
> Most likely, yeah.
>=20
> > I wonder about kernel modules, though flushing 32 MiB wouldn't be
> > adequate there.
>=20
> Good question, but would they be running? You have to have everything
> built in that you need to load the image? Or maybe not, with the
> userspace image restoration that became possible at some point...

Is that all that's being restored in this step, or would we be loading =20
all modules that were loaded before suspend (as they're normally not =20
swappable)?  I'm not too familiar with what gets saved where.

> > It's not a displacement flush (i.e. you don't do a separate load =20
> pass
> > first) -- it just flushes lines if they happen to be present, and
> > leaves alone anything outside that range.  Given that you just =20
> finished
> > copying a bunch of data, most likely what's in the cache is the last
> > bit of data you copied.
>=20
> Oops, good point.
>=20
> Maybe there's a way to completely flush the (i)cache? :-)

There is, but it's platform-dependent, and not pleasant on our chips =20
(need a displacement flush for L1, and sometimes errata are involved =20
for L2).

-Scott=
