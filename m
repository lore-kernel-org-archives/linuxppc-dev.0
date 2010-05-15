Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9C33B7DC9
	for <linuxppc-dev@ozlabs.org>; Sun, 16 May 2010 09:41:09 +1000 (EST)
Subject: Re: [PATCH]460EX on-chip SATA driver <Kernel 2.6.33> < resubmission >
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@mvista.com>
In-Reply-To: <4BED8BF1.5080800@ru.mvista.com>
References: <201005051757.o45HvPmY005954@amcc.com>
	<4BED8BF1.5080800@ru.mvista.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 16 May 2010 09:40:28 +1000
Message-ID: <1273966828.21352.670.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	sr@denx.de, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-05-14 at 21:44 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Rupjyoti Sarmah wrote:
> 
> > This patch enables the on-chip DWC SATA controller of the AppliedMicro processor 460EX.
> >
> > Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com> 
> > Signed-off-by: Mark Miesfeld <mmiesfeld@appliedmicro.com>
> > Signed-off-by: Prodyut Hazarika <phazarika@appliedmicro.com>
> > ---
> >  arch/powerpc/boot/dts/canyonlands.dts |    8 +
> >  drivers/ata/Kconfig                   |    9 +
> >  drivers/ata/Makefile                  |    1 +
> >  drivers/ata/sata_dwc.c                | 1827 +++++++++++++++++++++++++++++++++
> >  4 files changed, 1845 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/ata/sata_dwc.c
> >
> > diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
> > index cd56bb5..d3b2c99 100644
> > --- a/arch/powerpc/boot/dts/canyonlands.dts
> > +++ b/arch/powerpc/boot/dts/canyonlands.dts
> > @@ -163,6 +163,14 @@
> >  			interrupts = <0x1e 4>;
> >  		};
> >  
> > +		SATA0: sata@bffd1000 {
> > +                        compatible = "amcc,sata-460ex";
> > +			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
> > +                        interrupt-parent = <&UIC3>;
> > +                        interrupts = <0x0 0x4       /* SATA */
> > +                                      0x5 0x4>;     /* AHBDMA */
> > +                };
> > +
> >  		POB0: opb {
> >  			compatible = "ibm,opb-460ex", "ibm,opb";
> >  			#address-cells = <1>;
> >   
> 
>    Please put the device tree update in a separate patch to go thru the 
> PowerPC tree.

Additionally, the boot wrapper should probably either remove the node or
at least use a status property "ok" / "disabled" to represent whether
the board is configured for SATA or PCIe x1...

Cheers,
Ben.
