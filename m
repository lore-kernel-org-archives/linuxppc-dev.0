Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 563C22C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Aug 2013 03:07:46 +1000 (EST)
Date: Sat, 3 Aug 2013 19:07:38 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 11/31] net: can: mscan: improve clock API use
Message-ID: <20130803170738.GM2580@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-12-git-send-email-gsi@denx.de>
 <51ED2619.5040107@pengutronix.de>
 <20130723115348.GF19071@book.gsilab.sittig.org>
 <51EE77FC.8090809@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51EE77FC.8090809@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Wolfgang Grandegger <wg@grandegger.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ trimming the CC: list a bit, as this is CAN and clock specific,
  keeping Mark Brown and Greg KH for the UART and SPI part ]

On Tue, Jul 23, 2013 at 14:33 +0200, Marc Kleine-Budde wrote:
> 
> On 07/23/2013 01:53 PM, Gerhard Sittig wrote:
> > On Mon, Jul 22, 2013 at 14:31 +0200, Marc Kleine-Budde wrote:
> >>
> >> On 07/22/2013 02:14 PM, Gerhard Sittig wrote:
> >>> the .get_clock() callback is run from probe() and might allocate
> >>> resources, introduce a .put_clock() callback that is run from remove()
> >>> to undo any allocation activities
> >>
> >> looks good
> >>
> >>> use devm_get_clk() upon lookup (for SYS and REF) to have the clocks put
> >>> upon driver unload
> >>
> >> fine
> >>
> >>> assume that resources get prepared but not necessarily enabled in the
> >>> setup phase, make the open() and close() callbacks of the CAN network
> >>> device enable and disable a previously acquired and prepared clock
> >>
> >> I think you should call prepare_enable and disable_unprepare in the
> >> open/close functions.
> > 
> > After more local research, which totally eliminated the need to
> > pre-enable the CAN related clocks, but might need more discussion
> > as it touches the common gate support, I've learned something
> > more:
> > 
> > The CAN clock needs to get enabled during probe() already, since
> > registers get accessed between probe() for the driver and open()
> > for the network device -- while access to peripheral registers
> > crashes the kernel when clocks still are disabled (other hardware
> > may just hang or provide fake data, neither of this is OK).
> 
> Then call prepare_enable(); before and disable_unprepare(); after
> accessing the registers. Have a look at the flexcan driver.

OK, your feedback made me notice that I mentally have mixed
peripheral access clocks ('ipg') and bitrate clocks ('per') in
the past versions of the driver.

Fixing this, telling 'ipg' and 'per' apart, "in bypassing"
eliminates the need for "shared clock gates".  Since the MCLK
subtree of the clock tree apply to both the CAN controller and
the PSC controller, I will have to adjust all of the following:
- the platform's clock driver, telling the gate for the registers
  and the mux/div for the bitrate apart
- the CAN driver, acquiring both the 'ipg' clock item for
  register access and the "can" clock for the bitrate, the latter
  may get derived from either 'ips' or 'mclk', while 'mclk' may
  be derived from either 'sys' or 'ref' (or 'ips' in this
  hardware while the mscan(4) driver doesn't use this feature)
- the UART and SPI drivers, acquiring both the 'ipg' clock item
  for register access and the 'mclk' item for the bitrate

This obsoletes the request for "shared gates" and eliminates
another pre-enable workaround in the clock driver backend.

It also is an improvement for the MPC512x platform, and remains
neutral to the MPC52xx platform.  It's clearly desirable and
useful, and doesn't break anything.  So I will do it.

[ the above applied to CAN, SPI, and UART; the remainder is
  specific to CAN only ]


But I won't try to even further widen the scope of the series, I
won't try to address each and every potential for improvement
which drivers may have had for several years and which happened
to not have been addressed yet.  This needs to stop at some
reasonable point.  I'm not refusing to improve, but I'm asking to
check what is reasonable and what needs to get avoided.

I already introduced a bug in a recent version of the series
which went unnoticed during review (the unbalanced error path in
the network device open routine).  I'd rather not mess with power
management aspects "in bypassing" in a driver that I'm unable to
test thoroughly.  Not when I'm trying to work on something
totally different (introducing proper common clock support) and
try to minimize risk and avoid damage.


> > But I see the point in your suggestion to prepare _and_ enable
> > the clock during open() as well -- to have open() cope with
> > whatever probe() did, after all the driver is shared among
> > platforms, which may differ in what they do during probe().
> 
> If you enable a clock to access the registers before open() (and disable
> it afterwards), it should not harm any architecture that doesn't need
> this clock enabled.

You suggest to turn on the clock during initialization, and turn
it off until the network device actually gets used?  I had a look
at the flexcan driver, saw that it used two clock items, as
outlined above for register access and for wired communication.
This is good.  But I somehow doubt that the flexcan driver will
work if the ipg clock gets disabled (I assume it's a shared clock
that happens to remain enabled since others use it as well).

I'd rather not open that can of worms, too.  My gut is telling me
that either the peripheral does weird things or will lose data
when its (register access) clock gets disabled.  I won't try to
address power management and save/restore issues in that driver
now, and I won't try to hunt down and instrument any register
access in the shared code paths of a driver for multiple
platforms which is full of callbacks.

That's just out of the scope of the series.  It may be desirable
to address this issue as well, but it shall be done in a separate
action, not now "in bypassing".  Thank you for understanding. :)
And I do appreciate your feedback and desire for even better
drivers, just disagree on what to do now in this very moment.


