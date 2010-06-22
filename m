Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B130B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 08:40:15 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5MMdtJI007408 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 15:40:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o5MMq2Ef006653
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 17:52:03 -0500 (CDT)
Date: Tue, 22 Jun 2010 17:39:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
Message-ID: <20100622223954.GB5796@schlenkerla.am.freescale.net>
References: <4C187616.4000303@neli.hopto.org>
	<8660DA277DC57B4BAAC78225F03146B6AB1B5C@zin33exm24.fsl.freescale.net>
	<4C189860.3040702@neli.hopto.org>
	<AANLkTikDywS1B5i2kCQfTvJAWBuq7K3UuOmGQzi45UAX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikDywS1B5i2kCQfTvJAWBuq7K3UuOmGQzi45UAX@mail.gmail.com>
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 16, 2010 at 09:23:38AM -0500, Timur Tabi wrote:
> I'm sorry, but Linux does depend on the boot loader,

In some ways, but we try not to do so too gratuitously.

> and U-Boot does need to know whether Linux is going to use 36-bit
> addressing.

U-Boot knows whether it puts things over 4GiB.  If Linux is going to change
the LAWs in what was previously a 32-bit physical system, it doesn't seem
unreasonable for it to set EN_MAS7_UPDATE.

> That's just the way it works.  Linux patches that repeat what U-Boot
> already does just so that you don't need to update your U-boot are going
> to be rejected.

Why'd we do cuboot then?  Or any other compatibility measure (e.g. working
with old device trees) or board-specific non-OS-specific init thing which
might be better off done in firmware (e.g. setting up I/O pins to match
what's on the board)?

Firmware is harder to upgrade than a kernel, sometimes it's not worth it.

Especially if new firmware won't boot old OSes, which could be the case with
EN_MAS7_UPDATE on a non-36-bit-aware OS (compatibility is the reason that
bit exists).

-Scott
