Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 78273DDE41
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 02:12:53 +1100 (EST)
Message-ID: <47726F5E.6040207@scram.de>
Date: Wed, 26 Dec 2007 16:12:30 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH/RFC] powerpc: DBox2 Board Support
References: <476D61DB.2090201@scram.de>
	<20071223230342.GA20636@localhost.localdomain>
	<476F918F.4050909@scram.de>
	<20071225010412.GL21311@localhost.localdomain>
In-Reply-To: <20071225010412.GL21311@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

>>>> +			// Port D is LCD exclusive. Don't export as GPIO
>>>> +			CPM1_PIO: pio@970 {
>>>> +				compatible = "fsl,cpm1-pario";
>>>> +				reg = <970 180>;
>>>> +				num-ports = <3>;
>>>> +				#gpio-cells = <2>;
>>>> +			};
>>>> +
>>>> +			lcd@970 {
>>>> +				reg = <970 10>;
>>>> +				compatible = "samsung,ks0713";
>>> Is this representing an LCD controller, or the display itself.  Either
>>> way I'm surprised there's something here in the SoC that has a
>>> compatible string that's not "fsl,something"
>> It's a LCD controller wired to PortD. PortD is used for four 1bit lines
>> and one 8bit bus.
> 
> I'm still kind of confused here.  Does the pio@970 node above
> represent the PortD controller?  If the LCD controller is accessed
> solely through PortD, then it should be a child of the PortD node.
> 
> At present, pio and lcd have overlapping reg resources which is
> certainly wrong.
> 

pio@970 represent 4 ports (A-D). Ports A-C are used as GPIO lines. Port D
is exclusively used for the LCD, but it needs an 8bit accessor. Unfortunately,
the GPIO API doesn't have such an accessor, so the LCD driver needs to access
Port D itself and needs to make sure no other driver can access Port D via the
GPIO API. The representation as child of pio seems reasonable.

Thanks,
Jochen
