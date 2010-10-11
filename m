Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97D2CB6EFF
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2010 22:35:43 +1100 (EST)
Subject: Re: Freescale P2020 / 85xx PCIe and Advance Error Reporting (AER)
	service problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eran Liberty <liberty@extricom.com>
In-Reply-To: <4CB2E517.8020401@extricom.com>
References: <4CADBD7B.3000506@extricom.com>
	<1286756363.2463.517.camel@pasglop>  <4CB2E517.8020401@extricom.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Oct 2010 22:32:01 +1100
Message-ID: <1286796721.5220.2.camel@pasglop>
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> BUT if we take into consideration that:
> 1. Freescale is a serious dude in the hood and on the whole does a good 
> job with its products and their Linux support.

Sure but that's irrelevant to the technical problem at hand :-)

> 2. The P2020 does state it has an MSI mechanism support (although one is 
> not present as a PCIe capability header for some reason)

Then it's broken :-(

> 3. Errors in general and AER are major features in PCIe.
> 4. PCIe has been here quite a while and it is not new to Freescale or 
> anyone else.

Right but we don't do AER on ppc44x either, I know we should but for
some reason, AER hasn't been on anybody #1 priority list in embedded
world so far...

> I am much more inclined to believe that I have missed something by a 
> mile then that Freescale did. I just don't know what I am missing.

No, I think you haven't and we just need to fix it :-)

Cheers,
Ben.

> My device tree is a clone of "arch/ powerpc/ boot/ dts/ p2020rdb.dts"
> 
> It has a PCI node that looks like this:
> ----------------------------- snip -----------------------------
>     pci0: pcie@ffe09000 {
>         cell-index = <1>;
>         compatible = "fsl,mpc8548-pcie";
>         device_type = "pci";
>         #interrupt-cells = <1>;
>         #size-cells = <2>;
>         #address-cells = <3>;
>         reg = <0 0xffe09000 0 0x1000>;
>         bus-range = <0 255>;
>         ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
>               0x1000000 0x0 0x00000000 0 0xffc30000 0x0 0x10000>;
>         clock-frequency = <33333333>;
>         interrupt-parent = <&mpic>;
>         interrupts = <25 2>;
>         interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
>         interrupt-map = <
>             /* IDSEL 0x0 */
>             0000 0x0 0x0 0x1 &mpic 0x4 0x1
>             0000 0x0 0x0 0x2 &mpic 0x5 0x1
>             0000 0x0 0x0 0x3 &mpic 0x6 0x1
>             0000 0x0 0x0 0x4 &mpic 0x7 0x1
>             >;
>         pcie@0 {
>             reg = <0x0 0x0 0x0 0x0 0x0>;
>             #size-cells = <2>;
>             #address-cells = <3>;
>             device_type = "pci";
>             ranges = <0x2000000 0x0 0xa0000000
>                   0x2000000 0x0 0xa0000000
>                   0x0 0x20000000
> 
>                   0x1000000 0x0 0x0
>                   0x1000000 0x0 0x0
>                   0x0 0x100000>;
>         };
>     };
> ----------------------------- snap -----------------------------
> 
> and under "soc" it has an MSI node that looks like that:
> ----------------------------- snip -----------------------------
>         msi@41600 {
>             compatible = "fsl,p2020-msi", "fsl,mpic-msi";
>             reg = <0x41600 0x80>;
>             msi-available-ranges = <0 0x100>;
>             interrupts = <
>                 0xe0 0
>                 0xe1 0
>                 0xe2 0
>                 0xe3 0
>                 0xe4 0
>                 0xe5 0
>                 0xe6 0
>                 0xe7 0>;
>             interrupt-parent = <&mpic>;
>         };
> ----------------------------- snap -----------------------------
> 
> -- Liberty
> 
