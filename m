Message-ID: <381f2fd9382470a6@villosa.wanadoo.fr> (added by villosa.wanadoo.fr)
Date: Tue, 02 Nov 1999 19:32:19 +0100
Subject: Newworld OF boot
From: "Florent" <flobo@iname.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone succeeded in booting newworld macintoshes (ie the iMac or the B&W
G3) using OF ?
I've looked at the mailing list archive and this topic has already been
discuted here, but as far as I read, there was no solution found.
Because I can't believe Apple has crippled OF for non-MacOS booting, I'm
sure there is a way to turn around.

Here is what I know and what I've tried :

- Quik doesn't works on newworld, but it is not the only way to boot under
OF.

- OF can load files from HFS, HFS+, iso9660, FAT... filesystems (included in
/packages)

- OF can execute at least ELF and XCOFF binaries.

- the root of a MacOS disk I can see under OF is the System folder. (I can
see that with "dir hd:,5\\", where 5 is the number of my MacOS partition)

- I can boot MacOS by typing "boot hd:,5\\Mac%20OS%20ROM".

- When I try "boot hd:,5\\vmlinux" (there is a linux kernel in my system
folder), the kernel is recognised as an elf binary, OF writes some
informations about it, but it fails and replies : CLAIM failed.

- I can sucessfuly load smaller ELF binaries without CLAIM errors.

Next, I've examined the MacOS ROM file (there is something about it at
http://developer.apple.com/technotes/tn/tn1167.html)
Just open it with a disk track editor or a text editor :

This file contains the following :

- An header with some informations and a forth boot script

- an ELF bootstraff code

- a MacOS ROM image.

The script seems to create and/or modify /rom/macos and
/rom/AAPL,toolbox-image,lzss. Then it loads the ELF code.
According to Apple, the ELF code (called Trampoline code) is specific to OF
and does the transition between OF and the ROM image.

I can successfuly run any Forth script loaded from the hard disk. This would
be a way to make a nice dual-boot menu.

In the past (before BootX), I used to boot LinuxPPC on a floppy where there
was an XCoff kernel (boot fd:\\vmlinux.coff). How can I compile an XCoff
kernel to try it ?

I've heard that FreeBSD is bootable under newworld's OF. Is the kernel an
ELF file, too ? Or is it like MacOS Rom file ?


--
Il est maintenant temps de clore votre connection et de reprendre une vie
normale.
Mon e-mail : FloBo@iName.com (Florent Boudet)
Mon e-mail secondaire : FloBo@Rocketmail.com (je ne le regarde jamais)
Mon QG : http://www.multimania.com/flobo/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
