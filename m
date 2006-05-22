Return-Path: <SRS0+6268839a6384cbb21a2e+1002+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7717867A3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 08:35:18 +1000 (EST)
Subject: Re: Preferred way to configure MTD physical mapping and partitioning
From: David Woodhouse <dwmw2@infradead.org>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
In-Reply-To: <200605221232.14880.laurent.pinchart@tbox.biz>
References: <200605221232.14880.laurent.pinchart@tbox.biz>
Content-Type: text/plain
Date: Mon, 22 May 2006 23:35:22 +0100
Message-Id: <1148337323.10288.40.camel@shinybook.infradead.org>
Mime-Version: 1.0
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

On Mon, 2006-05-22 at 12:32 +0200, Laurent Pinchart wrote:
> - adding a board specific "driver" in drivers/mtd/maps and handle all mapping 
> manually
> - adding board specific MTD configuration in arch/ppc/platforms with calls to 
> physmap_set_partitions() and physmap_configure()
> - adding board specific MTD configuration in arch/ppc/platforms with a call to 
> physmap_set_partitions(), and using the CONFIG_MTD_PHYSMAP option with 
> physical mapping values provided in the kernel configuration.
> 
> Could anyone comment on the preferred approach ?

None of the above. The physmap driver in the MTD git tree already works
with a platform_device, instead of needing a call to physmap_configure()
or manual configuration at build time. Either register a
platform_device, or preferably extend it to use an of_device too.

-- 
dwmw2
