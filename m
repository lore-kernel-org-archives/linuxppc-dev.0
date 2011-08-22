Return-Path: <B25806@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D08BB6F00
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2011 20:00:05 +1000 (EST)
Content-Type: text/plain; charset="utf-8"; format=flowed; delsp=yes
To: Scott Wood <scottwood@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: Re: [PATCH] mtd/physmap_of: Don't add disabled flash devices
References: <1313486750-15211-1-git-send-email-Chunhe.Lan@freescale.com>
	<4E4AE4D8.1080903@freescale.com>
Date: Mon, 22 Aug 2011 18:02:47 +0800
MIME-Version: 1.0
From: Lan Chunhe <b25806@freescale.com>
Message-ID: <op.v0l0uxh9z91x4h@localhost.localdomain>
In-Reply-To: <4E4AE4D8.1080903@freescale.com>
Cc: dwmw2@infradead.org, kumar.gala@freescale.com,
	linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 Aug 2011 05:44:56 +0800, Scott Wood <scottwood@freescale.com>  
wrote:

> On 08/16/2011 04:25 AM, Chunhe Lan wrote:
>> Flash(cfi-flash, jedec-flash, and so on) nodes with the
>> property status="disabled" are not usable and so avoid
>> adding "disabled" flash devices with the system.
>>
>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> ---
>>  drivers/mtd/maps/physmap_of.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mtd/maps/physmap_of.c  
>> b/drivers/mtd/maps/physmap_of.c
>> index d251d1d..812e6dc 100644
>> --- a/drivers/mtd/maps/physmap_of.c
>> +++ b/drivers/mtd/maps/physmap_of.c
>> @@ -219,6 +219,9 @@ static int __devinit of_flash_probe(struct  
>> platform_device *dev)
>>  	struct mtd_info **mtd_list = NULL;
>>  	resource_size_t res_size;
>>
>> +	if (!of_device_is_available(dp))
>> +		return -ENODEV;
>> +
>>  	match = of_match_device(of_flash_match, &dev->dev);
>>  	if (!match)
>>  		return -EINVAL;
>
> Are you actually seeing unavailable devices get probed?  I thought the
> upper layers were supposed to prevent that.

    You are right.
    The upper layers have prevented unavailable devices.
    So, this patch is no need.

    Thanks.

    -Jack Lan

> -Scott
 
