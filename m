Return-Path: <david.hagood@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 98872B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 07:12:32 +1100 (EST)
Received: by yxs7 with SMTP id 7so110123yxs.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Oct 2010 13:12:30 -0700 (PDT)
Message-ID: <fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
In-Reply-To: <20100921170700.53a99e56@udp111988uds.am.freescale.net>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
Date: Thu, 7 Oct 2010 15:12:26 -0500
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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

> On Tue, 21 Sep 2010 17:37:15 -0400
> The MPIC interrupt numberspace in the device tree (which is not
> virtual; it is a private numberspace to MPIC) is based on the offset of
> the registers for that interrupt source. External interrupts start at
> zero (which is valid), internal at 16, and special things like MSIs at
> higher numbers (I don't think it's quite 256).

OK, so I'm slowly wrapping my head around this (OT: Has anybody considered
sending this information to the folks doing the Linux Device Drivers
books? They are just a bit x86 centric right now...).

As I understand, what I have to do is somehow get a device_node *, then
make a call to irq_of_parse_and_map() to convert that into a system IRQ.

What I am doing right now is:
device_node *mpic = of_find_node_by_type(0,"open-pic");
irq = irq_of_parse_and_map(mpic,256);

While I get a pointer from of_find_node_by_type, when I try to map IRQ
#256 via the irq_of_parse_and_map function, I get a zero back from it.

So I guess my questions would be:
1) should I be frobbing the PIC for this, or should I be looking up some
other device?
2) How do I know for certain that 256 is the right value for the first MSI
signaled via MSIR0?
