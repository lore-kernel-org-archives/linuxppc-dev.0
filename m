Message-ID: <3C1A21C4.6040607@gatekeeper.informatik.fh-dortmund.de>
Date: Fri, 14 Dec 2001 16:59:00 +0100
From: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: 2.4.17-pre8-ben0: kernel oops using pcmcia services
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I get the below kernel oops after I put my cisco aironet pcmcia card into
the external slot on my tibook. Kernel bug or wrong setup ? While loading
the airo_cs module per hand I get no oops.

Ralf

[root@tibook /root]# cat /etc/sysconfig/pcmcia
PCMCIA=yes
PCIC=yenta_socket
PCIC_OPTS=cardbus
CORE_OPTS=
CARDMGR_OPTS=-f

[root@tibook /root]# cat /etc/init.d/pcmcia start

[root@tibook /root]# lsmod
Module                  Size  Used by
ds                      8720   1
yenta_socket           11088   1
pcmcia_core            43120   0  [ds yenta_socket]
airport                 3840   1
orinoco                36000   0  [airport]
hermes                  6288   0  [airport orinoco]
dmasound_pmac          43136   0
i2c-core               14736   0  [dmasound_pmac]
dmasound_core          13616   0  [dmasound_pmac]
soundcore               4736   3  [dmasound_core]

[root@tibook /root]# ps x | grep cardm
   717 ?        S      0:00 /sbin/cardmgr -f
   726 pts/0    S      0:00 grep cardm


dmesg output after I put in the card:

Linux Kernel Card Services 3.1.22
   options:  [pci] [cardbus] [pm]
Yenta IRQ list 0000, PCI irq58
Socket status: 30000006
cs: memory probe 0x0c0000-0x0fffff:__ioremap(): phys addr c0000 is RAM lr c000f754
Oops: kernel access of bad area, sig: 11
NIP: E182C238 XER: 20000000 LR: E182C214 SP: C6321660 REGS: c63215b0 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 40000000
TASK = c6320000[717] 'cardmgr' Last syscall: 54
last math c6bc6000 last altivec 00000000
GPR00: 00001000 C6321660 C6320000 00000000 E183C815 00000000 00000002 C63216CA
GPR08: 00000000 00000000 08100000 00001000 24004024 1002207C 00000000 00000000
GPR16: 00000000 00000000 00000000 E182C468 00000000 00000000 E182C654 C6A77800
GPR24: 00040000 C63216CA 00000002 C6A77844 C63216CA 00000002 C6A77800 00000000
Call backtrace:
E182C214 E182C924 E182CE84 E182CC40 E182E870 E182C4B4 E182EE84
E182F01C E182C708 E182C100 E182C924 E182CE84 E182CC40 E182E870
E183F438 C004888C C000407C 0000000E 10001D3C 100032F4 10004A14
0FEE4238 00000000




[root@tibook /root]# modprobe airo_cs
[root@tibook /root]# lsmod
Module                  Size  Used by
airo_cs                 4192   0  (unused)
airo                   39264   0  [airo_cs]
ds                      8720   1  [airo_cs]
yenta_socket           11088   1
pcmcia_core            43120   0  [airo_cs ds yenta_socket]
airport                 3840   1
orinoco                36000   0  [airport]
hermes                  6288   0  [airport orinoco]
dmasound_pmac          43136   0
i2c-core               14736   0  [dmasound_pmac]
dmasound_core          13616   0  [dmasound_pmac]
soundcore               4736   3  [dmasound_core]


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
