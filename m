Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 6B669DE0C1
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:50:39 +1100 (EST)
In-Reply-To: <1231285442.8292.10.camel@localhost>
References: <kexec-29-1-7.miltonm@bga.com> <1231285442.8292.10.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f378ca9151a64ea3cead1b7354e8153c@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: check crash_base for relocatable kernel
Date: Wed, 7 Jan 2009 08:57:13 -0600
To: michael@ellerman.id.au
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[removed Paul from cc and fixed Mohan's email]

On Jan 6, 2009, at 5:44 PM, Michael Ellerman wrote:

> On Fri, 2009-01-02 at 14:46 -0600, Milton Miller wrote:
>> @@ -94,10 +95,35 @@ void __init reserve_crashkernel(void)
>>  				KDUMP_KERNELBASE);
>>
>>  	crashk_res.start = KDUMP_KERNELBASE;
>> +#else
>> +	if (!crashk_res.start) {
>> +		/*
>> +		 * unspecified address, choose a region of specified size
>> +		 * can overlap with initrd (ignoring corruption when retained)
>> +		 * ppc64 requires kernel and some stacks to be in first segemnt
>> +		 */
>> +		crashk_res.start = KDUMP_KERNELBASE;
>> +	}
>> +
>> +	crash_base = PAGE_ALIGN(crashk_res.start);
>> +	if (crash_base != crashk_res.start) {
>> +		printk("Crash kernel base must be aligned to 0x%lx\n",
>> +				PAGE_SIZE);
>> +		crashk_res.start = crash_base;
>> +	}
>> +
>>  #endif
>>  	crash_size = PAGE_ALIGN(crash_size);
>>  	crashk_res.end = crashk_res.start + crash_size - 1;
>>
>> +	/* The crash region must not overlap the current kernel */
>> +	if (overlaps_crashkernel(__pa(_stext), _end - _stext)) {
>> +		printk(KERN_WARNING
>> +			"Crash kernel can not overlap current kernel\n");
>> +		crashk_res.start = crashk_res.end = 0;
>> +		return;
>> +	}
>
> I think we can be smarter here. Why don't we adjust the crash kernel
> region so that it doesn't overlap the first kernel? ie. move it up a
> bit.

How much?   In addition to the size of the kernel, we have to allocate 
(1) the emergeency stacks as we use them to bring up secondary cpus (2) 
the irq stacks in the first segment.   While the second could be met 
easier on systems with 1TB slbs we don't take advantage of that yet.


>
> There's also the issue of the RMO, I'm not sure what we should do 
> there,
> but I think the kernel needs some smarts otherwise users are going to
> shoot themselves in the foot.

I was looking at the code in kexec-tools for the rmo, and it seems 
extremely broken (ie it sets rmo_top on every memory block instead of 
the lowest; the clamp to 768M is the savior for systems with multiple 
blocks).

Do we care about loading a kernel below a relocated kernel (between the 
interrupt vectors and the new kernel)?   I ignored that for now, 
arguing that we always run the first kernel at 0.


>
> We could ignore the @x setting and split the RMO between both kernels
> somewhat intelligently.
>
> What might work is multiple crash regions, that way we could have some
> space in the RMO for the second kernel (say 32MB?), but the rest 
> outside
> - leaving some RMO for the first kernel. But I think that would require
> some serious surgery.
>

Other archs have this, i guess because they read the memory out of 
/proc/iomem.   The trick is knowing what has to be put in real space 
and what can go abvoe the rmo.   Also, we have those horrible hard-code 
rmo to 768M max because some platform (one of the cell ones?) didn't 
make the device tree to show it.  Maybe we can track it down and add 
linux,usable-mem-ranges to fix it up?

Does the generic code support loading into the split regions, or is it 
just for giving the kernel room to run?



So while all of these are nice, what do you think about merging this as 
an interm measure, especially for backporting to 2.6.28 stable (and any 
distro that wants to pick up relocatable kdump)?

milton
