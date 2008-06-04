Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B502FDDF39
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 01:44:00 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m54Fhr54022628
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 08:43:54 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m54FhqW0024224
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 10:43:52 -0500 (CDT)
Date: Wed, 4 Jun 2008 10:43:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080604154351.GB10393@ld0162-tx32.am.freescale.net>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4846B39F.3010601@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 04, 2008 at 10:24:15AM -0500, Timur Tabi wrote:
> Stefan Roese wrote:
> > I'm wondering what is currently recommended in the I2C device tree nodes? The 
> > current IBM I2C driver (i2c-ibm_iic.c) checks "index" and most FSL dts files 
> > use "cell-index". Some 4xx dts files implement "cell-index" some have no 
> > index at all.
> > 
> > So what should be used here. Please advise and I'll prepare a patch for it.
> 
> I just posted a patch for the FSL I2C driver to check for cell-index.  I'm under
> the impression that cell-index is the standard for enumerating devices in the
> device tree.

No, it's the standard for correlating devices with portions of a shared
register block elsewhere.  Your use in the I2C node is merely a hack to
deal with Linux wanting to deal with indices rather than pointers,
combined with a lack of a decent way to look up a device struct from the
device node.

-Scott
