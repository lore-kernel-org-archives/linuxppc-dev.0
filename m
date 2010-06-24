Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id BBAF0B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Jun 2010 00:44:15 +1000 (EST)
Received: from [10.11.13.50] (unknown [10.11.13.50])
	by mail.theptrgroup.com (Postfix) with ESMTP id EF3191E002
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Jun 2010 10:44:13 -0400 (EDT)
Message-ID: <4C236F34.3020406@ThePTRGroup.com>
Date: Thu, 24 Jun 2010 10:44:04 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Continuing UCC UART woes
References: <4C2355A3.8000708@mlbassoc.com> <4C235FD0.4040608@ThePTRGroup.com>
	<4C23621D.1010600@mlbassoc.com>
In-Reply-To: <4C23621D.1010600@mlbassoc.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> You can use strategic printk debugging in the ucc_uart.c driver to
>> determine
>> on the Tx side what is going wrong.  For example, after you tell the
>> QE to
>> output chars, wait a bit and printk out the BD.  See if the QE is
>> clearing the
>> READY bit in that BD.  That will tell you if the QE is even processing
>> the BD
>> or not.
> 
> I've also done this - the descriptors are set up, never touched by the QE
> Odd that input always works, output works only very rarely.

You could check alignment of the BD address to be sure that got setup correctly.
Make sure you are not looking at a cached version of the BD, and make sure
you waited long enough for the QE to have processed it.

>> Also ensure that for all these other UCCs that you are using that the
>> CD, CTS,
>> RTS pins are set up as plain GPIO pins if you do not have them hooked
>> up to
>> actual CD, CTS, RTS signals.  If you *are* using HW flow control,
>> probe all the
>> signals to be sure they are all correct.
> 
> No change whether these pins are configured or not.

I would definitely leave these configured as GPIOs if the correct signals
are not present at the pins.

You could look through the pdf that is in that zipfile and make sure you are
following (that the driver is following) all the restrictions for soft UART
mode.

Perhaps printk debug in ucc_slow_init to make sure the UCC is getting set up correctly.
I would probably also make sure that the Tx parameter ram is allocated and
aligned OK.

Make sure you specify unique port-number fields in your dts for each of these UCC UARTs.

Beyond that, if printk-debugging does not show anything, then you may want to contact
Freescale and try to find out what the Soft UART mode microcode patch capabilities are,
in terms of exactly how many simultaneous UCC UARTs it has been proven to support.
The QE has processing limits, and maybe the soft UART microcode patch can't support
multiple UCC UARTs(?)  It's worth it to find out from Freescale I suppose.

Chuck Meade
chuck@ThePTRGroup.com
