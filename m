Message-ID: <380BAB9E.4470AB42@andrew.cmu.edu>
Date: Mon, 18 Oct 1999 19:22:06 -0400
From: Hollis R Blanchard <hollis@andrew.cmu.edu>
MIME-Version: 1.0
To: David Monro <davidm@amberdata.demon.co.uk>
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-workstation@lists.linuxppc.org
Subject: Re: 2.2.* broken on IBM 850?
References: <380B75A7.3DEE604C@amberdata.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Monro wrote:
> 
> has anybody got a 2.2 kernel working properly on an IBM PowerSeries 850
> (codenamed Carolina I think)?

No. There are at least 4 of us in this situation now. I left an
extensive email trail on -user and then on -workstation; probably only
the end would interest you.

> I can boot an old 2.0.32 kernel on it and it mostly seems to work,
> although the interrupt assignments are a little odd - NT on the same box
> claims that ide0 is on 16, ide1 is on 17 and my ncr825 card is on 15.
> Linux seems to think that ide0 is on 13, ide1 doesn't exist (and that
> the IDE cdrom on it isn't there either) and that the SCSI card is on irq
> 10. Is ARC playing games with me?

I'd love a working kernel - do you have a URL for that 2.0.32?

Of course, ramdisk format seems to have changed. The last time I tried
an older kernel it choked trying to read in the LinuxPPC 1999 ramdisk
(that I'd used fine with 2.2 zImages).

> 2.2 kernels (and I've tried quite a few, namely install images for
> yellow dog, debian and linuxppc, plus random other bits and bobs)
> exhibit symptoms which to me look like the interrupts aren't getting
> through. I get "hda IRQ probe failed (0)" several times, the partition
> table read fails, and then the ncr53c8xx driver gets a timeout on every
> command, which is exactly what happens on x86 machines when the
> interrupt mappings get stuffed and the driver isn't getting the
> interrupts.
> 
> The debian install image (bootprep.bin) behaved slightly differently -
> when I took the SCSI card out it managed to get the partition table from
> the hard drive while whinging about it all the time (timeouts I think),
> and then as soon as it got to mounting the ramdisk the screen went black
> and stayed that way. Trying to get it to boot hda1 in single user mode
> actually got as far as starting init, and I saw a shell prompt for a
> split second before the screen went black :-(
> 
> The interrupt mappings seem to be the same under 2.2 as under 2.0.

I had the most success by disconnecting the CDROM altogether.

After doing this, I could pass the partition check and all with no
problems. However, any disk activity (like mke2fs or rpm installation)
would result in many many "hda - lost interrupt" messages. Data would
eventually get written, but it was very very slow and unhappy. I believe
the kernel image I have at
http://www.andrew.cmu.edu/user/hollis/zImage-2.2.10 exhibits these
symptoms (it does have working builtin ethernet though. Yay.).

The conclusion we drew before was that something broke the IDE driver on
PReP machines. A Motorola PowerStack I with IDE was exhibiting the same
behavior I believe. That machine was shipped to the person who knows the
most about this problem, Gary Thomas, who's extremely busy.

> This is my first attempt at messing with PPC, although I've had a fair
> bit of experience with x86 and alpha boxes under linux.

I may be receiving a SCSI card to try with (since the problem is
supposed to be in the IDE driver... but now that seems less likely?).
I'd be ecstatic to get these machines working again.

The basic image that's supposed to work (and does on SCSI PowerStacks at
least) is located at ftp.linuxppc.org/users/gdt. I think the one you
want is zImage-2.2.10.install. Install instructions can be found at
http://www.linuxppc.com/think/r5-prep-install.shtml. Any problems you
have with that kernel and instructions should be posted on -workstation
so we can try to work through it I think.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
