Message-ID: <3754D532.A161F647@wanadoo.fr>
Date: Wed, 02 Jun 1999 08:54:42 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Satadru Pramanik <satadru@umich.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: compilation failure of 2.2 series cvs kernel sources
References: <Pine.LNX.4.10.9906020011480.10882-100000@beer.pub.umich.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Satadru Pramanik wrote:
> 
> After getting the sources with "cvs update -dP -rlinux_2_2"
>  I use the enclosed file as my .config, and then run a "make vmlinux"  The
> only change I made was to line 455 of linux/net/ipv4/ip_options.c,
> deleting "kfree_skb(skb);"  to fix the DOS attack on the 2.2 series
> kernels recently found.
> 
> Any output would be appreciated.  Thanks.  I have a egcs 1.1.2 system.
> 
> here's the dying output of the compile:
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char
> -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
> -mstring   -c -o scsi.o scsi.c
> scsi.c: In function `scan_scsis_single':
> scsi.c:768: `TYPE_ENCLOSURE' undeclared (first use in this function)

Just a wild guess: Did you upgrade your glibc-devel recently? 

TYPE_ENCLOSURE is defined in /usr/src/linux/include/scsi/scsi.h.
Formerly, /usr/include/scsi/ was a symlink to
/usr/src/linux/include/scsi/. It is now owned by glibc which has its own
scsi.h file without this definition. It happened to me that upgrading
glibc overwrote the contents of /usr/src/linux/include/scsi, with
disastrous results. Why there is such a directory in glibc is beyond me;
these *are* kernel headers, after all.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
