Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 8B6C0DDFCB
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 04:26:34 +1000 (EST)
In-Reply-To: <ff25e225fd11b8189ea922a33b71f164@kernel.crashing.org>
References: <4671AB2B.8000008@genesi-usa.com>,
	<ff25e225fd11b8189ea922a33b71f164@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <078cbaeb9ef1dc818b5416dd5cc74537@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: PowerPC boot wrapper and seperate initrd images
Date: Fri, 15 Jun 2007 13:25:39 -0500
To: Matt Sealey <matt@genesi-usa.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Jun 15 20:54:10 EST 2007, Segher Boessenkool wrote:
>> Matt Sealey wrote:
>>
>> However what I
>> am looking to do is have it so that a first stage bootloader (Forth
>> script or binary like Yaboot) loads in the initrd into memory via the
>> client interface or whatever other method, then just fires up the
>> kernel.
>
> Reasonable.

I had the same idea years ago but never took the time to write it;  
using my own kernels I just built zImage.initrd although my apple cube 
limits the size of that.

In other words, please post your script when you have it working.

>> This is simply because.. yaboot doesn't work here yet (Pegasos/Efika).
>
> Yeah yaboot is a royal pain.

yep doesn't trust OF and has its own assumptions ...

>> This is causing problems with distributions as they like to ship a
>> kernel and seperate initrd - and expect a boot loader like BootX or
>> Yaboot or Quick (pick one) to do all it's heavy lifting.
>>
>> However we CAN get the data into the right place, with a tiny Forth
>> script, and there are some standard properties to reference it.
>>
>> The linux,initrd-size and linux,initrd-start properties would
>> be set in the device tree by this tiny forth boot loader.
>>
>> That means of.c needs to pick them up, and main.c needs not to trash
>> them.
>
> Yes.

already does.

>> What I am asking, then, if all that information is correct, is if it
>> would be acceptable in any terms to add this code to the boot wrapper;
>> in platform_init, it would get the properties out of the tree and
>> assign them in the loader_info structure (maybe only if the r3 and
>> r4 values are invalid).

I've already written a routine to pick this up as part of my kexec 
zImage.  I needed it because I am extracting the kernel elf from a 
gzipped cpio using initramfs.   I split it into a separate file last 
night, I'll post shortly.

One suability is before 2.6.22, the properties had to be 64 bits, but 
now they can be 32 or 64 bits.  The wrapper  only stores 32 bit 
numbers.

>>
>> Then in main.c perhaps NOT set those values if they are already in
>> the device tree.. but I am not sure if any manipulation of the
>> values is going on. I assume they're absolute, real-mode addresses
>> and not being weirdly relocated or as an offset to the kernel
>> (I didn't look to hard).

The property contains a physical address.

Older yaboot passed an assumed virtual address in r3 (__va() isn't 
available outside the kernel) so prom_check_initrd checks 
is_kernel_address();  this means OF can't use r3 to store the initrd 
above 3GB or whatever maybe 2GB.

Both the code in boot/main.c and the code in kernel/prom_init.c will 
not overwrite the properties if r4 (size) is 0.

If you set the properties today it will just work.  If you claim the 
memory then of.c malloc won't overwrite it.

However, calling this routine will tell the boot wrapper about it, 
where it prep_initrd() can memmove() it out of the way of 0 to kernel 
mem size so it will not be overwritten, although this will result in 
two copies being claimed.

>>
>> Is it an insane or stupid idea, that everyone hates and thinks
>> we should just fix our broken firmware, or do you think it would
>> come in handy? I'm considering it's a 20-line patch that wouldn't
>> harm anyone..
>>
>> Any comments?

Another consideration is selecting your initrd load address.  prom_init 
will start will flatten the device tree starting at the larger of the 
loaded (offset in memory) kernel _end + 0x4000 or the end of the initrd 
(if it knows about it) rounded up to a page boundary and will not 
consider memory above 768MB.  It must be able to claim space for the 
flattened tree at that address.

>
> It's not a bad plan, but show us the code so we can see
> if it turns out nasty or not :-)
>
> Segher

milton
