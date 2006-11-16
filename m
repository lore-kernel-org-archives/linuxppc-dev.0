Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 2E30767D09
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 12:42:00 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kAG1fxsa014426
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:41:59 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kAG1fxdI014414
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:41:59 +0900 (JST)
Message-ID: <455BC1E1.2010300@am.sony.com>
Date: Wed, 15 Nov 2006 17:41:53 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
References: <4554DACB.8060809@am.sony.com> <20061115180440.GB18856@lst.de>
In-Reply-To: <20061115180440.GB18856@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
>> + *  Copyright (C) 2006 Sony Computer Entertainment Inc.
>> + *  Copyright 2006 Sony Corp.
> 
> One with a (C) and one without looks very odd.  Who from your corporate
> mother Sony Corp touched this code anyway?


Sony Corp. and Sony Computer Entertainment are different companies with
different policies.  I have no choice here.


>> +enum {
>> +#if defined(CONFIG_PS3PF_USE_LPAR_ADDR)
>> +	USE_LPAR_ADDR = 1,
>> +#else
>> +	USE_LPAR_ADDR = 0,
>> +#endif
>> +#if defined(CONFIG_PS3PF_DYNAMIC_DMA)
>> +	USE_DYNAMIC_DMA = 1,
>> +#else
>> +	USE_DYNAMIC_DMA = 0,
>> +#endif
>> +};
> 
> This is really ugly.  At least dynamic_dma (or as we'd say it iommu)
> shoud be a runtime feature.  So this should just be an
> 
>   "int ps3hv_use_iommu"
>   
> variable initialize to the proper default.


I set it up that way so that the optimizer will remove the unused parts.
This machine doesn't have much memory, and the dynamic (that's not my name
BTW, came from your side) will normally not be used.  I don't really want
to set it up as a runtime option unless there is a real user need.


>> +enum allocate_memory {
>> +	/* bit 63: transferability */
>> +	LV1_AM_TF_NO = 0x00,
>> +	LV1_AM_TF_YES = 0x01,
>> +	/* bit 62: destruction scheme */
>> +	LV1_AM_DS_NO_CONNECTIONS = 0x00,
>> +	LV1_AM_DS_ANYTIME = 0x02,
>> +	/* bit 61: fail or alternative */
>> +	LV1_AM_FA_FAIL = 0x00,
>> +	LV1_AM_FA_ALTERNATIVE = 0x04,
>> +	/* bit 60: lpar address */
>> +	LV1_AM_ADDR_ANY = 0x00,
>> +	LV1_AM_ADDR_0 = 0x08,
>> +};
> 
> If these are for different its they should be in different enums
> and use different prefixes.


These are all flags for lv1_allocate_memory (hence the the LV1_AM_
prefix).  The bits are documented there in the comments, bit 60, 61, etc.


>> +/**
>> + * struct mem_region - memory region structure
>> + * @base: base address
>> + * @size: size in bytes
>> + * @offset: difference between base and rm.size
>> + */
>> +
>> +struct mem_region {
>> +	unsigned long base;
>> +	unsigned long size;
>> +	unsigned long offset;
>> +};
> 
> This seems like a duplication of the iseries lmb, please try to reuse
> that functionality.


There is discussion on this ML to do that, or make some more generic
support that could be used.


>> +static int dma_map_pages(struct ps3pf_dma_region *r, unsigned long virt_addr,
>> +	unsigned long len, struct dma_chunk **c_out)
>> +{
>> +	int result;
>> +	unsigned long phys_addr;
>> +	struct dma_chunk *c;
>> +
>> +	phys_addr = is_kernel_addr(virt_addr) ? __pa(virt_addr) : virt_addr;
> 
> When do you ever get non-kernel addresses into the dma calls? I in
> either case this should move into the caller and the routine
> should get a simple unsigned long phys_addr argument.
> 
> But when looking at this whole dma_map code is looks rather bogus to
> me.  Could it be that you try to pre-map dma regions rather than doing
> it through the dma API?


Yes, I hope to hook it into the existing iommu support now that Ben has
made some changes to make it more generic.


>> +#if !defined(_510B7842_EE09_4B12_BE5C_D217383D50C7)
>> +#define _510B7842_EE09_4B12_BE5C_D217383D50C7
> 
> WTF?


Considering your criticism earlier in this mail regarding the use of a
file name in the file's comments, I'm wondering what your preference
is here, since the convention is to use a symbol based on the file
name...

BTW, I'm surprised you don't recognize it:
uuidgen | tr 'a-z-' 'A-Z_' | sed -e 's/^/_/'


>> +#if defined(CONFIG_BLK_DEV_INITRD)
>> + 	if (initrd_start)
>> + 		ROOT_DEV = Root_RAM0;
>> + 	else
>> +#endif
>> +#if defined(CONFIG_ROOT_NFS)
>> +		ROOT_DEV = Root_NFS;
>> +#else
>> + 		ROOT_DEV = Root_HDA1;
>> +#endif
> 
> Please don't put this auto-select root device idiocy into any new
> ports (Yeah, I'm pretty sure you just copy & pasted it from somewhere..)


I'm glad you gave me this comment, since I only put that in because I
thought it was expected.


>> +#if !defined(PPC_MSG_MIGRATE_TASK)
>> +static const int PPC_MSG_MIGRATE_TASK = 2;
>> +#endif
> 
> This looks rather odd, what is it trying to do?


For some reason the definition of PPC_MSG_MIGRATE_TASK is sometimes 2, and
sometimes not defined, depending on other config options.  It makes the code
much simpler if it is always defined as 2.  Maybe it makes more sense if I
change it to this:

#if !defined(PPC_MSG_MIGRATE_TASK)
#define PPC_MSG_MIGRATE_TASK 2
#endif


>> +unsigned long __deprecated ps3pf_legacy_virq_to_outlet(unsigned int virq);
> 
> Never put deprecated routines into a new code submission.

Good point!  Sorry, that slipped in from another patch when merging.

-Geoff
