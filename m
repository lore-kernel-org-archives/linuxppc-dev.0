Return-Path: <bzolnier@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190])
	by ozlabs.org (Postfix) with ESMTP id BC92DDDE34
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 23:20:28 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so2660138rnf.15
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 04:20:26 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH 09/18] ide: rework PowerMac media-bay support
Date: Wed, 13 Feb 2008 13:26:02 +0100
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<20080208004523.17746.24578.sendpatchset@localhost.localdomain>
	<1202887776.7971.19.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1202887776.7971.19.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802131326.02783.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

On Wednesday 13 February 2008, Michael Ellerman wrote:
> On Fri, 2008-02-08 at 01:45 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Rework PowerMac media-bay support in such way that instead of
> > un/registering the IDE interface we un/register IDE devices:
> > 
> > * Add ide_port_scan() helper for probing+registerering devices on a port.
> > 
> > * Rename ide_port_unregister_devices() to __ide_port_unregister_devices().
> > 
> > * Add ide_port_unregister_devices() helper for unregistering devices on a port.
> > 
> > * Add 'ide_hwif_t *cd_port' to 'struct media_bay_info', pass 'hwif' instead
> >   of hwif->index to media_bay_set_ide_infos() and use it to setup 'cd_port'.
> > 
> > * Use ide_port_unregister_devices() instead of ide_unregister()
> >   and ide_port_scan() instead of ide_register_hw() in media_bay_step().
> > 
> > * Unexport ide_register_hw() and make it static.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-probe.c        |   18 ++++++++++++++++++
> >  drivers/ide/ide.c              |   22 ++++++++++++++++------
> >  drivers/ide/ppc/pmac.c         |    3 ++-
> >  drivers/macintosh/mediabay.c   |   17 +++++++----------
> >  include/asm-powerpc/mediabay.h |    4 +++-
> >  include/linux/ide.h            |    6 ++----
> >  6 files changed, 48 insertions(+), 22 deletions(-)
> 
> > Index: b/include/asm-powerpc/mediabay.h
> > ===================================================================
> > --- a/include/asm-powerpc/mediabay.h
> > +++ b/include/asm-powerpc/mediabay.h
> > @@ -22,10 +22,12 @@ int check_media_bay(struct device_node *
> >  /* Number of bays in the machine or 0 */
> >  extern int media_bay_count;
> >  
> > +#ifdef CONFIG_BLK_DEV_IDE_PMAC

Does adding:

#include <linux/ide.h>

after ifdef help?

> >  int check_media_bay_by_base(unsigned long base, int what);
> >  /* called by IDE PMAC host driver to register IDE controller for media bay */
> >  int media_bay_set_ide_infos(struct device_node *which_bay, unsigned long base,
> > -			    int irq, int index);
> > +			    int irq, ide_hwif_t *hwif);
> > +#endif
> >  
> >  #endif /* __KERNEL__ */
> >  #endif /* _PPC_MEDIABAY_H */
> 
> This hunk breaks pmac32_defconfig for me.
> 
> include2/asm/mediabay.h:29: error: syntax error before 'ide_hwif_t'
> make[3]: *** [arch/powerpc/platforms/powermac/setup.o] Error 1
> make[2]: *** [arch/powerpc/platforms/powermac] Error 2
> make[1]: *** [arch/powerpc/platforms] Error 2
> make: *** [sub-make] Error 2
> 
> cheers
