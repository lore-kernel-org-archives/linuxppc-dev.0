Message-ID: <3D3F349B.7010006@lvl7.com>
Date: Wed, 24 Jul 2002 19:13:31 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: James F Dougherty <jfd@gigabitnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Mount failures on custom 8245 H/W
References: <3D3E22EE.DF4F3F83@gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello-
	I can't tell you much about the underlying cause of your errors I'm afraid, but
according to the Motorolla Programming Env. Manual, you got a Program Exception
Trap (0x700).  Page 6-29 of the book lists the various causes of this problem.
I would suggest running objdump with the disassemble option around the address
range specified by the NIP value of your first oops.  That should give you some
idea which of the listed reasons caused your problem, and which section of code
this problem occured in.  You will have to try it for yourself, but looking at
the list, I would put my money on either an explicit trap instruction in one the
offending driver, or in a misconfigured compiler generating instructions which
the 8245 does not support during the compilation of the misbehaving code in
question.

Hope that helps
Neil

James F Dougherty wrote:

> Hi,
>
> My h/w is an 8245 using internal UART, onboard BCM5701 Gig-E,
> dual DOC and 64MB PC100 SDRAM.
>
> I am running PPCBoot 1.1.4 and Linux 2.4.2 from MontaVista HHL20.
> I am using Denx ELDK for root-fs and toolchains.
>
> My Memory map is below:
>
> 0x00000000 - 0x40000000 - 64MB SDRAM SIMM
>                           (Unregistered PC-100 SDRAM DIMM Module)
>
> 0xFF000000 - 0xFF001FFF - M-Systems DiskOnChip (TM) 2000
>                           TSOP 16MB (MD2211-D16-V3)
>
> 0x70000000 - 0x70001FFF - M-Systems DiskOnChip (TM) 2000
>                           DIP32 (Socketed 16MB - 1GB ) *
>                           NOTE: this is not populated on all systems.
>
> 0x7c000000 - 0x7c000000 - Reset Register
>                           (Write 0 to reset)
>
> 0x7c000001 - 0x7c000001 - System LED
>                           (Clear Bit 7 to turn on, set to shut off)
>
> 0x7c000002 - 0x7c000002 - M48T59 Watchdog IRQ3
>                           (Clear bit 7 to reset, set to assert IRQ3)
>
> 0x7c000003 - 0x7c000003 - M48T59 Write-Protect Register
>                           (Clear bit 7 to make R/W, set to make R/O)
>
> 0x7c002000 - 0x7c002003 - Infineon OSRAM DLR2416 4 Character
>                           5x7 Dot Matrix Alphanumeric Display
>                           (Each byte sets the appropriate character)
>
> 0x7c004000 - 0x7c005FF0 - SGS-THOMSON M48T59Y 8K NVRAM/RTC
>                           NVRAM Memory Region
>
> 0x7c005FF0 - 0x7c005FFF - SGS-THOMSON M48T59Y 8K NVRAM/RTC
>                           Realtime Clock Registers
>
> 0xFFF00000 - 0xFFF80000 - 512K PLCC32 BootRom
>
> After reading through the documentation, I decided not to use any I/O
> devices from 0x70000000-0x7FFFFFFF (MPC8245 EXTROM space) after having
> previously used ioremap() for all of my I/O spaces, including the
> MPC8245
> internal UART after the EUMBBAR gets remapped in mpc10x_common.c. At
> this
> point, I have a very basic system, without a TOD, and only UART and
> Ethernet
> (in other words, I'm only using CPU registers and the PCI Bus). I am
> fairly
> confident in my H/W and the memory initialization, primarily because
> VxWorks
> runs perfectly on the same platform with some very memory intensive
> applications.
>
> Anyhow, my system boots, and mounts root via NFS, however, when I try to
> mount proc, it crashes and gives me the errors below.
>
> Anyone have an idea what could be wrong? I wonder -- could a misbehaving
> driver with
> bogus procfs entries be causing this problem?
>
>
> 					Thanks,
> 					-James
>
> Notes:
>
> c0040520 T sys_mount
> c0003ffc T ret_from_syscall_1
>
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 72k init 4k openfirmware
> modprobe: modprobe: Can't open dependencies file
> /lib/modules/2.4.2_hhl20/modules.dep (No such file or directory)
> INIT: version 2.78 booting
>                 Welcome to DENX Embedded Linux Environment
>                 Press 'I' to enter interactive startup.
> Mounting proc filesystem:  Oops: Exception in kernel mode, sig: 4
> NIP: C0040520 XER: 00000000 LR: C0003FFC SP: C3C7FE80 REGS: c3c7fdd0
> TRAP: 0700
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c3c7e000[18] 'mount' Last syscall: 21
> last math c3c7e000 last altivec 00000000
> GPR00: 00000054 C3C7FE80 C3C7E000 10020040 10020050 10020060 C0ED0000
> 00000000
> GPR08: 10020061 C3C7FE90 C0040520 40442080 40442080 100262E8 00000000
> 100D0890
> GPR16: 7FFFFC9C 7FFFFC98 10020000 00000000 00009032 03C7FE80 00000000
> C0004268
> GPR24: C0003FA0 10020020 7FFFFECA 00000000 10020040 00000000 00000000
> 7FFFFCA8
> Call backtrace:
> C0003FFC FFFFFFFF 10002440 10002ED0 10003B5C 100048EC 0FEE5238
> 00000000
> [FAILED]
> Configuring kernel parameters:  [  OK  ]
> RTC_RD_TIME: Invalid argument
> ioctl() to /dev/rtc to read the time failed.
> Setting clock : Wed Dec 31 19:00:28 EST 1969 [  OK  ]
> Activating swap partitions:  [  OK  ]
> Setting hostname switch-2:  [  OK  ]
> grep: /proc/mounts: No such file or directory
> Checking root filesystem
> fsck: fsck.nfs: not found
> fsck: Error 2 while executing fsck.nfs for /dev/nfs
> [  OK  ]
> Checking filesystems
> Checking all file systems.
> [  OK  ]
> Mounting local filesystems:  [  OK  ]
> Enabling swap space:  [  OK  ]
> grep: /proc/cpuinfo: No such file or directory
>                                               Oops: Exception in kernel
> mode, sig: 4
> NIP: C0040520 XER: 00000000 LR: C0003FFC SP: C3A7FE80 REGS: c3a7fdd0
> TRAP: 0700
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c3a7e000[95] 'mount' Last syscall: 21
> last math c3a7e000 last altivec 00000000
> GPR00: 00000054 C3A7FE80 C3A7E000 10020038 10020048 10020058 C0ED0000
> 00000000
> GPR08: 10020059 C3A7FE90 C0040520 40222088 40222088 100262E8 00000000
> 100D6ED0
> GPR16: 7FFFFCAC 7FFFFCA8 10020000 00000000 00009032 03A7FE80 00000000
> C0004268
> GPR24: C0003FA0 10020018 7FFFFED0 00000000 10020038 00000000 00000000
> 7FFFFCB8
> Call backtrace:
> C0003FFC FFFFFFFF 10002440 10002ED0 10003B5C 100048EC 0FEE5238
> 00000000
> INIT: Entering runlevel: 3
> grep: /proc/cmdline: No such file or directory
> Entering non-interactive startup
> Starting system logger: Oops: Exception in kernel mode, sig: 4
> NIP: C0040520 XER: 00000000 LR: C0003FFC SP: C3A3DE80 REGS: c3a3ddd0
> TRAP: 0700
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c3a3c000[112] 'mount' Last syscall: 21
> last math c3a3c000 last altivec 00000000
> GPR00: 00000054 C3A3DE80 C3A3C000 10020050 10020060 10020070 C0ED0000
> 00000000
> GPR08: 10020071 C3A3DE90 C0040520 40222080 40222080 100262E8 00000000
> 100AF350
> GPR16: 7FFFFC9C 7FFFFC98 10020000 00000000 00009032 03A3DE80 00000000
> C0004268
> GPR24: C0003FA0 10020030 7FFFFEC6 00000000 10020050 00000000 00000000
> 7FFFFCA8
> Call backtrace:
> C0003FFC FFFFFFFF 10002440 10002ED0 10003B5C 100048EC 0FEE5238
> 00000000
> pidof: /proc not mounted, failed to mount.
> [  OK  ]
> Starting kernel logger: Oops: Exception in kernel mode, sig: 4
> NIP: C0040520 XER: 00000000 LR: C0003FFC SP: C39B1E80 REGS: c39b1dd0
> TRAP: 0700
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c39b0000[123] 'mount' Last syscall: 21
> last math c39b0000 last altivec 00000000
> GPR00: 00000054 C39B1E80 C39B0000 10020050 10020060 10020070 C0ED0000
> 00000000
> GPR08: 10020071 C39B1E90 C0040520 40222080 40222080 100262E8 00000000
> 100DA250
> GPR16: 7FFFFC9C 7FFFFC98 10020000 00000000 00009032 039B1E80 00000000
> C0004268
> GPR24: C0003FA0 10020030 7FFFFEC6 00000000 10020050 00000000 00000000
> 7FFFFCA8
> Call backtrace:
> C0003FFC FFFFFFFF 10002440 10002ED0 10003B5C 100048EC 0FEE5238
> 00000000
> pidof: /proc not mounted, failed to mount.
> [  OK  ]
> Starting xinetd: Oops: Exception in kernel mode, sig: 4
> NIP: C0040520 XER: 00000000 LR: C0003FFC SP: C3967E80 REGS: c3967dd0
> TRAP: 0700
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c3966000[139] 'mount' Last syscall: 21
> last math c3966000 last altivec 00000000
> GPR00: 00000054 C3967E80 C3966000 10020CD8 10020CE8 10020CF8 C0ED0000
> 00000000
> GPR08: 10020CF9 C3967E90 C0040520 44222088 44222088 100262E8 00000000
> 100DD750
> GPR16: 7FFFFC1C 7FFFFC18 10020000 00000000 00009032 03967E80 00000000
> C0004268
> GPR24: C0003FA0 10020CB8 7FFFFE61 00000000 10020CD8 00000000 00000000
> 7FFFFC28
> Call backtrace:
> C0003FFC FFFFFFFF 10002440 10002ED0 10003B5C 100048EC 0FEE5238
> 00000000
> pidof: /proc not mounted, failed to mount.
> [  OK  ]
>
> switch-2 login:
>
>


--
/******************************************************************
*Neil Horman
*Software Engineer
*LVL7 Systems
*13000 Weston Pkwy.
*Cary, NC 27513
*(919)-865-2915
*nhorman@lvl7.com
*PGP keyID 0xB5E1020A
*http://www.keyserver.net/en
*******************************************************************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
