Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1800ADDE2D
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 07:15:38 +1000 (EST)
Date: Sun, 13 May 2007 16:18:29 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Message-ID: <20070513211829.GA24022@lixom.net>
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
	<20070513005830.38ba8e3b@the-village.bc.nu>
	<200705130248.22844.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705130248.22844.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Sun, May 13, 2007 at 02:48:22AM +0200, Arnd Bergmann wrote:

> Olof, have you looked at which of the two ->set_mode functions is more
> appropriate for electra? I would guess that you actually want to use
> the ata_generic one.

Actually, the pata_platform driver is _exactly_ what I want at this time,
since we can't do bus master dma and it assumes that. It's a perfect fit,
I see no reason to retool it.

Another reason for why I'm not that excited about doing a generic
of_platform driver is that it's likely that I'll do a new driver that
uses one of the simple dma engines on our SoC to get the data over PIO
(i.e still not bus master dma, but at least offloaded). That'd make the
resulting number of users of a pata_of driver 0 until the next one comes
around, with whatever that means with respect to bit-rot, etc.

That driver will, on the other hand, likely be an of_platform one. But
until then there's not much use in doing one.


-Olof
