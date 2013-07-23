Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 15C272C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 21:53:58 +1000 (EST)
Date: Tue, 23 Jul 2013 13:53:48 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 11/31] net: can: mscan: improve clock API use
Message-ID: <20130723115348.GF19071@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-12-git-send-email-gsi@denx.de>
 <51ED2619.5040107@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51ED2619.5040107@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>,
 devicetree-discuss@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 22, 2013 at 14:31 +0200, Marc Kleine-Budde wrote:
> 
> On 07/22/2013 02:14 PM, Gerhard Sittig wrote:
> > the .get_clock() callback is run from probe() and might allocate
> > resources, introduce a .put_clock() callback that is run from remove()
> > to undo any allocation activities
> 
> looks good
> 
> > use devm_get_clk() upon lookup (for SYS and REF) to have the clocks put
> > upon driver unload
> 
> fine
> 
> > assume that resources get prepared but not necessarily enabled in the
> > setup phase, make the open() and close() callbacks of the CAN network
> > device enable and disable a previously acquired and prepared clock
> 
> I think you should call prepare_enable and disable_unprepare in the
> open/close functions.

After more local research, which totally eliminated the need to
pre-enable the CAN related clocks, but might need more discussion
as it touches the common gate support, I've learned something
more:

The CAN clock needs to get enabled during probe() already, since
registers get accessed between probe() for the driver and open()
for the network device -- while access to peripheral registers
crashes the kernel when clocks still are disabled (other hardware
may just hang or provide fake data, neither of this is OK).

But I see the point in your suggestion to prepare _and_ enable
the clock during open() as well -- to have open() cope with
whatever probe() did, after all the driver is shared among
platforms, which may differ in what they do during probe().

So I will:
- make open() of the network device prepare _and_ enable the
  clock for the peripheral (if acquired during probe())
- adjust open() because ATM it leaves the clock enabled when the
  network device operation fails (the error path is incomplete in
  v3)
- make the MPC512x specific probe() time .get_clock() routine not
  just prepare but enable the clock as well
- and of course address all the shutdown counter parts of the
  above setup paths

This results in:
- specific chip drivers only need to balance their private get
  and put clock routines which are called from probe and remove,
  common paths DTRT for all of them
- correct operation for MPC512x, where common clock is used
- still everything is neutral for MPC5200 where common clock
  isn't used, behaviour is identical to before the change
- no assumptions are made about what occurs or doesn't occur
  during probe(), when the network device is used then the clock
  is fully setup and operational
- when the CAN network device isn't setup (because device tree
  doesn't describe it, or disables that node), then its clock
  remains idle (neither gets setup nor enabled)
- complete preparation for future improvement wrt power
  consumption, where potential changes remain isolated to the
  specific chip (probe() time setup, get_clock() routine) while
  the ndo part need not get touched any more

So this is the most appropriate approach I can come up with.


Removing unnecessary devm_put_clk() calls is orthogonal to that.
Putting these in isn't totally wrong (they won't harm, and they
do signal "visual balance" more clearly such that the next person
won't stop and wonder), but it's true that they are redundant.
"Trained persons" will wonder as much about their presence as
untrained persons wonder about their absence. :)  Apparently I'm
not well trained yet.

I thought that being explicit and cautious would be good, but the
feedback I got suggests that encoding unnecessary instructions
isn't desirable.  So I will remove those devm_put_clk() in v4.

To save us one more iteration, shall I remove those calls only
from error paths during setup?  Or shall I remove them from
regular shutdown paths as well?  How much pain does the community
feel with harmless yet unnecessary instructions? :)


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
