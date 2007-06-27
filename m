Return-Path: <sithglan@stud.informatik.uni-erlangen.de>
Received: from faui03.informatik.uni-erlangen.de
	(faui03.informatik.uni-erlangen.de [131.188.30.103])
	by ozlabs.org (Postfix) with ESMTP id 25F9CDDF1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 07:18:27 +1000 (EST)
Date: Wed, 27 Jun 2007 23:18:25 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: khollan <khollan@daktronics.com>
Subject: Re: Porting Linux to Xilinx ML410
Message-ID: <20070627211825.GA2003@cip.informatik.uni-erlangen.de>
References: <11328063.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11328063.post@talk.nabble.com>
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

Hello,

> Linux/PPC load: console=ttyUL0,9600 root=/dev/xsysace/disc0/part3 rw
> Uncompressing Linux...done.
> Now booting the kernel

> It always stall on the Now booting the kernel.  Im new to linux
> building and any help or suggestions are greatly appreciated.

I have the same problem on a Avnet Memev Virtex-4 FX12 LC Board. I typed
"stop" in the xmd and got an Instruction pointer. I took this
instruction pointer and called:

(thinkpad) [/scratch/tg/linux-2.6-ppc] powerpc-405-linux-gnu-objdump -dS vmlinux | less
/^c00045ac

c00045a0 <__delay>:
c00045a0:       2c 03 00 00     cmpwi   r3,0
c00045a4:       7c 69 03 a6     mtctr   r3
c00045a8:       4d 82 00 20     beqlr
c00045ac:       42 00 00 00     bdnz-   c00045ac <__delay+0xc> <<<< HERE
c00045b0:       4e 80 00 20     blr

which is called from the calibrating delay loop. The calibrating delay
loop is an endless loop if the jiffies do not get incremented. Which is
the case if there are no timer ticks for whatever reason. Reasons could
be:

        - PIT or FIT don't get initialized
        - Interrupts are disabled
        - No interrupt handler registerd or registered for the wrong iq.

However the calibrating delay loop is before the serial console
initialization code. The "Now booting the kernel" line comes from the in
kernel embedded bootloader just before it initalizes the MMU and jumps
to "start_kernel".

If you do any progress on that, please let me know. I am currently
extremly busy, so I don't have time at the moment to debug that any
further.

        Thomas
