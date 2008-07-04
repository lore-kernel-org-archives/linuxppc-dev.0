Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 4A2DFDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 01:10:50 +1000 (EST)
Message-ID: <486E3D76.5090207@matrix-vision.de>
Date: Fri, 04 Jul 2008 17:10:46 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: GPIO @ MPC5200
References: <486DF3FA.3010806@matrix-vision.de>
	<20080704143619.GA15751@secretlab.ca>
In-Reply-To: <20080704143619.GA15751@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely schrieb:
> On Fri, Jul 04, 2008 at 11:57:14AM +0200, Andre Schwarz wrote:
>   
>> Sascha, Grant,
>>
>> I'm running on 2.6.26-rc6 with an MPC5200B based system.
>>
>> Looks like some (for me) crucial GPIO are touched during boot.
>> Is this possible ?
>>
>> Of course I have compiled in GPIO-Lib and specified the GPIOs in the dts.
>> But no access yet - I'd like to preserve the setup from u-boot...
>>     
>
> The GPIO driver only writes to the GPIO registers when a driver actually
> requests to use them.  At probe time, the gpio drivers read the current
> values from the GPIO registers, so current config should be preserved.
>
> However, the gpiochip_dir hook explicitly sets the output value when it
> is called.  It may be that when you are claiming the GPIO line it is
> getting set with a default (and wrong) value.
>
> Another possibility; have you verified that it is the GPIO regs getting
> clobbered?  Or is port_config getting changed on you?  Which GPIO pins?
>
> g.
>   

The pin in question is PSC2_4, i.e. a wake-up GPIO.
It is configured as push-pull output and driven high.

Since it has an external pull-down resistor I can't say if it is driven
low or re-configured as an input ...

I removed GPIO Lib and the problem is gone.
I'm not yet using it anyway under linux - they're mainly for system
configuration (setting up muxes etc.).

I'll dig into it when I have some time.

thanks,
Andre






MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
