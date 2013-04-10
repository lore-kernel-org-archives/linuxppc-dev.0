Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0554E2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 15:56:54 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 15:54:42 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B7CEF357804A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 15:56:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A5gpEr6750626
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 15:42:52 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A5uH50028247
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 15:56:18 +1000
Message-ID: <1365573371.10616.16.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH v2 6/6] powerpc: Use generic code for exception
 handling
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 10 Apr 2013 13:56:11 +0800
In-Reply-To: <1365571931.10616.12.camel@ThinkPad-T5421>
References: <1364551221-23177-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1364551221-23177-7-git-send-email-zhong@linux.vnet.ibm.com>
 <20130410045659.GB15929@concordia>
 <1365571931.10616.12.camel@ThinkPad-T5421>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fweisbec@gmail.com, paulmck@linux.vnet.ibm.com, paulus@samba.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-04-10 at 13:32 +0800, Li Zhong wrote:
> On Wed, 2013-04-10 at 14:56 +1000, Michael Ellerman wrote:
> > On Fri, Mar 29, 2013 at 06:00:21PM +0800, Li Zhong wrote:
> > > After the exception handling moved to generic code, and some changes in
> > ...
> > > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> > > index 360fba8..eeab30f 100644
> > > --- a/arch/powerpc/mm/hash_utils_64.c
> > > +++ b/arch/powerpc/mm/hash_utils_64.c
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/init.h>
> > >  #include <linux/signal.h>
> > >  #include <linux/memblock.h>
> > > +#include <linux/context_tracking.h>
> > >  
> > >  #include <asm/processor.h>
> > >  #include <asm/pgtable.h>
> > > @@ -56,7 +57,6 @@
> > >  #include <asm/fadump.h>
> > >  #include <asm/firmware.h>
> > >  #include <asm/tm.h>
> > > -#include <asm/context_tracking.h>
> > >  
> > >  #ifdef DEBUG
> > >  #define DBG(fmt...) udbg_printf(fmt)
> > > @@ -919,13 +919,17 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
> > >  	const struct cpumask *tmp;
> > >  	int rc, user_region = 0, local = 0;
> > >  	int psize, ssize;
> > > +	enum ctx_state prev_state;
> > > +
> > > +	prev_state = exception_enter();
> > >  
> > >  	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
> > >  		ea, access, trap);
> > >  
> > >  	if ((ea & ~REGION_MASK) >= PGTABLE_RANGE) {
> > >  		DBG_LOW(" out of pgtable range !\n");
> > > - 		return 1;
> > > +		rc = 1;
> > > +		goto exit;
> > >  	}
> > >  
> > >  	/* Get region & vsid */
> > 
> > This no longer applies on mainline, please send an updated version.
> 
> Yes, for current mainline (powerpc tree), only previous five patches
> could be applied. The dependency of this patch is current in tip tree,
> and seems would be in for 3.10.
> 
> There are some more details in the cover letter (#0):
> 
> "I assume these patches would get in through powerpc tree, so I didn't
> combine the new patch (#6) with the original one (#2). So that if
> powerpc tree picks these, it could pick the first five patches, and
> apply patch #6 later when the dependency enters into powerpc tree (maybe
> on some 3.10-rcs)."

And I will send an updated version of this one when I see the dependency
commits in mainline. 

Thanks, Zhong

> Thanks, Zhong
> 
> > cheers
> > 
> 
