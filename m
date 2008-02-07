Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BE932DDFCC
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 01:57:05 +1100 (EST)
Message-ID: <47AB1BD2.9070104@ru.mvista.com>
Date: Thu, 07 Feb 2008 17:55:14 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH] MTD support for the AMCC Taishan
References: <120203530465-git-send-email-kaloz@openwrt.org>
	<op.t55gr5lb2s3iss@ecaz.afh.b-m.hu>
	<20080207060012.788e4258@zod.rchland.ibm.com>
	<47AB0BC3.2000202@ru.mvista.com>
	<op.t55p8elk2s3iss@ecaz.afh.b-m.hu>
	<47AB1023.9040707@ru.mvista.com>
	<op.t55r5tt22s3iss@ecaz.afh.b-m.hu>
In-Reply-To: <op.t55r5tt22s3iss@ecaz.afh.b-m.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Imre Kaloz wrote:
> On Thu, 07 Feb 2008 15:05:23 +0100, Valentine Barshak 
> <vbarshak@ru.mvista.com> wrote:
> 
>>> Well, arch/ppc calculates the mtd2 dynamically and doesn't create
>>> a separate partition for kozio.
>>
>> That dynamic size calculation depends on the flash size.
>> The board I use has a 64MB NOR flash (I'm not aware of other Taishan 
>> boards having chips of different size). So AFAIU if such board exists, 
>> we'll need a cuboot flash-size fixup.
> 
> 
> All Taishan boards have 64MB flash (2x32MB). Denx was doing the size 
> calculation
> to dynamically allocate mtd2 based on the size of mtd0+mtd1 if I recall 
> right.
>

This is actually the code:
arch/ppc/platforms/4xx/taishan.c:static int taishan_setup_flash(void)
{
taishan_nor_parts[2].size = __res.bi_flashsize -
		RW_PART0_SZ - RW_PART1_SZ - RW_PART3_SZ - RW_PART4_SZ;

Thanks,
Valentine.
> 
> Cheers,
> Imre
