Message-Id: <383BA0DF.510AA33E@ict.ac.cn>
Date: Wed, 24 Nov 1999 16:25:03 +0800
From: LiuTao <tliu@ict.ac.cn>
Mime-Version: 1.0
To: Jim Chapman <jim.chapman@iname.com>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: need suggestions
References: <383AF067.2B8EB961@iname.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jim:

I have a bootrom of vxWorks and I want to use it to download any
files that I need through FTP or TFTP. When I try to do it, I found
some problems.
If I use it to download vxWorks's image through FTP, that's all right.
If I use it to download vxWorks's image through TFTP, there is error.
If I use it to download a test image(ELF file), there is error too.
I think there must be some requirements to the download files, right?
Maybe the format of ELF is not correct?
I also want to make a bootrom of Linux, can you tell me how to do it?
I am a newbie, so if you can, tell me something in detail please.
Thanks!

LiuTao

Jim Chapman wrote:
> 
> Re: using a vxworks bootrom to load zImage
> 
> I am using a standard vxworks bootrom to load a zImage, but I had to
> make a few modifications to the zImage startup code to make it work. For
> us, it is useful to share the same target hardware between vxworks and
> linux developers, without having to reblow the flash bootrom each time
> we switch. And by building BOOTP into the vxworks bootrom, we simply
> change the BOOTP server entry to have the target boot vxWorks or zImage
> without changing the bootrom. However, once we're rid of vxworks
> altogether, then a linux-centric bootrom would be a much better
> solution.
> 
> It turns out that the vxworks bootrom ELF support doesn't handle named
> ELF sections (it's yet another undocumented feature of Wind River code
> -- it silently ignores sections that aren't ".text" or ".data"...), and
> since the compressed vmlinux image is objcopy'd into a special "image"
> section by arch/ppc/mbxboot/Makefile, I had to find a way to put the
> image section inside the text segment so that the image data would be
> copied by the vxworks bootrom. There may be a clever way to do that
> using ld scripts, but I ended up converting the image data to assembly,
> and used a couple of public symbols at the start/end of the data so that
> (a modified) decompress_kernel() could find the image. The
> binary-to-assembly convertor is a simple perl script which does almost
> the same thing as vxWorks' binToAsm tool.
> 
> The initrd stuff would need similar treatment, but since I don't use
> initrd, I haven't implemented it.
> 
> If you want more details (and the binToAsm perl script) let me know.
> 
> -Jim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
