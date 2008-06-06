Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8BE3DDF57
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:18:31 +1000 (EST)
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080604154351.GB10393@ld0162-tx32.am.freescale.net>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 14:13:43 +1000
Message-Id: <1212725623.12464.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Timur Tabi <timur@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-06-04 at 10:43 -0500, Scott Wood wrote:
> > I just posted a patch for the FSL I2C driver to check for cell-index.  I'm under
> > the impression that cell-index is the standard for enumerating devices in the
> > device tree.
> 
> No, it's the standard for correlating devices with portions of a shared
> register block elsewhere.  Your use in the I2C node is merely a hack to
> deal with Linux wanting to deal with indices rather than pointers,
> combined with a lack of a decent way to look up a device struct from the
> device node.

Totally agreed. cell-index should -only- be about correlating a given
device in an ASIC with some shared register (an example coming to mind
is clock control registers with one bit per cell) etc...

For the rest, well, use aliases :-)

Ben.
