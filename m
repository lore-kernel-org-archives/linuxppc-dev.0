Return-Path: <R58472@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5960DB7148
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 14:16:08 +1100 (EST)
Received: from mail32-am1 (localhost.localdomain [127.0.0.1])	by
	mail32-am1-R.bigfish.com (Postfix) with ESMTP id 63C77BA8319	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 12 Nov 2010 03:16:02 +0000 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.242])	by
	mail32-am1.bigfish.com (Postfix) with ESMTP id 15243E8804E	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 12 Nov 2010 03:16:02 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oAC3FwHr009419	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 20:15:58 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id oAC3FvAU015265	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 21:15:58 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Subject: RE: [PATCH v2] fsldma: add support to 36-bit physical address
Date: Fri, 12 Nov 2010 11:16:46 +0800
Message-ID: <F9BD3E0A8083BE4ABAA94D7EDD7E3F6339D5ED@zch01exm26.fsl.freescale.net>
In-Reply-To: <54AAF9B7-9533-45B8-9C49-A964203AF707@kernel.crashing.org>
References: <1289477789-10651-1-git-send-email-leoli@freescale.com>
	<54AAF9B7-9533-45B8-9C49-A964203AF707@kernel.crashing.org>
From: Li Yang-R58472 <r58472@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: Re: [PATCH v2] fsldma: add support to 36-bit physical address
>
>
>On Nov 11, 2010, at 6:16 AM, Li Yang wrote:
>
>> Expand the dma_mask of fsldma device to 36-bit, indicating that the
>> DMA engine can deal with 36-bit physical address and does not need =
the
>> SWIOTLB to create bounce buffer for it when doing dma_map_*().
>>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> Add more detailed commit message
>>
>> drivers/dma/fsldma.c |    4 +++-
>> 1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c index
>> cea08be..8c79b37 100644
>> --- a/drivers/dma/fsldma.c
>> +++ b/drivers/dma/fsldma.c
>> @@ -1,7 +1,7 @@
>> /*
>>  * Freescale MPC85xx, MPC83xx DMA Engine support
>>  *
>> - * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights =
reserved.
>> + * Copyright (C) 2007-2010 Freescale Semiconductor, Inc. All rights
>reserved.
>>  *
>>  * Author:
>>  *   Zhang Wei <wei.zhang@freescale.com>, Jul 2007
>> @@ -1338,6 +1338,8 @@ static int __devinit fsldma_of_probe(struct
>platform_device *op,
>> 	fdev->common.device_control =3D fsl_dma_device_control;
>> 	fdev->common.dev =3D &op->dev;
>>
>> +	dma_set_mask(&(op->dev), DMA_BIT_MASK(36));
>> +
>
>Is there any reason we shouldn't set DMA_BIT_MASK(64) since the DMA =
block
>programming model allows the address to be 64-bits?

The current code is only verified on chips with 36-bit physical address. =
 I'm not sure if the driver can work without any change on the 64-bit =
chip, although the register model suggests it can work well with 64-bit. =
 If you can confirm that it's compatible with the block on 64-bit chip, =
then we can change it to 64 bit dma mask.

- Leo
