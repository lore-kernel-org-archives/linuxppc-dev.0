Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 84D02B7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:05:13 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p19IktnO028574
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 13:47:02 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B01CE72818C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 18:04:29 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p19N3DKt140062
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 18:03:13 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p19N3D3g023901
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 21:03:13 -0200
Subject: Re: [PATCH V2 6/6] powerpc/476: Create a dts files for two 476 AMP
	instances under ISS
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20110202024315.GB3032@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-7-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110202024315.GB3032@yookeroo>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 09 Feb 2011 17:03:12 -0600
Message-ID: <1297292592.14457.6.camel@shaggy-w500>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-02-02 at 13:43 +1100, David Gibson wrote:
> On Tue, Feb 01, 2011 at 12:48:46PM -0600, Dave Kleikamp wrote:
> > These are completely independent OS instances, each running on 2
> > cores.
> 
> [snip]
> > +/memreserve/ 0x01f00000 0x00100000;
> 
> A comment describing what this reserved section is for would be good.

I with I knew what it was for.  I've blindly carried it along for a
while.  Removing it doesn't appear to do any harm.  Ben, any idea why
this was ever in here?

> > +/ {
> > +	#address-cells = <2>;
> > +	#size-cells = <1>;
> > +	model = "ibm,iss-4xx";
> > +	compatible = "ibm,iss-4xx", "ibm,47x-AMP";
> > +	dcr-parent = <&{/cpus/cpu@0}>;
> > +
> > +	aliases {
> > +		serial0 = &UART0;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu@0 {
> > +			device_type = "cpu";
> > +			model = "PowerPC,4xx"; // real CPU changed in sim
> 
> If the comment is true, then it's probably simpler to just omit the
> model property.  I'm pretty sure nothing will look at it.

It doesn't appear to be true.  Another bit I've been carrying along
without checking it.  Removing the comment.

> 
> > +			reg = <0>;
> > +			clock-frequency = <100000000>; // 100Mhz :-)
> > +			timebase-frequency = <100000000>;> +			i-cache-line-size = <32>;
> > +			d-cache-line-size = <32>;
> > +			i-cache-size = <32768>;
> > +			d-cache-size = <32768>;
> > +			dcr-controller;
> > +			dcr-access-method = "native";
> > +			status = "ok";
> 
> Should be "okay" rather than "ok".

okay :-)

> 
> [snip]
> > +			UART0: serial@40000200 {
> > +				device_type = "serial";
> > +				compatible = "ns16550a";
> > +				reg = <0x40000200 0x00000008>;
> > +				virtual-reg = <0xe0000200>;
> > +				clock-frequency = <11059200>;
> > +				current-speed = <115200>;
> > +				interrupt-parent = <&MPIC>;
> > +				interrupts = <0x0 0x2>;
> > +			};
> > +		};
> > +	};
> > +
> > +	nvrtc {
> > +		compatible = "ds1743-nvram", "ds1743", "rtc-ds1743";
> > +		reg = <0 0xEF703000 0x2000>;
> > +	};
> > +
> > +	chosen {
> > +		linux,stdout-path = "/plb/opb/serial@40000200";
> 
> You can use a string reference here:
> 	linux,stdout-path = &UART0;

no problem

Shaggy

-- 
Dave Kleikamp
IBM Linux Technology Center
