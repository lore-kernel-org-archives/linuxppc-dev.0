Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72066DDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 03:01:32 +1000 (EST)
In-Reply-To: <20070912163638.GA16326@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0709121119160.19430@blarg.am.freescale.net>
	<20070912163638.GA16326@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AE69C5D1-3910-40F0-80E5-283FDB5199F5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Wed, 12 Sep 2007 12:04:20 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 12, 2007, at 11:36 AM, Scott Wood wrote:

> On Wed, Sep 12, 2007 at 11:20:06AM -0500, Kumar Gala wrote:
>> +		pcie@0 {
>> +			reg = <0 0 0 0 0>;
>> +			#size-cells = <2>;
>> +			#address-cells = <3>;
>> +			device_type = "pci";
>> +			uli1575@0 {
>
> You need a ranges; in the pcie node, or else nothing can be translated
> through it.  Linux may let us get away with it currently, but other
> parsing code won't.

ok, wasn't sure.  will add that in.

>> +					i8259: interrupt-controller@20 {
>> +						reg = <1 20 2
>> +						       1 a0 2
>> +						       1 4d0 2>;
>> +						clock-frequency = <0>;
>> +						interrupt-controller;
>> +						device_type = "interrupt-controller";
>> +						#address-cells = <0>;
>> +						#interrupt-cells = <2>;
>> +						built-in;
>> +						compatible = "chrp,iic";
>> +						interrupts = <9 2>;
>> +						interrupt-parent =
>> +							<&mpic>;
>> +					};
>
> I'd get rid of clock-frequency and built-in.

I'm leaving them for now to match the others, we can clean them all  
up at the same time.  Technically built-in is spec'd by the CHRP spec  
for ISA/PCI.

As for clock-frequency, not sure where that came from.

- k
