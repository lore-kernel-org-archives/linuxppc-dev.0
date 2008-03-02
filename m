Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6367DDDEDA
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 07:48:13 +1100 (EST)
Subject: Re: [BUG/RFC/PATCH] drm: Fix for non-coherent DMA PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080302110505.175270@gmx.net>
References: <20071125234254.B4405DDE49@ozlabs.org>
	<20080302110505.175270@gmx.net>
Content-Type: text/plain
Date: Mon, 03 Mar 2008 07:47:09 +1100
Message-Id: <1204490829.15052.482.camel@pasglop>
Mime-Version: 1.0
Cc: airlied@linux.ie, linuxppc-dev@ozlabs.org, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Xorg (v7.1.1, Debian Etch) crashes with this patch (applied to 2.6.25-rc3)
> on my AmigaOne with a Radeon 9200 (PCIGART mode enabled). See the attached
> log file for the stack trace.

That doesn't look possible, which is weird... looks like we are passing
0 to clean_dcache_range().

Interestingly enough, I can -see- possible issues with the ppc32 DMA API
when trying to use HIGHMEM but that isn't the case here... 

Can you add printk's to ati_pcigart.c to print the arguments passed to

+               dma_sync_single_for_device(&dev->pdev->dev,
+                                          bus_address,
+                                          max_pages * sizeof(u32),
+                                          PCI_DMA_TODEVICE);
+

And also print the result of bus_to_virt(bus_address) ?

Ben.
