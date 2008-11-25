Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 0BFE5DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 01:08:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 8572E - machine check pin (MCP0)
Date: Tue, 25 Nov 2008 09:10:29 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010F1B2332@EMPBEDEX.empirix.com>
In-Reply-To: <Pine.LNX.4.64.0811241545040.21311@t2.domain.actdsltmp>
References: <mailman.176.1227568041.29923.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D9010F1B21F8@EMPBEDEX.empirix.com>
	<Pine.LNX.4.64.0811241545040.21311@t2.domain.actdsltmp>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Trent Piepho" <tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:
<snip some things>
>> I have an external watchdog timer that is going off - and pulsing
into
>> the MCP0 of the 8572E. I get the printk indicating that the MCP0 went
>> off - the problem is - how do I clear the condition that caused this
>> because my hardware engineer swears that the pulse is ONLY 250ms -
and
>> after resetting several status registers (mcpsumr & rst
>> (because my hardware engineer swears that the pulse is ONLY 250ms
long
>> (and I have a delay after my printk of 250ms)) - so I am pretty sure
>>
>> I am resetting the conditions mcpsumr (also, extra: the rstsr),
>> but after writing mcpsumr - and reading back - it still has
>> the mcp0 bit set?


<snip more>


Trent wrote:


>SRESET# also sets MCP0 and MCP1, maybe that is on?
>I'd also check the EMCP bit in SPRN_HID0 (on core 0 for MCP0).

I think SRESET is a separate signal - and even if it was ON
(which it shouldn't be) - it should show up in the MCPSUMR=20
Register (and I am clearing that condition)...

I am getting the first machine check (with an indication that=20
the MCP0 is pulled) - I don't think you can get a Machine check without=20
SPRN_HID0's EMCP being set?=20

The only thing that I am thinking is that I have two edges, and
after returning from the machine check (first time) the ME bit is
NOT enabled, so when the falling edge of that pulse occurs, it=20
causes another machine check - which because ME bit is NOT set
it causes a checkstop - and it goes away...

That explains why it hangs for the second machine check - although
it still 'starts' into the machine check handler before dying=20
very early in its execution (before it does a full dump of registers)...

very strange stuff here...

Tom
