Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55E5CDE0A2
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 06:35:09 +1000 (EST)
Message-Id: <2CFF27D3-1C31-4035-AC98-82F6F48EA32D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090418174852.GA28955@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] fsl_rio: Pass the proper device to dma mapping routines
Date: Tue, 21 Apr 2009 15:35:01 -0500
References: <20090418174852.GA28955@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 18, 2009, at 12:48 PM, Anton Vorontsov wrote:

> The driver should pass a device that specifies internal DMA ops, but
> currently NULL pointer is passed, therefore following bug appears
> during boot up:
>
>  ------------[ cut here ]------------
>  Kernel BUG at c0018a7c [verbose debug info unavailable]
>  Oops: Exception in kernel mode, sig: 5 [#1]
>  [...]
>  NIP [c0018a7c] fsl_rio_doorbell_init+0x34/0x60
>  LR [c0018a70] fsl_rio_doorbell_init+0x28/0x60
>  Call Trace:
>  [ef82bda0] [c0018a70] fsl_rio_doorbell_init+0x28/0x60 (unreliable)
>  [ef82bdc0] [c0019160] fsl_rio_setup+0x6b8/0x84c
>  [ef82be20] [c02d28ac] fsl_of_rio_rpn_probe+0x30/0x50
>  [ef82be40] [c0234f20] of_platform_device_probe+0x5c/0x84
>  [...]
>  ---[ end trace 561bb236c800851f ]---
>
> This patch fixes the issue.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/fsl_rio.c |   28 +++++++++++++++++-----------
> 1 files changed, 17 insertions(+), 11 deletions(-)

applied to merge.

- k
