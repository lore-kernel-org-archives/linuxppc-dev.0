Message-ID: <XFMail.000126175350.jeremy@goop.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20000127005854.B85911B172@elph.research.canon.com.au>
Date: Wed, 26 Jan 2000 17:53:50 -0800 (PST)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: (Graham Stoney) <greyham@research.canon.com.au>
Subject: Re: linuxppc-embedded: main kernel tree
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 27-Jan-00 Graham Stoney wrote:
>
> Alan Mimms writes:
>> In fact, I'm very interested in the new cramfs I have read about as a
>> solution for our flash based file system.
>
> cramfs sure looks interesting as an alternative to an initrd uncompressed
> ramdisk or romfs.
>
> A question for the knowledgeable about memory usage efficiency of Linux's
> regular ramdisk though: does the kernel share read-only program text space
> directly with the binary image data in the ramdisk, or does it copy the data
> from the ramdisk when it execs a program?

I've done an alternative called "zbd" (compressed block/boot device).  We use
it for our flash images.  Its essentially the same as a ramdisk/initrd, but
each block is individually compressed.  We leave the image in flash and mount
the root filesystem (ext2) from it.  The implementation is almost identical to
the ramdisk code, and they could be folded together: I just haven't done that
yet.

        J

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
