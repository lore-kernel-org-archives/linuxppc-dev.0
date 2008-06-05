Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CFBFDDF77
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 11:10:41 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m5619k5e007546
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 11:09:46 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m561ALmT3268846
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 11:10:21 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m561AcKW017016
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 11:10:38 +1000
Date: Thu, 5 Jun 2008 12:41:40 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605024140.GA30980@yookeroo.seuss>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080604211942.2bddc860@zod.rchland.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 04, 2008 at 09:19:42PM -0500, Josh Boyer wrote:
> On Wed, 4 Jun 2008 10:43:51 -0500
> Scott Wood <scottwood@freescale.com> wrote:
> 
> > On Wed, Jun 04, 2008 at 10:24:15AM -0500, Timur Tabi wrote:
> > > Stefan Roese wrote:
> > > > I'm wondering what is currently recommended in the I2C device tree nodes? The 
> > > > current IBM I2C driver (i2c-ibm_iic.c) checks "index" and most FSL dts files 
> > > > use "cell-index". Some 4xx dts files implement "cell-index" some have no 
> > > > index at all.
> > > > 
> > > > So what should be used here. Please advise and I'll prepare a patch for it.
> > > 
> > > I just posted a patch for the FSL I2C driver to check for cell-index.  I'm under
> > > the impression that cell-index is the standard for enumerating devices in the
> > > device tree.
> > 
> > No, it's the standard for correlating devices with portions of a shared
> > register block elsewhere.  Your use in the I2C node is merely a hack to
> > deal with Linux wanting to deal with indices rather than pointers,
> > combined with a lack of a decent way to look up a device struct from the
> > device node.
> 
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

Hear, hear.

Aliases can also provide a reasonable way of enumerating devices, if
"reg" isn't suitable on its own.  Though obviously, drivers will need
some sort of fallback if suitable aliases don't exist in the tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
