Message-ID: <37D36F1F.15DF13EF@col.bsf.alcatel.fr>
Date: Mon, 06 Sep 1999 09:37:03 +0200
From: Joel Vallier <vallier@col.bsf.alcatel.fr>
MIME-Version: 1.0
To: brendan@dgs.monash.edu.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: embedded linux: initrd root file-system in flash.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brendan Simon wrote:
> 
> 1) Store it at a known location seperate from the kernel.  eg.
> 0x400000.  I think I like this option as the root filesystem can be
> updated without touching the kernel/boot code and the start address is
> always fixed. Does anyone know how to tell the kernel where the
> location of the initrd image is and how big it is ?  I assume that the
> initrd image has to be uncompressed first or does the kernel assume it
> is compressed if the root filesystem is /dev/ram ?
> 
At the Linux boot time, the Linux Loader gives the initrd start address 
in register R4, initrd end address in register R5 and register R6 points 
to a command line string "root=/dev/ram".
(See arch/ppc/kernel/head.S file for more details).

If the inird is compressed, the Linux Loader have to uncompressed it first.

> 
> 2) Store it as a seperate section in the kernel image.  This is what is
> done with the mbx boot code.  The compressed kernel is stored as a
> separate section of the boot code image.  I guess same questions for 1)
> apply for this method.  The build processes can work out where to store
> the initrd image in the resultant loadable image.  This information
> would have to be passed to the kernel.  Any idea how this would be done
> ?
> 
In this case initrd is included in the vmlinux. So, It's uncompressed by 
the Linux Loader with the vmlinux image. The initrd location and size are 
defined at the compilation time. See INITRD_OFFSET and INIT_SIZE in the 
arch/ppc/boot/Makefile.

Joel Vallier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
