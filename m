Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED50DDDF34
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 13:03:09 +1000 (EST)
Subject: Re: irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
In-Reply-To: <48BEFB5D.3040903@gmail.com>
References: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
	<48BEA106.9090307@selcomgroup.com>
	<319b0ac50809030803p6d659468wd7d2425224653374@mail.gmail.com>
	<6a6049b80809030905u561043ecr1438d20aebf5598d@mail.gmail.com>
	<48BEBD17.1030705@gmail.com> <20080903170815.GA10979@loki.buserror.net>
	<48BEFB5D.3040903@gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 04 Sep 2008 13:02:46 +1000
Message-Id: <1220497366.4879.27.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	M B <super.firetwister@googlemail.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-03 at 23:02 +0200, Sébastien Chrétien wrote:

> irq_of_parse_and_map is equivalent to ioremap in the MMU case ?

On the powerpc architecture, we use virtualized IRQ numbers in order to
deal with the wide range of interrupt controllers around and multiple
of them cascaded.

The base function to "map" a physical interrupt to a virtual interrupt
is irq_create_mapping(). It takes an irq_host argument which represent
the IRQ "domain" (typically irq controller) off which the interrupt you
are trying to map hangs.

If you pass NULL, it will use the "default" controller, which doesn't
always exist, it depends on the platform. Usually, platforms set that
to the toplevel PIC.

However, normally, that function shouldn't be used directly. Instead,
you should create a representation of your device in the device-tree
along with the appropriate interrupt mapping, and then use the
irq_of_parse_and_map() function to obtain a mapped virtual irq based
on the device-tree information. This will take care of finding the
right irq_host but will also properly setup the polarity of the
interrupt etc...

Now, as to how you should represent the interrupt in the device-tree,
this should be explained in Documentation/booting-without-of.txt

Cheers,
Ben.
