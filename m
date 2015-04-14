Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F31FB1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 06:32:57 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2AC41140281
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2015 06:32:56 +1000 (AEST)
Message-ID: <1429042666.22867.686.camel@freescale.com>
Subject: Re: [1/3][PATCH][v2] Device Tree bindings for Freescale TDM controller
From: Scott Wood <scottwood@freescale.com>
To: Singh Sandeep-B37400 <sandeep@freescale.com>
Date: Tue, 14 Apr 2015 15:17:46 -0500
In-Reply-To: <DM2PR0301MB0622ECC6C5C64135B1BCA12CB1E60@DM2PR0301MB0622.namprd03.prod.outlook.com>
References: <1427971677-32395-1-git-send-email-sandeep@freescale.com>
 <1428023676.22867.320.camel@freescale.com>
 <DM2PR0301MB0622ECC6C5C64135B1BCA12CB1E60@DM2PR0301MB0622.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-14 at 08:50 -0500, Singh Sandeep-B37400 wrote:
> > > +TDM (Time Division Multiplexing)
> > > +
> > > +DESCRIPTION
> > > +
> > > +The TDM is full duplex serial port designed to allow various devices
> > > +including digital signal processors (DSPs) to communicate with a
> > > +variety of serial devices including industry standard framers, codecs, other
> > DSPs and microprocessors.
> > > +
> > > +The below properties describe the device tree bindings for Freescale
> > > +TDM controller.
> > > +This TDM controller is available on various Freescale Processors like
> > > +MPC8313, P1020, P1022 and P1010.
> > > +
> > > +PROPERTIES
> > > +
> > > +  - compatible
> > > +      Usage: required
> > > +      Value type: <string>
> > > +      Definition: Should contain "fsl,tdm1.0".
> > 
> > What does 1.0 refer to?  Is the TDM block identical on all the chips that currently
> > have it?  Is this a real version number scheme (public or
> > otherwise) or something made up for software?
> [Sandeep] Starlite TDM block is identical on all the chips. This is a software only version.

Then I recommend arbitrarily picking one of the chips and naming the
compatible after that: "fsl,mpc8313-tdm".

> > > +  - reg
> > > +      Usage: required
> > > +      Definition: A standard property. The first reg specifier describes the
> > > +          TDM registers, and the second describes the TDM DMAC registers.
> > > +
> > > +  - clock-frequency
> > > +      Usage: optional
> > > +      Value type: <u32 or u64>
> > > +      Definition: The frequency at which the TDM block is operating.
> > 
> > It'd be nice if new bindings used clock nodes rather than relying on U-Boot fixups.
> [Sandeep] This field is not currently used, but is planned to be used in future.

I don't see how that answers my request.

> > > +EXAMPLE
> > > +
> > > +	tdm@16000 {
> > > +		compatible = "fsl,tdm1.0";
> > > +		reg = <0x16000 0x200 0x2c000 0x2000>;
> > > +		clock-frequency = <0>;
> > > +		interrupts = <16 8 62 8>;
> > > +		phy-handle = <&zarlink1>;
> > > +		fsl,max-time-slots = <128>;
> > > +	};
> > 
> > The example refers to a "zarlink1" node but it is not present.  What does a "line
> > controller or framer node" look like?
> [Sandeep] phy-handle again is currently not being used. Added for future use.

Please submit a complete binding.

-Scott
