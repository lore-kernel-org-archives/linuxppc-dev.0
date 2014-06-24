Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44C2D1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 20:11:17 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id eu11so63887pac.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 03:11:14 -0700 (PDT)
Message-ID: <53A94EBD.101@ozlabs.ru>
Date: Tue, 24 Jun 2014 20:11:09 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio: Fix endianness handling for emulated BARs
References: <1403091391-31780-1-git-send-email-aik@ozlabs.ru>	
 <1403116512.3707.175.camel@ul30vt.home> <53A233E9.6030006@ozlabs.ru>	
 <53A241F6.9010307@ozlabs.ru> <53A25D74.5000804@ozlabs.ru>	
 <1403234514.3707.278.camel@ul30vt.home> <1403305961.4587.66.camel@pasglop>
In-Reply-To: <1403305961.4587.66.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2014 09:12 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-06-19 at 21:21 -0600, Alex Williamson wrote:
> 
>> Working on big endian being an accident may be a matter of perspective
> 
>  :-)
> 
>> The comment remains that this patch doesn't actually fix anything except
>> the overhead on big endian systems doing redundant byte swapping and
>> maybe the philosophy that vfio regions are little endian.
> 
> Yes, that works by accident because technically VFIO is a transport and
> thus shouldn't perform any endian swapping of any sort, which remains
> the responsibility of the end driver which is the only one to know
> whether a given BAR location is a a register or some streaming data
> and in the former case whether it's LE or BE (some PCI devices are BE
> even ! :-)
> 
> But yes, in the end, it works with the dual "cancelling" swaps and the
> overhead of those swaps is probably drowned in the noise of the syscall
> overhead.
> 
>> I'm still not a fan of iowrite vs iowritebe, there must be something we
>> can use that doesn't have an implicit swap.
> 
> Sadly there isn't ... In the old day we didn't even have the "be"
> variant and readl/writel style accessors still don't have them either
> for all archs.
> 
> There is __raw_readl/writel but here the semantics are much more than
> just "don't swap", they also don't have memory barriers (which means
> they are essentially useless to most drivers unless those are platform
> specific drivers which know exactly what they are doing, or in the rare
> cases such as accessing a framebuffer which we know never have side
> effects). 
> 
>>  Calling it iowrite*_native is also an abuse of the namespace.
> 
> 
>>  Next thing we know some common code
>> will legitimately use that name. 
> 
> I might make sense to those definitions into a common header. There have
> been a handful of cases in the past that wanted that sort of "native
> byte order" MMIOs iirc (though don't ask me for examples, I can't really
> remember).
> 
>>  If we do need to define an alias
>> (which I'd like to avoid) it should be something like vfio_iowrite32.


Ping?

We need to make a decision whether to move those xxx_native() helpers
somewhere (where?) or leave the patch as is (as we figured out that
iowriteXX functions implement barriers and we cannot just use raw
accessors) and fix commit log to explain everything.

Thanks!




>> Thanks,
> 
> Cheers,
> Ben.
> 
>> Alex
>>
>>>> ===
>>>>
>>>> any better?
>>>>
>>>>
>>>>
>>>>
>>>>>>> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>> ---
>>>>>>>  drivers/vfio/pci/vfio_pci_rdwr.c | 20 ++++++++++++++++----
>>>>>>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
>>>>>>> index 210db24..f363b5a 100644
>>>>>>> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
>>>>>>> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
>>>>>>> @@ -21,6 +21,18 @@
>>>>>>>  
>>>>>>>  #include "vfio_pci_private.h"
>>>>>>>  
>>>>>>> +#ifdef __BIG_ENDIAN__
>>>>>>> +#define ioread16_native		ioread16be
>>>>>>> +#define ioread32_native		ioread32be
>>>>>>> +#define iowrite16_native	iowrite16be
>>>>>>> +#define iowrite32_native	iowrite32be
>>>>>>> +#else
>>>>>>> +#define ioread16_native		ioread16
>>>>>>> +#define ioread32_native		ioread32
>>>>>>> +#define iowrite16_native	iowrite16
>>>>>>> +#define iowrite32_native	iowrite32
>>>>>>> +#endif
>>>>>>> +
>>>>>>>  /*
>>>>>>>   * Read or write from an __iomem region (MMIO or I/O port) with an excluded
>>>>>>>   * range which is inaccessible.  The excluded range drops writes and fills
>>>>>>> @@ -50,9 +62,9 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
>>>>>>>  				if (copy_from_user(&val, buf, 4))
>>>>>>>  					return -EFAULT;
>>>>>>>  
>>>>>>> -				iowrite32(le32_to_cpu(val), io + off);
>>>>>>> +				iowrite32_native(val, io + off);
>>>>>>>  			} else {
>>>>>>> -				val = cpu_to_le32(ioread32(io + off));
>>>>>>> +				val = ioread32_native(io + off);
>>>>>>>  
>>>>>>>  				if (copy_to_user(buf, &val, 4))
>>>>>>>  					return -EFAULT;
>>>>>>> @@ -66,9 +78,9 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
>>>>>>>  				if (copy_from_user(&val, buf, 2))
>>>>>>>  					return -EFAULT;
>>>>>>>  
>>>>>>> -				iowrite16(le16_to_cpu(val), io + off);
>>>>>>> +				iowrite16_native(val, io + off);
>>>>>>>  			} else {
>>>>>>> -				val = cpu_to_le16(ioread16(io + off));
>>>>>>> +				val = ioread16_native(io + off);
>>>>>>>  
>>>>>>>  				if (copy_to_user(buf, &val, 2))
>>>>>>>  					return -EFAULT;
>>>>>>
>>>>>>
>>>>>>

-- 
Alexey
