Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 4D235DE240
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 14:57:31 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so689586anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 21:57:24 -0700 (PDT)
Message-ID: <fa686aa40804152157v477574b6ka3e01957d6b112f2@mail.gmail.com>
Date: Tue, 15 Apr 2008 21:57:23 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: rodolfo <rodolfo@lesc.ufc.br>
Subject: Re: SystemACE on Kernel 2.6
In-Reply-To: <7aa21da00314dfb40c194e38e2488048@lesc.ufc.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7aa21da00314dfb40c194e38e2488048@lesc.ufc.br>
Cc: Linuxppc embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 15, 2008 at 7:40 PM, rodolfo <rodolfo@lesc.ufc.br> wrote:
> Hi Grant likely,
>
>  I got kernel 2.6.20 from kernel.org and I want boot it on XUP Virtex II Pro

This is an old kernel.  Use a current kernel.

>  University board.
>  I edited the Makefile putting:
>   ARCH? = ppc
>   CROSS_COMPILE? = ppc_4xx-
>  But I can't see anything about SystemACE driver on make menuconfig from
>  this Kernel. How can I add SystemACE controler?

Its in the block device menu

>  I compiled the kernel repeatedly generating a file zImage.elf. I used this
>  file with the genace.tcl from Xilinx and this opt file:
>  -jprog
>  -board user
>  -target ppc_hw
>  -hw implementation/download.bit
>  -elf zImage.elf
>  -configdevice devicenr 1 idcode 0x1127e093 irlength 14 partname xc2vp30
>  -debugdevice devicenr 1 cpunr 1
>  -ace system.ace
>
>  to generated ace file and put it in FAT16 partition of CF card, like a lot
>  of references in web. But it doesn't works!
>  Which IP cores must be present in my project of the EDK?
>  Still speaking in the EDK Did i have to mark bram with ppc_405_0_bootloop?
>  Did I have to mark bram whit any software project?

- Did you generate an xparameters_ml40x.h in edk and copy it into the
kernel tree?
- you need either a uart16550 or a uartlite for the console
- Make sure the matching serial driver is compiled into the kernel
- Make sure console support is enabled for the serial driver
- Make sure your kernel boot parameters include 'console=ttyS0,115200'
for uart16550 or 'console=ttyUL0' for uartlite.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
