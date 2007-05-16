Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8DF17DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 04:03:58 +1000 (EST)
Received: from [192.168.12.21] (unknown [10.149.0.1])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id B0C628810
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 23:03:56 +0500 (SAMST)
Message-ID: <464B475A.4090808@ru.mvista.com>
Date: Wed, 16 May 2007 22:03:06 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: New version of the device tree aware EMAC driver
References: <20070516032630.GC19127@localhost.localdomain>
	<464B38A9.9000402@ru.mvista.com>
In-Reply-To: <464B38A9.9000402@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> David Gibson wrote:
>   
>> I've made a few more tiny tweaks to BenH's rewritten device-tree based
>> 4xx EMAC driver.  The main change is that it now no longer requires
>> 'device_type', just 'compatible' to be set in the ZMII and MAL device
>> nodes when probing.  This works better with current thinking on
>> flattened device trees which discourages creating new device_type
>> values unless there is a clear use for a new device class binding.
>>
>> The patch can be obtained from:
>>
>> http://ozlabs.org/~dgibson/home/emac/powerpc-emac-new-20070516.patch
>>
>>   
>>     
> In __emac_mdio_read and __emac_mdio_write functions:
>
> +    if (!emac_has_feature(dev, EMAC_FTR_STACR_OC_INVERT))
> +        r |= EMAC_STACR_OC;
>
> should be
>
> +    if (emac_has_feature(dev, EMAC_FTR_STACR_OC_INVERT))
> +        r |= EMAC_STACR_OC;
>
> Thanks.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   
With the above 2 fixes (and Marvell 88E1111 Ethernet PHY support added) 
seems to work fine on Sequoia PPC440EPx,
thanks.
