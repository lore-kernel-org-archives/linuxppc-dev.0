To: Jim Thompson <jim@SmallWorks.COM>
Cc: sruel@oerlikon.ca, scott_anderson@mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPX-CLLF & Flash root filesystem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 24 Oct 2001 01:27:11 CDT."
             <15318.24383.143536.778353@zaphod.smallworks.com>
Date: Wed, 24 Oct 2001 09:00:26 +0200
Message-Id: <20011024070031.2451210CD6@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jim,

in message <15318.24383.143536.778353@zaphod.smallworks.com> you wrote:
>
> > With PPCBoot you pass the addresses of both images  as  arguments  to
> > the "bootm" command.
>
> Have you considered cramfs support for ppcboot?

Ummm... I think this is a misunderstanding on your side. Support  for
the  root  filesystem is an issue for the Linux kernel configuration,
PPCBoot is completely unaffected by this.

The great flexibility is IMHO one of the strongest points of PPCBoot.
Assuming that you have support  for  all  filesystems  and  partition
types  configured  for  Linux,  you  can  use  the  SAME Linux kernel
image...

...and load it from flash:

	=> setenv kernel_addr 0x40040000

...and load it using DHCP or BOOTP or plain TFTP:

	=> setenv kernel_addr 0x00100000
	=> tftp $(kernel_addr) /tftpboot/pImage

...and load it from IDE device 0, partition 3 (hard disk, CompactFlash, etc):

	=> setenv kernel_addr 0x00100000
	=> disk $(kernel_addr) 0:3

etc. (depending on the board, add Floppy Disk, CDROM, SCSI, ...)


...and boot with a ramdisk image (compressed or uncompressed):

	=> setenv ramdisk_addr 0x40200000
	=> setenv bootargs root=/dev/ram rw ...
	=> bootm $(kernel_addr) $(ramdisk_addr)

...and boot it with root filesystem over NFS:

	=> setenv bootargs root=/dev/nfs rw nfsroot=...
	=> bootm $(kernel_addr)

...and boot it with root filesystem on IDE device 0, partition 5:

	=> setenv bootargs root=/dev/hda5 ...
	=> bootm $(kernel_addr)

...and boot it with root filesystem on MTD partition 3 with a
   JFFS/JFFS2 filesystem:

	=> setenv bootargs root=/dev/mtdblock2 ...
	=> bootm $(kernel_addr)

etc. etc. - all with the same kernel image, and  in  any  combination
you like.


PPCBoot does not need to know about the root  filesystem  type  -  it
just  has to know how to load the Linux kernel; for example, we don;t
have NFS support in PPCBoot but can boot a Linux kernel which  mounts
the root filesystem over NFS.

Does this explain your question, or am I missing something?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can love it, change it, or leave it.    There is NO other option.
But do not complain - it is your own choice...                  -- wd

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
