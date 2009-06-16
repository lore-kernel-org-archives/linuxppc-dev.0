Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 91976B71A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 03:48:55 +1000 (EST)
Message-ID: <4A37DB0F.7060801@freescale.com>
Date: Tue, 16 Jun 2009 12:49:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
References: <4A37A503.3030209@oxtel.com> <4A37CF02.5080906@oxtel.com>
	<4A37D073.6020802@freescale.com> <200906161943.38764.arnd@arndb.de>
In-Reply-To: <200906161943.38764.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Chris Pringle <chris.pringle@oxtel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 16 June 2009, Scott Wood wrote:
>> Chris Pringle wrote:
>>> Ah right - that would explain what we're seeing then... Doh. Thought I 
>>> might have been onto something then. Is there any way to force a cache 
>>> flush? That'd at least prove it was a caching issue if it resolved the 
>>> problem.
>> You could enable CONFIG_NOT_COHERENT_CACHE.
> 
> If the whole system is noncoherent, that is the right solution.

I meant it more as a test than a permanent solution...

> If the
> device is the only one, you can also use dma_alloc_noncoherent() and
> flush explicitly with dma_cache_sync().

I don't see how that would help -- aren't those also controlled by 
CONFIG_NOT_COHERENT_CACHE?

-Scott
