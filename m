To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
References: <Pine.LNX.4.60.0407191558120.24452@dell.enoriver.com>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Mon, 19 Jul 2004 21:29:38 -0400
In-Reply-To: <Pine.LNX.4.60.0407191558120.24452@dell.enoriver.com> (Robert
 P. J. Day's message of "Mon, 19 Jul 2004 16:01:08 -0400")
Message-ID: <wn54qo3a2kd.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 19 Jul 2004, rpjday@mindspring.com wrote:
[...]
>
> and all i need to change is "ramdisk.image.gz" to, say, my "newc"
> format gzipped cpio archive, "initramfs.cpio.gz", and the early
> kernel code should recognize it as such automatically?
>
> i'll give that a shot later.
>
> rday

look at populate_rootfs(), it's that simple. Our local kernel tree has
the following in the boot/simple/Makefile:

ZRDIMAGE := $(images)/ramdisk.image.gz
ROOTDIR := $(srctree)/............/path/to/dir/containing/root-fs

$(ZRDIMAGE) :  $(OUR_LOCAL_RULES_FOR_BUSYBOX) FORCE
        (cd $(ROOTDIR) &&  find | grep -v '~$$' | cpio -o -Hnewc ) | \
        gzip -9 -c > $@

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
