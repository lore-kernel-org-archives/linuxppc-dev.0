Date: Tue, 8 Jun 1999 16:37:53 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: How to boot VME from HD?
In-Reply-To: <375D3258.54D3694B@fi.infn.it>
Message-ID: <Pine.HPP.3.96.990608162524.27048J-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 8 Jun 1999, Simone Piccardi wrote:

> Hi,
> I just got a new disk for our MVME2431 board. Up to now I was booting
> trough NFS using a kernel image and a root filesystem on a linux PC.
> Then I just copied all the files from the NFS root directory on the PC
> to the new disk, and after few adjustement (correction on fstab) I could
> have the root filesystem on the HD, uding it after boot.
> Now I would like to go further and boot directly from the HD, removing
> the needing of the PC; I looked into PPCBUG manual, finding the PBOOT
> command; but it require a bootable partition and a boot record, and I
> think that lilo did not work in these board, there is an equivalent
> tool? Or I can simply put the kernel image inside the NV Ram and start
> from there? 

You have to create a small primary (number 1-4) partition (say 5 Mb, only
needs to be larger than the zImage), give it type 0x41 and use the dd
command to copy the zImage to it.

For example my 0x41 type partition is /dev/sda3, and I type: 

	dd of=/dev/sda3 if=/usr/src/linux/arch/ppc/prepboot/zImage 

check twice before typing the return key since the wrong digit in the of0
parameter may make one of your partitions unusable (to solve this we would
need a MILO like loader, but I had no time to work on this, although
prepboot might be a good starting point). I have also considered the
possibility of booting from ROM (flash the kernel into the 4 or 8Mb of
PROM present on these boards), but not implemented it.

Also note that my FTP server is no more vcorr1.iram.es (150.214.224.201)
but vlab1.iram.es (150.214.224.210), so please upgrade your bookmarks.
I'm now up to 2.2.9 and the VME driver still has had some minor changes
(because the Raven/Falcon now are set up in a way which allows much
larger windows to the VME).

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
