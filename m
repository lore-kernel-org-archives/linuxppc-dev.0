Message-ID: <005901bfe55b$c2714110$1952df8d@SOYANG>
From: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA timing prob.
Date: Tue, 4 Jul 2000 11:01:25 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

Someone has kindly responded that I have to upgrade RPX Utility software to change SYPCR value.

As suggestion, I changed SYPCR to make it's maximum value of BMT - 0xff - with a BDM.

And I tried several values for clocks then I got some messages from cardmgr which is somewhat hopeful.

/* message from console */

bash-2.03# insmod pcmcia_core
Linux PCMCIA Card Services 3.1.10
  kernel build: 2.2.13 #29 Sun Jul 2 04:50:02 KST 2000
  options:  none
bash-2.03# insmod m8xx_pcmcia gClocks=48
gClocks=48
m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
m8xx_pcmcia: RPX CLASSIC or RPX LITE using SLOT_B with IRQ 13.
bash-2.03# insmod ds
bash-2.03# cardmgr
cardmgr[47]: starting, version is 3.1.10
bash-2.03# cardmgr[47]: watching 1 sockets
cardmgr[47]: initializing socket 0
cardmgr[47]: socket 0: Anonymous Memory
cardmgr[47]: executing: 'insmod /lib/modules/2.2.13/pcmcia/memory_cs.o'
__ioremap(): phys addr 0 is RAM lr c0009d98
memory_cs: mem0:<7>m8xx_pcmcia: Service(0, 8, 0xc0cf906c)
NIP: C43C12BC XER: C000007F LR: C43C12B8 REGS: c0b318a0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0b30000[47] 'cardmgr' mm->pgd c0d13000 Last syscall: 54
last math 00000000
GPR00: C43C12B8 C0B31950 C0B30000 00000000 00000001 C00D0B94 C00C0000 C00C0000
GPR08: 00001000 C400C874 E4001FFF 00000000 53033039 100214D0 100B47B0 00000000
GPR16: 100B4AF0 7FFFDC68 7FFFDC48 00000000 00009032 00000000 C016EC84 00000000
GPR24: C016EC00 C0B31988 00000001 C016ED54 C016EC00 C0B31958 0000000C 00000000
Call backtrace:
C43C12B8 C43C1654 C43C2E54 C4002118 C4003860 C43C1140 C400E834
C400F518 C00334AC C00022D8 0FF8CBA8 10002B9C 10003FD0 0FF09E78
00000000
Kernel panic: kernel access of bad area pc c43c12bc lr c43c12b8 address 0 tsk c7
Rebooting in 180 seconds..

/* message ends */

What's the meaning of Anonymous memory?

To be sure, I have read all the posts about PCMCIA in this group and applied all patches from ftp://ftp.absolval.com/rpxlite.

My board is RPX Lite 850 SR and I used Xircom CE3-10BT and 3Com 3CCFE574BT cards.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
