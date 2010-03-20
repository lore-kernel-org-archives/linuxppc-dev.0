Return-Path: <albert_herranz@yahoo.es>
Received: from smtp147.mail.ukl.yahoo.com (smtp147.mail.ukl.yahoo.com
	[77.238.184.78]) by ozlabs.org (Postfix) with SMTP id 17BA5B7D17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 11:58:13 +1100 (EST)
Message-ID: <4BA41D9D.4060904@yahoo.es>
Date: Sat, 20 Mar 2010 01:58:05 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v5 08/10] wii: add mem2 dma mapping ops
References: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
	<1269023546-25534-9-git-send-email-albert_herranz@yahoo.es>
	<20100319195114.GD31908@phenom.dumpdata.com>
In-Reply-To: <20100319195114.GD31908@phenom.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Konrad Rzeszutek Wilk wrote:
>> +/*
>> + * The mem2_dma "device".
>> + *
>> + * This device "owns" a pool of coherent MEM2 memory that can be shared among
>> + * several devices requiring MEM2 DMA buffers, instead of dedicating specific
>> + * pools for each device.
>> + *
>> + * A device can use the shared coherent MEM2 memory pool by calling
>> + * wii_set_mem2_dma_constraints().
>> + *
>> + */
>> +
>> +struct mem2_dma {
>> +	struct platform_device *pdev;
>> +
> 
> The space there isn't neccessary.
> 

Yes. Having it or not is just a matter of formatting style taste.

>> +	dma_addr_t dma_base;
> 
> I think you need only one of them. You don't seem to use 'base'
>> +	void *base;
>> +	size_t size;
>> +};
> 

I can even get rid of the whole struct mem2_dma and just use a struct platform_device now that there's no mem2_dma_exit() function.
I'll do that on the next iteration.

Thanks for your comments.

Cheers,
Albert
