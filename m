Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 733802C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 02:14:48 +1100 (EST)
Message-ID: <1381418079.7979.396.camel@snotra.buserror.net>
Subject: Re: Elbc device driver
From: Scott Wood <scottwood@freescale.com>
To: Mercier Ivan <ivan.mercier@gmail.com>
Date: Thu, 10 Oct 2013 10:14:39 -0500
In-Reply-To: <CAMc2ieqXg1C6twTaqL9irJoLceSw-fFyTseifW5dmCmnXHWLCw@mail.gmail.com>
References: <CAMc2ieqYDBE8HYzmEvfKxw8o7AdYVGN_ew6tvsn_TsRcpEgL8g@mail.gmail.com>
 <1381271655.7979.290.camel@snotra.buserror.net>
 <CAMc2ieqXg1C6twTaqL9irJoLceSw-fFyTseifW5dmCmnXHWLCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-10 at 16:54 +0200, Mercier Ivan wrote:
> Hi,
> I've got a KERN_INFO msg: "fsl-lbc a3p400.11: failed to get memory
> region" corresponding to my elbc device that I try to map.
>                 a3p400@3,0 {
>                         compatible = "fsl,elbc";
>                         reg = <0 0xe0000000 0x1000000>;
>                 };

The node name and unit address do not match the contents of the node.
The former describes a device that sits on the localbus, while the
latter has a compatible describes the localbus itself.  I don't know
what that reg is, but it doesn't match the unit address.

> The corresponding law on ELBC is 0xe0000000 ->0xf0000000.
> I want to map my device on 0xe0000000 ->0xe8000000 as it has 16 adress bits.
> 
> Now the controler registers are properly set,but how do I map the device?

Your eLBC node should look something like this (I'm assuming CCSR is at
0xffe000000, and that you actually meant 0x0e0000000 and not
0xfe0000000, though probably one of those assumptions is wrong):

	localbus@ffe124000 {
		compatible = "fsl,elbc", "simple-bus";
		reg = <0xf 0xfe124000 0 0x1000>;
		interrupts = <25 2 0 0>;
		#address-cells = <2>;
		#size-cells = <1>;

		ranges = <3 0 0 0xe0000000 0x08000000>;

		/* If at all possible, replace "a3p400" in the node name with
something generic */
		a3p400@3,0 {
			compatible = "something appropriate here";
			reg = <3 0 0x08000000>;
		};
	};

Note that at the dts level, you should be including
arch/powerpc/boot/dts/fsl/p3041-post.dtsi and thus your board dts would
only need to supply reg, ranges, and the a3p400 node (see
arch/powerpc/boot/dts/p3041ds.dts for an example).

-Scott
