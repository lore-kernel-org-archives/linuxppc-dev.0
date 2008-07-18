Return-Path: <dgibson@ozlabs.org>
Date: Fri, 18 Jul 2008 13:35:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080718033512.GC18748@yookeroo.seuss>
References: <20080714164114.GA18784@polina.dev.rtsoft.ru>
	<dc452eaab83710e7d6f86dcc5d77bdda@kernel.crashing.org>
	<20080717110730.GA24775@polina.dev.rtsoft.ru>
	<20080717150715.GD31932@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080717150715.GD31932@secretlab.ca>
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

On Thu, Jul 17, 2008 at 09:07:15AM -0600, Grant Likely wrote:
> On Thu, Jul 17, 2008 at 03:07:30PM +0400, Anton Vorontsov wrote:
> > On Thu, Jul 17, 2008 at 07:59:03AM +0200, Segher Boessenkool wrote:
> > > What would be the parent node of this, btw?
> > 
> > This is tricky question. Personally I place them inside the gpio
> > controller node that is responsible for the LED. But I think placing the
> > led nodes at top level would be also fine (maybe with "leds { }" node as
> > a parent for all board's LEDs. What would you suggest for a "best
> > practice"?
> 
> I like this idea (a 'leds' parent node).  They aren't really children
> of the GPIO node or any other device/bus in the system.  Putting them
> under a dedicated 'leds' node would make them easy to find and would
> have the added advantage of making it easier to have a single driver
> instance manage the whole lot.

Hmm.  Putting them under the gpio seems reasonable to me.  The gpio
lines are the LEDs' "bus" to the limited extent that they have any bus
at all.

This brings us back to the issue we also have with DCR controlled
devices.  Possibly we should have two ways of representing these
connections: for "pure" GPIO-only or DCR-only devices, they appear
under the relevant controller with the addresses encoded with 'reg'.
For devices on other busses which also have a few GPIO lines / DCR
registers, they would appear on the other bus with 'gpios' or
'dcr-reg' properties (or some new, generalized 'other-bus-reg'
property).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
