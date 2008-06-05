Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0CBB9DDED1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 12:19:58 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m552JsB8006550
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 22:19:54 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m552Jsn3107712
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 20:19:54 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m552JsLU020327
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 20:19:54 -0600
Date: Wed, 4 Jun 2008 21:19:42 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080604211942.2bddc860@zod.rchland.ibm.com>
In-Reply-To: <20080604154351.GB10393@ld0162-tx32.am.freescale.net>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Jun 2008 10:43:51 -0500
Scott Wood <scottwood@freescale.com> wrote:

> On Wed, Jun 04, 2008 at 10:24:15AM -0500, Timur Tabi wrote:
> > Stefan Roese wrote:
> > > I'm wondering what is currently recommended in the I2C device tree no=
des? The=20
> > > current IBM I2C driver (i2c-ibm_iic.c) checks "index" and most FSL dt=
s files=20
> > > use "cell-index". Some 4xx dts files implement "cell-index" some have=
 no=20
> > > index at all.
> > >=20
> > > So what should be used here. Please advise and I'll prepare a patch f=
or it.
> >=20
> > I just posted a patch for the FSL I2C driver to check for cell-index.  =
I'm under
> > the impression that cell-index is the standard for enumerating devices =
in the
> > device tree.
>=20
> No, it's the standard for correlating devices with portions of a shared
> register block elsewhere.  Your use in the I2C node is merely a hack to
> deal with Linux wanting to deal with indices rather than pointers,
> combined with a lack of a decent way to look up a device struct from the
> device node.

So if possible, I'd like to eliminate the *index stuff all together
from the 4xx driver.  The private data structure contains an idx
parameter, but this can be populated based on probe order or something.

=46rom a device tree perspective, index and cell-index are both
incorrect.  The IIC macros don't share register blocks with anything,
are enumerated as unique instances per macro in the device tree, and
should be able to be distinguished by "regs" and/or unit address.

Does anyone disagree with that?

josh
