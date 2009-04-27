Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD3E3DE1CC
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 06:47:57 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3RKlrHR007875
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 13:47:53 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3RKlrjZ016525
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 15:47:53 -0500 (CDT)
Date: Mon, 27 Apr 2009 15:47:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
Message-ID: <20090427204752.GA22406@ld0162-tx32.am.freescale.net>
References: <20090424183517.GB23140@ovro.caltech.edu>
	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<49F608B7.9080409@ovro.caltech.edu>
	<49F60A3A.4060402@freescale.com>
	<49F60BF8.8040404@ovro.caltech.edu> <49F60FE1.90707@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F60FE1.90707@freescale.com>
Cc: David Hawkins <dwh@ovro.caltech.edu>, Ira Snyder <iws@ovro.caltech.edu>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 03:04:49PM -0500, Timur Tabi wrote:
> David Hawkins wrote:
> 
> > Can you give me an example of non-PCI memory that would be
> > non-prefetchable that you'd like us to try? We can see if our
> > host CPUs have an area like that ... we just need to know
> > what device to look for first :)
> 
> Hmmmm.... I was going to say any SOC device in the IMMR, but I don't see
> anything there that would constitute a memory buffer.
> 
> I test this change on an 8610 and DMA to a register I/O, where this bit
> isn't even defined, and it made no difference.  So I guess this change
> is okay.

I thought the driver only used the bit if the device tree indicated it
was an 83xx-era DMA controller?

That said, the bits are documented as specifically for PCI, so it would
be surprising if it had any effect elsewhere.

-Scott
