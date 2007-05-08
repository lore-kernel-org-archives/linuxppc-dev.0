Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1DBA8DDECA
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 01:29:37 +1000 (EST)
Message-ID: <46409759.1020105@freescale.com>
Date: Tue, 08 May 2007 10:29:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 05/13] Document the fsl, magic-packet property in gianfar
	nodes.
References: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
	<B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
	<463F9A38.6080408@freescale.com>
	<AC7B08C0-E41A-458F-8E9F-59901443600A@freescale.com>
	<3FE06AFA-BEE6-46CF-B12C-29D979AE50D7@kernel.crashing.org>
In-Reply-To: <3FE06AFA-BEE6-46CF-B12C-29D979AE50D7@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On May 7, 2007, at 4:51 PM, Andy Fleming wrote:
>> Yeah, I just read that.  You should either make that more explicit in
>> the documentation, or make it generic.  It's fine if there are
>> drivers/devices that don't need to be told or tell anyone that they
>> recognize magic packets for them to work.  The lack of the property
>> in other controllers won't break anything.
>>
>> But I'm fine if you just document that the bit indicates,
>> specifically, the presence of magic-packet bits in certain registers
>> on the eTSEC.
> 
> I'd ask is it really freescale specific?  In that I'd assume its  
> support for the standard wake-on-lan packet.

It is the standard wake-on-lan packet, but the intent of the property is 
not to advertise to the entire system that this device supports it, but 
rather to indicate that the MPEN bit and the like are valid for the 
driver to use.  Making it standard means that someone might use it for 
other purposes, such as pm config tools digging around in 
/proc/device-tree (sure, they could just use ethtool -- but they might 
not), which would mean that all magic-packet-capable devices (gianfar or 
not) would need the property.

If we want to do that, fine -- but that change is at a different scope 
than the one I made.

-Scott
