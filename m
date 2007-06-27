Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 04CB5DDF5C
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 21:29:17 +1000 (EST)
In-Reply-To: <d8960a6c86859c19b84dc9fd41446fbd@bga.com>
References: <d8960a6c86859c19b84dc9fd41446fbd@bga.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64edb4cfb6f38bd6e1d7de64bbbebae6@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: udbg_16550.c and legacy_serial.c
Date: Wed, 27 Jun 2007 06:29:26 -0500
To: Milton Miller <miltonm@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jun 27, 2007, at 6:22 AM, Milton Miller wrote:
> (4) Adding a 5th udbg_putc method that calls a byte read to 
> udbg_comport->lsr masked with THRE until 0 and performs a byte write 
> to ->thr shows we have the wrong abstraction.   Please make the 
> inb/outb a method with the comport.  It would seem the actual init_xx 
> could be in the platforms, passing inb, outb, and comport to a helper 
> in udbg_16550.c.   I'm fine with declaring all the early inits in 
> udbg.h
>


I'll repost that with a different subject in case someone else wants to 
work on that.


Also, while researching this, I found that check_legacy_serial_console 
has a check for legacy_serial_console < 0 in it.  Since that is set to 
the legacy_ports array we pass to the serial layer, it would seem all 
the other parsing to find the console is redundant; we can get the np 
that we already found.   However, it also means that the code to notice 
the stdout path is ch-a or ch-b will never be executed because of that 
check.

The comment about stdout being a wierd phandle should read 
"/chosen/stdout is a ihandle.  use linux,stdout-path instead".

no patch at this hour.

milton
