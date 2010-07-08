Return-Path: <dedekind1@gmail.com>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 318C3B6EEE
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jul 2010 16:24:10 +1000 (EST)
Received: from mgw-mx09.nokia.com ([192.100.105.134])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id
	o6861uo2030095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jul 2010 09:01:59 +0300
Subject: Re: [PATCH 1/2] mtd: m25p80: Fix false-positive probing
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Anton Vorontsov <avorontsov@mvista.com>
In-Reply-To: <20100622165734.GA20699@oksana.dev.rtsoft.ru>
References: <20100622165545.GA10255@oksana.dev.rtsoft.ru>
	<20100622165734.GA20699@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 08:57:24 +0300
Message-ID: <1278568644.12733.35.camel@localhost>
Mime-Version: 1.0
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Mike Frysinger <vapier.adi@gmail.com>,
	Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-06-22 at 20:57 +0400, Anton Vorontsov wrote:
> Since commit 18c6182bae0acca220ed6611f741034d563cd19f ("Rework
> probing/JEDEC code"), m25p80 driver successfully registers chips
> even if JEDEC probing fails.
> 
> This was needed to support non-JEDEC flashes. Though, it appears
> that some platforms (e.g. blackfin bf533 stamp[1]) used the old
> behavior to detect if there's any flash connected, so the driver
> have to fail on JEDEC probing errors.
> 
> This patch restores the old behavior for JEDEC flashes, and adds
> "-nonjedec" SPI device IDs for M25Pxx flashes, so that the kernel
> still supports non-JEDEC flashes.
> 
> [1] http://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_item_id=5975
> 
> Reported-by: Mingquan Pan
> Reported-by: Barry Song <21cnbao@gmail.com>
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---

Pushed both patches to my l2-mtd-2.6.git / dunno, added Mike's ack.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
