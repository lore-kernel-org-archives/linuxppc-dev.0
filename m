Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 38A2ADDE08
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 22:02:09 +1100 (EST)
Message-ID: <476F918F.4050909@scram.de>
Date: Mon, 24 Dec 2007 12:01:35 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH/RFC] powerpc: DBox2 Board Support
References: <476D61DB.2090201@scram.de>
	<20071223230342.GA20636@localhost.localdomain>
In-Reply-To: <20071223230342.GA20636@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

>> +	localbus@8000000 {
>> +		compatible = "betaresearch,dbox2-localbus";
> 
> Is this bus interface really board specific?  I would have thought the
> localbus bridge would have been part of the SoC in which case the
> compatible string should mention the 823 rather than the dbox.
> 
>> +		#address-cells = <1>;
> 
> It's also usual for these localbus things, to have #address-cells of
> 2, with the chipselect explicitly present as the first cell.

The setup of the localbus is already done in the boot loader. However, i'll
recode this to reflect the mapping of addresses to chipselects.

>> +		#size-cells = <1>;
>> +		reg = <8000000 18000000>;
>> +
>> +		ranges = <0 8000000 18000000>;
>> +
>> +		enx@0 {
>> +			compatible = "c-cube,enx";
> 
> What are these mysterious enx, gtx, etc. devices?  Some comments might
> be nice.

Those are mostly devices for video processing (MPEG demux, on screen display, MPEG decoder, etc).
Drivers (for ARCH=ppc) are available on cvs.tuxbox.org with GPL license. A work in progress port
to ARCH=powerpc is at git://git.bocc.de/dbox2.git.

>> +			// Port D is LCD exclusive. Don't export as GPIO
>> +			CPM1_PIO: pio@970 {
>> +				compatible = "fsl,cpm1-pario";
>> +				reg = <970 180>;
>> +				num-ports = <3>;
>> +				#gpio-cells = <2>;
>> +			};
>> +
>> +			lcd@970 {
>> +				reg = <970 10>;
>> +				compatible = "samsung,ks0713";
> 
> Is this representing an LCD controller, or the display itself.  Either
> way I'm surprised there's something here in the SoC that has a
> compatible string that's not "fsl,something"

It's a LCD controller wired to PortD. PortD is used for four 1bit lines
and one 8bit bus.

Would something like this be better?

CPM1_PIO: pio@970 {
	compatible = "fsl,cpm1-pario";
	reg = <970 180>;
	num-ports = <4>;
	#gpio-cells = <2>;
};

lcd@0 {
	compatible = "samsung,ks0713";
	gpio-parent = <&CPM1_PIO>;
	gpio-port = 3;
}

And then run gpio_request() for all lines on this port in the driver?

Thanks,
Jochen
