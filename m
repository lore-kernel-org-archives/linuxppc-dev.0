Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 84376DDE1E
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 19:33:13 +1000 (EST)
In-Reply-To: <20070924030937.GF8058@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-05.miltonm@bga.com>
	<20070924030937.GF8058@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <940c77ad23c1ac82da1557fd7c2bb563@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 5/15] bootwrapper: occuppied memory ranges
Date: Mon, 24 Sep 2007 04:33:46 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 23, 2007, at 10:09 PM, David Gibson wrote:
> On Fri, Sep 21, 2007 at 06:04:18PM -0500, Milton Miller wrote:
>> Add a set of library routines to manage gross memory allocations.
>>
>> This code uses an array in bss to store upto 32 entrys with merging
>> representing a range of memory below rma_end (aka end of real mode
>> memory at 0).
>>
>> To use this code, a platform would set rma_end (find_rma_end), mark
>> memory ranges occupied (add_known_ranges et al), initialize malloc in
>> the spaces between (ranges_init_malloc), and optionally use the 
>> supplied
>> vmlinux_alloc may be used.
>
> Urg.  It's an awful lot of code for the bootwrapper.  Am I right in
> understanding that the only reason to use the ranges code is for the
> ranges based malloc() and vmlinux_alloc() you get out of it?

Yes.

The ranges based malloc is simple_alloc after finding a sutable chunk 
to operate in.

When doing a kexec, there are several chunks of memory to avoid.  There 
are at least the wrapper, the initrd, the input device tree, and 
possibly rtas and tce tables.  The last two are avoided by parsing the 
memory resrve list in the flat tree blob.

In practice, on 64 bit powerpc kexec-tools loads the kernel (in this 
case zImage) immediately following the old kernel _end (becauset the 
kernel doesnt' allow otherwise, like 32 bit and most other platforms 
do).  If the kernel being execd is larger than the kernel invoking 
kexec, then the vmlinux will not fit below the wrapper, but when they 
are the same it will fit.  So in the malloc region we need space for 
random temps, the final device tree, the kernel, and possibly the 
initrd -- especially if its attached to the zImage instead of supplied 
by kexec-tools.

While I titled this platform kexec, in reality, it is a generic chain 
looading platform for flat device trees in that it is invoked with the 
same calling conveintions as it calls the kernel.  With the current 
policy of run-where-loadeed, the wrapper has to be able to find out 
what memory is available.  It may be above or below itself, and the 
bulk of available memory may be after any of the above mentioned 
ranges.  The only information is the the flat device tree and its 
knowledge of itself.  Most of this code deals with building the sorted 
list of what memory is used.

Actually, there is a hole in that malloc may be initialzed below the 
vmlinux.size and the initrd and deviece tree could end up overwritten.  
This can't be eliminated without doing something like prpmc2800 where 
the kernel decompression is started and the elf header is read before 
initializing malloc.  In practice has not  triggered because the 
vmlinux will be malloced before the device tree without an initrd, and 
with it the kernel is likely smaller than the wrapper (since the memory 
chunk at 0 is avoided, it requires the end of some other chunk to be 
low in memory).

At one point you had mentioned considering changes to run out of bss 
and handling the initrd and kernel with calls to memmove; any such 
movement would requrie similar information to what is being built into 
the storted structure in this code to support externally loaded initrds 
and device-trees, which could not be allocated into the bss wihout 
arbitrarilly limiting their size.

I've made several changes to the split btween memranges.c and kexec.c 
over time.  Perhaps there are more left.  There is a bit of policy in 
the ranges malloc initialilzation; that could probably be eliminated by 
query functions for the largest chunk. The vmlinux alloc could try just 
0 and malloc().  And the area from the last occupied range to roa_end 
should be available for malloc as well as the kernel.

milton
