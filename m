Return-Path: <ricardo.ribalda@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id 859E0DDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 22:22:08 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so3216891fga.39
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 05:22:06 -0700 (PDT)
Message-ID: <aa76a2be0806160522n357165d4pb6a0d1b24c670a4d@mail.gmail.com>
Date: Mon, 16 Jun 2008 14:22:05 +0200
From: Ricardo <ricardo.ribalda@gmail.com>
To: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Xilinx EDK 10.1 and XUPV2P: A little report
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello list

 I have tried to port Linux 2.6 (xilinx git) to a XUPV2P board
running a system implemented with EDK10.1 (Linux Version). I have
fail, and I think I now why, this is a little report written for
saving you some time (and maybe solving my problem if I am doing
something wrong)

The board is not supported by EDK 10.1, but I have found a Board
Support File form https://wiki.ittc.ku.edu that seems to work. To
start I have created a design that consists on a ppc, the mpmc, an
uartlite, an interrupt manager and some bram. The "basic programs":
Test memory and peripherals
worked ok on it.

 I have downloaded the kernel form xilinx git and adapted the
xparameters file to fit my design.

 I have created a toolchain using OpenEmbedded and compiled the kernel
with it, then I have downloaded the binary to the board and everything
works fine until "Now booting the kernel"

 Debugging the kernel I have found that the system crashes (Exception
0x700) setting the mmu inside "start_here" (head_4xx.S)...

 Because it was a crash in the "very beginning" of my kernel live I
developed some simple apps to tests all my peripherals and they worked
ok in real mode: All of them worked OK

 BUT I have created a small piece of code that tests the peripherals
in virtual mode and when the program is linked to the ram the system
crashes!! Strangely, it works ok when it runs from bram.....

 The same code works perfectly on a design created with EDK 8.1 and
the kernel also works fine.

 I attach the source code of my test app parameters I have used.



                                    Best Regards



-- 
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
