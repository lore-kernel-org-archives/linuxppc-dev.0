Return-Path: <david.hagood@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 4A0ACB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 01:45:04 +1100 (EST)
Received: by gxk28 with SMTP id 28so1253321gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 07:45:02 -0700 (PDT)
Message-ID: <8f62561e16a507967978112d03fe5867.squirrel@localhost>
In-Reply-To: <4CB2DE2B.7040504@windriver.com>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
	<4CB2DE2B.7040504@windriver.com>
Date: Mon, 11 Oct 2010 09:44:58 -0500
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Scott Wood <scottwood@freescale.com>, david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> You should define MSI device nodes on your target dts. And you can refer
> to the
> file, mpc8572ds.dts.

I see nothing in that file that defines any MSIs. I see code that looks
like it maps ROOT COMPLEX MODE interrupts on regular PCI interfaces, which
IS NOT WHAT I AM DOING.

Since it seems I have been unclear, let me state this as clearly as possible.

I AM DOING ENDPOINT MODE.


> I think you can check fsl_msi.c to figure out what you want.
Except that file doesn't exist in the 2.6.26 kernel with which I am working.

> Firstly you should use irq_of_parse_and_map()/irq_create_mapping() to map
> the
> real hardware irq to virtual irq. Then use request_irq() with the virtual
> irq to
> hook your interrupt handler.

Except I have no device to pass irq_of_parse_and_map, and when I call
irq_create_mapping it seg faults.

>
> Maybe you can check the file, ppc4xx_pci.c since ppc4xx also can support
> EP as I
> previously said.

It only "supports" EP mode in the sense that it sets the hardware up to
export a BAR, and does nothing else. It doesn't provide any means for any
other code to actually DO anything in that mode. It doesn't define a way
to be interrupted by the root complex, nor to do anything when that
interrupt happens. It doesn't supply any meaningful framework to get any
data from the Root Complex.

That's the whole reason I am trying to make a piece of code that actually
WILL make those things available in a useful fashion.
