Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1158DDF45
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:17:06 +1000 (EST)
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080604211942.2bddc860@zod.rchland.ibm.com>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 14:14:40 +1000
Message-Id: <1212725680.12464.11.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-06-04 at 21:19 -0500, Josh Boyer wrote:
> So if possible, I'd like to eliminate the *index stuff all together
> from the 4xx driver.  The private data structure contains an idx
> parameter, but this can be populated based on probe order or something.
> 
> >From a device tree perspective, index and cell-index are both
> incorrect.  The IIC macros don't share register blocks with anything,
> are enumerated as unique instances per macro in the device tree, and
> should be able to be distinguished by "regs" and/or unit address.
> 
> Does anyone disagree with that?

Not sure what you mean, but some of the 4xx drivers need to know
their cell index to whack the right bits in some SDRs etc... for
things like clock control. That's also the only reason they should
use cell-index :-)

Ben.
