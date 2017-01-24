Return-Path: <groug@kaod.org>
Received: from 6.mo69.mail-out.ovh.net (6.mo69.mail-out.ovh.net
 [46.105.50.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v79FG15PkzDqRP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 01:15:29 +1100 (AEDT)
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 38CAF1803D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 12:48:11 +0100 (CET)
Date: Tue, 24 Jan 2017 12:48:05 +0100
From: Greg Kurz <groug@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Frederic
 Barrat <fbarrat@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH] cxl: drop unused header asm/pnv-pci.h
Message-ID: <20170124124805.6b8e798f@bahia.lan>
In-Reply-To: <87k29kaih9.fsf@concordia.ellerman.id.au>
References: <148482301037.30441.14177888563610790803.stgit@bahia>
 <87k29kaih9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 24 Jan 2017 20:57:06 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Greg Kurz <groug@kaod.org> writes:
> 
> > The kernel API does not use anything from this header file.  
> 
> That's actually hard to prove in general, because pnv-pci.h includes
> linux/pci.h, linux/pci_hotplug.h, linux/irq.h, misc/cxl-base.h and
> asm/opal-api.h. At least four of which aren't included directly by
> api.c.
> 
> But I'll take you word for it :)
> 

Sorry for the lack of details...

api.c doesn't do anything related to pci hotplug, nor to OPAL. This
happens in pci.c.

It includes cxl.h which includes misc/cxl-base.h.

The only generic irq bits are irq_hw_number_t, provided by linux/types.h,
and irq_find_mapping(), provided by linux/irqdomain.h, which is included
by misc/cxl-base.h -> linux/interrupt.h -> asm/irq.h.

Cheers (and congrats :)

--
Greg


> cheers
> 
> > diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> > index 1b35e33d2434..bcc030eacab7 100644
> > --- a/drivers/misc/cxl/api.c
> > +++ b/drivers/misc/cxl/api.c
> > @@ -11,7 +11,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/file.h>
> >  #include <misc/cxl.h>
> > -#include <asm/pnv-pci.h>
> >  #include <linux/msi.h>
> >  #include <linux/module.h>
> >  #include <linux/mount.h>  
