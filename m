Message-ID: <2F67A63DFFB1D31185D90090278CBB2D014ECCEF@apmail6.chn.agilent.com>
From: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
To: mgreer@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: IDE on Sandpoint
Date: Wed, 6 Sep 2000 17:58:31 +0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Thanks for your help. I have tried the new 2.4 source and make the kernel
boot, but the kernel crashs when initializes the Intel eepro100 network
card.

Here is the message:
============================================================================
============
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.33 $ 2000/05/24 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Enabling device 00:10.0 (0000 -> 0003)
Kernel stack overflow in process c0230000, r1=c0230410
NIP: 00000000 XER: 20000000 LR: 00000000 REGS: c0230360 TRAP: 0400
MSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0230000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C0230410 C0230000 C0230420 00000000 20001032 C0150000
00000000
GPR08: C0150000 C0120000 C0130000 FE000000 00000000 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00001032 00230410 00000000
00000000
GPR24: 00000000 C0130000 00000001 C014B577 00000000 C014B577 C014B577
C014B54B
Call backtrace:
00000000 C0158D0C C0230590 00000000 C0158D0C C02307D0 00000000
C0158D0C C0230A10 00000000 C0158D0C C0230C50 00000000 C0158D0C
C0230E90 00000000 C0158D0C C02310D0 00000000 C0158D0C C0231310
00000000 C0158D0C C0231550 00000000 C0158D0C C0231790 00000000
C0158D0C C0018B74 C015FB8C C0231E78 C0244020
Kernel panic: kernel stack overflow
Rebooting in 180 seconds..
============================================================================
===============

I am using kernel 2.3.16 before, its driver of eepro100 works well. I am
tring to fix it, any suggestions?

Thanks,
Zhang haitao,



-----Original Message-----
From: Mark A. Greer [mailto:mgreer@mvista.com]
Sent: Wednesday, September 06, 2000 6:33 AM
To: ZHANG,HAI-TAO (Non-A-China,ex1)
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on Sandpoint


Yes, I had to make some minor changes to the driver to get ide to work (plus
add support to sandpoint_setup.c).

Go to ftp://www.mvista.com/pub/Area51/sandpoint-8240/  and get
sandpoint.linux.tar.gz.  This is a tarball of kernel source that has IDE
working (at least on an 8240 and a 755/107).  I just put it there so let me
know if you have any problems ftp'ing it or its corrupted or something.

This kernel routes ide interrupts to the standard ISA/8259 IRQ's, namely 14
&
15.

Mark

> Hi,
>
> I have tried to boot Linux kernel on Sandpoint 603e using the nfsroot. But
I
> cannot make the IDE working under Mode 1.
>
> There are some comments from MontaVista CDK1.2:
> "5) If you want to try IDE, you must route the IDE interrupts through the
> i8259; they are not wired to PCI slots 1 & 2 as the Sandpoint manual
> indicates."
>
> In the Winbond 83c553 manual, there are some registers that can route the
> IDE IRQ into 8259 (IRQ14). I have tried to set them but it does not work,
do
> I need to modify the hardware? or someone has the successful experience on
> IDE disk who can help me?
>
> Thanks a lot,
> Haitao Zhang,
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
