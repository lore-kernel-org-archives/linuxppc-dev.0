Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7030D2C0390
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 18:03:02 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 12:30:37 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C3914125805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 12:33:53 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2672nJu10682502
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 12:32:51 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2672pZG026391
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 18:02:52 +1100
Message-ID: <5136EA12.7040703@linux.vnet.ibm.com>
Date: Wed, 06 Mar 2013 15:02:42 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] irq: Add hw continuous IRQs map to virtual continuous
 IRQs support
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1358235536-32741-3-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20130305022348.GB7656@concordia> <51359C9D.5030009@linux.vnet.ibm.com>
 <20130306035443.GB3493@concordia> <5136D582.80101@linux.vnet.ibm.com>
 <20130306054203.GA13075@concordia>
In-Reply-To: <20130306054203.GA13075@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013/3/6 13:42, Michael Ellerman 写道:
> On Wed, Mar 06, 2013 at 01:34:58PM +0800, Mike Qiu wrote:
>> 于 2013/3/6 11:54, Michael Ellerman 写道:
>>> On Tue, Mar 05, 2013 at 03:19:57PM +0800, Mike Qiu wrote:
>>>> 于 2013/3/5 10:23, Michael Ellerman 写道:
>>>>> On Tue, Jan 15, 2013 at 03:38:55PM +0800, Mike Qiu wrote:
>>>>>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>>>>>> index 96f3a1d..38648e6 100644
>>>>>> --- a/kernel/irq/irqdomain.c
>>>>>> +++ b/kernel/irq/irqdomain.c
>>>>>> @@ -636,6 +636,67 @@ int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
>>>>>>   }
>>>>>>   EXPORT_SYMBOL_GPL(irq_create_strict_mappings);
>>>>>> +/**
>>>>>> + * irq_create_mapping_many - Map a range of hw IRQs to a range of virtual IRQs
>>>>>> + * @domain: domain owning the interrupt range
>>>>>> + * @hwirq_base: beginning of continuous hardware IRQ range
>>>>>> + * @count: Number of interrupts to map
>>>>> For multiple-MSI the allocated interrupt numbers must be a power-of-2,
>>>>> and must be naturally aligned. I don't /think/ that's a requirement for
>>>>> the virtual numbers, but it's probably best that we do it anyway.
>>>>>
>>>>> So this API needs to specify that it will give you back a power-of-2
>>>>> block that is naturally aligned - otherwise you can't use it for MSI.
>>>> rtas_call will return the numbers of hardware interrupt, and it
>>>> should be power-of-2, as this I think do not need to specify
>>> You're confusing hardware interrupt numbers and virtual interrupt
>>> numbers. My comment is about irq_create_mapping_many(), which returns
>>> virtual interrupt numbers.
>>>
>>> As I said I don't think there is a requirement that the virtual
>>> interrupt numbers are also a power-of-2 naturally aligned block, but we
>>> should allocate them as one anyway, to avoid any issues in future.
>> But for virtual interrupt numbersit should be a power-of-2 naturally
>> aligned block, because it must be continuous, as the MSI-HOWTO.txt says:
>>
>>      4.2.2 pci_enable_msi_block
>>      int pci_enable_msi_block(struct pci_dev *dev, int count)
>>      This variation on the above call allows a device driver to request
>>      multiple MSIs.  The MSI specification only allows interrupts to be
>>      allocated in powers of two, up to a maximum of 2^5 (32).
>>      If this function returns 0, it has succeeded in allocating at least
>>      as many interrupts as the driver requested
>>      (it may have allocated more in order to satisfy the power-of-two
>>      requirement). In this case, the function enables MSI on this device
>>      and updates dev->irq to be the lowest of the new interrupts
>>      assigned to it. The other interrupts assigned to the device are in
>>      the range dev->irq to dev->irq + count - 1.
>>
>> See the last line, that means for the virtual interrupts must be a
>> continuous block.
> In practice I think things could work if we didn't, because we are not
> using the mask routines that assume that layout.
>
> But you're right, we must implement the API as it's specified, so the
> virtual interrupt numbers must be a naturally aligned power-of-2.
Yes, also your opinion is also right, just becasue the API requires
a naturally aligned power-of-2 interrupt numbers, so we need to
implement it like this.

cheers
>
> cheers
>
