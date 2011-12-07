Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 583341007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 04:18:16 +1100 (EST)
Message-ID: <4EDF9F9C.7050702@freescale.com>
Date: Wed, 7 Dec 2011 11:17:16 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Subject: Re: [PATCH 1/2 v2] mtd/nand: fixup for fmr initialization of Freescale
 NAND controller
References: <1323161655-19050-1-git-send-email-Shengzhou.Liu@freescale.com>
 <4EDE4DEC.7010308@freescale.com>
 <3F453DDFF675A64A89321A1F352810216B0787@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <3F453DDFF675A64A89321A1F352810216B0787@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2011 12:30 AM, Liu Shengzhou-B36685 wrote:
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Wednesday, December 07, 2011 1:16 AM
>> To: Liu Shengzhou-B36685
>> Cc: linuxppc-dev@lists.ozlabs.org; linux-mtd@lists.infradead.org;
>> dwmw2@infradead.org; Gala Kumar-B11780
>> Subject: Re: [PATCH 1/2 v2] mtd/nand: fixup for fmr initialization of
>> Freescale NAND controller
>>
>> On 12/06/2011 02:54 AM, Shengzhou Liu wrote:
>>> There was a bug for fmr initialization, which lead to  fmr was always
>>> 0x100 in fsl_elbc_chip_init() and caused FCM command timeout before
>>> calling fsl_elbc_chip_init_tail(), now we initialize CWTO to maximum
>>> timeout value and not relying on the setting of bootloader.
>>>
>>> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
>>> ---
>>> v2: make fmr not relying on the setting of bootloader.
>>>
>>>  drivers/mtd/nand/fsl_elbc_nand.c |   10 +++++-----
>>>  1 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/fsl_elbc_nand.c
>>> b/drivers/mtd/nand/fsl_elbc_nand.c
>>> index eedd8ee..4f405a0 100644
>>> --- a/drivers/mtd/nand/fsl_elbc_nand.c
>>> +++ b/drivers/mtd/nand/fsl_elbc_nand.c
>>> @@ -659,9 +659,7 @@ static int fsl_elbc_chip_init_tail(struct mtd_info
>> *mtd)
>>>  	if (chip->pagemask & 0xff000000)
>>>  		al++;
>>>
>>> -	/* add to ECCM mode set in fsl_elbc_init */
>>> -	priv->fmr |= (12 << FMR_CWTO_SHIFT) |  /* Timeout > 12 ms */
>>> -	             (al << FMR_AL_SHIFT);
>>> +	priv->fmr |= al << FMR_AL_SHIFT;
>>>
>>>  	dev_dbg(priv->dev, "fsl_elbc_init: nand->numchips = %d\n",
>>>  	        chip->numchips);
>>> @@ -764,8 +762,10 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd
>> *priv)
>>>  	priv->mtd.priv = chip;
>>>  	priv->mtd.owner = THIS_MODULE;
>>>
>>> -	/* Set the ECCM according to the settings in bootloader.*/
>>> -	priv->fmr = in_be32(&lbc->fmr) & FMR_ECCM;
>>> +	/* set timeout to maximum */
>>> +	priv->fmr = 15 << FMR_CWTO_SHIFT;
>>> +	if (in_be32(&lbc->bank[priv->bank].or) & OR_FCM_PGS)
>>> +		priv->fmr |= FMR_ECCM;
>>
>> Please do not change the way ECCM is handled.  We probably should have
>> done it this way from the start, but at this point it breaks
>> compatibility if you have a large page flash and the firmware didn't
>> touch NAND.
>>
>> -Scott
> [Shengzhou] This patch doesn't change the way ECCM is handled, it's still same as before, just make sure CWTO timeout is set to maximum.  

It does change it.  It used to use the existing value in FMR, and now it
sets it based on ORn[PGS].

-Scott
