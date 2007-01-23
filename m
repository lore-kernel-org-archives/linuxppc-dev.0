Return-Path: <rmcguire@uwbt.com>
Received: from mail19l.g19.rapidsite.net (mail19l.g19.rapidsite.net
	[204.202.242.137]) by ozlabs.org (Postfix) with SMTP id DA8A9DDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 09:34:10 +1100 (EST)
Received: from mx87.stngva01.us.mxservers.net (198.173.112.4)
	by mail19l.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	0-0988751645 for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 17:34:06 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.993.1169563649.9285.linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8360E Linux and 2.6.19.2
Date: Tue, 23 Jan 2007 14:33:51 -0800
Message-ID: <000301c73f3e$8fceb780$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <mailman.993.1169563649.9285.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I have tracked my 'lockup' to a specific line in /powerpc/kernel/prom.c

In the function: __init unflatten_device_tree(void)
On line:

mem = lab_alloc(size + 4, __alignof__(struct device_node));
mem = (unsigned long) __va(mem);

((u32 *)mem[size / 4] = 0xdeadbeef;


This is causing a lockup when 0xdeadbeef is written. I have no idea why...

My assumption would be that somehow the memory is not ready? Or BATS are not
setup correctly? Perhaps a LAW register?

Is this line dependent on having the DTS tree setup correctly? If so, how
big can the 'memory' node be in the DTS file? I have mine tried a single
bank of 256MB, and of 512MB <I have a single 512MB DIMM at the moment>

-Russ

----------------------------------------------------------------------
Original Message:

All,

Trying to boot up / debug my board with a Rev 1.2 MPC8360E. 

After the kernel launches from U-boot I receive no serial debug, and the
system hangs. 

I am running U-boot 1.1.6. Dirty <which does contains support for the 8360>,

I have walked through the DTS/blob file, after U-boot modifies it, <I turned
on all the debug info>, and can clearly see that the /chosen node, etc.. is
getting entered. My original DTS file already has all of the clock speeds
entered <modeled after the MPC8360xx.dts file that was already in the
DENX-2.6.19.2 kernel release>.

I have limited debug ability via some GPIO leds on our board, I can see that
the kernel starts to run and at least gets to the point where it clears all
the BATs <powerpc/boot/head_32.S and setup_32.c>, at which point I lose
access to the IO space and can no longer write out to the debug lights.
Unfortunately I do not have access to a COP debugger at this point. It
doesn't seem to get to the platform files, or at least I can get the GPIO
access inside the IMMR space to work correctly.

Does anyone have any suggestion per software only debug method that might be
enabled? Or a way to temporarily hack the early serial output so I can see
what is going on?

-Russ
