Return-Path: <srs0=h+48=76=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgf9D3tSszDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:36:16 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xgf9D3H47z8t8Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:36:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xgf9D0D6nz9sPk
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 14:36:15 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S4ZpAm088435
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 00:36:13 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cm2rpj09b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 00:36:13 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 00:36:12 -0400
Date: Sun, 27 Aug 2017 21:36:07 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/12] powerpc/vas: Define helpers to access MMIO
 regions
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <87efs0uxj4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87efs0uxj4.fsf@concordia.ellerman.id.au>
Message-Id: <20170828043607.GB12907@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
> Hi Suka,
> 
> Comments inline.
> 
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> > diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> > index 6156fbe..a3a705a 100644
> > --- a/arch/powerpc/platforms/powernv/vas-window.c
> > +++ b/arch/powerpc/platforms/powernv/vas-window.c
> > @@ -9,9 +9,182 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +#include <linux/io.h>
> >  
> >  #include "vas.h"
> >  
> > +/*
> > + * Compute the paste address region for the window @window using the
> > + * ->paste_base_addr and ->paste_win_id_shift we got from device tree.
> > + */
> > +void compute_paste_address(struct vas_window *window, uint64_t *addr, int *len)
> > +{
> > +	uint64_t base, shift;
> 
> Please use the kernel types, so u64 here.

Ok.

> 
> > +	int winid;
> > +
> > +	base = window->vinst->paste_base_addr;
> > +	shift = window->vinst->paste_win_id_shift;
> > +	winid = window->winid;
> > +
> > +	*addr  = base + (winid << shift);
> > +	if (len)
> > +		*len = PAGE_SIZE;
> 
> Having multiple output parameters makes for a pretty awkward API. Is it
> really necesssary given len is a constant PAGE_SIZE anyway.
> 
> If you didn't return len, then you could just make the function return
> the addr, and you wouldn't need any output parameters.

I agree, I went back and forth on it. I was trying to avoid callers
making assumptions on the size. But since there are just a couple
of places, I guess we could have them assume PAGE_SIZE.

> 
> One of the callers that passes len is unmap_paste_region(), but that
> is a bit odd. It would be more natural I think if once a window is
> mapped it knows its size. Or if the mapping will always just be one page
> then we can just know that.

Agree, since the len values are constant I was trying to avoid saving
them in each of the 64K windows - so the compute during unmap. Will change
to assume  PAGE_SIZE.

Also agree with other comments here.
