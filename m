Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC567DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 02:29:00 +1000 (EST)
In-Reply-To: <35786B99AB3FDC45A8215724617919730136DA91@gbrwgceumf01.eu.xerox.net>
References: <35786B99AB3FDC45A8215724617919730136DA91@gbrwgceumf01.eu.xerox.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <43F1785C-E5DA-4460-A9C7-9B02431F1FE0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Machine check exception. 2.6.20 powerpc tree. 
Date: Tue, 17 Jul 2007 11:29:29 -0500
To: "Ramirez-Ortiz, Jorge" <Jorge.Ramirez-Ortiz@xerox.com>
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


On Jul 17, 2007, at 9:21 AM, Ramirez-Ortiz, Jorge wrote:

> Running our multithreaded application on ppc8548 (E500 core) =20
> generates a machine check exception when trying to access some =20
> ASIC=92s registers mapped on the PCI space (This application maps a =20=

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