What we already have is:
- probe() and remove() for the driver, calling into clock setup
  and allocation and deallocation routines
- no allocation for MPC52xx and thus no deallocation, keeping the
  status of how things used to be
- allocation of a "can" clock for MPC512x and the respective
  deallocation
- open() and close() for the network device, which prepare/enable
  and disable/unprepare the allocated clocks

What I will add is:
- allocation and release of both the 'ipg' and a "can" clock for
  the MPC512x case
- handling of all allocated clocks in open() and close() (such
  that no assumption is made what occurs at probe() and remove()
  time)
- permanently enabled 'ipg' clock when allocated, such that the
  driver may happily access the controller's registers and may
  assume things remain there
- usually disabled 'can' clock, but enable/disable between open()
  and close()

This shall result in:
- no change in behaviour for MPC52xx
- disabled clocks and hardware for MPC512x when CAN isn't probed
  (not listed in the device tree, or disabled)
- enabled internal peripherals but wire disabled for MPC512x when
  CAN is probed and attached but not in use
- only enabled wire related clock when the network device is open
  and in actual use

The above goal of the next update in the series won't break any
operation of peripherals, will be a clear improvement in that the
driver finally does properly use the clock API, and will result
in an appropriate use of hardware.  There may be potential to
conserve even more power, but it's not essential given the
previous status of the driver, and it's out of the scope for the
very series we are talking about.


> > So I will:
> > - make open() of the network device prepare _and_ enable the
> >   clock for the peripheral (if acquired during probe())
> 
> good
> 
> > - adjust open() because ATM it leaves the clock enabled when the
> >   network device operation fails (the error path is incomplete in
> >   v3)
> 
> yes, clock should be disabled if open() fails.
> 
> > - make the MPC512x specific probe() time .get_clock() routine not
> >   just prepare but enable the clock as well
> 
> If needed enable the clock, but disable after probe() has finished.
> 
> > - and of course address all the shutdown counter parts of the
> >   above setup paths
> 
> > This results in:
> > - specific chip drivers only need to balance their private get
> >   and put clock routines which are called from probe and remove,
> >   common paths DTRT for all of them
> 
> Yes, but clock should not stay enabled between probe() and open().

For this one I offered the compromise of only enabling the "can"
clock during network device operation, but keeping the 'ipg'
clock active over the driver's complete attachment period.  This
shall be acceptable.  Anything else can be done later and
independently.

> [...]
> 
> > Removing unnecessary devm_put_clk() calls is orthogonal to that.
> > Putting these in isn't totally wrong (they won't harm, and they
> > do signal "visual balance" more clearly such that the next person
> > won't stop and wonder), but it's true that they are redundant.
> > "Trained persons" will wonder as much about their presence as
> > untrained persons wonder about their absence. :)  Apparently I'm
> > not well trained yet.
> 
> The whole point about devm_* is to get rid of auto manually tear down
> functions. So please remove all devm_put_clk() calls, as it will be
> called automatically if a driver instance is removed.

Ah, yes, the devm_*() feedback was processed as well.  Release
won't occur explicitly, as it's done implicitly by common code.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
