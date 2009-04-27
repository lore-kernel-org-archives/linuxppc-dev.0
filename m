Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B1D2DDDE1B
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 19:09:19 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3R99F3d012173
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 02:09:16 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3R99DAT029659
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 04:09:14 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] fsldma: use PCI Read Multiple command
Date: Mon, 27 Apr 2009 17:09:13 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
In-Reply-To: <20090424183517.GB23140@ovro.caltech.edu>
References: <20090424183517.GB23140@ovro.caltech.edu>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Ira Snyder" <iws@ovro.caltech.edu>, <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> By default, the Freescale 83xx DMA controller uses the PCI Read Line
> command when reading data over the PCI bus. Setting the=20
> controller to use the PCI Read Multiple command instead allows the
> controller to read much larger bursts of data, which provides a
drastic
> speed increase.

IIRC, the default for 83xx DMA controller uses the PCI mem read
command, not mem read line.

You are assuming the PCI memory space is prefetchable( no side effect)
for DMA.
Is it possible that DMA is from non-prefetchable memory space?

> The slowdown due to using PCI Read Line was only observed=20
> when a PCI-to-PCI bridge was between the devices trying to
communicate.
>=20
> A simple test driver showed an increase from 4MB/sec to 116MB/sec when
> performing DMA over the PCI bus. Using DMA to transfer between blocks
> of local SDRAM showed no change in performance with this patch.=20
> The dmatest driver was also used to verify the correctness of the
transfers,
> and showed no errors.
