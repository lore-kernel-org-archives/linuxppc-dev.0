Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 62F31DE8FF
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:07:19 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5572170wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:07:17 -0700 (PDT)
Date: Thu, 17 Jul 2008 09:07:15 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080717150715.GD31932@secretlab.ca>
References: <20080714164114.GA18784@polina.dev.rtsoft.ru>
	<dc452eaab83710e7d6f86dcc5d77bdda@kernel.crashing.org>
	<20080717110730.GA24775@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080717110730.GA24775@polina.dev.rtsoft.ru>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2008 at 03:07:30PM +0400, Anton Vorontsov wrote:
> On Thu, Jul 17, 2008 at 07:59:03AM +0200, Segher Boessenkool wrote:
> > What would be the parent node of this, btw?
> 
> This is tricky question. Personally I place them inside the gpio
> controller node that is responsible for the LED. But I think placing the
> led nodes at top level would be also fine (maybe with "leds { }" node as
> a parent for all board's LEDs. What would you suggest for a "best
> practice"?

I like this idea (a 'leds' parent node).  They aren't really children
of the GPIO node or any other device/bus in the system.  Putting them
under a dedicated 'leds' node would make them easy to find and would
have the added advantage of making it easier to have a single driver
instance manage the whole lot.

g.
