Message-ID: <001a01bfe190$40457fe0$1952df8d@SOYANG>
From: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: [PCMCIA] cardmgr (or something) crashes the kernel.
Date: Thu, 29 Jun 2000 15:07:05 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

After I've posted PCMCIA network card recommendation related message, I have optain one card from a friend.

It is named as "3Com Megahertz 10/100 LAN PC Card Model 3CCFE574BT".

I accomplished everything from ftp://ftp.absolval.com/pub/rpxlite/.

When I executed rc.pcmcia script this message follows and kernel is crashed.

/* message from console */

bash-2.03# export PCMCIA=yes
bash-2.03# export PCIC=m8xx_pcmcia
bash-2.03# bash /etc/rc.d/rc.pcmcia start
/etc/rc.d/rc.pcmcia: PCIC: readonly variable
Starting PCMCIA services: modulesLinux PCMCIA Card Services 3.1.10
  kernel build: 2.2.13 #6 Wed Jun 28 22:11:22 KST 2000
  options:  none
m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
m8xx_pcmcia: RPX CLASSIC or RPX LITE using SLOT_B with IRQ 13.
 cardmgr.
bash-2.03# cardmgr[53]: starting, version is 3.1.10
cardmgr[53]: watching 1 sockets
cardmgr[53]: initializing socket 0
Machine check in kernel mode.
Caused by (from msr): regs c0a9d850 Unknown values in msr
NIP: C4003C94 XER: E000047F LR: C4003C70 REGS: c0a9d850 TRAP: 0200
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0a9c000[53] 'cardmgr' mm->pgd c0cd9000 Last syscall: 54
last math 00000000
GPR00: C4012000 C0A9D900 C0A9C000 C4011000 C0AB0044 000001DF C00B3000 00000011
GPR08: 00000C40 C4011000 C0CB6FAC 00001000 35F35F3C 100214D0 100ADFF0 00000000
GPR16: 100A0E50 7FFFDC68 7FFFDC48 00000000 00009032 00A9DE80 00000000 C0002544
GPR24: C0002284 00000002 C01E906C C0A9D96A 00000002 00000000 C01E9000 C4011000
Call backtrace:
C4003C70 C4004418 C4004978 C4004700 C400608C C40038C8 C400F4C8
C00335E8 C00022D8 00000000 10001880 10002A30 10003FD0 0FF09E78
00000000
Kernel panic: machine check
Rebooting in 180 seconds..

/* message end */

I've assigned M8XX_BUSFREQ in pcmcia-cs-3.1.10/modules/m8xx_pcmcia.c to 50 * 1000000, since my board is RPX Lite 850 SR 50Mhz

What's the main cause of problem?

The cardmgr?, The modules - pcmcia_core, m8xx_pcmcia, ds - ? or that The card itself is unsupported?

Please answer.

Thanks in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
