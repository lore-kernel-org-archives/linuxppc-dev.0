Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 301FC679F0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Apr 2006 17:15:00 +1000 (EST)
Date: Mon, 10 Apr 2006 00:14:57 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andre Draszik <kernel@andred.net>
Subject: Re: Slab errors on 4xx (STB04)
Message-ID: <20060410071457.GA16898@gate.ebshome.net>
References: <44398BD4.60904@andred.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44398BD4.60904@andred.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 10, 2006 at 12:33:56AM +0200, Andre Draszik wrote:
> 
> Since it _seems_ to work nevertheless - is CONFIG_DEBUG_SLAB known to be
> broken on this platform?

Yes, it's very likely that CONFIG_DEBUG_SLAB is the culprit here. This 
config option changes allocation alignment (it becomes not L1 cache 
line aligned). For 4xx which has non-coherent L1 cache this with 
almost 100% probability will break DMA, resulting in memory 
corruption.

You can try changing __dma_sync() to do flush_dcache_range() even for 
DMA_FROM_DEVICE case. However, do this only to check this theory, not 
as a permanent solution :).

-- 
Eugene
