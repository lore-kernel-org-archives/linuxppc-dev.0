Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 85565B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 19:50:48 +1000 (EST)
Date: Mon, 23 Apr 2012 10:50:13 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Boojin Kim <boojin.kim@samsung.com>
Subject: Re: [PATCH 5/9] dmaengine: provide a common function for
 completing a dma descriptor
Message-ID: <20120423095013.GL24211@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
 <056201cd2135$10ea5b70$32bf1250$%kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <056201cd2135$10ea5b70$32bf1250$%kim@samsung.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: 'Stephen Warren' <swarren@nvidia.com>,
 'Linus Walleij' <linus.walleij@stericsson.com>,
 'Srinidhi Kasagar' <srinidhi.kasagar@stericsson.com>,
 'Vinod Koul' <vinod.koul@intel.com>, 'Dan Williams' <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2012 at 06:40:06PM +0900, Boojin Kim wrote:
> I met a problem on DMA cyclic mode (DMA_CYCLIC) for sound playback.
> Kernel BUG occurs during DMA transfer with DMA cyclic mode.
> This patch makes the cookies into zero. But, cookies should be kept
> during cyclic mode because cyclic mode re-uses the cookies.

The protection is there to prevent cookies being accidentally re-used.
If you're running a cyclic transfer, even then you shouldn't be completing
the same cookie time and time again - I think Vinod also concurs with this.

I think our preference is for cyclic transfers to entire remain uncompleted,
or to get a new cookie each time they allegedly "complete".
