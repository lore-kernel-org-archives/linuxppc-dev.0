Date: Mon, 19 Jul 2004 16:01:08 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linh Dang <linhd@nortelnetworks.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
In-Reply-To: <wn5ekn7amp7.fsf@linhd-2.ca.nortel.com>
Message-ID: <Pine.LNX.4.60.0407191558120.24452@dell.enoriver.com>
References: <Pine.LNX.4.60.0407191350320.23725@dell.enoriver.com>
 <wn5ekn7amp7.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 19 Jul 2004, Linh Dang wrote:

> Don't use the .initramfs section option (the one that's linked with
> with vmlinux.) Build your ramdisk.image.gz as a compressed cpio
> archive. I.e. zvmlinux.initrd's .ramdisk section contains a compressed
> cpio archive instead of an compressed ext2 image.

so, just to clarify, i'm looking at arch/ppc/boot/simple/Makefile, the
excerpt:

$(obj)/zvmlinux.initrd: $(OBJS) $(LIBS) $(srctree)/$(boot)/ld.script \
                 $(images)/vmlinux.gz $(obj)/dummy.o
         $(OBJCOPY) $(OBJCOPY_ARGS) \
-->             --add-section=.ramdisk=$(images)/ramdisk.image.gz \
 		--set-section-flags=.ramdisk=contents,alloc,load,readonly,data \

and all i need to change is "ramdisk.image.gz" to, say, my "newc"
format gzipped cpio archive, "initramfs.cpio.gz", and the early kernel
code should recognize it as such automatically?

i'll give that a shot later.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
