Message-ID: <3B3A7958.340746FC@carts.com>
Date: Wed, 27 Jun 2001 17:24:56 -0700
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: 1337 linuxppc list ???? <linuxppc-embedded@lists.linuxppc.org>
Subject: invalid page faults..
References: <3B3A5A16.6010005@ccc-dcs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Maybe you guys have encountered a similar probelm to the one I'm having with
my custom 8260 board, HHL 2.0 journeyman, 2.4.2 kernel.

I got past the rtc/timer issue. Even though the kernel reports that the 166mhz
cpu is .81 bogomips, I'll mess with that later, I just want to get the shell
up and running for now. The kernel boots and initializes everything else well,
but when it starts loading init or sh, I keep getting invalid page faults
looping.  The ramdisk shows as mounting fine, (except it always says: Maximal
mount count reached, recommened ext2fsck.. i dont know why..)

What happens is that load_elf_interp() is called and then it calls
padzero(elf_bss) and the page faults start occuring.
when padzero is called elf_bss is in the 3Exxxxx range. Why would it be so
high in memory? I have the memory mapped to start at 0, and i've got 64 megs.

thanks
Kevin Fry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
