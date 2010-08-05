Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B28C7B6EED
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 04:05:09 +1000 (EST)
Date: Thu, 5 Aug 2010 11:02:11 -0700
From: Greg KH <gregkh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] driver core: Add ability for arch code to setup
	pdev_archdata
Message-ID: <20100805180211.GA12687@suse.de>
References: <1281021347-1278-1-git-send-email-galak@kernel.crashing.org>
	<1281021347-1278-2-git-send-email-galak@kernel.crashing.org>
	<20100806014351.a3bddf08.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100806014351.a3bddf08.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 06, 2010 at 01:43:51AM +1000, Stephen Rothwell wrote:
> Hi Kumar,
> 
> On Thu,  5 Aug 2010 10:15:45 -0500 Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/err.h>
> >  #include <linux/slab.h>
> >  #include <linux/pm_runtime.h>
> > +#include <asm/platform_device.h>
> >  
> >  #include "base.h"
> >  
> > @@ -170,6 +171,9 @@ struct platform_device *platform_device_alloc(const char *name, int id)
> >  		pa->pdev.id = id;
> >  		device_initialize(&pa->pdev.dev);
> >  		pa->pdev.dev.release = platform_device_release;
> > +#ifdef ARCH_HAS_PDEV_ARCHDATA_SETUP
> > +		arch_setup_pdev_archdata(&pa->pdev);
> > +#endif
> >  	}
> >  
> >  	return pa ? &pa->pdev : NULL;
> > diff --git a/include/asm-generic/platform_device.h b/include/asm-generic/platform_device.h
> > new file mode 100644
> > index 0000000..64806dc
> > --- /dev/null
> > +++ b/include/asm-generic/platform_device.h
> > @@ -0,0 +1,7 @@
> > +#ifndef __ASM_GENERIC_PLATFORM_DEVICE_H_
> > +#define __ASM_GENERIC_PLATFORM_DEVICE_H_
> > +/*
> > + * an architecture can override to define arch_setup_pdev_archdata
> > + */
> > +
> > +#endif /* __ASM_GENERIC_PLATFORM_DEVICE_H_ */
> 
> Why not do:
> 
> #include <linux/platform_device.h>
> 
> #ifndef arch_setup_pdev_archdata
> static inline void arch_setup_pdev_archdata(struct platform_device *pdev) { }
> #endif
> 
> in asm-generic/platform-device.h
> 
> and the the call in platform_device_alloc() can be unconditional.  If the arch wants to override arch_setup_pdev_archdata, it defines the function and then does
> 
> #define arch_setup_pdev_archdata arch_setup_pdev_archdata
> 
> before still including asm-generic/platform_device.h

Yes, I'd prefer that method as well.

thanks,

greg k-h
