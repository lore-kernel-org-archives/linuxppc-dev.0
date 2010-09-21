Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id C00A1B70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 08:07:14 +1000 (EST)
Received: from mail81-tx2 (localhost.localdomain [127.0.0.1])	by
	mail81-tx2-R.bigfish.com (Postfix) with ESMTP id 83FF8C9035B	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 22:07:03 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.243])	by
	mail81-tx2.bigfish.com (Postfix) with ESMTP id 45D4A45804C	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 22:07:03 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8LM71xn029793	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 15:07:01 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8LM78QS004158	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 17:07:08 -0500 (CDT)
Date: Tue, 21 Sep 2010 17:07:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Anderson, Trevor" <tanderson@curtisswright.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
Message-ID: <20100921170700.53a99e56@udp111988uds.am.freescale.net>
In-Reply-To: <1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "david.hagood@gmail.com" <david.hagood@gmail.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Sep 2010 17:37:15 -0400
"Anderson, Trevor" <tanderson@curtisswright.com> wrote:

> IRQ assignments for MPC8641D are "virtual", 

This is true for powerpc in general.

> meaning "made up" and quite difficult to determine by looking through code.
> But I believe the plan goes something like this:
> 
>   IRQ
> ---------
>     0           No interrupt
>   1 - 15        External interrupts (only 1..12 would be used)
>  16 - 127       Internal interrupts - see Table 9-2 of 8641D ref man,
>             Add 15 to the numbers shown
> 128 - 255       Yours, or your BSP's, to do with as you like
> 256 - 511       Message Signaled Interrupts
> 
> If you look in the sample device trees for 8641 cards you'll see that
> the interrupt values cited there for various devices match the 16..127
> group above.

There are two different numberspaces involved here.

The MPIC interrupt numberspace in the device tree (which is not
virtual; it is a private numberspace to MPIC) is based on the offset of
the registers for that interrupt source. External interrupts start at
zero (which is valid), internal at 16, and special things like MSIs at
higher numbers (I don't think it's quite 256).

The numberspace for virtual interrupts, which is what you pass to
request_irq(), is dynamically allocated.  You shouldn't need to know
anything about it other than that zero is invalid, and you get the
virtual IRQ from irq_of_parse_and_map() or another such mapping
function.

In neither case is there a range that is set aside for you "to do with
as you like".  If you have another interrupt controller and need a
block of virtual interrupts, register the controller with
irq_alloc_host() and you'll get a block assigned.

-Scott
