From: v.sudeep@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E57860290F8B0@ap-bang-m02.india.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: dummy_con
Date: Mon, 15 Dec 2003 03:29:43 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !!!
I am a relatively newbie in both embedded stuff and Linux and would
appreciate any help that is given.

I am trying to bring up the Display on the system. It has a S3 ViRGE/GX
card.
the other m/c Specifications:
Host Machine :  Intel x86 having RedHat 7.0 installed
Target Board: IBM Walnut board - 405GP with PowerPC processor.
Cross-Compiler: MonteVista Hard Hat Linux 2.0  for the ibm-walnut board



THE PROBLEM:  While compiling the kernel I get the following error.
arch/ppc/kernel/kernel.o: In function `ppc4xx_setup_arch':
arch/ppc/kernel/kernel.o(.text.init+0xbee): undefined reference to
`dummy_con'
arch/ppc/kernel/kernel.o(.text.init+0xbf2): undefined reference to
`dummy_con'
arch/ppc/kernel/kernel.o(.text.init+0xbf6): undefined reference to
`conswitchp'
arch/ppc/kernel/kernel.o(.text.init+0xbfa): undefined reference to
`conswitchp'
drivers/char/char.o: In function `chr_dev_init':
drivers/char/char.o(.text.init+0x248): undefined reference to `fbmem_init'
drivers/char/char.o(.text.init+0x248): relocation truncated to fit:
R_PPC_REL24 fbmem_init
make: *** [vmlinux] Error 1

If its not too much of a trouble someone help me with how to get this
working...

Thanks in advance....
- S u d e e p    V
If at first you dont succeed, skydiving is not for you.





-----Original Message-----
From: Sudeep, V
Sent: Friday, December 05, 2003 4:10 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Loading Linux on the Walnut Board



Hi !!!

I am a Linux newbie.. And recently I was trying to bring up the Walnut Board
with Linux and found that the documentation for the whole thing was vastly
inadequate. So I decided to pen my experience for everyone else's benefit.
So here goes....
Regs
Sudeep V



Aim: As a first step in the process of learning about Embedded Linux, we
thought we would try the relatively easy part of trying to bring up Linux on
the Walnut Board.

Specifications:
Host Machine : Intel x86 having Red Hat 9 installed (& Intel x86 having Red
Hat 7.0 installed for compiling the kernel since we had issues with RH9)
Target Board: IBM Walnut board - 405GP with PowerPC processor.
Cross-Compiler: MonteVista Hard Hat Linux 2.0  for the ibm-walnut board

The Success Story:
1. Connected the PPC board to the Host machine by the serial cable and the
network cable. Started minicom (version 1.83.1) which is being used as the
serial communication program.
2. Using minicom set the local(walnut board) and remote(host) ip-address.
3. Set up and start the Internet Boot Protocol Server(bootpd implements an
Internet Bootstrap protocol{BOOTP} server) in standalone mode (we used it
with debug level 5 ----  /usr/sbin/bootpd -d5). In the config file
/etc/bootptab, specify the following:
*	Bootfile Home Directory (hd),
*	Bootfile (bf),
*	Host IP Address (ip),
*	TFTP server address client should use(sa),
*	Host subnet mask (sm),
*	Host Hardware address (ha),
*	Root path to mount as root(rp).

4. Start the ftp service Trivial File Transfer Protocol (TFTP - A simple
file transfer protocol used for down-loading boot code to diskless
workstations.) /usr/sbin/in.tftpd

5.  Building the kernel image: We had issues compiling the MonteVista Hard
Hat 2.0 kernel source from the Red Hat 9 Host machine (probably due to a
incompatible version of Perl). So we installed the MonteVista Hard Hat 2.0
kernel on a Red Hat Linux 7.0 machine. And built the kernel as usual.
Steps while building the kernel
*	cd /opt/hardhat/devkit/lsp/ibm-walnut/linux-2.4.2_hhl120/
*	make walnut_config
*	make clean
*	make dep
*	make zImage

6. The image created is available at
/opt/hardhat/devkit/lsp/ibm-walnut/linux-2.4.2_hhl120//arch/ppc/boot/images/
as vmlinux.tree.img.
Copy this to the /tftpboot/ directory or wherever the Bootfile Home
Directory has been set to.

7. Now power on or reset the board and Bingo !!!! the kernel must be loading
....

Lessons Learnt:
1. This whole exercise was very useful in understanding the way things are
done in the embedded world.
2. We have begun to understand the  A B Cs involved in bringing up a board.
3. Never trust anything. After installing MonteVista Hard Hat Linux on the
Host machine with RH9, we tried to build the kernel for the target board.
After many unsuccessful attempts and a little bit of debugging, we realised
that probably the errors were due to the incompatible versions of Perl. (RH7
uses Perl v5.6.0 while RH9 uses Perl v5.8.0)
4. Leave no stone unturned. After successfully building the kernel, we had
to search with quite a few of files created to find which was the correct
image. Most of the documentation that we found on the net did misguide us on
this count.
5. Its fun to work with stuff with very less documentation. But there are
many people having trouble getting things working in this field, we are not
alone......



Notes :
TFTP (Trivial File Transfer Protocol) is used on light-weight Internet
devices in order to transfer files. Specifically, it is one of the most
popular methods for "remote booting". It is such a simple protocol that it
can be implemented within the firmware on network devices that do not
contain hard-disks. It is often used in conjunction with bootp
<http://www.iss.net/security_center/advice/Services/bootp/default.htm>: the
device first contacts the bootp server, which then tells it which TFTP to
load the "boot image" from.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
