Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97A951A0593
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:57:48 +1100 (AEDT)
Message-ID: <1457528262.10966.1.camel@ellerman.id.au>
Subject: Re: [v6,12/20] cxl: Add guest-specific code
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com,  linuxppc-dev@lists.ozlabs.org
Date: Wed, 09 Mar 2016 23:57:42 +1100
In-Reply-To: <20160309124238.37FD414032B@ozlabs.org>
References: <20160309124238.37FD414032B@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-09 at 23:42 +1100, Michael Ellerman wrote:
> On Fri, 2016-04-03 at 11:26:36 UTC, Frederic Barrat wrote:
> > From: Christophe Lombard <clombard@linux.vnet.ibm.com>
> > diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
> > index be2ac5c..a3d4bef 100644
> > --- a/drivers/misc/cxl/Makefile
> > +++ b/drivers/misc/cxl/Makefile
> > @@ -4,6 +4,7 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
> >  cxl-y				+= main.o file.o irq.o fault.o native.o
> >  cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
> >  cxl-y				+= vphb.o api.o
> > +cxl-y				+= guest.o of.o hcalls.o
> >  obj-$(CONFIG_CXL)		+= cxl.o
> >  obj-$(CONFIG_CXL_BASE)		+= base.o
>
> This breaks the (newly added[1]) powernv_defconfig. ie. CONFIG_POWERNV=y, CONFIG_PPC_PSERIES=n.

That footnote was meant to be a link to the powernv_defconfig patch:

  https://patchwork.ozlabs.org/patch/587157/

And also here's the full build failure report:

  http://kisskb.ellerman.id.au/kisskb/buildresult/12629380/

It's rebuliding now with that fixup patch, the result should appear here:

  http://kisskb.ellerman.id.au/kisskb/buildresult/12629513/

cheers
