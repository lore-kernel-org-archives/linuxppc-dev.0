Return-Path: <glikely@secretlab.ca>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 23A08DF30C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 06:50:00 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so80621qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 13:49:58 -0700 (PDT)
Date: Thu, 17 Jul 2008 14:49:51 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH v3] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080717204951.GD6894@secretlab.ca>
References: <1216133032.5345.73.camel@dax.rpnet.com>
	<20080715151917.GA30607@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807161546010.12709@t2.domain.actdsltmp>
	<20080717041531.GA27243@secretlab.ca>
	<20080717140519.GA32617@polina.dev.rtsoft.ru>
	<20080717141335.GA2219@polina.dev.rtsoft.ru>
	<20080717150422.GC31932@secretlab.ca>
	<20080717152006.GA26120@polina.dev.rtsoft.ru>
	<fa686aa40807171105m22dda41dqb334dd5f7b2634d8@mail.gmail.com>
	<Pine.LNX.4.64.0807171302190.27902@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0807171302190.27902@t2.domain.actdsltmp>
Sender: Grant Likely <glikely@secretlab.ca>
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

On Thu, Jul 17, 2008 at 01:18:18PM -0700, Trent Piepho wrote:
> On Thu, 17 Jul 2008, Grant Likely wrote:
> > Alternately, I would also be okay with a scheme where all LED nodes
> > have a common parent and an of_platform driver would bind against the
> > parent node; not the individual children.  Then the leds-gpio driver
> > could be refactored to have both platform and of_platform bus
> > bindings.
> 
> Basically what I did then in my patch then, refactor leds-gpio so most of
> it is shared and there is a block of code that does platform binding and
> another block that does of_platform binding.

Yes

> I didn't change the OF platform binding syntax so as not to complicate the
> example, but that's easy to do.  Something like:
> 
> leds {
>  	compatible = "gpio-led";
>  	gpios = <&mpc8572 6 0
>  	         &mpc8572 7 0>;
>  	labels = "red", "green";
> };
> 
> Or like this, which needs a little more code to parse:
> 
> leds {
>  	compatible = "gpio-led";
>  	led@6 {
>  		gpios = <&mpc8572 6 0>;
>  		label = "red";
>  	};
>  	led@7 {
>  		gpios = <&mpc8572 7 0>;
>  		label = "green";
>  	};
> };

I kind of like the second option better, because there is less chance
of doing bad stuff if the gpio specifier was buggered up; but I'm cool
with either.

However, if the second option is chosen then something like the following
might be better as it eliminates the meaningless @<number> specifier.

leds {
	compatible = "gpio-led";
	red {
		gpios = <&mpc8572 6 0>;
	};
	green {
		gpios = <&mpc8572 7 0>;
	};
};

Cheers,
g.
