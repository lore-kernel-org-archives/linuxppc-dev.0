Message-ID: <3C51BFB7.9ABB6E46@mvista.com>
Date: Fri, 25 Jan 2002 13:27:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: lapinski@ece.utexas.edu
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem with initial Linux kernel booting on Sandpoint
References: <Pine.A41.4.44.0201222126270.10594-100000@pacific.ece.utexas.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Viktor,

Verify your switch settings...

Mark
--

Viktor Lapinskii wrote:

> Hello!
>
> I am having problems booting HardHat Linux kernel on Sandpoint.
>
> After uncompress_kernel() writes the message
>
> Now booting the kernel
>
> and the booter jumps the the kernel, there is a delay of at least 40
> (forty) minutes before the kernel displays the messages (see the log at
> the end of this message).  Then it hangs forever having displayed a
> warning about the real-time clock.  I tried both the "standard" HardHat
> kernel and custom-built ones.  Results are the same.
>
> I would appreciate any suggestions as to how to approach this problem.
>
> Viktor
>
> --------------------------------------------------------
> Here are the details:
>
> Hardware:
>  Motorola Sandpoint M98SP_X1
>  M98PPMC8240 Rev. X1
>
> Switches:
>  S3 down (towards PPMC8240)
>  S4 up
>  S5 tried both -- no difference
>  S6 down
>
> Firmware:
>  DINK 32 V10.0, Rev. 5.
>
> Kernel:
>  Hard Hat Journeyman 2.0 -- linux-2.4.2_hhl20
>
> Host OS (should not matter):
>  Red Hat Linux 7.1
>
> --------------------------------------------------------
> root:/opt/hardhat/devkit/ppc/82xx/target/boot
> # ls
> System.map-motorola-sandpoint
> System.map-motorola-sandpoint-2.4.2_hhl20-hhl2.0.0
> vmlinux-motorola-sandpoint
> vmlinux-motorola-sandpoint-2.4.2_hhl20-hhl2.0.0
> vmlinuz-motorola-sandpoint
> vmlinuz-motorola-sandpoint-2.4.2_hhl20-hhl2.0.0
>
> root:/opt/hardhat/devkit/ppc/82xx/target/boot
> # zsrec -s 900000 vmlinuz-motorola-sandpoint > vmlinuz-msp.900000.srec
>
> root:/opt/hardhat/devkit/ppc/82xx/target/boot
> # ascii-xfr -svn -l 25 vmlinuz-msp.900000.srec > /dev/ttyS1
> Line delay: 25 ms, character delay 0 ms
>
> 1509.8 Kbytes transferred at 1546040 CPS... Done.
>
> root:/opt/hardhat/devkit/ppc/82xx/target/boot
> #
>
> --------------------------------------------------------
> Duart Initialized...
> 32 General Purpose Registers Initialized...
> 32 Floating Point Registers Initialized...
> 100 Special Purpose Registers Initialized...
>
> Data Cache has been enabled...
> Instruction Cache has been enabled...
>
> DDD   III  N   N  K  K   333    222
> D  D   I   NN  N  K K   3   3  2   2
> D   D  I   N N N  KK      33     22
> D  D   I   N  NN  K K   3   3  22
> DDD   III  N   N  K  K   333   22222  for KAHLUA - Address Map: B
>
> Version 10.0, Revision 5
>
> Written by : Motorola's RISC Applications, Austin, TX
> Released :   Nov 24th, 1998
> Yellowknife X4
>
> Copyright Motorola, Inc. 1993, 1994, 1995, 1996, 1997, 1998
>
> DINK32_KAHLUA >>sb -k 38400
>
>  Baud rate changing to 38400...
> ....
> DINK32_KAHLUA >>
> DINK32_KAHLUA >>dl -k
> set to Keyboard Port
>
> DINK32_KAHLUA >>sb -k 9600
>
>  Baud rate changing to 9600...
> ....
> DINK32_KAHLUA >>
> DINK32_KAHLUA >>sb -k
> Current baud rate is 9600
> DINK32_KAHLUA >>dl -k
> set to Keyboard Port
> Download Complete.
> DINK32_KAHLUA >>go 900000
> loaded at:     00900000 009091B8
> relocated to:  00800000 008091B8
> zimage at:     00906000 00997904
> avail ram:     00400000 00800000
>
> Linux/PPC load:
> Uncompressing Linux...done.
> Now booting the kernel
> *** >>> The messages below appeared after at least 40-minute delay <<< ***
> Total memory = 32MB; using 0kB for hash table (at 00000000)
> Linux version 2.4.2_hhl20 (build@2of9) (gcc version 2.95.3 20010315 (release/MontaVista)) #1 Wed May 23 14:33:28 PDT 2001
> Motorola SPS Sandpoint Test Platform
> Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
> On node 0 totalpages: 8192
> zone(0): 8192 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line:
> OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at f7fd0000
> TODC real-time-clock was stopped. Now starting...
> time_init: decrementer frequency = 820.000092 MHz
> Warning: real time clock seems stuck!
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
