Message-ID: <3A240461.10B69DF3@nexus-tech.net>
Date: Tue, 28 Nov 2000 14:15:45 -0500
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: fb on mpc823
References: <3A22BB86.92419741@nexus-tech.net> <3A22BFAE.997F20C6@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Kyle Harris wrote:
>
> > ... I'm a little confused (not unusual :). Which device should
> > /dev/fb0 be? fbmem.c opens a device using major 29. But lcd823.c....
>
> The confusion is probably not your fault this time :-).  Don't use
> the old lcd driver that has my name in it.  That was just something
> I hacked together one day for testing.  I posted it so someone that
> knew something about frame buffers would really write one.
>
> Fortunately, someone did.  I believe it was Joe Green from MontaVista
> that did a real framebuffer driver.  Go to the MontaVista web site
> and find the CDK 1.2 with the 2.2.14 kernel.
>

Thanks, this makes more sense. But I'm still having problems. I'm
running 2.2.13 on a TQM823 board. I updated lcd823.c and rebuilt the
kernel with fb and vt support. Now I get a kernel panic (listed below).

It appears to be related to the virtual console. If I run without the fb
(but keep vt) it also crashes.

I guess it's time to figure out how to interpret and debug kernel
panics. Any suggestions on where to start?

Thanks, Kyle.

Panic follows:

Linux version 2.2.13 (kyle@brdc01.nexus-tech.net) (gcc version 2.95.2
19991024
(release)) #53 Tue Nov 28 11:14:07 EST 2000
Boot arguments: root=/dev/nfs rw nfsroot=10.77.77.50:/LinuxPPC
nfsaddrs=10.77.77.20:10.77.77.50
LCD frame buffer 75 pages
time_init: decrementer frequency = 187500000/60
Calibrating delay loop... 49.87 BogoMIPS
Memory: 14760k available (780k kernel code, 792k data, 52k init)
[c0000000,c1000000]
Dentry hash table entries: 2048 (order 2, 16k)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
Console: switching to frame buffer device
fb0:  MPC823 LCD frame buffer device
NIP: 00000000 XER: C000FA7F LR: C00F6BEC REGS: c0199df0 TRAP: 0400 DAR:
c00a3824
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0198000[1] 'swapper' mm->pgd c00db000 Last syscall: 120
last math 00000000
GPR00: 00000000 C0199EA0 C0198000 00000000 C00D3B21 C00E9324 C010901C
00000000
GPR08: 00000000 C0100000 00000000 C0110000 35FF5F33 02000130 00FFE500
C0FE0000
GPR16: 40800804 007FFF4F 0000000C 00000000 007FFF00 007FFEA0 00FBFFA0
00000002
GPR24: 00000000 00FFC76C 00000002 00000004 00000005 C0108F5C 00000001
C0108D10
Call backtrace:
C0108F5C C00F5DB0 C00F5E1C C00F4F50 C00F07A8 C0002B8C C0006E68
Kernel panic: kernel access of bad area pc 0 lr c00f6bec address 0 tsk
swapper/1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
