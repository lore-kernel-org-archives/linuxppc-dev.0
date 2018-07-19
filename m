Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WcV44NfwzDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 00:54:02 +1000 (AEST)
Subject: Re: [PATCH] powerpc/ps3: Set driver coherent_dma_mask
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-usb@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <Pine.LNX.4.44L0.1807191029570.1491-100000@iolanthe.rowland.org>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <3264269e-9a6e-da8e-3857-c0b55d7ee776@infradead.org>
Date: Thu, 19 Jul 2018 07:53:58 -0700
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1807191029570.1491-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alan,

On 07/19/2018 07:33 AM, Alan Stern wrote:
> On Wed, 18 Jul 2018, Geoff Levand wrote:
> 
>> diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
>> index 8c733492d8fe..454d8c624a3f 100644
>> --- a/drivers/usb/host/ehci-ps3.c
>> +++ b/drivers/usb/host/ehci-ps3.c
>> @@ -86,7 +86,7 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
>>  	int result;
>>  	struct usb_hcd *hcd;
>>  	unsigned int virq;
>> -	static u64 dummy_mask = DMA_BIT_MASK(32);
>> +	static u64 dummy_mask;
>>  
>>  	if (usb_disabled()) {
>>  		result = -ENODEV;
>> @@ -131,7 +131,9 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
>>  		goto fail_irq;
>>  	}
>>  
>> -	dev->core.dma_mask = &dummy_mask; /* FIXME: for improper usb code */
>> +	dummy_mask = DMA_BIT_MASK(32);
>> +	dev->core.dma_mask = &dummy_mask;
>> +	dma_set_coherent_mask(&dev->core, dummy_mask);
> 
> What is the reason for changing a static initialization to a dynamic
> one?  As far as I can see, the patch touches four lines of code but the
> only real difference is addition of a single line (and removal of a 
> comment).

I thought it would be better if all the setting was done in
one place, that's the only reason.

-Geoff
