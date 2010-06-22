Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id 29202B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 05:01:47 +1000 (EST)
Received: from [10.11.13.50] (unknown [10.11.13.50])
	by mail.theptrgroup.com (Postfix) with ESMTP id 906EE1E002
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 15:01:45 -0400 (EDT)
Message-ID: <4C210892.3040503@ThePTRGroup.com>
Date: Tue, 22 Jun 2010 15:01:38 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: UCC UART
References: <4C20CECB.9050609@mlbassoc.com>	<4C20D27D.5000503@ThePTRGroup.com>	<4C20D34A.80202@mlbassoc.com>	<4C20D699.1080404@ThePTRGroup.com>	<4C20DABA.5030301@mlbassoc.com>	<4C20DC5F.80902@ThePTRGroup.com>	<4C20F671.9090605@mlbassoc.com>
	<4C20FDA0.5050208@ThePTRGroup.com> <4C2103DE.6020801@mlbassoc.com>
In-Reply-To: <4C2103DE.6020801@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> What BRGs did you choose for tx and rx?
> 
> BRG1 & BRG2

OK

>> Get a scope on the UCC3 tx pin and try to output some chars.  See if
>> there is
>> any digital activity on that pin at all.  If you are looking at a
>> terminal for
>> output, there are too many things that could be wrong between that tx
>> pin and
>> your display (e.g. level translation issue, null modem issue, baud
>> incompatibility,
>> terminal program set for XON/XOFF or HW flow control and UART not set
>> up compatibly).
>>
>> For now get the probe directly on the CPU's UCC3 Tx pin, output chars
>> and see
>> if there is any activity.
> 
> We've done all this - nothing on the pins directly at the CPU.
> 
> This is behaving very much like there is no clock to the device.
> Is there something special that needs to be done to get the BRGs
> to work?

If I was doing this, at this point I would do some strategic printk debugging
within ucc_uart.c.  You said that you are using 2.6.33.3, so you already have
all the fixes in ucc_slow.c that I had to backport to my older kernel.

If you question the setup of the BRGs, go to your function that sets them up.
I don't know about 2.6.33.3, but in the latest kernel it is qe_setbrg() in
qe.c.  At the very bottom there is an out_be32().
printk both the address, and the value that is being written to that address.
You may need to cast the values to unsigned longs to printk them.  I will look
at your numbers if you send them to me.  In my implemenation (which again was
a backport, so this may not apply to you) the BRG writes were off by 4 bytes.
But I think that this error was due to the backport -- a logic mismatch I
needed to resolve during the port.

Also in the current Linux kernel, there is a dependence on the correctness
of the "brg-frequency" property from the dts.  Look up above qe_setbrg() at
the qe_get_brg_clk() function.  Before the return (there are multiple return
points) printk the brg_clk being returned.  That must be correct for your
hardware -- must be the actual brg freq.  I assume that you are booting from
U-Boot.  I believe in modern implementations that U-Boot fills in the
brg-frequency in the device tree at boot time.

Let me know how it goes,
Chuck Meade
chuck@ThePTRGroup.com
