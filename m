Return-Path: <pacman@shell.TheWorld.com>
Received: from TheWorld.com (pcls1.std.com [192.74.137.141])
	by ozlabs.org (Postfix) with ESMTP id 53E97679E1
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2006 15:30:46 +1100 (EST)
Received: from shell.TheWorld.com (root@shell01.theworld.com [192.74.137.71])
	by TheWorld.com (8.12.8p1/8.12.8) with ESMTP id k1J4PGRc002389
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2006 23:25:16 -0500
Received: (from pacman@localhost)
	by shell.TheWorld.com (8.9.3/8.9.3) id XAA914217
	for linuxppc-dev@ozlabs.org; Sat, 18 Feb 2006 23:10:16 -0500 (EST)
From: Alan Curry <pacman@TheWorld.com>
Message-Id: <200602190410.XAA914217@shell.TheWorld.com>
Subject: altivec_unavailable_exception Oopses
To: linuxppc-dev@ozlabs.org
Date: Sat, 18 Feb 2006 23:10:16 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When running a CONFIG_ALTIVEC=n kernel on a G4, altivec_unavailable_exception
should send a SIGILL to any process that tries to execute a vector
instruction in user mode. For some reason, it's not doing that. Instead, it
either Oopses or continually retries the faulting instruction. Sometimes it
also prints the message indicating that fault happened in kernel mode.

I've tried 2.6.15.4 and 2.6.16-rc4. Although the log messages look different,
the general idea is the same.

Log messages from 2.6.15.4:
AltiVec used in kernel (task=dd77a050, pc=0)
AltiVec used in kernel (task=dd77a050, pc=0)
AltiVec used in kernel (task=dd77a050, pc=0)
AltiVec used in kernel (task=dd77a050, pc=0)
AltiVec used in kernel (task=dd77a050, pc=0)
AltiVec used in kernel (task=dd77a050, pc=0)
AltiVec used in kernel (task=dd77a050, pc=0)
AltiVec used in kernel (task=dd77a050, pc=0)
AltiVec used in kernel (task=dd77a050, pc=0)
[...much later, on another attempt...]
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0005ABC LR: C0004A5C SP: D17E9F20 REGS: d17e9e70 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000088, DSISR: 40000000
TASK = c93ad830[11262] 'mplayer' THREAD: d17e8000
Last syscall: 174
GPR00: C0004A5C D17E9F20 C93AD830 00000004 00000004 00030001 00000000 0F9E4C00
GPR08: 10530000 C0004A5C 00009032 C0320000 093ADA00 1053A930 00000001 00000000
GPR16: 10097774 00000000 00000000 10090000 00000000 30017480 00000000 7FA87A74
GPR24: 00000004 00000004 7FA87B14 7FA87A60 7FA87A74 300269E8 0FAFBA1C 00000004
NIP [c0005abc] altivec_unavailable_exception+0x24/0x94
LR [c0004a5c] ret_from_except+0x0/0x1c
Call trace:
 [c0004a5c] ret_from_except+0x0/0x1c

Log messages from 2.6.16-rc4:
Unable to handle kernel paging request for data at address 0x00000088
Faulting instruction address: 0xc000e5a0
Oops: Kernel access of bad area, sig: 11 [#1]
Modules linked in: ipv6 ip_nat_tftp ip_conntrack_tf tp ip_nat_irc ip_conntrack_irc ip_nat_ftp ip_conntrack_ftp ip_nat_amanda ip_conntrack_amanda ipt_MASQUERADE iptable_nat ip_nat ip_conntrack nfnetlink ip_tables x_tables snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd ohci_hcd usbcore ohci1394 ieee1394 unix dm_mod mv643xx_eth via_rhine psmouse i8042 atkbd serio libps2
NIP: C000E5A0 LR: C000F540 CTR: 00000000
REGS: d4e49e70 TRAP: 0300   Not tainted  (2.6.16-rc4)
MSR: 00009032 <EE,ME,IR,DR>  CR: 44000482  XER: 00000000
DAR: 00000088, DSISR: 40000000
TASK = dbc29440[1347] 'mplayer' THREAD: d4e48000
GPR00: C000F540 D4E49F20 DBC29440 00000004 00000004 00030001 00000000 0F9E4C00
GPR08: 104C0000 C000F540 00009032 C000E580 1BC29618 104CC6C0 100A0000 FFFFFFFF
GPR16: 00000000 00000000 00000000 10090000 00000000 30017720 10007CD0 103A3BA8
GPR24: 103A3C38 00000006 7FDB2B8C 00000000 7FDB2AF4 00000006 00000001 00000004
NIP [C000E5A0] altivec_unavailable_exception+0x20/0x84
LR [C000F540] ret_from_except+0x0/0x14
Call Trace:
[D4E49F20] [10003D85] 0x10003d85 (unreliable)
[D4E49F40] [C000F540] ret_from_except+0x0/0x14
--- Exception: f21 at 0x10014524
    LR = 0x100144a0
Instruction dump:
bba10014 3863eba8 38210020 4bfff190 9421ffe0 7c0802a6 3ca00003 7c641b78
93e1001c 60a50001 90010024 7c7f1b78 <80030084> 38600004 70094000 801f0080
[...later, on second attempt...]
Oops: Unrecoverable VMX/Altivec Unavailable Exception, sig: 6 [#2]
Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc ipv6 ip_nat_tftp ip_conntrack_tftp ip_nat_irc ip_conntrack_irc ip_nat_ftp ip_conntrack_ftp ip_nat_amanda ip_conntrack_amanda ipt_MASQUERADE iptable_nat ip_nat ip_conntrack nfnetlink ip_tables x_tables snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd ohci_hcd usbcore ohci1394 ieee1394 unix dm_mod mv643xx_eth via_rhine psmouse i8042 atkbd serio libps2
NIP: 00000000 LR: 00000000 CTR: 00000000
REGS: 105bd458 TRAP: 0000   Not tainted  (2.6.16-rc4)
MSR: 00000000 <>  CR: 00000000  XER: 00000000
TASK = d3106050[1428] 'mplayer' THREAD: dc664000
GPR00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
GPR08: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
GPR24: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
NIP [00000000] 0x0
LR [00000000] 0x0
Call Trace:
[DC665ED0] [C0007674] show_stack+0x5c/0x184 (unreliable)
[DC665F00] [C00070B0] show_regs+0x180/0x1b8
[DC665F20] [C000D788] die+0x7c/0xe0
[DC665F40] [C000F540] ret_from_except+0x0/0x14
--- Exception: f21 at 0x10015374
    LR = 0x10006438
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 

/proc/cpuinfo while running the no-altivec 2.6.16-rc4:
processor       : 0
cpu             : 7447/7457
clock           : 999.999990MHz
revision        : 0.1 (pvr 8002 0101)
bogomips        : 66.56
timebase        : 33333333
machine         : CHRP Pegasos2
