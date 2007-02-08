Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 8ED3BDDE44
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 11:53:47 +1100 (EST)
Date: Wed, 7 Feb 2007 18:53:37 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add base support for the MPC8313E RDB
Message-Id: <20070207185337.39dead9b.kim.phillips@freescale.com>
In-Reply-To: <7A666EA2-E740-42D8-9B36-1E7F6B46158F@kernel.crashing.org>
References: <20070207170602.45f9c2ee.kim.phillips@freescale.com>
	<7A666EA2-E740-42D8-9B36-1E7F6B46158F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 7 Feb 2007 17:36:34 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Feb 7, 2007, at 5:06 PM, Kim Phillips wrote:
> 
> > Add support for the MPC8313E Reference Development Board (RDB).
> > Includes dts.
> 
> Can you give some better description about the RDB, like what  
> functionality it supports, etc..

I'll respin with the details..

> 
> > +	soc8313@e0000000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		#interrupt-cells = <2>;
> > +		device_type = "soc";
> > +		ranges = <0 e0000000 00100000>;
> > +		reg = <e0000000 00000200>;
> > +		bus-frequency = <0>;
> > +		compatible = "mpc8313\0mpc831x\0mpc83xx";
> 
> I'm not sure what this compatible property is suppose to mean?
> 

it was the part of Scott's "ioremap the entire IMMR" patch you acked.  I'll take it out for now, since it should really be a part of that patch.

> > +		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
> > +		usb@23000 {
> > +			device_type = "usb";
> > +			compatible = "fsl-usb2-dr";
> > +			reg = <23000 1000>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			interrupt-parent = <700>;
> > +			interrupts = <26 2>;
> > +			phy_type = "utmi_wide";
> 
> Does anything change because of the integrated UTMI phy?
> 
yes, it's..

> > +			control_init  = <00000280>; // UTMI ext 48 MHz clk
> 
> What is 'control_init' ?
> 

..which selects and enables the UTMI phy interface options.

> > +
> > +		ethernet@24000 {
> > +			device_type = "network";
> > +			model = "TSEC";
> 
> isn't eTSEC on 8313?
> 
quite right, I'll change it.

Thanks,

Kim
