To: linuxppc-dev@lists.linuxppc.org
From: Alexander Larsson <alex@signum.se>
Subject: Re: Booting Linux from Flash
Date: 15 Apr 1999 18:06:32 +0200
Message-ID: <w1g16198c7.fsf@tammy.signum.se>
References: <01BE8665.A0E7B070.john.vanloon@oregonchain.com> <37156C34.C1DEE82F@dgs.monash.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


brendan@dgs.monash.edu.au (Brendan Simon) writes:

> I would certainly like to get a flash filesystem driver.  I'm not sure if it
> is the same thing you are talking about.
> 
> I want to boot linux on an powerpc embedded system which has no hard disk.  I
> do not want to use lilo.  I imagine that I would have write a simple
> bootloader to get the kernel booting.  I want to store the kernel at a known
> location in Flash and store a boot image at a known location in Flash.  I then
> want to execute the kernel somehow (jump to appropriate address) and pass to
> it any parameters required to let it place the boot image in a ram disk.  I
> think the kernel lives in the file system so it's a bit of a chicken and egg
> problem as far as I can see.  Is the kernel that is booting stored in the boot
> image.  If so I guess the boot image has to be uncompressed.  The root
> filesystem can be a compressed image though.

The way I'm doing it is i just place the bootcode and a zImage at place in the
flash-mem where the machine boots. Then i just set up the machine and copy the
zImage down to ram and jump to it.

You could probably get it to read a compressed fs image from flash and mount it
as a ram-disk by either using some initrd hacking or doing some kernel startup
modifications.

> Anyone know where I should start with regards to bootloaders or how to get the
> kernel booting if I have the kernel and bootimage in Flash somewhere.  Note
> the Flash is just memory mapped on a SIMM.  There is no IDE driver or
> filesystem on it.  Do I need a Flash device driver ??

No, you don't need a Flash device driver unless you want to write to the flash.

/ Alex



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
