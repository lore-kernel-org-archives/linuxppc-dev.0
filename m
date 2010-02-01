Return-Path: <minyard@acm.org>
Received: from vms173011pub.verizon.net (vms173011pub.verizon.net
	[206.46.173.11]) by ozlabs.org (Postfix) with ESMTP id 385F0B7D0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 05:01:24 +1100 (EST)
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
	by vms173011.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0KX60017ZCPNLUM8@vms173011.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 01 Feb 2010 12:00:59 -0600 (CST)
Message-id: <4B6716D8.2050209@acm.org>
Date: Mon, 01 Feb 2010 12:00:56 -0600
From: Corey Minyard <minyard@acm.org>
MIME-version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add DMA mask to MPSC serial and network and UART
	device to serial
References: <20100130000407.GA16156@minyard.local>
	<1265000313.8287.25.camel@pasglop>
In-reply-to: <1265000313.8287.25.camel@pasglop>
Content-type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2010-01-29 at 18:04 -0600, Corey Minyard wrote:
>   
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> The MPSC drivers that use DMA need to set coherent_dma_mask to allow
>> dma_alloc_xxx routines to work properly.  Also, the mpsc serial driver
>> needed to set pi->port.dev to register properly.  With these fixes,
>> the MPSC drivers seem to work again.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>     
>
> Is that enough ? Since 2.6.31 we also need the dma ops to be filled
> properly and obviously that isn't going to happen for random platform
> devices... Or are those initialized elsewhere by your platform code ? In
> which case it might be a good place to also set the coherent mask...	
>   
That's done in ppc_dflt_bus_notify(), but that didn't seem an appropriate
place to do this.  If it is, it's easy enough to add it there, but that 
would
mean it would get set for all devices on any type of ppc system.

-corey
> Maybe we should have a more generic way to set the "default" dma
> information (including ops, masks etc...) for use by platform,
> of_platform etc... devices.
>
> Cheers,
> Ben.
>
>   
>> I'm not really sure about where to set the coherent_dma_mask, it seems
>> like a more general place would be better but I couldn't find it.
>>
>> Without these, the console stops working after the switchover andantipode
>> the network driver fails to allocate buffers.  With these, my board
>> boots up and works fine.
>>
>> Index: linux-2.6.31/drivers/serial/mpsc.c
>> ===================================================================
>> --- linux-2.6.31.orig/drivers/serial/mpsc.c
>> +++ linux-2.6.31/drivers/serial/mpsc.c
>> @@ -2071,6 +2071,9 @@ static int mpsc_drv_probe(struct platfor
>>  		if (!(rc = mpsc_drv_map_regs(pi, dev))) {
>>  			mpsc_drv_get_platform_data(pi, dev, dev->id);
>>  
>> +			dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> +			pi->port.dev = &dev->dev;
>> +
>>  			if (!(rc = mpsc_make_ready(pi))) {
>>  				spin_lock_init(&pi->tx_lock);
>>  				if (!(rc = uart_add_one_port(&mpsc_reg,
>> Index: linux-2.6.31/drivers/net/mv643xx_eth.c
>> ===================================================================
>> --- linux-2.6.31.orig/drivers/net/mv643xx_eth.c
>> +++ linux-2.6.31/drivers/net/mv643xx_eth.c
>> @@ -2916,7 +2916,7 @@ static int mv643xx_eth_probe(struct plat
>>  	mp->shared = platform_get_drvdata(pd->shared);
>>  	mp->base = mp->shared->base + 0x0400 + (pd->port_number << 10);
>>  	mp->port_num = pd->port_number;
>> -
>> +	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>>  	mp->dev = dev;
>>  
>>  	set_params(mp, pd);
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>     
>
>
>   
