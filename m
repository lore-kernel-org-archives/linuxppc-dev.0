Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id A222767B16
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 15:28:24 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k5U5SMmi006136
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 22:28:22 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5U5SKNB018506
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 00:28:21 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FEB@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
Subject: RE: [PATCH] Add QE device tree definition
Date: Fri, 30 Jun 2006 13:28:14 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, June 30, 2006 1:10 PM
> To: Li Yang-r58472
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Add QE device tree definition
> 
> 
> On Jun 29, 2006, at 11:52 PM, Li Yang-r58472 wrote:
> 
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Friday, June 30, 2006 12:11 PM
> >> To: Li Yang-r58472
> >> Cc: linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH] Add QE device tree definition
> >>
> >> [snip]
> >>
> >>>>> +   2) SPI (Serial Peripheral Interface)
> >>>>> +
> >>>>> +   Required properties:
> >>>>> +   - device_type : should be "spi".
> >>>>> +   - compatible : should be "fsl_spi".
> >>>>> +   - mode : the spi operation mode, it can be "cpu" or "qe".
> >>>>
> >>>> What does it mean for the spi to be in "qe" mode?
> >>> That means:
> >>> The SPI can operate in QE mode or in CPU mode. In QE mode SPI is
> >>> compatible to the MPC826x SPI, and is controlled by QE RISC. In CPU
> >>> mode, the SPI is controlled wholly by the CPU without any QE RISC
> >>> intervention.
> >>
> >> In QE mode does software get involved at all?
> >
> > Yes, of course.  The driver needs to do initialization, and deal
> > with the BDs.
> 
> So what exactly does the QE do in this mode?

Just like CPM.  Driver only deal with buffer and buffer descriptor.  And QE will take care of the other things.
While in CPU mode, it is up to the CPU to pack and unpack the receive/transmit frames.  And tx/rx through data registers.
> 
> >>>>> +   - reg : offset to the register set and its length.
> >>>>> +   - interrupts : <a b> where a is the interrupt number and b
> >>>>> is a
> >>>>> +     field that represents an encoding of the sense and level
> >>>>> +     information for the interrupt.  This should be encoded
> >>>>> based on
> >>>>> +     the information in section 2) depending on the type of
> >>>>> interrupt
> >>>>> +     controller you have.
> >>>>> +   - interrupt-parent : the phandle for the interrupt controller
> >>>>> that
> >>>>> +     services interrupts for this device.
> >>>>> +
> >>>>> +   Example:
> >>>>> +	spi@4c0 {
> >>>>> +		device_type = "spi";
> >>>>> +		compatible = "fsl_spi";
> >>>>> +		reg = <4c0 40>;
> >>>>> +		interrupts = <82 0>;
> >>>>> +		interrupt-parent = <700>;
> >>>>> +		mode = "cpu";
> >>>>> +	};
> >>>>> +
> >>
> >> [snip]
> >>
> >>>>> +   5) Parallel I/O Ports
> >>>>> +
> >>>>> +   This node configures Parallel I/O ports for CPUs with QE
> >>>>> support.
> >>>>> +   The node should reside in the "soc" node of the tree.  For
> >>>>> each
> >>>>> +   device that using parallel I/O ports, a child node should be
> >>>>> created.
> >>>>> +   See the definition of the Pin configuration nodes below for
> >>>>> more
> >>>>> +   information.
> >>>>> +
> >>>>> +   Required properties:
> >>>>> +   - device_type : should be "par_io".
> >>>>> +   - reg : offset to the register set and its length.
> >>>>> +
> >>>>> +   Example:
> >>>>> +	par_io@1400 {
> >>>>> +		reg = <1400 100>;
> >>>>> +		#address-cells = <1>;
> >>>>> +		#size-cells = <0>;
> >>>>> +		device_type = "par_io";
> >>>>> +		ucc_pin@01 {
> >>>>> +			......
> >>>>> +		};
> >>>>> +
> >>>>
> >>>> Can you explain this further, I'm not getting the relationship
> >>>> between a par_io & ucc_pin.  An example maybe helpful.
> >>>
> >>> Each QE device needs to configure Parallel I/O Ports pin
> >>> configuration in order to work, for example the configuration for
> >>> ucc1 is ucc_pin@01.  par_io is a container for all these
> >>> configurations and gives the base for parallel io port register.  I
> >>> will paste dts file for 8360 to give an example.
> >>
> >> Maybe its the name that's confusing me, ucc_pin@01 describes what
> >> exactly?  A single pin? or all the pin configs for ucc 1?
> >
> > All pin configs to ucc1.
> > Could you suggest a more proper name?
> 
> Let me think on this now that I understand what's going on.
> 
> - k
