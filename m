Date: Wed, 25 Sep 2002 08:12:13 -0700
From: curt brune <curt@acm.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initrd, ramdisk problems
Message-ID: <20020925151213.GA19241@lenin.net>
References: <20020922032631.GA30804@lenin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020922032631.GA30804@lenin.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I managed to get this working -- what I did differently was:

 * changed kernel version from 2.4.18 to 2.4.4 (from the ELDK cvs
   repository)

And that was it.  It now works.  The ramdisk decompresses without
errors and the systems boots fine.  Happy day.

I noticed that the directory layout for the kernel changed somewhat
from 2.4.4 to 2.4.18 --  In 2.4.4 I put ramdisk.image.gz in
linux/arch/ppc/mbxboot, while in 2.4.18 the ramdisk goes in
linux/arch/ppc/boot/images .  Plus in 2.4.18 there are a lot of
directories in linux/arch/ppc/boot compared to 2.4.4 .

As a history lesson, why did this change ?

Another question: When booting the two different kernels (2.4.18 and
2.4.4-eldk) I noticed that the initial message about where the images
are loaded and relocated reported different addresses and sizes.  Is
that expected?

Cheers,
Curt

On Sat, Sep 21, 2002 at 08:26:31PM -0700, curt brune wrote:
> Hi,
>
> I'm booting linux 2.4.18 on an embedded planet RPX_LITE-DW (823e) with
> a RAM disk, however I am getting a "crc" error while decompressing the
> RAM disk.  Snipped from the boot log are these two lines:
>
> >> RAMDISK: Compressed image found at block 0
> >> crc errorFreeing initrd memory: 1670k freed
>
> I built the kernel image using "gmake zImage.initrd" .  This picked up
> my gzipped ramdisk image OK.
>
> [editor: I know, I know.  I should be using ppcboot.]
>
> The ramdisk is 8192 bytes uncompressed.  Compressed it is 1.7MB.
>
> The target kernel is configured for 8192 byte ramdisks also.  This is
> stumping me.
>
> In the boot log I also noticed something funny.  My board only has
> 16MB total on it and the kernel is configured for 8MB ramdisk.  In the
> boot log it says it is initializing 16 ramdisks of 8MB each ....
>
> >> Kernel command line: root=/dev/ram ramdisk=8192
> >> Memory: 13104k available (916k kernel code, 348k data, 52k init, 0k
> >> highmem)
> >> ...
> >> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
>
> Looking in rd.c I see 16 is a #define constant.  Is this a problem?
>
> Cheers,
> Curt
>
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
