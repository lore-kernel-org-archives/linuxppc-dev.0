Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96CB9DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:20:30 +1000 (EST)
Message-Id: <4A6C5BFC-C079-4D19-A0FC-992DF2DCF6B4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090404183120.GA21671@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] fsl-diu-fb: Pass the proper device for dma mapping
	routines
Date: Mon, 6 Apr 2009 09:16:00 -0500
References: <20090404183120.GA21671@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Timur Tabi <timur@freescale.com>, Antonino Daplas <adaplas@gmail.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 4, 2009, at 1:31 PM, Anton Vorontsov wrote:

> The driver should pass a device that specifies internal DMA ops, but
> currently NULL pointers are passed, and thus following bug pops up:
>
>  Freescale DIU driver
>  ------------[ cut here ]------------
>  kernel BUG at arch/powerpc/include/asm/dma-mapping.h:237!
>  Oops: Exception in kernel mode, sig: 5 [#1]
>  ...
>  NIP [c01658b4] allocate_buf+0x0/0x8
>  LR [c0306554] fsl_diu_probe+0x2b4/0x518
>  Call Trace:
>  [df02be10] [c030638c] fsl_diu_probe+0xec/0x518 (unreliable)
>  [df02be60] [c020cdec] of_platform_device_probe+0x5c/0x84
>  [df02be80] [c018f5d0] really_probe+0x78/0x1a0
>  [df02bea0] [c018f7c0] __driver_attach+0xa4/0xa8
>  [df02bec0] [c018ea00] bus_for_each_dev+0x60/0x9c
>  [df02bef0] [c018f414] driver_attach+0x24/0x34
>  [df02bf00] [c018f168] bus_add_driver+0x12c/0x1cc
>  [df02bf20] [c018fbdc] driver_register+0x6c/0x110
>  [df02bf30] [c020ccb4] of_register_driver+0x54/0x70
>  [df02bf40] [c03d0a50] fsl_diu_init+0x70/0xa4
>  ...
>
> This patch fixes the issue.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/video/fsl-diu-fb.c |   34 +++++++++++++++++++++-------------
> 1 files changed, 21 insertions(+), 13 deletions(-)

applied

- k
