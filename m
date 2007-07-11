Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74E69DDE40
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 01:30:50 +1000 (EST)
Message-ID: <4694F7A2.6040403@freescale.com>
Date: Wed, 11 Jul 2007 10:30:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
	<20070710161121.GA14556@ld0162-tx32.am.freescale.net>
	<22488704-4826-413B-BD18-F75C2743FB5B@kernel.crashing.org>
In-Reply-To: <22488704-4826-413B-BD18-F75C2743FB5B@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> Some hardware has DMA channels hardwired to certain peripherals,  such as
>> an audio codec.  This keeps them from being used as general purpose  DMA
>> channels.
> 
> 
> I think you need this knowledge in the kernel drivers anyway,
> or at the very least, the device node for for example that
> audio codec needs to refer to the DMA channel in the device
> tree, so this "reserved" property is unnecessary.

The generic DMA driver needs to know not to touch the reserved channels.

>> I'd rather just treat the different DMA channels as independent  devices,
>> rather than children of a dma "bus", and change the compatible name if
>> they're not general purpose.  There's only one register that's shared
>> among the channels, and it's a superfluous status summary register.
> 
> If you make separate nodes for the channels, they need to have
> a parent.  I don't think it makes sense to have the channel
> nodes and the "master" node as siblings -- maybe it all should
> be just one node with a "#channels" property or such?

I don't see the need for a master node -- there are no shared registers 
(other than a redundant read-only status summary register) to 
synchronize access to.  Each channel would be an independent device 
under the SoC bus.

The benefit is that if a channel needs to be driven by (for example) a 
sound driver, it can have a different compatible that will be matched by 
the sound driver, and the generic DMA driver will never see it unless 
the sound driver explicitly chooses to make use of the generic DMA code 
-- and most of the time I think it'd be simpler for the special-purpose 
driver to manage the descriptors itself.

-Scott
