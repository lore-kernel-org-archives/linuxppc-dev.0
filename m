Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FFyp3j3dzDrS3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 07:10:58 +1000 (AEST)
Date: Tue, 18 Sep 2018 16:10:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux@yadro.com,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
Message-ID: <20180918211055.GC13616@bhelgaas-glaptop.roam.corp.google.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com>
 <20180917052800.GA7315@tungsten.ozlabs.ibm.com>
 <6b913e12-e8c8-30c1-5269-3029ddb00a4d@yadro.com>
 <20180917225935.GD54859@bhelgaas-glaptop.roam.corp.google.com>
 <b3963047-e3c1-5612-1bcf-04c9e81dacd2@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b3963047-e3c1-5612-1bcf-04c9e81dacd2@yadro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2018 at 05:01:48PM +0300, Sergey Miroshnichenko wrote:
> On 9/18/18 1:59 AM, Bjorn Helgaas wrote:
> > On Mon, Sep 17, 2018 at 11:55:43PM +0300, Sergey Miroshnichenko wrote:
> >> On 9/17/18 8:28 AM, Sam Bobroff wrote:
> >>> On Fri, Sep 14, 2018 at 07:14:01PM +0300, Sergey Miroshnichenko wrote:
> >>>> Introduce a new command line option "pci=pcie_movable_bars"
> >>>> that indicates support of PCIe hotplug without prior
> >>>> reservation of memory regions by BIOS/bootloader.

> >>> What about devices with drivers that don't have reset_prepare()?  It
> >>> looks like it will just reconfigure them anyway. Is that right?
> >>
> >> It is possible that unprepared driver without these hooks will get BARs
> >> moved, I should put a warning message there. There three ways we can see
> >> to make this safe:
> >>  - add the reset_prepare()/reset_done() hooks to *every* PCIe driver;
> >>  - refuse BAR movement if at least one unprepared driver has been
> >> encountered during rescan;
> >>  - reduce the number of drivers which can be affected to some
> >> controllable value and prepare them on demand.
> >>
> >> Applying the second proposal as a major restriction seems fairly
> >> reasonable, but for our particular setups and use-cases it is probably
> >> too stiff:
> >>  - we've noticed that devices connected directly to the root bridge
> >> don't get moved BARs, and this covers our x86_64 servers: we only
> >> insert/remove devices into "second-level" and "lower" bridges there, but
> >> not root;
> >>  - on PowerNV we have system devices (network interfaces, USB hub, etc.)
> >> grouped into dedicated domain, with all other domains ready for hotplug,
> >> and only these domains can be rescanned.
> >>
> >> With our scenarios currently reduced to these two, we can live with just
> >> a few drivers "prepared" for now: NVME and few Ethernet adapters, this
> >> gives us a possibility to use this feature before "converting" *all* the
> >> drivers, and even have the NVidia cards running on a closed proprietary
> >> driver.
> >>
> >> Should we make this behavior adjustable with something like
> >> "pcie_movable_bars=safe" and "pcie_movable_bars=always" ?
> > 
> > I like the overall idea of this a lot.
> > 
> >   - Why do we need a command line parameter to enable this?  Can't we
> >     do it unconditionally and automatically when it's possible?  We
> >     could have a chicken switch to *disable* it in case this breaks
> >     something horribly, but I would like this functionality to be
> >     always available without a special option.
> 
> After making this feature completely safe we could activate it with the
> existing option "pci=realloc".

That *sounds* good, but in practice it never happens that we decide a
feature is completely safe and somebody makes it the default.  If
we're going to do this, I think we need to commit to making it work
100% of the time, with no option needed.

> >   - I'm not sure the existence of .reset_done() is evidence that a
> >     driver is prepared for its BARs to move.  I don't see any
> >     documentation that refers to BAR movement, and I doubt it's been
> >     tested.  But I only see 5 implementations in the tree, so it'd be
> >     easy to verify.
> 
> You are right, and we should clarify the description:
>  - drivers which have the .reset_done() already - none of them are aware
> of movable BARs yet;
>  - the rest of the drivers should both be able to pause and handle the
> changes in BARs.

This doesn't clarify it for me.  If you want to update all existing
.reset_done() methods so they deal with BAR changes, that would be
fine with me.  That would be done by preliminary patches in the series
that adds the feature.

> >   - I think your second proposal above sounds right: we should regard
> >     any device whose driver lacks .reset_done() as immovable.  We will
> >     likely be able to move some devices but not others.  Implementing
> >     .reset_done() will increase flexibility but it shouldn't be a
> >     requirement for all drivers.
> 
> Thanks for the advice! This is more flexible and doesn't have any
> prerequisites. In this case the greater the "movable"/"immovable" ratio
> of the devices that was working before the hotplug event - the higher
> the probability to free some space for new BARs. But even a single
> "immovable" device at an undesirable place can block the re-arrangement,
> in this case all we can is just give up and print an error message.

Right.  There's nothing we can do about that except make the relevant
drivers smarter.

> This patchset in its current form doesn't support marking a choosen BAR
> as immovable (just releasing all the resources of the root bridge and
> trying to sort and re-assign them back), so I'll have to implement that.

The current IORESOURCE_PCI_FIXED usage is for things that literally
*cannot* be moved because there is no BAR at all (VGA or IDE legacy,
enhanced allocation (see pci_ea_read()) or there's some platform
quirk.

It *might* make sense to also use it for devices where the *driver*
isn't smart enough to deal with moving it, but I'm not sure.  That
would have to be done at driver probe time, I guess.
