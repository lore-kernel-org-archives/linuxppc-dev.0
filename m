Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id F2F8CB70BD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 20:42:56 +1000 (EST)
Date: Thu, 11 Aug 2011 05:42:52 -0500
From: Robin Holt <holt@sgi.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v11 4/5] powerpc: Add flexcan device support for p1010rdb.
Message-ID: <20110811104252.GC4926@sgi.com>
References: <1312993670-23999-1-git-send-email-holt@sgi.com>
	<1312993670-23999-5-git-send-email-holt@sgi.com>
	<8E5FA886-038D-4DF4-8A54-DD60188A21A2@kernel.crashing.org>
	<4E42CB01.7030700@grandegger.com>
	<634AB7A6-1CDA-41B3-8A5D-01F29EF01521@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <634AB7A6-1CDA-41B3-8A5D-01F29EF01521@kernel.crashing.org>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2011 at 11:46:27PM -0500, Kumar Gala wrote:
> 
> On Aug 10, 2011, at 1:16 PM, Wolfgang Grandegger wrote:
> 
> > On 08/10/2011 07:01 PM, Kumar Gala wrote:
> >> 
> >> On Aug 10, 2011, at 11:27 AM, Robin Holt wrote:
> >> 
> >>> I added a simple clock source for the p1010rdb so the flexcan driver
> >>> could determine a clock frequency.  The p1010 flexcan device only has
> >>> an oscillator of system bus frequency divided by 2.
> >>> 
> >>> Signed-off-by: Robin Holt <holt@sgi.com>
> >>> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>,
> >>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>,
> >>> Cc: U Bhaskar-B22300 <B22300@freescale.com>
> >>> Cc: socketcan-core@lists.berlios.de,
> >>> Cc: netdev@vger.kernel.org,
> >>> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> >>> Cc: Kumar Gala <galak@kernel.crashing.org>
> >>> ---
> >>> arch/powerpc/platforms/85xx/Kconfig    |    2 +
> >>> arch/powerpc/platforms/85xx/Makefile   |    2 +
> >>> arch/powerpc/platforms/85xx/clock.c    |   52 ++++++++++++++++++++++++++++++++
> >>> arch/powerpc/platforms/85xx/p1010rdb.c |    8 +++++
> >>> 4 files changed, 64 insertions(+), 0 deletions(-)
> >>> create mode 100644 arch/powerpc/platforms/85xx/clock.c
> >> 
> >> I dont understand how mpc85xx_clk_functions() ends up being associated with the frequency the flexcan is running at.
> > 
> > The function mpc85xx_clk_get_rate() returns "fsl_get_sys_freq() / 2" for
> > Flexcan devices.
> > 
> >> This either seems to global or I'm missing something.
> > 
> > This patch extends the existing Flexcan platform driver for ARM for the
> > PowerPC using the device tree. Due to the nice integration of the device
> > tree (of-platform) into the platform driver and devices, the difference
> > are quite small (see patches 1..3). Apart from the endianess issue, only
> > the clock needs to be handled in a common way. As ARM already uses the
> > clk interface, we found it straight-forward to implement it for the
> > P1010, or more general for the 85xx, as well, instead of using an
> > additional helper function.
> 
> I see, that.  What concerns me is there are numerous clocks /
> frequencies that exist inside a MPC85xx/P1010 SOC.  The code I'm seeing
> does NOT seem to do anything to relate this clock JUST to the flexcan.

        if (!dev->of_node ||
            !of_device_is_compatible(dev->of_node, "fsl,flexcan"))
                return ERR_PTR(-ENOENT);

That should relate it just to flexcan, right?  Plus it has the added
benefit of being a baby-step in the direction of implementing a clkdev
type thing for powerpc which did look fairly slick to me, but I may
be confused.

It sounds like Wolfgang is defering to you.  Give it an honest evaluation
and tell me which direction you would like me to go.  I don't have a
strong preference either way.  The alternative I gave to Wolfgang of
using a flexcan property to avoid needing any clk_get_rate seems fairly
hackish at this point, but I have had more time to get used to the
'hack in a 85xx clock' method.

Thanks,
Robin
