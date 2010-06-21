Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 9A25FB6F15
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 02:47:41 +1000 (EST)
Received: by wyf22 with SMTP id 22so2924688wyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jun 2010 09:47:39 -0700 (PDT)
Date: Mon, 21 Jun 2010 20:47:32 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] mtd: m25p80:
	Reworkprobing/JEDEC code
Message-ID: <20100621164732.GA2725@oksana.dev.rtsoft.ru>
References: <AANLkTikg60s6ZRSEDCq9PQK1z7hJtBDk6t4VE1lYDv8u@mail.gmail.com>
	<20100618133212.GA5276@oksana.dev.rtsoft.ru>
	<0F1B54C89D5F954D8535DB252AF412FA065551D8@chinexm1.ad.analog.com>
	<AANLkTiksYofs6hhWta6uFX2cla_g8pBu0Mtbtcbv-2tl@mail.gmail.com>
	<20100621071551.GA16109@oksana.dev.rtsoft.ru>
	<AANLkTiknH95loHJsQNxvCCyQbriCFWqM5LHl3wKzmdWX@mail.gmail.com>
	<20100621073909.GA20674@oksana.dev.rtsoft.ru>
	<AANLkTinjhmkQafVlrtQC5yDnqIZz859_wrZqo45QOEJ2@mail.gmail.com>
	<20100621112049.GA9273@oksana.dev.rtsoft.ru>
	<AANLkTinvHrjD-gwCMQIgaC4WqAbdXNstdNff2_C28byx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinvHrjD-gwCMQIgaC4WqAbdXNstdNff2_C28byx@mail.gmail.com>
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

On Mon, Jun 21, 2010 at 12:34:05PM -0400, Mike Frysinger wrote:
> On Mon, Jun 21, 2010 at 07:20, Anton Vorontsov wrote:
> > You can't easily change OF. It's like "let's change ACPI tables
> > or BIOS in these PCs". Doable, but involves things like reflashing.
> > And we usually have to support old BIOSes as well.
> >
> > OTOH, I see (git grep m25p arch/powerpc/boot/dts/) that in
> > mainline kernel only MPC8569 board has a correct m25p
> > node, and it is STMicro variant (it is JEDEC capable).
> >
> > As we don't really have to support out of tree code, I'd
> > just go with this patch, assuming that we have to change
> > device tree for boards with non-JEDEC flashes. It's
> > effectively the same thing as platform data flag, except
> > that it works automatically for OF platforms.
> >
> > diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> > index 81e49a9..a610ca9 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -680,6 +680,16 @@ static const struct spi_device_id m25p_ids[] = {
> >        { "m25p64",  INFO(0x202017,  0,  64 * 1024, 128, 0) },
> >        { "m25p128", INFO(0x202018,  0, 256 * 1024,  64, 0) },
> >
> > +       { "m25p05-nonjedec",  INFO(0, 0,  32 * 1024,   2, 0) },
> > +       { "m25p10-nonjedec",  INFO(0, 0,  32 * 1024,   4, 0) },
> > +       { "m25p20-nonjedec",  INFO(0, 0,  64 * 1024,   4, 0) },
> > +       { "m25p40-nonjedec",  INFO(0, 0,  64 * 1024,   8, 0) },
> > +       { "m25p80-nonjedec",  INFO(0, 0,  64 * 1024,  16, 0) },
> > +       { "m25p16-nonjedec",  INFO(0, 0,  64 * 1024,  32, 0) },
> > +       { "m25p32-nonjedec",  INFO(0, 0,  64 * 1024,  64, 0) },
> > +       { "m25p64-nonjedec",  INFO(0, 0,  64 * 1024, 128, 0) },
> > +       { "m25p128-nonjedec", INFO(0, 0, 256 * 1024,  64, 0) },
> > +
> 
> are you picking the m25p because its flash geometry matches whatever
> you're using, or because you have some weird variant of the m25p that
> has JEDEC commands removed ?

The latter. It's Numonyx M25Pxx flashes, see
http://www.numonyx.com/Documents/Datasheets/M25P80.pdf

   The RDID instruction is available only for parts made with 110
   nm Technology identified with Process letter '4'.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
