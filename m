Message-Id: <200004171354.PAA29963@denx.local.net>
To: Dan Malek <dan@netx4.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bizarre initrd problem on CLLF860T 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Apr 2000 09:12:00 EDT."
             <38FB0DA0.DDE9098C@embeddededge.com>
Date: Mon, 17 Apr 2000 15:54:50 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <38FB0DA0.DDE9098C@embeddededge.com> Dan Malek wrote:
>
> > Sending BOOTP requests..... OK
> > IP-Config: Got BOOTP answer from 10.2.2.90, my address is 10.2.0.21
> > IP-Config: Guessing netmask 255.0.0.0
> > RAMDISK: Compressed image found at block 0
>
> IP-Config with Ramdisk is a pretty weird configuration.  At the
> 'Linux/PPC Load:' enter 'root=/dev/ram ip=off'.

Why do you call this weird? Is it not possible to use BOOTP  to  just
get an IP address assigned?

What method for network configuration do you suggest for a  minimized
embedded  system? Including tools like ifconfig and set-up scripts to
call them?

I've been using similar combinations (RARP + initrd)  for  some  time
without problems; would this fail using BOOTP?

Ummm... let's see:

Using RARP:

	...
	ttyS00 at 0x0380 is a SMC
	ttyS01 at 0x0280 is a SMC
	pty: 256 Unix98 ptys configured
	Found 2x16bit 4Mbyte CFI flash device of type AMD/Fujitsu standard at 40000000
	registered flash device /dev/flash0
	Found 2x16bit 4Mbyte CFI flash device of type AMD/Fujitsu standard at 40400000
	registered flash device /dev/flash1
	RAM disk driver initialized:  16 RAM disks of 4096K size
	eth0: CPM ENET Version 0.2, 00:d0:93:00:02:6c
	PPP: version 2.3.7 (demand dialling)
	TCP compression code copyright 1989 Regents of the University of California
	PPP line discipline registered.
	Sending RARP requests.... OK
	IP-Config: Got RARP answer from 10.0.0.1, my address is 10.0.0.99
	IP-Config: Guessing netmask 255.0.0.0
	RAMDISK: Compressed image found at block 0
	EXT2-fs warning: checktime reached, running e2fsck is recommended
	VFS: Mounted root (ext2 filesystem).
	Freeing unused kernel memory: 32k init
	Stand-alone shell (version 2.1)
	>

Using BOOTP:

	...
	ttyS00 at 0x0380 is a SMC
	ttyS01 at 0x0280 is a SMC
	pty: 256 Unix98 ptys configured
	Found 2x16bit 4Mbyte CFI flash device of type AMD/Fujitsu standard at 40000000
	registered flash device /dev/flash0
	Found 2x16bit 4Mbyte CFI flash device of type AMD/Fujitsu standard at 40400000
	registered flash device /dev/flash1
	RAM disk driver initialized:  16 RAM disks of 4096K size
	eth0: CPM ENET Version 0.2, 00:d0:93:00:02:6c
	PPP: version 2.3.7 (demand dialling)
	TCP compression code copyright 1989 Regents of the University of California
	PPP line discipline registered.
	Sending BOOTP requests.... OK
	IP-Config: Got BOOTP answer from 10.0.0.1, my address is 10.0.0.99
	RAMDISK: Compressed image found at block 0
	EXT2-fs warning: checktime reached, running e2fsck is recommended
	VFS: Mounted root (ext2 filesystem).
	Freeing unused kernel memory: 36k init
	Stand-alone shell (version 2.1)
	>

This works for me, too.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Man is the best computer we can put aboard a spacecraft ...  and  the
only one that can be mass produced with unskilled labor.
                                                  - Wernher von Braun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
