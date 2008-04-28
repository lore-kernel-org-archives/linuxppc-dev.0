Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 9A799DE213
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 03:10:03 +1000 (EST)
Date: Mon, 28 Apr 2008 13:10:01 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-ID: <20080428131001.052be010@lappy.seanm.ca>
In-Reply-To: <fa686aa40804272147y54df795fj7e8dad89dc237ecd@mail.gmail.com>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080427152546.1e26b145@lappy.seanm.ca>
	<20080428105859.daef4d71.sfr@canb.auug.org.au>
	<fa686aa40804271851t6d762a1et76fa3cc02c2205fe@mail.gmail.com>
	<20080427222514.1086f2d3@lappy.seanm.ca>
	<fa686aa40804272147y54df795fj7e8dad89dc237ecd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 27 Apr 2008 22:47:43 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> If your LEDs are attached to gpio pins, then you should use the
> current draft led->gpio bindings as shown in the above patch.  Then,
> let your platform code extract whatever data it needs from the device
> tree to set up the LEDs.

I added the following to the dts:

	led@31 {
		compatible = "linux,gpio-led";
		linux,name = "green";
		gpios = <&GPIO1 31>;
	};

	led@30 {
		compatible = "linux,gpio-led";
		linux,name = "red";
		gpios = <&GPIO1 30>;
	};

I then map the gpio base as follows (I removed the if checks just to
make things short and sweet):

	np = of_find_compatible_node(NULL, NULL, "linux,gpio-led");

	gpios = of_get_property(np, "gpios", &lenp);
	of_node_put(np);

	np = of_find_node_by_phandle(gpios[0]);

	gpio_base = of_iomap(np, 0);
	of_node_put(np);

Comments?

Cheers,
  Sean
