Message-ID: <3958AF3E.32693109@vas-gmbh.de>
Date: Tue, 27 Jun 2000 15:42:22 +0200
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
CC: Kwansuk Kim <kskim@neowave.co.kr>
Subject: Re: omitted kernel sections
References: <Your message of "Mon, 26 Jun 2000 15:43:35 +0900." <NEBBKFENMLEDKDHMEHPJKEMECAAA.kskim@neowave.co.kr> <4.3.2.20000626080626.00b482e0@falcon.si.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Jerry Van Baren wrote:
>
> Jon Diekema and I tried Wolfgang's "load" flag hint with the EST JTAG
> debugger and were unsuccessful.  We were unable to use objcopy to make
> the extra sections loadable.  We are guessing that you have to set the
> loadable flag, but you also have to label the section ".text" for the
> tools that are giving problems (EST in our case).  Jon produced a patch
> (based on work by Arto Vuori) which goes into the makefile and makes
> valid loadable sections out of the gzimage (compressed kernel) and the
> rdimage (initial ramdisk) sections.
>

I'd guess it's more important to adjust the VMA than the section's name to tell
the loader where to put the sections content.

If you examine the section's listing you'll notice address zero for .image and
.initrd, so only setting the load flag won't do the job.

I only prepare the kernel image (right now, I don't use .initrd) for loading
with the following objcopy call:

'powerpc-linux-objcopy \
 --set-section-flags=image=contents,alloc,load,readonly,data \
 --adjust-section-vma=image=$(powerpc-linux-objdump -h $kernel/zvmlinux | \
 grep .bss | awk '{print "0x"$4}') \
 $kernel/zvmlinux \
 $kernel/zvmlinux2'

To be on the secure side one should correct the vma's of .image to fit behind
.bss and of .initrd behind .image.

I thought someone patched the makefile to do this? (I guess, I'm not working on
the actual sources, but I don't like the idea behind bitkeeper very much
either...)

hth
	Frank

--
===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097 Hamburg,GERMANY,TEL:+49-40-238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
