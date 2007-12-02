Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 7D40EDDE35
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 10:40:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Date: Mon, 3 Dec 2007 00:40:21 +0100
References: <20071127153708.GA12490@localhost.localdomain>
	<20071202114617.GA2923@zarina> <20071202154539.GA12415@lixom.net>
In-Reply-To: <20071202154539.GA12415@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712030040.22701.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Anton Vorontsov <cbou@mail.ru>,
	Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 02 December 2007, Olof Johansson wrote:

> Yes, I agree with Sergei: I don't think the pio/ata mode belongs there,
> "ata-generic" (or "generic-ata") sounds good to me. If firmwares want to
> specify pata/sata stuff as more specific compatible fields, then they are
> free to, but the driver shouldn't depend on it as long as "ata-generic"
> is in the list.

Yes, that makes sense. Let me just make it clear that I no longer think
we should have the PIO mode or the ATA level in the compatible property.
The PIO modes should really have their own property, if any, and the ATA
standard would need to be a property of the attached device, not a property
of the controller.

I can see a point in listing the ATA devices themselves in the device tree,
but it's probably not really worth it for the fdt setup, since they
can easily be probed at runtime.

> I will need to add a compatible field to it myself (our firmware uses
> "electra-ide") + some minor changes, but I will do that on top of this
> patch once it goes in since it involves removing the old code from
> arch/powerpc/platforms/pasemi.

I'd suggest to also have electra-ide hardcoded in the driver alongside
ata-generic, as a special case for backwards compatibility.

	Arnd <><
