Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id AD72A67A2F
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Mar 2005 01:55:59 +1100 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 26 Mar 2005 09:55:55 -0500
Date: Sat, 26 Mar 2005 09:54:21 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.61.0503260953100.12378@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: 2.6.11-5 kernel on 8xx -- perhaps i messed up the console port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


  to make a long story a little shorter, once upon a time, i had a
2.5.xx kernel running on my 8xx-based board.  i used the latest bk
checkout from bkbits.net and had at least a minimal operational kernel
that would boot, mount its root filesystem, mount JFFS2 and a bit
more.

  finally getting back to that, i grabbed the latest stock (2.6.11-5)
kernel and tried to reproduce that.  by hand, i perused my old config
file, duplicated what i could, made (relatively?) intelligent
decisions about new options and tried again.  to keep things simple, i
left out absolutely *everything* that wasn't essential for just an
initial boot -- no networking, no MTD, not even an initrd -- i just
wanted to see the kernel boot and would be quite happy for it to get
to trying to mount the root filesystem, only to choke and fall over.
no problem.

  however, after (all based on ELDK 3.1 cross-compilation):

	$ make ARCH=ppc menuconfig
	$ make ARCH=ppc
	$ ppc_8xx-objcopy -O binary zImage.elf zImage.bin

download (via planet core boot loader) to 400000 in RAM, and "g
400000", i get:

  loaded at:     00400000 00485160
  board data at: 00483124 00483140
  relocated to:  00405090 004050AC
  zimage at:     004058C8 0048275F
  avail ram:     00486000 02000000

  Linux/PPC load: rw root=/dev/ram0
  Uncompressing Linux...done.
  Now booting the kernel

  ... hangs ...

of course, there are an infinite number of ways i could have screwed
up, but one possibility is that i just messed up configuring the
console port.  the kernel could very well be loading but, as this is a
bare board with no blinkenlights or anything, there's no way to tell.

  has anything changed in the last little while in terms of the
console port?  i tried to reproduce faithfully my earlier config
options for console port support, but no luck.

  thoughts?  the problem could, of course, be elsewhere but i'd like
to check this out first.

rday
