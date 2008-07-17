Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E64A3DE36B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 06:19:42 +1000 (EST)
Date: Thu, 17 Jul 2008 13:18:18 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3] leds: implement OpenFirmare GPIO LED driver
In-Reply-To: <fa686aa40807171105m22dda41dqb334dd5f7b2634d8@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0807171302190.27902@t2.domain.actdsltmp>
References: <1216133032.5345.73.camel@dax.rpnet.com>
	<20080715151917.GA30607@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807161546010.12709@t2.domain.actdsltmp>
	<20080717041531.GA27243@secretlab.ca>
	<20080717140519.GA32617@polina.dev.rtsoft.ru>
	<20080717141335.GA2219@polina.dev.rtsoft.ru>
	<20080717150422.GC31932@secretlab.ca>
	<20080717152006.GA26120@polina.dev.rtsoft.ru>
	<fa686aa40807171105m22dda41dqb334dd5f7b2634d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jul 2008, Grant Likely wrote:
> Alternately, I would also be okay with a scheme where all LED nodes
> have a common parent and an of_platform driver would bind against the
> parent node; not the individual children.  Then the leds-gpio driver
> could be refactored to have both platform and of_platform bus
> bindings.

Basically what I did then in my patch then, refactor leds-gpio so most of
it is shared and there is a block of code that does platform binding and
another block that does of_platform binding.

I didn't change the OF platform binding syntax so as not to complicate the
example, but that's easy to do.  Something like:

leds {
 	compatible = "gpio-led";
 	gpios = <&mpc8572 6 0
 	         &mpc8572 7 0>;
 	labels = "red", "green";
};

Or like this, which needs a little more code to parse:

leds {
 	compatible = "gpio-led";
 	led@6 {
 		gpios = <&mpc8572 6 0>;
 		label = "red";
 	};
 	led@7 {
 		gpios = <&mpc8572 7 0>;
 		label = "green";
 	};
};

I like the first better.  It follows the example from the docs about how
devices with multiple gpios should work too.
