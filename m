Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FB7EDE16F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 21:09:05 +1100 (EST)
Message-ID: <49B77CBF.6070005@embedded-sol.com>
Date: Wed, 11 Mar 2009 10:56:31 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: RX problem in ibm_newemac driver
References: <49B6C4A2.8060302@embedded-sol.com>	
	<1236718202.7086.10.camel@pasglop>
	<49B6E658.4010900@embedded-sol.com>	
	<1236725832.7086.21.camel@pasglop>
	<49B6FA3B.8030509@embedded-sol.com>
	<1236730894.7086.29.camel@pasglop>
In-Reply-To: <1236730894.7086.29.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev <netdev@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2009-03-11 at 01:39 +0200, Felix Radensky wrote:
>   
>> Benjamin Herrenschmidt wrote:
>>     
>>> On Wed, 2009-03-11 at 00:14 +0200, Felix Radensky wrote:
>>>   
>>>       
>>>> Yes, seems logical. U-boot has code to enable and disable loopback clock
>>>> for 440SPE, 440EPX,440GRX,405EX, 460EX and 460GT.
>>>>
>>>> I can test patches on my board. Alternatively, I can try something myself
>>>> if you can provide some guidance. I guess you are referring to the code 
>>>> using
>>>> EMAC_FTR_440GX_PHY_CLK_FIX and EMAC_FTR_440EP_PHY_CLK_FIX.
>>>>     
>>>>         
>>> It would be nice if you could try something as I don't have anything to
>>> test here.
>>>
>>> And yes, it's probably one of those 2 fixes that need to be extended.
>>>
>>> I'll have a look later today if I can find the 405EXr user manual and
>>> give you more precise guidance.
>>>       
>
> >From the doc, it looks like it needs the 440 type workaround (and the
> 405EX as well). Can you try this patch:
>
> emac: Fix clock control for 405EX and 405EXr chips
>
> The EMAC variant in the 405EX and 405EXr chips needs the "440EP" type clock
> control workaround to avoid lockups of the Rx side during reset.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Index: linux-work/drivers/net/ibm_newemac/core.c
> ===================================================================
> --- linux-work.orig/drivers/net/ibm_newemac/core.c	2009-03-11 11:13:37.000000000 +1100
> +++ linux-work/drivers/net/ibm_newemac/core.c	2009-03-11 11:14:00.000000000 +1100
> @@ -2594,6 +2594,9 @@ static int __devinit emac_init_config(st
>  		if (of_device_is_compatible(np, "ibm,emac-460ex") ||
>  		    of_device_is_compatible(np, "ibm,emac-460gt"))
>  			dev->features |= EMAC_FTR_460EX_PHY_CLK_FIX;
> +		if (of_device_is_compatible(np, "ibm,emac-405ex") ||
> +		    of_device_is_compatible(np, "ibm,emac-405exr"))
> +			dev->features |= EMAC_FTR_440EP_PHY_CLK_FIX;
>  	} else if (of_device_is_compatible(np, "ibm,emac4")) {
>  		dev->features |= EMAC_FTR_EMAC4;
>  		if (of_device_is_compatible(np, "ibm,emac-440gx"))
>
>
>   
Hi, Ben

This patch fixes a problem for me. Thank you very much for a quick fix.

Felix.
