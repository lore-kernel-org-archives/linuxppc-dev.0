Return-Path: <21cnbao@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 4BD69B7D4F
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jun 2010 20:32:06 +1000 (EST)
Received: by gyf2 with SMTP id 2so2161617gyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jun 2010 03:32:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100621073909.GA20674@oksana.dev.rtsoft.ru>
References: <20090818214449.GA12848@oksana.dev.rtsoft.ru>
	<20090818214622.GA22651@oksana.dev.rtsoft.ru>
	<AANLkTikg60s6ZRSEDCq9PQK1z7hJtBDk6t4VE1lYDv8u@mail.gmail.com>
	<20100618133212.GA5276@oksana.dev.rtsoft.ru>
	<0F1B54C89D5F954D8535DB252AF412FA065551D8@chinexm1.ad.analog.com>
	<AANLkTiksYofs6hhWta6uFX2cla_g8pBu0Mtbtcbv-2tl@mail.gmail.com>
	<20100621071551.GA16109@oksana.dev.rtsoft.ru>
	<AANLkTiknH95loHJsQNxvCCyQbriCFWqM5LHl3wKzmdWX@mail.gmail.com>
	<20100621073909.GA20674@oksana.dev.rtsoft.ru>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Jun 2010 18:31:44 +0800
Message-ID: <AANLkTinjhmkQafVlrtQC5yDnqIZz859_wrZqo45QOEJ2@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] mtd: m25p80: Reworkprobing/JEDEC
	code
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On Mon, Jun 21, 2010 at 3:39 PM, Anton Vorontsov <cbouatmailru@gmail.com> w=
rote:
> On Mon, Jun 21, 2010 at 03:22:48PM +0800, Barry Song wrote:
>> On Mon, Jun 21, 2010 at 3:15 PM, Anton Vorontsov <cbouatmailru@gmail.com=
> wrote:
>> > On Mon, Jun 21, 2010 at 11:27:31AM +0800, Barry Song wrote:
>> > [...]
>> >> > How about we add a non_jedec flag in platform_data, if the flag is =
1, we
>> >> > let the detection pass even though the ID is 0? Otherwise, we need =
a
>> >> > valid ID?
>> >> Here i mean:
>> >
>> > This will break at least OF-enabled platforms (e.g. PowerPC),
>> > they assume that the driver will success for non-JEDEC flashes.
>> > OF platforms don't pass platform data, and even if they did,
>> > device tree doesn't specify if the flash is JEDEC or non-JEDEC.
>> >
>> > Which is why I think that, by default, the driver should
>> > successfully register the flash even if JEDEC probe fails. So,
>> > instead of checking for "!non_jedec", I would recommend
>> > "force_jedec" check.
>>
>> Mike Frysinger suggested to use non_jedec since most devices are
>> standard jedec devices.
>
> Well, on OF platforms most devices that I'm aware of are non-JEDEC.
>
>> Only if non_jedec=3D1, we let the detection pass
>> if ID is 0.
>
> Then please #ifdef it with CONFIG_OF.
I think the patch has nothing to do with platform. Here SPI Flash is a
peripherals, doesn't depend on any platform. Adding a CONFIG_OF
doesn't make sense very much.
If you think most devices are non-JEDEC, we can change non_JEDEC to
force_JEDEC as you said. But anyway, is that real that most devices
are non_JEDEC?  If not, I think we should change OF platform codes to
fit with this patch.

>
> Thanks,
>
>> >> Index: drivers/mtd/devices/m25p80.c
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> --- drivers/mtd/devices/m25p80.c =C2=A0 =C2=A0 =C2=A0(revision 8927)
>> >> +++ drivers/mtd/devices/m25p80.c =C2=A0 =C2=A0 =C2=A0(revision 8929)
>> >> @@ -795,8 +795,13 @@
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 jid =3D jedec_probe(=
spi);
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!jid) {
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_info(&spi->dev, "non-JEDEC variant of %s\n",
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id->name);
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!data->non_jedec) {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&spi->dev, "fail to detect%s\n",
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 id->name);
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } else
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&spi->dev, "non-JEDEC variant of %=
s\n",
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 id->name);
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (jid !=3D =
id) {
>> >
>> > --
>> > Anton Vorontsov
>> > email: cbouatmailru@gmail.com
>> > irc://irc.freenode.net/bd2
>> >
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>
