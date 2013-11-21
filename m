Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 375302C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 20:22:08 +1100 (EST)
Date: Thu, 21 Nov 2013 10:21:58 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 01/17] powerpc/fsl-pci: improve clock API use
Message-ID: <20131121092158.GV17929@book.gsilab.sittig.org>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
 <1384729577-7336-2-git-send-email-gsi@denx.de>
 <1384900872.1403.381.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384900872.1403.381.camel@snotra.buserror.net>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Minghuan Lian <Minghuan.Lian@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ summary:  the PCI driver change of mine looks innocent yet
  raises questions (not for the current situation, but in the
  face of potential future changes); these concerns were not
  introduced by me but were "inherited" from the former
  implementation, as I understand it

  let's drop my patch now, have the Layerscape series show up,
  and add proper clock handling to the PCI peripheral driver
  later, while in the meantime either nothing needs to be done
  (83xx, 85xx, 86xx) or workarounds do their job (512x)

  should 8xxx platforms want to introduce CCF support, they can
  and may apply the same workaround as 512x ]

On Tue, Nov 19, 2013 at 16:41 -0600, Scott Wood wrote:
> 
> On Mon, 2013-11-18 at 00:06 +0100, Gerhard Sittig wrote:
> > make the Freescale PCI driver get, prepare and enable the PCI clock
> > during probe(); the clock gets put upon device shutdown by the devm
> > approach
> > 
> > clock lookup is non-fatal as not all platforms may provide clock specs
> > in their device tree or implement a device tree based clock provider,
> > but failure to enable clocks after successful lookup is fatal
> > 
> > the driver appears to not have a remove() routine, so no reference to
> > the clock is kept during use, and the clock isn't released (the devm
> > approach will put the clock, but it won't get disabled or unprepared)
> > 
> > the 85xx/86xx platforms go through the probe() routine, where clock
> > lookup occurs and the clock gets acquired if one was specified; the
> > 512x/83xx platforms don't pass through probe() but instead directly call
> > the add_bridge() routine at a point in time where the clock provider has
> > not been setup yet even if the platform implements one -- add comments
> > to the code paths as a reminder for the potential need of a workaround
> > in the platform's clock driver, and to keep awareness if code should get
> > re-arranged or moved
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Kumar Gala <galak@kernel.crashing.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > ---
> >  arch/powerpc/sysdev/fsl_pci.c |   52 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> 
> Please coordinate this change with Minghuan Lian's patchset (posted Oct
> 23) to move the bulk of this driver outside of arch/powerpc.

Ah, you Cc'ed him, good.  I spotted an earlier RFC submission,
but somehow missed more recent updates.  With the move of the
fsl_pci driver into pcie my comments partially turn into lies as
the driver will grow .remove() support.

What's necessary upon remove is along the lines of b3bfce2b "i2c:
mpc: cleanup clock API use" or 2771399a "fs_enet: cleanup clock
API use" (when clocks were not acquired at all) or something like
180890c7 "mtd: mpc5121_nfc: cleanup clock API use" or 7282bdb2
"USB: fsl-mph-dr-of: cleanup clock API use" (when clocks were
acquired but not fully prepared).  With the introduction of
remove support this is just about keeping a reference to the
acquired clock to disable and unprepare it, putting the clock is
done by the devm mechanism.

For the time being I'd suggest to skip this PCI driver clock API
use cleanup patch of mine if the Layerscape PCI patch is more
probable to make it into mainline, and I shall re-submit after
the Layerscape patch was applied.

If my patch is taken before the Layerscape change, then the
latter would have to "postprocess" and update mine.  Which would
be straight forward but might be out of the scope of a "move
code" commit.

I'm fine with either approach, dropping my PCI patch now, or
applying it and adding PCI clock release to .remove within the
Layerscape series.


> > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> > index ccfb50ddfe38..efa0916f61b6 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -17,6 +17,8 @@
> >   * Free Software Foundation;  either version 2 of the  License, or (at your
> >   * option) any later version.
> >   */
> > +
> > +#include <linux/clk.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pci.h>
> >  #include <linux/delay.h>
> > @@ -755,6 +757,32 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
> >  	const int *bus_range;
> >  	int primary;
> >  
> > +	/*
> > +	 * 85xx/86xx platforms take the path through the probe() routine
> > +	 * as one would expect, PCI related clocks get acquired there if
> > +	 * specified
> > +	 *
> > +	 * 83xx/512x _don't_ pass through probe(), this add_bridge()
> > +	 * routine instead is called from within .setup_arch() at a
> > +	 * point in time where clock providers haven't been setup yet;
> > +	 * so clocks cannot get acquired here -- lookup would always
> > +	 * fail even on those platforms which implement the provider
> > +	 *
> > +	 * there is no counterpart for add_bridge() just like there is
> > +	 * no remove() counterpart for probe(), so in either case the
> > +	 * PCI related clock won't get released, and all of the
> > +	 * 512x/83xx/85xx/86xx platforms behave in identical ways
> 
> How is it identical if 85xx/86xx will acquire a clock in probe(), but
> 83xx/512x can't acquire it in add_bridge()?
> 
> Could you explain the relevance of releasing clocks here?

The situation I found was that none of the platforms which use
this fsl_pci driver did acquire any PCI related clock, all of
them "just used the hardware" and assumed that "someone" will
have setup and enabled the clock (some boot loader maybe).

The structure of the fsl_pci driver with its attaching but not
detaching from the hardware made things easy.  I assumed that
this is because there may be boot media or mass storage connected
to PCI which you don't want to lose and which you don't want to
disconnect from upon shutdown.

So the previous situation for all platforms is
- 512x, 83xx, 85xx, 86xx:  don't setup the clock, just use the
  hardware, just works


What my PCI driver clock API use cleanup patch does is to add a
clock lookup to the .probe() routine, fail silently if there is
no clock spec or no clock provider, do setup the clock when a
spec was found.

So the intermediate situation for all platforms is
- 512x, 83xx:  initialization in .setup_arch(), call to
  add_bridge(), don't setup the clock, just use the hardware,
  still works
- 85xx, 86xx:  initialization in .probe(), clock lookup, silent
  failure, don't setup the clock, just use the hardware, still
  works


Then CCF support gets added to 512x, including migration support.
The situation then is
- 512x:  .setup_arch calls add_bridge, nothing is done to the
  clock; CCF provider registers the PCI clock item, pre-enables
  the clock item;  late init finds the PCI clock "in use"
  (pre-enabled) and leaves it enabled; things keep working
- 83xx:  .setup_arch and add_bridge, no clock handling, no CCF
  provider either, so no "disable unused" step, all the same
- 85xx, 86xx:  .probe, no clock handling, no CCF "disable
  unused", all the same

Then peripheral drivers get adjusted after CCF has become
available, nothing changes for PCI here.

Then CCF migration support gets removed for 512x.  The situation
is then:
- 512x:  .setup_arch and add_bridge, no clock related setup; CCF
  provider registers PCI clock item, leaves it alone in the
  absence of PCI related OF nodes, pre-enables it in the presence
  of PCI related OF nodes; CCF "disable unuses" leaves PCI clock
  active, PCI still operational
- 83xx, 85xx, 86xx: no change


So before my series, "someone" (a bootloader) sets up the PCI
clock, the driver does nothing with it.

With my series, the CCF provider introduces a PCI clock item, it
gets enabled and remains active, the driver still does nothing to
the clock item.  Those platforms without a CCF provider won't
disable the clock item.

Other series may introduce CCF providers for 83xx/85xx/86xx,
these might apply the same workarounds for migration as the 512x
code does.

Yes, I am aware of CCF code for "corenet".  But my understanding
is that this only manages a few PLLs and only applies to CPU
cores, not to peripherals and the complete clock tree.


> > +	 *
> > +	 * this comment is here to "keep the balance" against the
> > +	 * probe() routine, and as a reminder to acquire clocks if the
> > +	 * add_bridge() call should move to some later point in time
> > +	 *
> > +	 * until then clock providers are expected to work around the
> > +	 * peripheral driver's not acquiring the PCI clock on those
> > +	 * platforms where clock providers exist, while nothing needs to
> > +	 * be done for those platforms without a clock provider
> > +	 */
> 
> What would be involved in moving 83xx/512x to use .probe() as well?

Oh, that's a completely different can of worms.  I dare to judge
what my approach does, as it is minimal and keeps the order of
steps in place.

Rearranging the PCI initialization order is way beyond my
capabilities (both in coding as well as testing).  Considering
that I only noticed rather late that 512x won't pass through
probe() and that I might even have broken compilation with an
early submission, I'd rather not start fiddling with this stuff.
My contribution would just not be helpful.


> >  	is_mpc83xx_pci = 1;
> >  
> >  	if (!of_device_is_available(dev)) {
> > @@ -1086,9 +1114,33 @@ void fsl_pci_assign_primary(void)
> >  
> >  static int fsl_pci_probe(struct platform_device *pdev)
> >  {
> > +	struct clk *clk;
> >  	int ret;
> >  	struct device_node *node;
> >  
> > +	/*
> > +	 * clock lookup is non-fatal since the driver is shared among
> > +	 * platforms and not all of them provide clocks specs in their
> > +	 * device tree, but failure to enable a specified clock is
> > +	 * considered fatal
> > +	 *
> > +	 * note that only the 85xx and 86xx platforms pass through this
> > +	 * probe() routine, while 83xx and 512x directly invoke the
> > +	 * mpc83xx_add_bridge() routine from within .setup_arch() code
> > +	 */
> > +	clk = devm_clk_get(&pdev->dev, "ipg");
> > +	if (!IS_ERR(clk)) {
> > +		ret = clk_prepare_enable(clk);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Could not enable PCI clock\n");
> > +			return ret;
> > +		}
> > +		/*
> > +		 * TODO where to store the 'clk' reference?  there appears
> > +		 * to be no remove() routine which undoes what probe() does
> > +		 */
> > +	}
> 
> There is a .remove(); this driver just doesn't support it.
> 
> As for where to store things, you could turn private_data into a struct
> rather than a direct iomem pointer.  Or just replace the comment with a
> non-TODO statement that says we'll never release the clock because the
> PCI controller driver is non-removable.

Re-considering the above, the most appropriate thing to do may be
to drop my patch now, and see how the Layerscape series evolves.

Once there is a PCI driver which works on all the platforms and
has the probe and remove counterparts, adding proper clock
handling to the peripheral driver is straight forward (along the
lines of the above mentioned i2c and fs_enet changes).


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
