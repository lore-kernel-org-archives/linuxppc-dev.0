Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03E4DDDE39
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 17:35:56 +1100 (EST)
Subject: Re: [PATCH] powerpc: document new interrupt-array property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <9841c5ba165e4bec773366568b3d4195@kernel.crashing.org>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<9841c5ba165e4bec773366568b3d4195@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 07:35:48 +0100
Message-Id: <1172298948.1902.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stuart Yoder <b08248@freescale.com>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It would be nicer to keep the "interrupts" property and
> add a property "interrupt-parents" with the same number
> of entries, that encodes the same as "interrupt-parent"
> but per interrupt.  You keep more in line with the
> "normal" stuff and I suspect it's less code to parse as
> well.

There are pro and cons to this approach. I did think about it initially.
The main cons is that "interrupts" becomes harder to parse as you ahve
to walk interrupt-parents at the same time to get the #interrupt-cells
of each entry. Also, it adds more potential for stupid breakage (how
shluld the parser react if interrupt-parents has less entries than
interrupts ?)

The pro, which is quite important too, is that it's a common assuption
that you have interrupts when you have an "interrupts" property, period.
In fact, it would indeed fit a bit better in the current parser.

> Wrong place to document this?  It's true for all interrupt
> specifiers.

Might be worth giving a crazy example where the 2 interrupt specifiers
have different size.

Ben.
