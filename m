Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id A8CE2B6F10
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 02:55:54 +1000 (EST)
Received: by bwz1 with SMTP id 1so1946047bwz.15
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 09:55:52 -0700 (PDT)
Date: Tue, 22 Jun 2010 20:55:45 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Barry Song <21cnbao@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] mtd: m25p80:
	Reworkprobing/JEDEC code
Message-ID: <20100622165545.GA10255@oksana.dev.rtsoft.ru>
References: <AANLkTikg60s6ZRSEDCq9PQK1z7hJtBDk6t4VE1lYDv8u@mail.gmail.com>
	<20100618133212.GA5276@oksana.dev.rtsoft.ru>
	<0F1B54C89D5F954D8535DB252AF412FA065551D8@chinexm1.ad.analog.com>
	<AANLkTiksYofs6hhWta6uFX2cla_g8pBu0Mtbtcbv-2tl@mail.gmail.com>
	<20100621071551.GA16109@oksana.dev.rtsoft.ru>
	<AANLkTiknH95loHJsQNxvCCyQbriCFWqM5LHl3wKzmdWX@mail.gmail.com>
	<20100621073909.GA20674@oksana.dev.rtsoft.ru>
	<AANLkTinjhmkQafVlrtQC5yDnqIZz859_wrZqo45QOEJ2@mail.gmail.com>
	<20100621112049.GA9273@oksana.dev.rtsoft.ru>
	<AANLkTikY9pfHsQ6xeVkixKF5kqL2nLyV2kgcR2iJKhG-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTikY9pfHsQ6xeVkixKF5kqL2nLyV2kgcR2iJKhG-@mail.gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	linux-kernel@vger.kernel.org, "Song,
	Barry" <Barry.Song@analog.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 22, 2010 at 02:37:52PM +0800, Barry Song wrote:
[...]
> >                jid = jedec_probe(spi);
> >                if (!jid) {
> > -                       dev_info(&spi->dev, "non-JEDEC variant of %s\n",
> > -                                id->name);
> > +                       return -ENODEV;
> The patch looks good to me. Only problem is NULL is also returned by
> spi_write_then_read() fail:
[...]
> Here much better for -EIO (return tmp)?

Agreed. Though, this is not a regression, and I guess desires
its own patch. 

Here are two patches, one for 2.6.35 (minimal changes to fix
the JEDEC problem), another for 2.6.36.
