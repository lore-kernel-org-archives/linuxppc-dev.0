Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83508.mail.sp1.yahoo.com (web83508.mail.sp1.yahoo.com
	[216.252.120.164]) by ozlabs.org (Postfix) with SMTP id 38417DE090
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 04:07:12 +1000 (EST)
Date: Mon, 16 Jun 2008 11:07:10 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4856A3CA.4010905@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <788575.91210.qm@web83508.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I don't see a "dma" node in the mpc8377mds.dts (2.6.25).  I found one in mpc8610_hpcd.dts and
modeled it after that.

		dma@82a8 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "fsl,elo-dma";
			cell-index = <0>;
			reg = <0x82a8 0x4>; /* DMA general status register */
			ranges = <0x0 0x8100 0x200>;

			dma-channel@0 {
				compatible = "fsl,elo-dma-channel";
				cell-index = <0>;
				reg = <0x0 0x80>;
				interrupt-parent = <&ipic>;
				interrupts = <71 0x8>;
			};
			dma-channel@1 {
				compatible = "fsl,elo-dma-channel";
				cell-index = <1>;
				reg = <0x80 0x80>;
				interrupt-parent = <&ipic>;
				interrupts = <71 0x8>;
			};
			dma-channel@2 {
				compatible = "fsl,elo-dma-channel";
				cell-index = <2>;
				reg = <0x100 0x80>;
				interrupt-parent = <&ipic>;
				interrupts = <71 0x8>;
			};
			dma-channel@3 {
				compatible = "fsl,elo-dma-channel";
				cell-index = <3>;
				reg = <0x180 0x80>;
				interrupt-parent = <&ipic>;
				interrupts = <71 0x8>;
			};
		};

--- Scott Wood <scottwood@freescale.com> wrote:

> Ron Madrid wrote:
> > Here's my code.  There are a few other things that happen but they are inconsequential to this
> > problem.  I'm sure that the request_irq call is right, especially since it works if the fsldma
> > drivers are builtin to the kernel.  Also, the irq number 71 comes from the reference manual
> for
> > them MPC8313.  It is the internal interrupt for the DMA.  I'll do some more testing in a
> little
> > while to try to determine the cause of the error in request_irq.
> 
> You cannot pass hardware IRQ numbers directly to request_irq() -- it has 
> no idea which IRQ controller you're referring to (even if there happens 
> to be only one on your board).
> 
> You should get the IRQ from the device tree, using 
> irq_of_parse_and_map() on the device node for the DMA channel (see the 
> mpc8377mds device tree for an example DMA node).
> 
> -Scott
> 
