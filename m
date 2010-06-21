Return-Path: <vapier.adi@gmail.com>
Received: from mail-yw0-f204.google.com (mail-yw0-f204.google.com
	[209.85.211.204]) by ozlabs.org (Postfix) with ESMTP id D40B4B6F0E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 02:39:51 +1000 (EST)
Received: by ywh42 with SMTP id 42so2525569ywh.15
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jun 2010 09:39:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100621112049.GA9273@oksana.dev.rtsoft.ru>
References: <20090818214449.GA12848@oksana.dev.rtsoft.ru>
	<20090818214622.GA22651@oksana.dev.rtsoft.ru>
	<AANLkTikg60s6ZRSEDCq9PQK1z7hJtBDk6t4VE1lYDv8u@mail.gmail.com>
	<20100618133212.GA5276@oksana.dev.rtsoft.ru>
	<0F1B54C89D5F954D8535DB252AF412FA065551D8@chinexm1.ad.analog.com>
	<AANLkTiksYofs6hhWta6uFX2cla_g8pBu0Mtbtcbv-2tl@mail.gmail.com>
	<20100621071551.GA16109@oksana.dev.rtsoft.ru>
	<AANLkTiknH95loHJsQNxvCCyQbriCFWqM5LHl3wKzmdWX@mail.gmail.com>
	<20100621073909.GA20674@oksana.dev.rtsoft.ru>
	<AANLkTinjhmkQafVlrtQC5yDnqIZz859_wrZqo45QOEJ2@mail.gmail.com>
	<20100621112049.GA9273@oksana.dev.rtsoft.ru>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Mon, 21 Jun 2010 12:34:05 -0400
Message-ID: <AANLkTinvHrjD-gwCMQIgaC4WqAbdXNstdNff2_C28byx@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] mtd: m25p80: Reworkprobing/JEDEC
	code
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
	"Song, Barry" <Barry.Song@analog.com>, linuxppc-dev@ozlabs.org,
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

On Mon, Jun 21, 2010 at 07:20, Anton Vorontsov wrote:
> You can't easily change OF. It's like "let's change ACPI tables
> or BIOS in these PCs". Doable, but involves things like reflashing.
> And we usually have to support old BIOSes as well.
>
> OTOH, I see (git grep m25p arch/powerpc/boot/dts/) that in
> mainline kernel only MPC8569 board has a correct m25p
> node, and it is STMicro variant (it is JEDEC capable).
>
> As we don't really have to support out of tree code, I'd
> just go with this patch, assuming that we have to change
> device tree for boards with non-JEDEC flashes. It's
> effectively the same thing as platform data flag, except
> that it works automatically for OF platforms.
>
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 81e49a9..a610ca9 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -680,6 +680,16 @@ static const struct spi_device_id m25p_ids[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "m25p64", =C2=A0INFO(0x202017, =C2=A00, =C2=
=A064 * 1024, 128, 0) },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "m25p128", INFO(0x202018, =C2=A00, 256 * 102=
4, =C2=A064, 0) },
>
> + =C2=A0 =C2=A0 =C2=A0 { "m25p05-nonjedec", =C2=A0INFO(0, 0, =C2=A032 * 1=
024, =C2=A0 2, 0) },
> + =C2=A0 =C2=A0 =C2=A0 { "m25p10-nonjedec", =C2=A0INFO(0, 0, =C2=A032 * 1=
024, =C2=A0 4, 0) },
> + =C2=A0 =C2=A0 =C2=A0 { "m25p20-nonjedec", =C2=A0INFO(0, 0, =C2=A064 * 1=
024, =C2=A0 4, 0) },
> + =C2=A0 =C2=A0 =C2=A0 { "m25p40-nonjedec", =C2=A0INFO(0, 0, =C2=A064 * 1=
024, =C2=A0 8, 0) },
> + =C2=A0 =C2=A0 =C2=A0 { "m25p80-nonjedec", =C2=A0INFO(0, 0, =C2=A064 * 1=
024, =C2=A016, 0) },
> + =C2=A0 =C2=A0 =C2=A0 { "m25p16-nonjedec", =C2=A0INFO(0, 0, =C2=A064 * 1=
024, =C2=A032, 0) },
> + =C2=A0 =C2=A0 =C2=A0 { "m25p32-nonjedec", =C2=A0INFO(0, 0, =C2=A064 * 1=
024, =C2=A064, 0) },
> + =C2=A0 =C2=A0 =C2=A0 { "m25p64-nonjedec", =C2=A0INFO(0, 0, =C2=A064 * 1=
024, 128, 0) },
> + =C2=A0 =C2=A0 =C2=A0 { "m25p128-nonjedec", INFO(0, 0, 256 * 1024, =C2=
=A064, 0) },
> +

are you picking the m25p because its flash geometry matches whatever
you're using, or because you have some weird variant of the m25p that
has JEDEC commands removed ?
-mike
