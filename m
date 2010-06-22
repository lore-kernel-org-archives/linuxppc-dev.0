Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id 1B079B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 04:15:04 +1000 (EST)
Received: from [10.11.13.50] (unknown [10.11.13.50])
	by mail.theptrgroup.com (Postfix) with ESMTP id A33C11E002
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 14:15:02 -0400 (EDT)
Message-ID: <4C20FDA0.5050208@ThePTRGroup.com>
Date: Tue, 22 Jun 2010 14:14:56 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: UCC UART
References: <4C20CECB.9050609@mlbassoc.com>	<4C20D27D.5000503@ThePTRGroup.com>	<4C20D34A.80202@mlbassoc.com>	<4C20D699.1080404@ThePTRGroup.com>	<4C20DABA.5030301@mlbassoc.com>	<4C20DC5F.80902@ThePTRGroup.com>
	<4C20F671.9090605@mlbassoc.com>
In-Reply-To: <4C20F671.9090605@mlbassoc.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I did not do that, and I have it running here.  I will say though that I
>> hardcoded the driver to run in soft UART mode.  You will need to at least
>> add the appropriate line to your dts to get the driver to operate in
>> Soft UART mode.
>>
>> I hardcoded mine because I had to backport this UCC UART driver to an
>> older
>> Linux kernel, and that kernel was from before dts existed.
>>
>> Add whatever you need to your dts to make it run in soft UART mode and
>> get
>> the firmware loaded.  Use two different BRGs for tx and rx.  Make sure
>> your
>> BRG choice is valid for your UCC3.
>>
>> I believe that the UCC UART support has not had too much use so far, but
>> I do have it working (in that older kernel after backporting).
> 
> I've done all this but sadly the behaviour is the same :-(
> 
> Any ideas what I might be missing?

Check your setup of the UCC3 pins for UART mode.  Make sure you either have
the UCC3 CD, CTS, RTS pins at the correct levels, or deconfigure those pins
(set them up as GPIOs).  Just verify every pin is properly set up for UCC3.
The UCC3 TxD and RxD signals must be set up properly.

What BRGs did you choose for tx and rx?

Get a scope on the UCC3 tx pin and try to output some chars.  See if there is
any digital activity on that pin at all.  If you are looking at a terminal for
output, there are too many things that could be wrong between that tx pin and
your display (e.g. level translation issue, null modem issue, baud incompatibility,
terminal program set for XON/XOFF or HW flow control and UART not set up compatibly).

For now get the probe directly on the CPU's UCC3 Tx pin, output chars and see
if there is any activity.

Chuck Meade
chuck@ThePTRGroup.com
