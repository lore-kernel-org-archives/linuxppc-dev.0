Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 9527CDE19A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 13:51:46 +1000 (EST)
Message-ID: <4A137E4F.4040900@ovro.caltech.edu>
Date: Tue, 19 May 2009 20:51:43 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Sauce.Cheng" <chmhou@sina.com>
Subject: Re: question : DMA of PCI bridge
References: <23628338.post@talk.nabble.com>
In-Reply-To: <23628338.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> Now I attempt to fetch data from peripheral device to SDRAM, and it has been
> successed
> 
> but how the DMA controller know the data bandwidth of src and dest.
> 
> for example, if i get a 16bits data with a 32bits bus, and other 16bits will
> be set high
> and data will fetched into cache line of dma, then it will be wrote to
> 32bits SDRAM.

You'll need to give us a little more detail. For example,
what processor are you using to perform the transaction?

Your email title says DMA of PCI bridge, however, you
mention peripheral to SDRAM. Are you using a DMA controller
on the peripheral, eg. a PCI bus master, to DMA into the
host SDRAM, or are you using a host DMA controller to
DMA over PCI into memory on the host?

Whether or not you get packing bytes when you access a
16-bit device and transfer the data to a 32-bit destination
depends on how the device is mapped. For example, a 16-bit
device can be implemented such that it responds to 8-bit,
16-bit, and 32-bit requests, but the 32-bit requests will
require more wait-states, since the device has to be
read from twice before constructing a 32-bit word to
place on the PCI bus.

Its also possible that the DMA controller can be configured
to deal with different source and destination widths. However
without knowing what processor or DMA controller you are
asking about, theres not much to say.

Cheers,
Dave
