Message-ID: <383AF067.2B8EB961@iname.com>
Date: Tue, 23 Nov 1999 19:52:07 +0000
From: Jim Chapman <jim.chapman@iname.com>
MIME-Version: 1.0
To: LiuTao <tliu@ict.ac.cn>
CC: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: need suggestions
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Re: using a vxworks bootrom to load zImage

I am using a standard vxworks bootrom to load a zImage, but I had to
make a few modifications to the zImage startup code to make it work. For
us, it is useful to share the same target hardware between vxworks and
linux developers, without having to reblow the flash bootrom each time
we switch. And by building BOOTP into the vxworks bootrom, we simply
change the BOOTP server entry to have the target boot vxWorks or zImage
without changing the bootrom. However, once we're rid of vxworks
altogether, then a linux-centric bootrom would be a much better
solution.

It turns out that the vxworks bootrom ELF support doesn't handle named
ELF sections (it's yet another undocumented feature of Wind River code
-- it silently ignores sections that aren't ".text" or ".data"...), and
since the compressed vmlinux image is objcopy'd into a special "image"
section by arch/ppc/mbxboot/Makefile, I had to find a way to put the
image section inside the text segment so that the image data would be
copied by the vxworks bootrom. There may be a clever way to do that
using ld scripts, but I ended up converting the image data to assembly,
and used a couple of public symbols at the start/end of the data so that
(a modified) decompress_kernel() could find the image. The
binary-to-assembly convertor is a simple perl script which does almost
the same thing as vxWorks' binToAsm tool.

The initrd stuff would need similar treatment, but since I don't use
initrd, I haven't implemented it.

If you want more details (and the binToAsm perl script) let me know.

-Jim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
