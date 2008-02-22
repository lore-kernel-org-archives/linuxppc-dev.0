Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E86B5DE044
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 06:17:53 +1100 (EST)
Message-ID: <47BF1F6E.8050805@ru.mvista.com>
Date: Fri, 22 Feb 2008 22:15:58 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC][PATCH] PowerPC 4xx: ibm_newemac 440GX phy clock	workaround.
References: <20080221144617.GA19465@ru.mvista.com>
	<1203634340.10422.203.camel@pasglop>
In-Reply-To: <1203634340.10422.203.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-02-21 at 17:46 +0300, Valentine Barshak wrote:
>> The PowerPC 440GX Taishan board fails to reset EMAC3 (reset timeout error)
>> and because of that it can't find PHY chip. The older ibm_emac driver had
>> a workaround for that: the EMAC_CLK_INTERNAL/EMAC_CLK_EXTERNAL macros which
>> toggle the Ethernet Clock Select bit in the SDR0_MFR register. This patch
>> does the same for "ibm,emac-440gx" compatible chips.
> 
> The main problem is that will force clock on -all- EMACs ... which can
> be a problem as they can be in probe at the same time. Might be worth
> also adding a global mutex around that block.

I've tried to move clock selection inside the global emac_phy_map_lock 
block. That works fine for 440GX.

> 
> Also, would you mind having a look at the other workaround for the
> similar bug?

OK, I'll add 440EP/440GR workaround, but I'm not sure if we need it for
the currently supported boards. The older ibm_emac driver also has a 
workaround for it on 405ep. This part uses CPC0 dcr registers. So, looks 
like we'll have to search device tree for the CPC0 entry in ibm_newemac 
driver, map dcr registers and select clock with dcr_read/write calls. 
I've omitted the 405ep part, since there's currently no board supported.

Thanks,
Valentine.
> 
> Cheers,
> Ben.
> 
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> ---
>>  drivers/net/ibm_newemac/core.c |   16 +++++++++++++++-
>>  drivers/net/ibm_newemac/core.h |    8 ++++++--
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff -pruN linux-2.6.orig/drivers/net/ibm_newemac/core.c linux-2.6/drivers/net/ibm_newemac/core.c
>> --- linux-2.6.orig/drivers/net/ibm_newemac/core.c	2008-02-21 16:45:36.000000000 +0300
>> +++ linux-2.6/drivers/net/ibm_newemac/core.c	2008-02-21 17:21:21.000000000 +0300
>> @@ -43,6 +43,8 @@
>>  #include <asm/io.h>
>>  #include <asm/dma.h>
>>  #include <asm/uaccess.h>
>> +#include <asm/dcr.h>
>> +#include <asm/dcr-regs.h>
>>  
>>  #include "core.h"
>>  
>> @@ -2480,8 +2482,11 @@ static int __devinit emac_init_config(st
>>  	}
>>  
>>  	/* Check EMAC version */
>> -	if (of_device_is_compatible(np, "ibm,emac4"))
>> +	if (of_device_is_compatible(np, "ibm,emac4")) {
>>  		dev->features |= EMAC_FTR_EMAC4;
>> +		if (of_device_is_compatible(np, "ibm,emac-440gx"))
>> +			dev->features |= EMAC_FTR_440GX_PHY_CLK_FIX;
>> +	}
>>  
>>  	/* Fixup some feature bits based on the device tree */
>>  	if (of_get_property(np, "has-inverted-stacr-oc", NULL))
>> @@ -2673,8 +2678,17 @@ static int __devinit emac_probe(struct o
>>  	dev->stop_timeout = STOP_TIMEOUT_100;
>>  	INIT_DELAYED_WORK(&dev->link_work, emac_link_timer);
>>  
>> +	/* Enable internal phy clock source */
>> +	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
>> +		mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) | SDR0_MFR_ECS);
>> +
>>  	/* Find PHY if any */
>>  	err = emac_init_phy(dev);
>> +
>> +	/* Enable external phy clock source */
>> +	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
>> +		mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) & ~SDR0_MFR_ECS);
>> +
>>  	if (err != 0)
>>  		goto err_detach_tah;
>>  
>> diff -pruN linux-2.6.orig/drivers/net/ibm_newemac/core.h linux-2.6/drivers/net/ibm_newemac/core.h
>> --- linux-2.6.orig/drivers/net/ibm_newemac/core.h	2008-02-21 16:45:36.000000000 +0300
>> +++ linux-2.6/drivers/net/ibm_newemac/core.h	2008-02-21 17:21:47.000000000 +0300
>> @@ -301,6 +301,10 @@ struct emac_instance {
>>   * Set if we have new type STACR with STAOPC
>>   */
>>  #define EMAC_FTR_HAS_NEW_STACR		0x00000040
>> +/*
>> + * Set if we need phy clock workaround for 440gx
>> + */
>> +#define EMAC_FTR_440GX_PHY_CLK_FIX	0x00000080
>>  
>>
>>  /* Right now, we don't quite handle the always/possible masks on the
>> @@ -312,8 +316,8 @@ enum {
>>  
>>  	EMAC_FTRS_POSSIBLE	=
>>  #ifdef CONFIG_IBM_NEW_EMAC_EMAC4
>> -	    EMAC_FTR_EMAC4	| EMAC_FTR_HAS_NEW_STACR	|
>> -	    EMAC_FTR_STACR_OC_INVERT	|
>> +	    EMAC_FTR_EMAC4 | EMAC_FTR_HAS_NEW_STACR |
>> +	    EMAC_FTR_STACR_OC_INVERT | EMAC_FTR_440GX_PHY_CLK_FIX |
>>  #endif
>>  #ifdef CONFIG_IBM_NEW_EMAC_TAH
>>  	    EMAC_FTR_HAS_TAH	|
> 
