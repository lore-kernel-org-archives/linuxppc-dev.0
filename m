Return-Path: <Jorge.Ramirez-Ortiz@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B6C36DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 19:34:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Machine check exception. 2.6.20 powerpc tree. 
Date: Wed, 18 Jul 2007 10:27:22 +0100
Message-ID: <35786B99AB3FDC45A8215724617919730136DC04@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <43F1785C-E5DA-4460-A9C7-9B02431F1FE0@kernel.crashing.org>
From: "Ramirez-Ortiz, Jorge" <Jorge.Ramirez-Ortiz@xerox.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar

The address we are trying to access corresponds to a mapped device in
the PCI space
Attached some additional debugging information (we have instrumented the
kernel)

Thanks
jorge


INFO [_probe]: Found Device [irq=3D58]
INFO [_open]: device opened with irq 58
INFO [_read]: waiting for interrupt
INFO [_intr]: ISR 58

PCI1: Error! ERR_DETECT=3D00000040, ATTR=3D00516001, addr=3D80020034,
data=3D00050000

machine_check_exception: task my_process, MCSR=3D0x10008, =
NIP=3D0x10153530
Machine check in user mode.
Caused by (from MCSR=3D10008): Guarded Load or Cache-Inhibited stwcx.
Bus - Read Data Bus Error

Call Trace:
[C7355EF0] [C0006E64] show_stack+0x48/0x19c (unreliable)
[C7355F20] [C000C04C] machine_check_exception+0x294/0x484
[C7355F40] [C000E48C] ret_from_mcheck_exc+0x0/0xe0

cat /proc/cpuinfo
processor       : 0
cpu             : e500v2
clock           : 799.500000MHz
revision        : 2.0 (pvr 8021 0020)
bogomips        : 99.84
timebase        : 49968750
platform        : MPC85xx CDS
Vendor          : Freescale Semiconductor
Machine         : MPC85xx CDS (0xff)
PVR             : 0x80210020
SVR             : 0x80390220
PLL setting     : 0x4
Memory          : 256 MB
LAW 1           : 00000000, 20000000 -> DDR SDRAM
LAW 2           : 80000000, 10000000 -> PCI1
LAW 3           : 90000000, 10000000 -> PCI2
LAW 4           : a0000000, 10000000 -> PCI Express
LAW 5           : e1000000, 01000000 -> PCI1
LAW 6           : e2000000, 01000000 -> PCI2
LAW 7           : e3000000, 01000000 -> PCI Express
LAW 8           : f0000000, 10000000 -> Local bus
DDR 0           : 00000000, 20000000 -> 2/14/10 addr bits
PCI1 Out_1      : 80000000, 10000000 -> Mem: 80000000
PCI1 Out_2      : e1000000, 01000000 -> I/O: 00000000
PCI2 Out_1      : 90000000, 10000000 -> Mem: 90000000
PCI2 Out_2      : e2000000, 01000000 -> I/O: 00000000
PCI3 Out_1      : a0000000, 10000000 -> Mem: a0000000
PCI3 Out_2      : e3000000, 01000000 -> I/O: 00000000
PCI1 In_1       : 00000000, 20000000 (Internal,R:snoop,W:snoop) <-
00000000 PF
PCI2 In_1       : 00000000, 20000000 (Internal,R:snoop,W:snoop) <-
00000000 PF
PCI3 In_1       : 00000000, 20000000 (Internal,R:snoop,W:snoop) <-
00000000 PF


______________________________

=20

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: 17 July 2007 17:29
To: Ramirez-Ortiz, Jorge
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Machine check exception. 2.6.20 powerpc tree.=20


On Jul 17, 2007, at 9:21 AM, Ramirez-Ortiz, Jorge wrote:

> Running our multithreaded application on ppc8548 (E500 core) =20
> generates a machine check exception when trying to access some =20
> ASIC's registers mapped on the PCI space (This application maps a =20
> PCI device to access its registers)
>
>
>
> machine_check_exception: task my_process, MCSR=3D0x10008, =
NIP=3D0x10153530
>
> Machine check in user mode.
>
> Caused by (from MCSR=3D10008): Guarded Load or Cache-Inhibited stwcx.
>
> Bus - Read Data Bus Error
>
>
>
> Here is the assembly dump of the region of code containing the =20
> offending instruction in user-space, with SRR0 pointing us at =20
> 0x10153530 when the exception is raised:
>
>
>
> 0x10153528 <_ZN2vk7in_le32EPVKj+16>:    lwz     r0,8(r31)
>
> 0x1015352c <_ZN2vk7in_le32EPVKj+20>:    lwz     r9,8(r31)
>
> 0x10153530 <_ZN2vk7in_le32EPVKj+24>:    lwbrx   r0,0,r0
>
> 0x10153534 <_ZN2vk7in_le32EPVKj+28>:    twi     0,r0,0
>
> 0x10153538 <_ZN2vk7in_le32EPVKj+32>:    isync

Can you get the code to dump the value of r0.  I'm wondering if =20
you're really getting a read data bus error due to the fact that r0 =20
is pointing to a PCI address that doesn't have a device that will =20
respond.

- k
