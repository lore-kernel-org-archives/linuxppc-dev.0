To: Jerry Van Baren <vanbaren_gerald@si.com>
Cc: "Kwansuk Kim" <kskim@neowave.co.kr>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: omitted kernel sections 
In-reply-to: Your message of "Mon, 26 Jun 2000 08:48:36 -0400"
             <4.3.2.20000626080626.00b482e0@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 27 Jun 2000 00:40:38 +1000
Message-ID: <20179.962030438@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 26 Jun 2000 08:48:36 -0400, Jerry Van Baren <vanbaren_gerald@si.com> writes:
>* It isn't how everybody uses the load: everybody just strips the elf
>header (pastes on a proprietary(?) header) and uses it as as a raw
>binary image

Here's one example of how people use the load ...

I use the "libbfd" library (generated when you build the binutils usually)
to read the ELF headers of the image file ("zImage.initrd" in my case) and
determine the entry point of the image, then I wrap the whole thing in my
own (open, non-proprietary :-) header which contains various stuff (e.g.
checksums), and the entry point.

My boot loader then can simply use the entry point in the header to begin
execution of the image, either directly where it is stored (e.g. in flash)
or after storing/relocating it. The assumption is that the image (whatever
it is) is either location independent or will relocate the appropriate bits
as required. Fortunately, the mbxboot stuff does the latter.

This scheme has the advantage that the entry point could be set different
to the real entry point in the ELF file - for what that's worth, I can't think
of any use for that at the moment (you might have two text sections and
have to choose one? I dont know), but my goal was to try to be object format
independent in the boot loader (and so I had to create yet another object
format :-) - learning the entry point is dependent on the object format,
and is best done on the host.

So, I don't strip the ELF header, but I do paste on my own header and use
the image as a raw binary image - except that I know the entry point (as an
offset from the start of the image). But I don't do any of this as part of
the kernel build, I have a simple tool that does it when I want to "download"
the image to the target.

For the record, I support Dan's view - the way it is now, is very simple,
and has worked fine for a long time. To me, it looks like the tools you
are using are broken (or at least lacking certain features, namely the
ability to load arbitrary sections from the ELF image into memory - which
doesn't surprise me, because the JTAG stuff you mention sounds proprietary
commercial stuff, and you always run into bugs/lack of features that you
can't fix when you use software you haven't go the source for - sorry for
the soapbox - you probably don't need me to tell you :-). The "loading" of
the image (and stuff to support that) should be done outside of the kernel
build area.

In fact, it could be argued that the *boot directories don't belong in the
kernel build area either, because there is no connection between the code
in the *boot directories and the kernel code - they are separate things.
They don't share any code (at least in the mbxboot case) - the boot stuff
treats the kernel image (and ramdisk image, if it exists) as blobs of bytes,
it really should be in a separate development tree (I suppose one connection
is the way arguments/bootinfo/etc are passed to the kernel, however I would
argue that this is only an interface).

But historically (and not just with linux), the boot stuff has always been
in there for convenience so thats not going to change, just because I get
pedantic. But at least we can keep it as simple as possible. I'll shut-up
now (I wonder if anyone has actually read this far - I hope it wasn't a waste
of time for you - it was good for me *pant* *pant* :-) Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
