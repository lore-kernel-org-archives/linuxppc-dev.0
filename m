Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 09D91DDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 10:33:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 8572E - machine check pin (MCP0)
Date: Mon, 24 Nov 2008 18:35:50 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010F1B21F8@EMPBEDEX.empirix.com>
In-Reply-To: <mailman.176.1227568041.29923.linuxppc-dev@ozlabs.org>
References: <mailman.176.1227568041.29923.linuxppc-dev@ozlabs.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Running 2.6.23.25 kernel...

I have an external watchdog timer that is going off - and pulsing into
the MCP0 of the 8572E. I get the printk indicating that the MCP0 went
off - the problem is - how do I clear the condition that caused this
because my hardware engineer swears that the pulse is ONLY 250ms - and
after resetting several status registers (mcpsumr & rst
(because my hardware engineer swears that the pulse is ONLY 250ms long
(and I have a delay after my printk of 250ms)) - so I am pretty sure

I am resetting the conditions mcpsumr (also, extra: the rstsr),
but after writing mcpsumr - and reading back - it still has=20
the mcp0 bit set?

Where else do I need to reset the status - I think I am doing it
right...
but it isn't clearing the exception - and it 'dies' the next time
through
this (why is another problem - but first, I'd like to know why the
condition
is NOT being cleared...at all)...

A couple of possibilities is that because the external MCP0 condition
is actually a pulse - another machine check could be clocked in on the
'falling' edge - but this pulse is long gone before I even come close
to attempting clearing the mcp0 exception in mcpsumr?

FWIW, I also have the same signal pulsing to my UDE - and at least after
resetting the UDE condition, it 'looks' reset - before immediately
getting
another UDE interrupt (potentially for the falling edge)...

I am very confused here...

Thanks for any advice...

Tom
