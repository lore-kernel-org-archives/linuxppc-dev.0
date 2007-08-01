Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 593ABDDD0D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 19:29:28 +1000 (EST)
Message-ID: <46B051F2.5080101@semihalf.com>
Date: Wed, 01 Aug 2007 11:27:14 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [patch 07/35] pasemi_mac: stop using the pci config
	space	accessors for register read/writes
References: <20070705170233.258351000@lixom.net>	<20070705170235.314700000@lixom.net>	<46A91130.8000907@semihalf.com>
	<20070728083530.GA4580@lixom.net>
In-Reply-To: <20070728083530.GA4580@lixom.net>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Thu, Jul 26, 2007 at 11:25:04PM +0200, Marian Balakowicz wrote:
>>
>> Olof Johansson wrote:
>>> Move away from using the pci config access functions for simple register
>>> access.  Our device has all of the registers in the config space (hey,
>>> from the hardware point of view it looks reasonable :-), so we need to
>>> somehow get to it. Newer firmwares have it in the device tree such that
>>> we can just get it and ioremap it there (in case it ever moves in future
>>> products). For now, provide a hardcoded fallback for older firmwares.
>> I have recently tried to apply a group of your MAC patches that
>> includes the one from this email. Strangely, I got a pretty random
>> kernel panics (or kernel freezes) when this patch is included. Panics
>> happen in a random, places and have random causes. What I observed is
>> that replacing newly introduced mac->iob_regs with the corresponding
>> offset from (already ioremapped) hose->cfg_data removed the problem. So,
>> it seems that dereferencing pointers based on a second ioremap on a
>> subset of 0xe000_0000 addresses is problematic.
> 
> The problem is that the IOB register range is 8K, not 4K. I have since
> fixed that bug but I didn't repost the patch series. It does cause weird
> and strange errors to happen since register writes into the second 4K
> would really go to another mapping somewhere else.
> 
> So, the quick fix is to always map 0x2000 in map_one_reg, the slightly better
> one is to check the PCI dev and only map 2K for the IOB.

Thanks for the pointer. Using 0x2000 for IOB solves the problem.

Regards,
Marian
