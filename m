Message-ID: <391834D3.9E57B710@Zentropix.com>
Date: Tue, 09 May 2000 11:54:59 -0400
From: "Daniel G. Clemmensen" <DanC@Zentropix.com>
MIME-Version: 1.0
To: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Getting the image section of the ELF file to load w/ VxWorks boot
 ROM
References: <m12mgPF-001SyZC@bucks> <3917E2A7.6EEDDD93@vas-gmbh.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Przybylski wrote:
>
> Hi,
> I had similar problems when loading kernel images with gdb over BDM into
> an MPC.
> I have no solution (which would be a patch to the Makefile in
> /usr/src/linux/arch/ppc/mbxboot) but I try to handle the symptons:
>   powerpc-linux-objcopy \
>     --set-section-flags=image=contents,alloc,load,readonly,data \
>     --adjust-section-vma=image=$(powerpc-linux-objdump -h
> $kernel/zvmlinux | grep .bss | awk '{print "0x"$4}') \
>     $kernel/zvmlinux \
>     $kernel/zvmlinux2
>
> The first command to objcopy is to set the 'load' flag for the image
> section. Without this, gdb won't load this section.
> The second is to patch the load address of that section to be the same
> as the .bss section. I'm a little bit unsecure about the last, but it
> seems to work. I think this is what the loader expects and I hope
> someone can verify this?
>

I was able to load successfully using a variant of the second method:
I used objcopy to remove the .bss section. This appears to also make the
zImage file smaller by 60,000 bytes or so. I checked the boot code and
determined that this method WILL work if the zImage is NOT initially loaded
into the location is linked for, and WILL NOT work if the zImage IS initially
loaded into the location it is linked for. The reason: The code really does
use the location the .bss section is linked to store read/write variables.
If the image section is physically at that location, it will be damaged.
But,the code then moves itself, but not the image, to its origin location,
and then decompresses the image from its load location to its own origin location.
All of this works just fine, since in this case the image is never resident in the
compiled-in .bss location.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
