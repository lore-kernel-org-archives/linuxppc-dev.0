Message-Id: <5.1.0.14.0.20011120081828.03bcedb0@pop.gmx.de>
Date: Tue, 20 Nov 2001 08:31:28 +0800
To: linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: About floating point exception!
In-Reply-To: <20011119091232.84575.qmail@web15004.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:12 PM 11/19/2001 +0800, =?gb2312?q?Dross=20Zhou?= wrote:
>  Here is dump message:
>  Oops: Kernel Mode Software FPU Emulation, sig: 8
>  NIP: 00001FFC XER: 00000000 LR: 00000590 SP:
>  C05DDBC0

The floating point exception is to emulate floating point machine
instructions on processors without floating-point unit. Each time the
processors tries to execute a instruction it doesn't know, this exception
is thrown to let the operating system do a software emulation.

In your case, this means that this unknown instruction has been found at
the instruction pointer (NIP) 00001FFC. If it is really a floating-point
instruction and the FP-emulation is enabled in the kernel, you don't get an
error message. So at 0x1ffc must be an completely unknown intruction. This
is often caused by accessing invalid memory.

Probably you have a problem with your device driver or with the signal handler.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
