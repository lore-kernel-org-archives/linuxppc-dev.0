Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (tim.rpsys.net [194.106.48.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 459BB67B5D
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 19:56:12 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Richard Purdie <rpurdie@rpsys.net>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1151429483.597.12.camel@localhost>
References: <1149635136.32002.49.camel@johannes>
	<1150884676.23386.6.camel@johannes>
	<1151394629.2350.64.camel@localhost.localdomain>
	<1151429483.597.12.camel@localhost>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 10:38:02 +0100
Message-Id: <1151487483.15913.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-27 at 19:31 +0200, Johannes Berg wrote:
> > Looks good. Only one nit: in pmu_led_set(), you should be able to test
> > if the requested state is identical to the current one and do nothing
> > without taking the lock no ?
> > 
> > Or does the upper level LED infrastructure takes care of it ?
> 
> I don't know, Richard? But yeah, I can do that too.

The core doesn't do that. In some cases setting the LED is easier and
cheaper than checking a cached value. If setting the LED state is
expensive, it would be simple enough to implement value caching in the
driver.

Part of the problem is also that we provide several values to the driver
(brightness, power, blanking, device specific parameters) and it needs
to combine those values in a way that is only meaningful to the specific
driver.

Richard
