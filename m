Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE76CDE11B
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 06:06:44 +1000 (EST)
Date: Sat, 7 Jul 2007 21:13:06 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Message-ID: <20070707211306.2ef074cf@the-village.bc.nu>
In-Reply-To: <20070707094852.9473.21013.stgit@localhost.localdomain>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 07 Jul 2007 13:48:52 +0400
Vitaly Bordug <vitb@kernel.crashing.org> wrote:

> 
> This adds support for MMIO IDE device like CompactFlash 
> in TrueIDE mode.

Really we should be working towards libata support for all new devices.
This looks like a candidate for the existing (or a little enhanced)
pata_platform driver.

> +config BLK_DEV_MMIOIDE
> +	tristate "Memory Mapped IDE support"

Please pick a better description. This isn't a generic option for
enabling MMIO based IDE as you make it sound.


Also we have an accepted match name for ATA platform devices - and adding
another one messes it up irrespective of whether you want libata or
legacy IDE support. If you use the same matches then your platform code,
and everyone elses platform code can work with both drivers, except for
hotpluggability.

Other bugs

- Your remove code releases the resources before the hwif which means it
races another user trying to claim the resource
- Be careful with ide_unregister. It exists and you can call it but its
actually not very safe and there are lots of unfixed races in the IDE
layer if you do


The "should we have a legacy ide driver that matches the libata
pata_platform" question I don't really care about. Its a waste of effort
in many ways but if you've written the code the work is done so why not
use it.

However it needs to be *compatible* so that platform devices can be
claimed by either so the kernel build can pick legacy IDE v libata and
not have to #ifdef all the platform code.

Alan
