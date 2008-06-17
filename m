Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C20DDE4D3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 05:31:40 +1000 (EST)
Message-ID: <48581113.4060101@freescale.com>
Date: Tue, 17 Jun 2008 14:31:31 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
	<20080617192237.GA12961@uranus.ravnborg.org>
In-Reply-To: <20080617192237.GA12961@uranus.ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, John Rigby <jrigby@freescale.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sam Ravnborg wrote:
>> +	data = of_get_property(ofdev->node, "fsl,align-tx-packets", &len);
>> +	if (data && len == 4)
>> +		fpi->align_tx_packets = *data;
>> +
> Where did "4" come from. USe a define with a desriptive name.

It's sizeof(u32), i.e. one device tree cell.  This is fairly normal.

>>  	fpi->rx_ring = 32;
>>  	fpi->tx_ring = 32;
> Same for "32"
>>  	fpi->rx_copybreak = 240;
> Same for "240".

They're arbitrary tuning parameters.  How is a #define any more 
descriptive than the field name?

Besides, that's pre-existing, and has nothing to do with this patch.

>> --- a/drivers/net/fs_enet/fs_enet.h
>> +++ b/drivers/net/fs_enet/fs_enet.h
>> @@ -10,12 +10,17 @@
>>  
>>  #include <linux/fs_enet_pd.h>
>>  #include <asm/fs_pd.h>
>> +#ifdef CONFIG_FS_ENET_MPC5121_FEC
>> +#include "fec_mpc5121.h"
>> +#endif
> 
> Which is this include ifdeffed - looks like some wrong concept.

This has already been discussed.  There are two similar but different 
ethernet controllers that are being targeted, and the chips they are a 
part of (8xx and 512x) are already mutually exclusive with respect to 
multiplatform kernels due to core differences.

> The amount of ifdef introduced looks bad..

Yes, it's bad -- but it's a matter of which is the lesser evil, a few 
ifdefs or large amounts of mostly duplicated code.

> And try to run the patch through scripts/checkpatch.pl
> And try to split it up a bit.

Other than the fec_t thing, I don't see any needed splitting...

-Scott
