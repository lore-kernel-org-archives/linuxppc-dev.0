Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 568DBDDDF7
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 00:24:15 +1000 (EST)
Message-ID: <46FD0E4D.30305@ru.mvista.com>
Date: Fri, 28 Sep 2007 18:23:09 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
Subject: Re: [RFC] [PATCH] PowerPC: add more than 4MB kernel image size support
	to bootwarapper
References: <20070924113627.GA30504@ru.mvista.com>
	<20070925022935.GI30338@localhost.localdomain>
In-Reply-To: <20070925022935.GI30338@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Mon, Sep 24, 2007 at 03:36:27PM +0400, Valentine Barshak wrote:
>> Currently zImage is linked at the 4MB base address.
>> Some platforms (using cuboot, treeboot) need the zImage's
>> entry point and base address. They place zImage exactly
>> at the base address it's been linked to. Sometimes 4MB left
>> at the start of the memory is simply not enough to unpack zImage.
>> This could happen with initramfs enabled, since the kernel image
>> packed along with initramfs.cpio could be over 5MB in size.
>> This patch checks vmlinux image size and links zImage at
>> the base address that is equal to the unpacked image size
>> aligned to 4MB boundary. This way zImage base address is 4MB
>> only if unpacked kernel image size is less then 4MB.
> 
> Good plan.  However..
> 
> [snip]
>> diff -ruN linux-2.6.orig/arch/powerpc/boot/zImage.lds.S linux-2.6/arch/powerpc/boot/zImage.lds.S
>> --- linux-2.6.orig/arch/powerpc/boot/zImage.lds.S	2007-09-22 00:48:08.000000000 +0400
>> +++ linux-2.6/arch/powerpc/boot/zImage.lds.S	2007-09-22 04:03:58.000000000 +0400
>> @@ -3,7 +3,7 @@
>>  EXTERN(_zimage_start)
>>  SECTIONS
>>  {
>> -  . = (4*1024*1024);
>> +  . = ALIGN((_kend - _kstart), (4*1024*1024));
> 
> ..I don't see any reason to keep the 4MB granularity.  I would just
> align the address to say a 64k boundary (64k because that's the
> granularity used in the normal ABI).

Looking deeper at this I've found that currently u-boot thinks that 
memory space over 8MB is not reached by Linux kernel (CFG_BOOTMAPSZ 
defined as (8 << 20)), although all physical memory is identity mapped. 
That's why it puts command line and board info structure as high as 
possible within the first 8MB. This worked fine with uImage, since 
u-boot always unpacked it to 0. Now, cuImage has to be unpacked higher 
(we need space at the start of the memory to eventually put vmlinux 
image there). So, if unpacked kernel image crosses 8MB boundary, it gets 
damaged by u-boot when it prepares cmd_line and bdinfo. The possible 
workaround for that is to always link zImage at >=8MB base or to have 
4MB granularity like this:

+  . = ALIGN((_kend - _kstart + 64*1024), (4*1024*1024));

Reserve at least 64K for u-boot cmd_line and bdinfo.
Thanks,
Valentine.

> 
>>    _start = .;
>>    .text      :
>>    {
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
> 
