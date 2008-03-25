Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A700CDE394
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 03:52:10 +1100 (EST)
Message-ID: <47E92D60.6090008@semihalf.com>
Date: Tue, 25 Mar 2008 17:50:40 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-mpc52xx.git
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>	
	<20080317222836.AFA66241A2@gemini.denx.de>	
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>	
	<47DF7D6F.8010808@semihalf.com>	
	<fa686aa40803180747u532f6a0bq1e64e01662bdb6bd@mail.gmail.com>	
	<1205858510.7500.35.camel@dax.rpnet.com>
	<fa686aa40803180953v7b704cf4g484324ef6fc8f523@mail.gmail.com>
In-Reply-To: <fa686aa40803180953v7b704cf4g484324ef6fc8f523@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Tue, Mar 18, 2008 at 10:41 AM, Richard Purdie <rpurdie@rpsys.net> wrote:
>>  On Tue, 2008-03-18 at 08:47 -0600, Grant Likely wrote:
>>  I don't mind having a specific driver but I don't know anything about
>>  the hardware its creating the interface for so I need the community's
>>  help with that part. There is drivers/leds/leds-gpio.c if that would
>>  work better.
> 
> Yes, I think that would be the right approach.  We would need to add
> the binding code to translate from the OF device tree to the leds-gpio
> driver.

I think that leds-gpio.c is a good solution for long-term. Note however,
that having the LED-to-GPIO pin mapping defined in the OF device
tree is problematic for targets that don't use a device tree, and for a
generic driver like leds-gpio.c some other mechanisms should probably be
used.

Going back to LEDs on Motion-PRO, using leds-gpio.c for this target
won't be achieved quickly. leds-gpio.c uses generic GPIO access
routines, which are not implemented for powerpc in general, and MPC5200
in particular. One would have to add support for MPC5200 to GPIO LIB
API, and implement the above mentioned LED-to-GPIO pin mapping in
leds-gpio.c, and then convert Motion-PRO.

Since both you and Richard don't have objections against a specific
driver, and switching Motion-PRO to a generic approach requires quite a
bit of work -- then how about we provide a patch that addresses
Richard's comments, and have the Motion-PRO LED support merged upstream
as a specific driver?

Regards,
Bartlomiej
