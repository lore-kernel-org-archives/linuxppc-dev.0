Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0112.outbound.protection.outlook.com [65.55.169.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC3F41A115C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 04:34:54 +1000 (AEST)
Message-ID: <1431022714.16357.396.camel@freescale.com>
Subject: Re: [PATCH 1/1] powerpc: mpc85xx: Add board support for ucp1020
From: Scott Wood <scottwood@freescale.com>
To: Oleksandr G Zhadan <oleks@arcturusnetworks.com>
Date: Thu, 7 May 2015 13:18:34 -0500
In-Reply-To: <554B934C.5090406@arcturusnetworks.com>
References: <1430841121-1997-1-git-send-email-oleks@arcturusnetworks.com>
 <1430968950.16357.369.camel@freescale.com>
 <554B934C.5090406@arcturusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Michael Durrant <mdurrant@arcturusnetworks.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-07 at 12:31 -0400, Oleksandr G Zhadan wrote:
> Hi Scott,
> 
> Thanks for fast response, please see inline.
> 
> On 05/06/2015 11:22 PM, Scott Wood wrote:
> > On Tue, 2015-05-05 at 11:52 -0400, Oleksandr G Zhadan wrote:
> >> +-------------------------------------------------
> >> +
> >> +P1020 SPI controller
> >> +
> >> +Properties:
> >> +- compatible:		"spansion,s25fl008k", "winbond,w25q80bl"
> >> +
> >> +Example:
> >> +	spi@7000 {
> >> +		flash@0 {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <1>;
> >> +			compatible = "spansion,s25fl008k", "winbond,w25q80bl";
> >> +			reg = <0>;
> >> +			spi-max-frequency = <40000000>; /* input clock */
> >> +			...
> >> +		};
> >
> > This isn't describing the controller, but rather a SPI chip attached to
> > the controller.  This also doesn't seem like the right place for random
> > SPI chips.
> >
> > If all you're specifying is the compatible, maybe create a
> > spi/trivial-devices.txt similar to i2c/trivial-devices.txt?  Or
> > something specific to SPI flash chips to describe the partition
> > specification, though I generally recommend against describing
> > partitions in the device tree -- especially if this is a developer board
> > rather than something fixed-purpose where the partitioning is not going
> > to change based on user requirements.
> >
> >
> 
> Mostly in all Documentation/devicetree/bindings/ I tried to satisfy 
> checkpatch script as simple as possible. And for me as well it looks 
> reasonable to create spi/trivial-devices.txt file and I will.

Checkpatch is a tool, not a dictator.  Sometimes it gets things wrong.

Also, please CC devicetree@vger.kernel.org when adding bindings or
modifying dts files.

> >> +-------------------------------------------------
> >> +
> >> +Chipselect/Local Bus
> >> +
> >> +Properties:
> >> +- #address-cells:	<2>.
> >> +- #size-cells:		<1>.
> >> +- compatible:		"fsl,p1020-elbc", "fsl,elbc", "simple-bus","fsl,p1020-immr"
> >> +- interrupts:		interrupts to report localbus events.
> >> +
> >> +Example:
> >> +
> >> +&lbc {
> >> +	#address-cells = <2>;
> >> +	#size-cells = <1>;
> >> +	compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
> >> +	interrupts = <19 2 0 0>;
> >> +};
> >
> > There's already a binding for elbc -- and the elbc node certainly should
> > not claim compatibility with "fsl,p1020-immr".
> >
> >
> 
> to satisfy checkpatch script.

Even if that were necessary, why do it by copy-and-paste, and why put
the immr compatible in the binding for a different node?

> >> diff --git a/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi b/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
> >> new file mode 100644
> >> index 0000000..930a6e3
> >> --- /dev/null
> >> +++ b/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
> >
> > Why can't you use p1020si-post.dtsi?  The "si" means "silicon" -- it's
> > meant to be included by all p1020 boards.
> >
> 
> Yes, silicon is the same, but p1020 boards using all 3 etsec ethernet 
> controllers. Our board using only 2: etsec1 and etsec3.

So have your board write status = "disabled" into the etsec2 node after
including the post file.

> >> diff --git a/arch/powerpc/configs/ucp1020_defconfig b/arch/powerpc/configs/ucp1020_defconfig
> >> new file mode 100644
> >> index 0000000..62f99aa
> >> --- /dev/null
> >> +++ b/arch/powerpc/configs/ucp1020_defconfig
> >
> > Please explain why your board needs its own defconfig.
> >
> 
> Because, it's our own board and it has some specific to board 
> definitions like CONFIG_DEFAULT_HOSTNAME and some specific to product 
> definitions.
> 
> If I can do it in some other way could you please give me some example 
> if it's possible.

I don't think stuff like CONFIG_DEFAULT_HOSTNAME belongs upstream.
Could you list what you need to be set that mpc85xx_smp_defconfig
doesn't set?

-Scott
