Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id EE2BCDDF09
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 21:09:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Early UART setup on 2.6 kernel for mpc85xx 
Date: Mon, 13 Aug 2007 07:09:40 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90108D46267@EMPBEDEX.empirix.com>
In-Reply-To: <mailman.1.1186797602.26064.linuxppc-dev@ozlabs.org>
References: <mailman.1.1186797602.26064.linuxppc-dev@ozlabs.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> In order to debug the kernel 2.6, I want setup serial port with=20
>> UART on mpc85xx as early as possible. I add the register access=20
>> code at the beginning of  platform_init(). For example, I try=20
>> to write THR register(0xe0004500). However the system just=20
>> hanging there with this line.

<snip everything else>

If you are using a relatively new kernel like I am starting=20
up with - you don't need to add anything - you can use the
"Early Debugging/Early Console" which defines PPC_EARLY_DEBUG
You can find this in the kernel hacking options when you=20
go in and configure your linux kernel.

This causes the udbg serial driver to be initialized, and=20
99% of the early debug output is already put to the screen.
This hands the serial port over to the console driver later
on in the boot, and it works great (good job whoever wrote
this piece - more than a helpful tool!).

FWIW, you really can't debug the earliest init code=20
because most of that is in assembly. Get a JTAG emulator
(BDI or Lauterbach) and start stepping through.

Tom Morrison
