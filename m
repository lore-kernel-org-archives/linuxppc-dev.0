Message-ID: <37D30C0C.94E29FF0@dgs.monash.edu.au>
Date: Mon, 06 Sep 1999 10:34:20 +1000
From: Brendan Simon <brendan@dgs.monash.edu.au>
Reply-To: brendan@dgs.monash.edu.au
MIME-Version: 1.0
To: linux-embedded <linux-embedded@waste.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: embedded linux: initrd root file-system in flash.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I want to boot linux on a PowerPC embedded system WITHOUT using NFS.
>From what I can tell, initrd seems to be the best way of doing this.
All the docs I have read regarding initrd refer to LOADLIN or LILO.  I
am not using either as they assume some kind of disk like filesystem.
There are two methods that I can think of to use an initrd image stored
in flash.

1) Store it at a known location seperate from the kernel.  eg.
0x400000.  I think I like this option as the root filesystem can be
updated without touching the kernel/boot code and the start address is
always fixed.  Does anyone know how to tell the kernel where the
location of the initrd image is and how big it is ?  I assume that the
initrd image has to be uncompressed first or does the kernel assume it
is compressed if the root filesystem is /dev/ram ?

2) Store it as a seperate section in the kernel image.  This is what is
done with the mbx boot code.  The compressed kernel is stored as a
separate section of the boot code image.  I guess same questions for 1)
apply for this method.  The build processes can work out where to store
the initrd image in the resultant loadable image.  This information
would have to be passed to the kernel.  Any idea how this would be done
?

Thanks,
Brendan Simon.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
