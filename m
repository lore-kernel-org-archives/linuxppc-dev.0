Message-Id: <200405190319.i4J3JNRV012673@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: memory issue?
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 19 May 2004 11:19:22 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all
   I encountered a problem.
   1) Linux works fine on MPC8241 platform with 32Mbyte memory. (I used
      swap partition in disk)
   2) When working in MPC8241 with 64Mbyte memory, system crash when
      execuate memory-hungry program such as samba and lvm. The
      following is the log info:

	First , U-boot relocates itself to 3fe1000 and works fine.

   Then,  Transferring control to Linux (at address 00000000) ...
   Loading kernel ......Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
	Linux version 2.4.21
	...
	On node 0 totalpages: 16384
	zone(0): 16384 pages.
	zone(1): 0 pages.
	zone(2): 0 pages.
	OpenPIC Version 1.2 (1 CPUs and 6 IRQ sources) at fdfcd000
	OpenPIC timer frequency is 66.000000 MHz
	time_init: decrementer frequency = 16.000000 MHz
	Calibrating delay loop... 106.49 BogoMIPS
	Memory: 61860k available (1996k kernel code, 784k data, 84k init, 0k highmem)
	Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
	Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
	Mount cache hash table entries: 512 (order: 0, 4096 bytes)
	Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
	Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
	.........
	Freeing unused kernel memory: 84k init
	INIT: version 2.84 booting

	After booting OK, when user access the system through samba or execute lvm command, system crash.
  lvm vgdisplay
 Oops: kernel access of bad area, sig: 11
 NIP: C0046F3C XER: 00000000 LR: C0047E3C SP: C2C93E70 REGS: c2c93dc0 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000008C, DSISR: 20000000
TASK = c2c92000[577] 'lvm' Last syscall: 106
last math c2c92000 last altivec 00000000
GPR00: C0047E3C C2C93E70 C2C92000 00000000 00000001 C2C93F18 C3905010 C3FC0E20
GPR08: C3905000 00000009 00001000 C23C6368 44000428 10075EF8 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 02C93F40 00000000 C0005E90
GPR24: C0005C00 00000001 00000009 C3905001 00000000 C2C93F18 C2C93F18 C3905000
Call backtrace:
C2C93F18 C0047E3C C0047E84 C0048078 C00483E0 C0043B50 C0005C5C
00000008 1001FB14 1001FA6C 1001FB78 1001FA6C 1001FC64 1002046C
1001A67C 1001A788 10036A30 100131EC 10016118 1000BF6C 1000C800
0FE7304C 00000000

This is the top command:
  7:07pm  up 7 min,  1 user,  load average: 0.03, 0.17, 0.12
23 processes: 22 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  0.7% user,  0.5% system,  0.0% nice, 98.6% idle
Mem:    61944K av,   28132K used,   33812K free,       0K shrd,    1784K buff
Swap:  498004K av,       0K used,  498004K free                   16504K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  580 root      15   0  1108 1104   924 R     0.9  1.7   0:00 top
    1 root       8   0   540  540   484 S     0.0  0.8   1:08 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    4 root       9   0     0    0     0 SW    0.0  0.0   0:00 kswapd
    5 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    6 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdated
    8 root       9   0     0    0     0 SW    0.0  0.0   0:00 khubd
   12 root       9   0     0    0     0 SW    0.0  0.0   0:00 kcopyd
  7:08pm  up 8 min,  1 user,  load average: 0.00, 0.12, 0.10
24 processes: 23 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  0.9% user,  0.0% system,  0.0% nice, 99.0% idle
Mem:    61944K av,   29500K used,   32444K free,       0K shrd,    1804K buff
Swap:  498004K av,       0K used,  498004K free                   17540K cached

Oops: kernel access of bad area, sig: 11
NIP: C003D210 XER: 00000000 LR: C003E410 SP: C2C93E30 REGS: c2c93d80 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 2BC1BFB7, DSISR: 20000000
TASK = c2c92000[586] 'smbd' Last syscall: 4
last math c2c92000 last altivec 00000000
GPR00: 00000D4C C2C93E30 C2C92000 2BC1BFB3 0003AE16 00001000 00000303 00000FFF
GPR08: 0003AE16 C02A0000 00E82B8B C03A4D4C 44000862 100FAC68 00000000 C26338AC
GPR16: C2CCC240 C0067968 C2C93E48 00001000 00000000 C23A0000 C2633840 00000001
GPR24: 0000002F C3134360 00000000 C0340094 00000FBF C2C93E48 00000000 00001000
Call backtrace:
C2C93E48 C003E85C C003F25C C0067E10 C002E028 C003B4F8 C0005C5C
1000CA38 1000D004 10026764 1003AAE0 1003ABBC 1003ADCC 1003B904
1000365C 0FE4D04C 00000000

  I test the memory using simplt write-and-read method and it is OK.
Therefore I think it is not becuase of the memory configuration problem.
And since system works fine with 32M memory so it is not becuase of
programs. I am confused about this. Can anyone give me some clues?

Best regards
Jack Liu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
