Message-ID: <3B991184.7CCB4E15@mvista.com>
Date: Fri, 07 Sep 2001 13:27:16 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: linuxppc-embedded@lists.linuxppc.org,
	jfd@krakatoa.gigabitnetworks.com
Subject: Re: swapspace in HHL 2.0
References: <200109071118.EAA14228@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James F Dougherty wrote:
>
> Hi,
>
> I used initdconfig to enable mountall.sh and have an /etc/fstab like
> so:
>
> # /etc/fstab: static file system information.
> #
> # <file system> <mount point>   <type>  <options>               <dump>  <pass>
> /dev/root       /               auto    defaults,errors=remount-ro      0 0
> /proc           /proc           proc    defaults                        0 0
> /dev/hda1       /               auto    rw                              0 1
> /dev/hda2       swap            swap    defaults                        0 2
>
> When the system boots, it says that it is enabling the swapspace, however
> if you cat /proc/meminfo, it shows that it is really not enabled.
> Now, if you do a "swapon -a" instead of "swapon -a 2" (like in the mountall.sh)
> then swap comes on.
>
> What am I doing wrong?

The file on one of my targets is:

/dev/hda3       /               ext2    defaults,errors=remount-ro
1 1
/dev/hda4       /usr/local      ext2    defaults,errors=remount-ro
1 2
/dev/hda2       /boot           hfs     defaults
1 2
proc            /proc           proc    defaults
0 0
/var/swap       swap            swap    defaults
0 0

(and that works)  FYI my swap is in a file not a partition, that way I
can increase/decrease the size of the swap file at will...  (Only down
side, is that swap is not read/write until after the root filesystem is
mounted in my case...)

So the only thing I can think of the is "pass" flag you have set to 2.
I don't know why that would effect anything though.

Look at the "checkroot.sh" and "mountall.sh" initscripts, they enable
the swap spaces.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
