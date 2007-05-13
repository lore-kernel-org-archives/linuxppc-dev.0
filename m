Return-Path: <tnt@246tNt.com>
Received: from mailgate100.isp.belgacom.be (mailgate100.isp.belgacom.be
	[195.238.6.81]) by ozlabs.org (Postfix) with ESMTP id 60545DDEA2
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 17:20:26 +1000 (EST)
Message-ID: <4646BB76.1080602@246tNt.com>
Date: Sun, 13 May 2007 09:17:10 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/9] powerpc: BestComm core support for Freescale MPC5200
References: <11790019171838-git-send-email-tnt@246tNt.com>
	<200705130127.08761.arnd@arndb.de> <46465295.90309@246tNt.com>
	<200705130224.46114.arnd@arndb.de>
In-Reply-To: <200705130224.46114.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>> However, you could totally implement a "DMA devices" that would just
>> use a simple "copy from there to there" task using this BestComm driver.
>> So other part of the kernel (like network) could use that interface to
>> use the dma engine ...
>>     
>
> Can it also do the advanced operations like XOR on DMA that the
> Intel ioat has? That would be even more interesting, I guess.
>   
Actually yes it can.
It just need someone motivated enough to write it ;)


>>>> +static int __init
>>>> +mpc52xx_bcom_init(void)
>>>> +{
>>>> +	struct device_node *ofn_bcom, *ofn_sram;
>>>> +	struct resource res_bcom;
>>>> +
>>>> +	int rv;
>>>> +
>>>> +	/* Find the bestcomm node. If none, fails 'silently' since
>>>> +	 * we may just be on another platform */
>>>> +	ofn_bcom = of_find_compatible_node(
>>>> +			NULL, "dma-controller", "mpc5200-bestcomm");
>>>> +	if (!ofn_bcom)
>>>> +		return -ENODEV;
>>>>         
>>> I know, my usual rant is getting old, but why is this one not an
>>> of_platform_driver? It's not shared with arch/ppc or with arch/mips,
>>> and it's not needed before module_init() time.
>>>       
>> It needs to be initialized before _any_ other driver that uses bestcomm.
>> When compiled as module that could be an of_platform_driver but when
>> built-in there is apparently no way to ensure it's going to be probed
>> first. (At least no clean way ... )
>>     
>
> Initialization order is always a little tricky, but if you use a 
> subsys_initcall, it should at least come before any regular driver
> like network or disk, and arch/ drivers come before any code in drivers/,
> so I don't see much of a problem here.
>   
Mmm ... Silly of me but I didn't think of that.
I'll give it a shot.

(Actually before the transition to arch/powerpc, this was a
platform_driver ...
but there I could control the probe order with ppc_sys ).

>>> Why don't you use EXPORT_SYMBOL_GPL?
>>>       
>> Why would I ? Is it mandatory now ?
>> I don't really have an objection to non-gpl modules to use the exported
>> functions ...
>>     
>
> It's your choice, but there is a strong recommendation to use _GPL for
> all new interfaces nowadays. If you don't, people might suspect that
> you have a hidden agenda and actually plan to do non-gpl modules
> yourself.
>   
Well if it's recommended ... And since Dale is in favor of it, so be it,
I don't have any hidden agenda ;)


    Sylvain
