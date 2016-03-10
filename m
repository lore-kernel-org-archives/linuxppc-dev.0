Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 851171A0007
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 14:24:31 +1100 (AEDT)
Message-ID: <1457580271.26279.8.camel@neuling.org>
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
From: Michael Neuling <mikey@neuling.org>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, Ian Munsie
 <imunsie@au1.ibm.com>,  Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Matt Ochs <mrochs@us.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Thu, 10 Mar 2016 14:24:31 +1100
In-Reply-To: <87a8m7iunv.fsf@vajain21.in.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <87a8m7iunv.fsf@vajain21.in.ibm.com>
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

On Wed, 2016-03-09 at 20:07 +0530, Vaibhav Jain wrote:
> Hi Ian,
>=20
> Sorry for getting into this discussion late. I have few suggestions.
>=20
> Ian Munsie <imunsie@au1.ibm.com> writes:
> >=20
> > diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
> > index 8756d06..560412c 100644
> > --- a/drivers/misc/cxl/Kconfig
> > +++ b/drivers/misc/cxl/Kconfig
> > @@ -15,12 +15,17 @@ config CXL_EEH
> >  	bool
> >  	default n
> > =20
> > +config CXL_AFU_DRIVER_OPS
> > +	bool
> > +	default n
> > +
> >  config CXL
> >  	tristate "Support for IBM Coherent Accelerators (CXL)"
> >  	depends on PPC_POWERNV && PCI_MSI && EEH
> >  	select CXL_BASE
> >  	select CXL_KERNEL_API
> >  	select CXL_EEH
> > +	select CXL_AFU_DRIVER_OPS
> I suggest wrapping the driver_ops struct definition and other related
> functions inside a #ifdef CONFIG_CXL_AFU_DRIVER_OPS.

These are here to enable the feature in other drivers.  So the cxlflash
(or whoever) can put their code in via the linux-scsi tree but that new
piece is only enabled when CXL_AFU_DRIVER_OPS is present (ie. when
merged upstream).  But if it's not, their code can still compile. =20

Hence their code compiles in linux-scsi and our code compiles in linux
-ppc, but only once they're together do they actually enable the full
feature.  We don't have a nasty dependency of linux-scsi having to pull
in linux-ppc or visa versa before the merge window.  Everyone works
independently and it all gets fixed in linus tree.

Eventually, when everyone has the all the code in merged upstream, we
can remove these config options.  We should be able to remove
 CXL_KERNEL_API and CXL_EEH now actually!

So no, we shouldn't wrap the actual code.

Mikey
