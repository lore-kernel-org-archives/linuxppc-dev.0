Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43400B6F92
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 05:04:45 +1000 (EST)
Date: Tue, 14 Jun 2011 14:04:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: Steve Best <sfbest@us.ibm.com>
Subject: Re: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM
	checking
Message-ID: <20110614140431.31ae4357@schlenkerla.am.freescale.net>
In-Reply-To: <1308075422.13495.8.camel@dhcp-100-2-27.bos.redhat.com>
References: <20110614165011.23034.66685.sendpatchset@squad5-lp1.lab.bos.redhat.com>
	<1308072658.2452.10.camel@orca.stoopid.dyndns.org>
	<1308075422.13495.8.camel@dhcp-100-2-27.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Jun 2011 14:17:01 -0400
Steve Best <sfbest@us.ibm.com> wrote:

> On Tue, 2011-06-14 at 12:30 -0500, Nathan Lynch wrote:
> > Hi Steve,
> > 
> > On Tue, 2011-06-14 at 12:58 -0400, Steve Best wrote:
> > > +/*
> > > + * devmem_is_allowed() checks to see if /dev/mem access to a certain address
> > > + * is valid. The argument is a physical page number.
> > > + *
> > > + * On PowerPC, access has to be given to data regions used by X. We have to
> > > + * disallow access to device-exclusive MMIO regions and system RAM. 
> > > + */
> > > +int devmem_is_allowed(unsigned long pfn)
> > > +{
> > > +        if ((pfn >= 57360 || pfn <= 57392))
> > > +                return 1;
> > 
> > That seems... fragile.  Where do these numbers come from, and are they
> > appropriate for all platforms and configurations?
> 
> This is the range I got from testing pseries blades and servers. maybe
> there is a better way to get this range anyone know of a way?

Use iomem_is_exclusive(), as other architectures (e.g. x86, arm) do.

Anything else is both platform-specific, and inappropriate hardcoding of
policy.

-Scott
