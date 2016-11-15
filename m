Return-Path: <lsorense@csclub.uwaterloo.ca>
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca
 [129.97.134.17])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJCSM2GNzzDvj0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 03:26:10 +1100 (AEDT)
Date: Tue, 15 Nov 2016 11:26:05 -0500
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mathieu Malaterre <malat@debian.org>, linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] Fix loading of module radeonfb on PowerMac
Message-ID: <20161115162605.GI1465@csclub.uwaterloo.ca>
References: <1479153557-20849-1-git-send-email-malat@debian.org>
 <c447ef6d-adf0-651f-e7a6-5f340e957df5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c447ef6d-adf0-651f-e7a6-5f340e957df5@ti.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 15, 2016 at 01:46:10PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 14/11/16 21:59, Mathieu Malaterre wrote:
> > When the linux kernel is build with (typical kernel ship with Debian
> > installer):
> > 
> > CONFIG_FB_OF=y
> > CONFIG_VT_HW_CONSOLE_BINDING=y
> > CONFIG_FB_RADEON=m
> > 
> > The offb driver takes precedence over module radeonfb. It is then
> > impossible to load the module, error reported is:
> > 
> > [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> > [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
> > [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> > [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
> > 
> > This patch reproduce the behavior of the module radeon, so as to make it
> > possible to load radeonfb when offb is first loaded.
> > 
> > It should be noticed that `offb_destroy` is never called which explain the
> > need to skip error detection on the radeon side.
> > 
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > Link: https://bugs.debian.org/826629#57
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=119741
> > Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> > ---
> 
> Please always have a changelog in patch new revisions. For individual
> patches, you can insert the changes here.
> 
> >  drivers/video/fbdev/aty/radeon_base.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> > index 218339a..84d634b 100644
> > --- a/drivers/video/fbdev/aty/radeon_base.c
> > +++ b/drivers/video/fbdev/aty/radeon_base.c
> > @@ -2259,6 +2259,22 @@ static struct bin_attribute edid2_attr = {
> >  	.read	= radeon_show_edid2,
> >  };
> >  
> > +static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
> > +{
> > +	struct apertures_struct *ap;
> > +
> > +	ap = alloc_apertures(1);
> > +	if (!ap)
> > +		return -ENOMEM;
> > +
> > +	ap->ranges[0].base = pci_resource_start(pdev, 0);
> > +	ap->ranges[0].size = pci_resource_len(pdev, 0);
> > +
> > +	remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
> > +	kfree(ap);
> > +
> > +	return 0;
> > +}
> >  
> >  static int radeonfb_pci_register(struct pci_dev *pdev,
> >  				 const struct pci_device_id *ent)
> > @@ -2314,19 +2330,27 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
> >  	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
> >  	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
> >  
> > +	ret = radeon_kick_out_firmware_fb(pdev);
> > +	if (ret)
> > +		return ret;
> > +
> >  	/* request the mem regions */
> >  	ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
> >  	if (ret < 0) {
> >  		printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
> >  			pci_name(rinfo->pdev));
> > +#ifndef CONFIG_PPC
> >  		goto err_release_fb;
> > +#endif
> 
> If this is not a problem on PPC, the kernel shouldn't print an error either.
> 
> >  	}
> >  
> >  	ret = pci_request_region(pdev, 2, "radeonfb mmio");
> >  	if (ret < 0) {
> >  		printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
> >  			pci_name(rinfo->pdev));
> > +#ifndef CONFIG_PPC
> >  		goto err_release_pci0;
> > +#endif
> 
> Same here.
> 
> >  	}
> >  
> >  	/* map the regions */
> > @@ -2511,10 +2535,12 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
> >  	iounmap(rinfo->mmio_base);
> >  err_release_pci2:
> >  	pci_release_region(pdev, 2);
> > +#ifndef CONFIG_PPC
> >  err_release_pci0:
> >  	pci_release_region(pdev, 0);
> >  err_release_fb:
> >          framebuffer_release(info);
> > +#endif
> >  err_disable:
> >  err_out:
> >  	return ret;
> > 
> 
> So I don't quite follow what's going on here. Why the CONFIG_PPC
> conditionals? Is this problem only with OFFB and only with PPC?

I don't think so.  I am no convinced the pci_request_region even serves
a purpose.  Certainly a number of the other drivers don't even bother
doing it.

The problem is that offb does do it, and radeon_fb tries to do it,
and since one is trying to take over from the other, it can't do that
because the area is already reserved.

> And I think the code itself should have comments on this rather strange
> behavior: the driver fails to get HW resources, but decides to ignore
> the failure on PPC.

It seems the simpler answer is to just not do it at all.

Now if some architectures require you to do it (no idea), then that
could be an issue.

Looking at all the other FB drivers, none of the ones that support
kicking out another driver to takeover call pci_request_region.
The ones that do call it all appear to be older drivers, likely not
updated much lately.

-- 
Len Sorensen
