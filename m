Date: Wed, 2 Jun 1999 00:17:13 -0400 (EDT)
From: Satadru Pramanik <satadru@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: compilation failure of 2.2 series cvs kernel sources
Message-ID: <Pine.LNX.4.10.9906020011480.10882-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After getting the sources with "cvs update -dP -rlinux_2_2"
 I use the enclosed file as my .config, and then run a "make vmlinux"  The
only change I made was to line 455 of linux/net/ipv4/ip_options.c,
deleting "kfree_skb(skb);"  to fix the DOS attack on the 2.2 series
kernels recently found.  

Any output would be appreciated.  Thanks.  I have a egcs 1.1.2 system.

here's the dying output of the compile:
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring   -c -o scsi.o scsi.c
scsi.c: In function `scan_scsis_single':
scsi.c:768: `TYPE_ENCLOSURE' undeclared (first use in this function)
scsi.c:768: (Each undeclared identifier is reported only once
scsi.c:768: for each function it appears in.)
scsi.c: In function `resize_dma_pool':
scsi.c:2499: `TYPE_ENCLOSURE' undeclared (first use in this function)
make[3]: *** [scsi.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

Thanks again.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
