Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id A88C7B7D81
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jun 2010 17:39:15 +1000 (EST)
Received: by wyf22 with SMTP id 22so2452764wyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jun 2010 00:39:13 -0700 (PDT)
Date: Mon, 21 Jun 2010 11:39:09 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Barry Song <21cnbao@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] mtd: m25p80:
	Reworkprobing/JEDEC code
Message-ID: <20100621073909.GA20674@oksana.dev.rtsoft.ru>
References: <20090818214449.GA12848@oksana.dev.rtsoft.ru>
	<20090818214622.GA22651@oksana.dev.rtsoft.ru>
	<AANLkTikg60s6ZRSEDCq9PQK1z7hJtBDk6t4VE1lYDv8u@mail.gmail.com>
	<20100618133212.GA5276@oksana.dev.rtsoft.ru>
	<0F1B54C89D5F954D8535DB252AF412FA065551D8@chinexm1.ad.analog.com>
	<AANLkTiksYofs6hhWta6uFX2cla_g8pBu0Mtbtcbv-2tl@mail.gmail.com>
	<20100621071551.GA16109@oksana.dev.rtsoft.ru>
	<AANLkTiknH95loHJsQNxvCCyQbriCFWqM5LHl3wKzmdWX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTiknH95loHJsQNxvCCyQbriCFWqM5LHl3wKzmdWX@mail.gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	linux-kernel@vger.kernel.org, "Song,
	Barry" <Barry.Song@analog.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 21, 2010 at 03:22:48PM +0800, Barry Song wrote:
> On Mon, Jun 21, 2010 at 3:15 PM, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> > On Mon, Jun 21, 2010 at 11:27:31AM +0800, Barry Song wrote:
> > [...]
> >> > How about we add a non_jedec flag in platform_data, if the flag is 1, we
> >> > let the detection pass even though the ID is 0? Otherwise, we need a
> >> > valid ID?
> >> Here i mean:
> >
> > This will break at least OF-enabled platforms (e.g. PowerPC),
> > they assume that the driver will success for non-JEDEC flashes.
> > OF platforms don't pass platform data, and even if they did,
> > device tree doesn't specify if the flash is JEDEC or non-JEDEC.
> >
> > Which is why I think that, by default, the driver should
> > successfully register the flash even if JEDEC probe fails. So,
> > instead of checking for "!non_jedec", I would recommend
> > "force_jedec" check.
> 
> Mike Frysinger suggested to use non_jedec since most devices are
> standard jedec devices.

Well, on OF platforms most devices that I'm aware of are non-JEDEC.

> Only if non_jedec=1, we let the detection pass
> if ID is 0.

Then please #ifdef it with CONFIG_OF.

Thanks,

> >> Index: drivers/mtd/devices/m25p80.c
> >> ===================================================================
> >> --- drivers/mtd/devices/m25p80.c      (revision 8927)
> >> +++ drivers/mtd/devices/m25p80.c      (revision 8929)
> >> @@ -795,8 +795,13 @@
> >>
> >>               jid = jedec_probe(spi);
> >>               if (!jid) {
> >> -                     dev_info(&spi->dev, "non-JEDEC variant of %s\n",
> >> -                              id->name);
> >> +                     if (!data->non_jedec) {
> >> +                             dev_err(&spi->dev, "fail to detect%s\n",
> >> +                                             id->name);
> >> +                             return -ENODEV;
> >> +                     } else
> >> +                             dev_info(&spi->dev, "non-JEDEC variant of %s\n",
> >> +                                             id->name);
> >>               } else if (jid != id) {
> >
> > --
> > Anton Vorontsov
> > email: cbouatmailru@gmail.com
> > irc://irc.freenode.net/bd2
> >

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
