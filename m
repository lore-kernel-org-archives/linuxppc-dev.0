In-Reply-To: <19991123133536.013861>
Date: Tue, 23 Nov 1999 18:07:52 +0100
To: Cort Dougan <cort@fsmlabs.com>
CC: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootloader & head.S weirdness (patch)
Message-Id: <19991123180752.027815@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I posted the very first version of this bootloader. I'd appreciate
any comment, suggestion, etc... It's called "yaboot" and is on my test page

<http://calvaweb.calvacom.fr/bh40/test.html>

It's targeted for newworld machines only (machines with a working OF that
can load ELF binaries). It has a quik-like interface.

The config file must be named "yaboot.conf and located next to yaboot
itself, currently I put both on the first HFS volume of my disk, this
way, I can launch it with the simple OF command "boot hd:yaboot".

(Note that it's better to type boot hd:p,yaboot where "p" is the
partition number. If you don't do so, the bootloader will have to look at
all partitions it can read on device "hd" 
until it finds yaboot.conf since I didn't manage to find out the
partition number I was loaded from).

It supports loading files (both kernel and initrd) from any supported OF
disklabel/filesystem, and is had built-in ext2 support (only on Apple
partition maps for now). I'll add a built-in ISO (OF one doesn't seem to
work correctly) soon and also support for ext2 on PC disklabel partition
maps when I find some time>
Note also that currently, loading files from ext2 can be very slow, this
will be fixed in a future version. (The first time I tested, I thought it
was crashed, there is no spinning thing nor progress bar yet).

The kernel is loaded at 0x1000000 (16Mb). Currently, I've not been able
to boot successfully unless I apply the patch I posted earlier (that
disables the MMU after prom_init). I'll probably add an option for
specifying the load base on a per-kernel image basis. The bootloader
itself uses the range 0x200000->0x400000 (2Mb->4Mb) for now.

The syntax for a kernel image path (or initrd path) is a normal OF
syntax, for example:

hd:8,/boot/vmlinux

means the file "/boot/vmlinux" on partition 8 of device "hd". (hd is an
alias to the internal IDE disk of most macs). The parsing is a little bit
different than what quik used to do, so be careful.

I'll add a README and a sample config file with the next version.

Ultimately, this will allow bootable CDs for Macs (with the help of
miBoot for oldworld machines), and with a bit more GUI and the help of an
installer, we'll be, I hope, the primary bootloader for newworld Macs. I
plan to slowly abandon BootX support for those machines since it involves
too many hacks to work around various issues related to getting rid of
MacOS and problems with devices MacOS put in a non-reset state).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
