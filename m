Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com",
	Issuer "GeoTrust SSL CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E86F9B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Sep 2011 22:00:11 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id p86BsXPJ015922
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2011 21:54:33 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p86Bxwoa1785878
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2011 21:59:58 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p86BxwjI032210
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2011 21:59:58 +1000
Message-ID: <4E660B3B.3070608@linux.vnet.ibm.com>
Date: Tue, 06 Sep 2011 17:29:55 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [RFC PATCH 02/10] fadump: Reserve the memory for firmware assisted
	dump.
References: <20110713180252.6210.34810.stgit@mars.in.ibm.com>
	<20110713180648.6210.39530.stgit@mars.in.ibm.com>
	<20110831141134.590c4f4e@kryten>
In-Reply-To: <20110831141134.590c4f4e@kryten>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On 08/31/2011 09:41 AM, Anton Blanchard wrote:
> 
> Hi Mahesh,
> 
> Just a few comments.
> 
>> +#define RMR_START	0x0
>> +#define RMR_END		(0x1UL << 28)	/* 256 MB */
> 
> What if the RMO is bigger than 256MB? Should we be using ppc64_rma_size?

The idea was to have a minimum memory threshold that requires for a
kernel to boot successfully. On some Power systems where RMO is 128MB,
it still requires minimum of 256MB for kernel to boot successfully.

I think we can rename above #defines as BOOT_MEM_START and BOOT_MEM_END
respectively and have BOOT_MEM_END defined as below:

#define BOOT_MEM_END 	((ppc64_rma_size < (0x1UL << 28)) ? \
			(0x1UL << 28) : ppc64_rma_size)

What do you think?

> 
>> +#ifdef DEBUG
>> +#define PREFIX		"fadump: "
>> +#define DBG(fmt...)	printk(KERN_ERR PREFIX fmt)
>> +#else
>> +#define DBG(fmt...)
>> +#endif
> 
> We should use the standard debug macros (pr_debug etc).

Sure will do that.

> 
>> +/* Global variable to hold firmware assisted dump configuration info. */
>> +static struct fw_dump fw_dump;
> 
> You can remove this comment, especially because the variable isn't global :)

Agree.

> 
>> +	sections = of_get_flat_dt_prop(node, "ibm,configure-kernel-dump-sizes",
>> +					NULL);
>> +
>> +	if (!sections)
>> +		return 0;
>> +
>> +	for (i = 0; i < FW_DUMP_NUM_SECTIONS; i++) {
>> +		switch (sections[i].dump_section) {
>> +		case FADUMP_CPU_STATE_DATA:
>> +			fw_dump.cpu_state_data_size =
>> sections[i].section_size;
>> +			break;
>> +		case FADUMP_HPTE_REGION:
>> +			fw_dump.hpte_region_size =
>> sections[i].section_size;
>> +			break;
>> +		}
>> +	}
>> +	return 1;
>> +}
> 
> This makes me a bit nervous. We should really get the size of the property
> and use it to iterate through the array. I saw no requirement in the PAPR
> that the array had to be 2 entries long.
> 

Agree. Will make the change.

>> +static inline unsigned long calculate_reserve_size(void)
>> +{
>> +	unsigned long size;
>> +
>> +	/* divide by 20 to get 5% of value */
>> +	size = memblock_end_of_DRAM();
>> +	do_div(size, 20);
>> +
>> +	/* round it down in multiples of 256 */
>> +	size = size & ~0x0FFFFFFFUL;
>> +
>> +	/* Truncate to memory_limit. We don't want to over reserve
>> the memory.*/
>> +	if (memory_limit && size > memory_limit)
>> +		size = memory_limit;
>> +
>> +	return (size > RMR_END ? size : RMR_END);
>> +}
> 
> 5% is pretty aribitrary, that's 400GB on an 8TB box. Also our experience
> with kdump is that 256MB is too small. Is there any reason to scale it
> with memory size? Can we do what kdump does and set it to a single
> value (eg 512MB)?

I have picked up this heuristic from the phyp-assisted dump code. I am
yet to figure out a fool-proof method to calculate the minimum memory
needed for any Power box to successfully boot. Till then, I presume we
can use this heuristic based approach?

While testing these patches on huge power system with 1TB RAM and 896
CPUs, I found that even 512MB is small. Hence setting it to a single
value may not work for all system configuration.

> 
> We could override the default with a boot option, which is similar to
> how kdump specifies the region to reserve.

Agree, will work on the change.

Thanks,
-Mahesh.
