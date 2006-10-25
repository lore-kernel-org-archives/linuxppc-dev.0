Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0610251541s21bb45f1t6fc911778d5084@mail.gmail.com>
References: <453FB582.20802@bplan-gmbh.de>
	<17727.56923.634981.723647@cargo.ozlabs.ibm.com>
	<528646bc0610251541s21bb45f1t6fc911778d5084@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 08:59:38 +1000
Message-Id: <1161817178.22582.138.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> What are the implications anyway for the bplan board being CHRP vs the
> way the rest of the embedded ppcs are set up?  Will having this setup
> as a CHRP system conflict w/ non-CHRP embedded boards?  (I'm assuming
> that CHRP requires more capable firmware than u-boot passing in a fdt)

Not really :) The main thing they "buy" by going CHRP is that they use
RTAS for PCI config space access and thus don't have to write the host
bridge code. Since their firmware initializes everything properly, there
is little need for non-generic platform code and that sort of generic
platform code is what CHRP provides.

With the device-tree thingy done properly nowadays, there should be
little difference between platforms unless you end up dealing with
really special things.

There should be no conflict with non-CHRP boards using the MPC5200 chip
provided they do things right which is what I've been advocating so far.
That includes making sure everybody agrees on the format of the MPC5200
specific bits in the device-tree:

 - Format of the interrupt cells (they have come up upon my suggestion
to a 3-cell based format (could probably be compressed a bit but heh)
and that should be documented publically)

 - Binding (set of required properties and their definitions) for on
chip devices, and more specifically, for representing the bestcomm and
the links between devices and associated bestcomm tasks.

If the above is properly agreed upon, then the code for dealing with
MPC5200 specific devices will purely rely on those bits, and thus should
be useable from whatever platform it's included in, wether it's CHRP, or
something else.

Unfortunately, at this point, Nicolas seems to be unwilling to open up
his device-tree publically.

Ben.
