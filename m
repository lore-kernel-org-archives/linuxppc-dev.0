Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id ADCD5DE055
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 19:46:30 +1100 (EST)
In-Reply-To: <20071213234221.B0BC27D0054@mail142-sin.bigfish.com>
References: <20071213234221.B0BC27D0054@mail142-sin.bigfish.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f7eb0ae3da29213720e6b0049deca335@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/7] bootwrapper: Add a firmware-independent "raw" target.
Date: Fri, 14 Dec 2007 02:05:56 -0600
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Dec 14 10:43:27 EST 2007,  Stephen Neuendorffer wrote:

> From: Grant Likely <grant.likely at secretlab.ca>
>
> This target produces a flat binary rather than an ELF file,
> fixes the entry point at the beginning of the image, and takes
> a complete device tree with no fixups needed.
>
> The device tree must have labels on /#address-cells, the timebase
> frequency, and the memory size.
>
> Signed-off-by: Grant Likely <grant.likely at secretlab.ca>
> ---


You indicated in the intro in 0/ that this was not ready, and you 
didn't include your own s-o-b, but you did not put any statements to 
that effect in the header.  The intro is not copied into patchwork, 
which maintainers often use when deciding what to push.

Now on to why this should not be merged:

In addition to the above, it changes the build rules.  It tries to 
change wrapper to assemble the .dtb into a .o from a .S file, but 
doesn't set any flags to force the assembler into the right mode.  In 
contrast the linker is controlled by the .lds linker script.

In addition, the requirement for assembly labels can easily be 
eliminated.  As mentioned above, they are used for 3 properties.  With 
the existing library (in 2.6.24 and earlier), call simple_malloc_init 
with a small bss array (like BSS_STACK does to allocate stack), and 
then read the properties out of the device tree.  At that point, call 
simple_malloc_init a second time using the found memory size.   As I 
said the last time this was posted, my patches to boot from kexec 
implemented this strategy.

However, with the new libfdt, which is already in for-2.6.25, we should 
no longer need malloc() to simple read the tree.   At least that is 
what was advertised.

> +$(obj)/zImage.raw: vmlinux $(dts) $(wrapperbits)
> +       $(call if_changed,wrap,raw,$(dts))
>

This should be handled by the standard zImage% rule.

> +void platform_init(unsigned long r3, unsigned long r4, unsigned long 
> r5,
> +                   unsigned long r6, unsigned long r7)
>

The calling convention of platform_init is controlled by head, and 
doesn't have a global prototype.  Since you use none of these 
arguments, this implementation should take void.

In general, serial_console_init is not safe to call, as the wrapper has 
no access mode change for its io access macros and instead requires 
firmware to setup a mapping.  That and the fact the wrapper uses the 
same properties to choose the console as the kernel means even 
kexec-tools can't add or delete a property to kill that call.  (This 
statement is made from the viewpoint that this raw image should be 
suitable for kexec in addition to being loaded by a dumb firmware).


I'm not sure exactly what platform you are using this on.  Apparently 
it is a legacy firmware that loads the image and jumps to it leaving 
interrupts on and not invalidating the cache.

I was going to suggest this platform_init be turned into a helper like 
simple_platform_init or so.  However, that brings up a philosophy 
question on what the directory should look like (I was going for a 
modular library with lots of small routines loaded on demand, but 
others are going for fewer files that tend to drag sometimes used 
routines.  They later resist features with "thats a lot of code").  And 
with the read_only libfdt pending, the remaining code maybe considered 
too trivial not to replicate in the platforms that need it.

milton
