Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E12EDDDA1
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 21:20:33 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n54BKTfx019531
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Jun 2009 04:20:29 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n54BKRgq012672
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Jun 2009 06:20:28 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC PATCH] fsldma: Add DMA_SLAVE support
Date: Thu, 4 Jun 2009 19:20:26 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED48368B@zch01exm26.fsl.freescale.net>
In-Reply-To: <20090603181038.GC7292@ovro.caltech.edu>
References: <20090515225659.GD858@ovro.caltech.edu>
	<20090603181038.GC7292@ovro.caltech.edu>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Ira Snyder" <iws@ovro.caltech.edu>,
	"Dan Williams" <dan.j.williams@intel.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>> This is a request for comments on this patch. I hunch it is=20
>not quite=20
>> ready for inclusion, though it is certainly ready for=20
>review. Correct=20
>> functioning of this patch depends on the patches submitted earlier.
>>=20
>> As suggested by Dan Williams, I implemented DMA_SLAVE=20
>support for the=20
>> fsldma controller to allow me to use the hardware to=20
>transfer to/from=20
>> a scatterlist to a list of hardware address/length pairs.
>>=20
>> I implemented support for the extra features available in the DMA=20
>> controller, such as external pause and external start. I have not=20
>> tested the features yet. I am willing to drop the support if=20
>> everything else looks good.
>>=20
>> I have implemented helper functions for creating the list of=20
>hardware=20
>> address/length pairs as static inline functions in the=20
>linux/fsldma.h=20
>> header. Should I incorporate these into the driver itself and use=20
>> EXPORT_SYMBOL()? I've never done this before :)
>>=20
>
>Any comments on this patch?
>

No comment for now.  Didn't get the time to study the DMA_SLAVE thing.
:(

>I've tested the external start feature, and it works great. I=20

Good.  Is it working with your custom board?  Can I verify this with my
reference board?

>had to set the DMA Request Count (in the mode register) after=20
>the driver was in control. There is no interface for doing=20
>this in the existing driver. I just ioremap()ed the registers=20
>and added the value from my driver after claiming the channel=20
>with dma_request_channel().
>
>There are ways to get the DMA controller into a state where=20
>the CB bit stays set no matter what you do. I have only seen=20
>this during an externally controlled transfer, when the=20
>external master does weird things. I would fix this state in=20
>terminate_all(), but I have been unsuccessful in getting the=20
>DMA controller working again after it has been messed up.

What's the frequency for this to happen?  Is the problem reproducable?

- Leo
