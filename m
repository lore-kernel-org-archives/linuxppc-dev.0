Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000d01c2fe74$83264520$1464a8c0@sjeng3>
From: "El Topo" <ElTopo@myrealbox.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <200304081158.29606.ADharankar@ATTBI.Com>
Subject: ppcboot 2.0.0 + ppclinux2.4.devel, network weirdo
Date: Wed, 9 Apr 2003 01:46:27 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys:

I have ppclinux 2.4.devel (2.4.20) running on my 440gp ebony board
with ppcboot 2.0.0.  Normally I use tftp to get the compressed kernel
image to 440gp and bootm from memory. So far I have these issues:

1. for some reason, linux kernel sees the two eth interfaces but fails
to get the correct MAC addresses, thus when system fully boots up
"ifconfig" shows two eth0/eth1 with MAC addr as ff:ff:ff:ff:ff:ff, because
this is same as brd, many network services won't work.
I checked kernel source code and found that, in include/asm-ppc/ibm440.h,
there's a structure "board_info" holds MAC addresses of the two enet
interfaces. According to this header file: "Ebony firmware stores MAC
addresses in the F/W VPD area. The firmware must store the other dynamic
values in NVRAM like on the previous 40x systems so they  should be
accessible if we really want them."
So, my question is: how can I get ibm440's EMAC info? from NVRAM?
the kernel I am using now does not support NVRAM for ppc yet.

2. to temporarily solve the problem in 1., I modifed
drivers/net/ibm_ocp/ibm_ocp_enet.c:ocp_enet_probe(),
when reading the MAC address, I simply assigned some fake MAC addrs
to dev->dev_addr, and the network part is working now, I can telnet
into my 440gp, also ftp out from it.
I did relatively enough tests using tftp from my server to get the kernel
image loaded to 440gp and bootm to bring the system up, everything
looked fine. Then I decided that I want to copy the memory area of
kernel image to flash and boot from there. the booting seemed OK,
no errors reported, except that after the system fully booted up I found
I could not ping the network from/into 440gp box.
Several minutes later I found if I tftp something, let's see, a 1-byte
file, or even a non-existent file, then bootm from flash would bring
up working network interfaces. It looked like "tftp" does some
initialization
for the network interfaces.
I read ppcboot-2.0.0/common/cmd_net.c:netboot_common(), which
calls net/net.c:NetLoop(), in which I see functions like eth_halt(),
eth_init(bd) get called.
Here's my 2nd question: is it a good idea that I modify ppcboot to
include these network initialization functions just before booting my
kernel image? Maybe this is not necessary but I really could not figure
out why the "tftp" before loading kernel image made the difference
on the network.

Thanks,

El.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
