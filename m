Return-Path: <bantonovici@priority.mb.ca>
From: bogdan antonovici <bantonovici@priority.mb.ca>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Message-Id: <1121959795.800.18.camel@rd-lab>
Mime-Version: 1.0
Date: 21 Jul 2005 10:29:56 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, ppckernel <ppckernel@ppckernel.org>
Subject: swap_dup: Bad swap file entry 00480020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have an MPC860 system, 16M flash, 16M SDRAM, no disk, just kernel
support for ramdisk. root fs is nfs mounted.
I get messages like the one bellow:

swap_dup: Bad swap file entry 00480020
VM: killing process chat
swap_free: Bad swap file entry 00480020

and after a while a get an oops:

Oops: kernel access of bad area, sig: 11
NIP: C0045154 XER: 20000000 LR: C0045464 SP: C0CBBE60 REGS: c0cbbdb0
TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00E9A01C, DSISR: C0000000
TASK = c0cba000[36] 'pppd' Last syscall: 142
last math 00000000 last altivec 00000000
GPR00: C0045464 C0CBBE60 C0CBA000 C0CBBE88 C01DE8C0 00000000 C010E2B8
0000001F
GPR08: C0CBA000 00000000 C0C4E03C 00000001 84444448 100B0C5C 10040000
10040000
GPR16: 10040000 10040000 10040000 10040000 C0CBBEF8 00000000 00000001
7FFFFFFF
GPR24: 00000004 00000001 00000145 C0CBBED8 00000004 C0E9A000 C0E9A008
00E9A008
Call backtrace:
C0087D84 C0045464 C0045858 C0009448 C00041DC 1001DB84 10006F24
10006A8C 0FE4BDA0 00000000

At the time of swap messages i was running a proprietary driver, my
application and few daemons.

ps
  PID  Uid     VmSize Stat Command
    1 root        584 S   init
    2 root            SW  [keventd]
    3 root            SWN [ksoftirqd_CPU0]
    4 root            SW  [kswapd]
    5 root            SW  [bdflush]
    6 root            SW  [kupdated]
    7 root            SW  [rpciod]
    9 root        760 S   -ash
   21 root        616 S   sectionmond
   22 root        608 S   sectionmond
   23 root        608 S   sectionmond
   24 root        608 S   sectionmond
   25 root        612 S   sectionmond
   26 root        608 S   sectionmond
   30 root       1304 S   /ppcnetsnmp/sbin/snmpd
   39 root        916 S   pppd /dev/ttyS1 19200 defaultroute demand idle
5 192.
  109 root        680 R   ps


I look on the net for some clues but it's quite confusing, i noticed
many emails on swap_dup/swap_free error messages but i couldn't figure
out what should i search for.
I tested the ram with mtest from pppboot2.0.


Has any of you an idea what is all about? 

Thank you
Bogdan
