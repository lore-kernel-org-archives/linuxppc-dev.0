From: marko.virkki@mitron.fi
Message-ID: <17D9D7DF3CD5A94A9B4E82778D24391910A068@MITRON>
To: Tord.Andersson@combitechsystems.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MPC5200LITE - kernel BUG at page_alloc.c
Date: Thu, 27 Nov 2003 10:15:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Tord

Don't know reason for your problem (I'm using 2.4.21) but this is the first
time I've seen someone sending a boot printout of IceCube5200. I have been
wondering BogoMips value for IceCube. Why it is about 266? I assume you are
(and possibly you really are) running at 396MHz. If I have understood things
correctly it should be something like 400. Decrementer calculates correctly
(i.e 10ms timer period when HZ==100) because it is derived from XLB_CLK.
BogoMips is calculated using __delay-function that seems to run correctly if
I bypass core PLL by jumpers (99MHz XLB_CLK gives something like 99
BogoMips). When PLL is enabled and CPU seems to run at 396 BogoMips value is
as it is in your listing too. The source code for __delay-function is the
same than it's in 8xx-port and 823 at 58MHz gives about 56 BogoMips. Has
Motorola weakened something in CPU core?

Yes, I know that BogoMips (and MIPS in general) does not mean anything. I'm
just curious to get some explanation for this behaviour (or have I really
misunderstood something).

br, Marko


> -----Original Message-----
> From:	Tord Andersson [SMTP:Tord.Andersson@combitechsystems.com]
> Sent:	27. marraskuuta 2003 9:53
> To:	linuxppc-embedded@lists.linuxppc.org
> Subject:	MPC5200LITE - kernel BUG at page_alloc.c
>
>
> Hi,
>
> I have some troubles when trying to run Linux-2.4.23-pre5 on a an
> MPC5200LITE board (16MB) with U-BOOT 1.0.1). Right after the bogoMIPS
> calculation I get "kernel BUG at page_alloc.c:105", and the system
> reboots (see excerpt at end of mail).
> I think the part which goes wrong is when the system tries to check if
> the free pages in memory are OK (__freepages_ok(...)), where the
> (page->mapping) seems to be marked and thus causing a bug.
> Is there some kind of problems related to that all pages resides in the
> zone(0), which seems to be used for DMA?
> I have tried both the ELDK as described in other mails in this list and
> the Metrowerks PCS evaluation version, and I end up with the same
> problem irregardless if I try to use tftp for the kernel, nfs for the
> root file system or all things in flash (rootfs in jffs2).
>
> Any clues?
>
> Kind regards,
>
> Tord
>
> .....
> => run net_nfs
> TFTP from server 146.75.80.108; our IP address is 146.75.80.234
> Filename '/MPC5200/uImage'.
> Load address: 0x200000
> Loading:
> #################################################################
>
> #################################################################
>          #
> done
> Bytes transferred = 669156 (a35e4 hex)
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.4.23-pre5
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    669092 Bytes = 653.4 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
> Linux version 2.4.23-pre5 (toande@jupiter) (gcc version 2.95.4 20010319
> (prerele
> ase/franzo/20011204)) #1 Mon Nov 10 17:25:53 CET 2003
> Motorola Icecube port
>     (C) 2003 MontaVista Software, Inc. (source@mvista.com)
>     (C) 2003 DENX Software Engineering (wd@denx.de)
> On node 0 totalpages: 16384
> zone(0): 16384 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/nfs rw
> nfsroot=146.75.80.108:/opt/eldk/ppc_82xx i
> p=146.75.80.234:146.75.80.108::255.255.255.0:orion:eth0:off panic=1
> Calibrating delay loop... 266.24 BogoMIPS
> kernel BUG at page_alloc.c:105!
> Oops: Exception in kernel mode, sig: 4
> NIP: C002F8F8 XER: 00000000 LR: C002F8F8 SP: C0146380 REGS: c01462d0
> TRAP: 0700
>    Not tainted
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c0144480[0] 'swapper' Last syscall: 0
> last math 00000000 last altivec 00000000
> GPR00: C002F8F8 C0146380 C0144480 00000020 00001032 00000001 00000000
> C0190000
> GPR08: 0000029A C0146DC0 C014DB88 C01462A0 44002044 FFFFFFFE 03FF4000
> 007FFF7E
> GPR16: 00000000 00000001 007FFF00 03FF3E60 003FF000 FFFFFFFF 00000001
> 03F9EC00
> GPR24: 00000000 00000001 00004000 00000008 00004000 00000000 000002FB
> C024B43C
> Call backtrace:
> C002F8F8 C0030654 C017ED34 C017EF58 C017CC04 C0179500 000035F0
> Kernel panic: Attempted to kill the idle task!
> In idle task - not syncing
>  <0>Rebooting in 1 seconds..
>
> U-Boot 1.0.1 (Nov 10 2003 - 10:38:02)
>
###########################################


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
