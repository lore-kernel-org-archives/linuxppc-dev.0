Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 276C0B71A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 08:04:24 +1100 (EST)
Message-ID: <1328735054.2903.29.camel@pasglop>
Subject: Re: tlb flushing on Power
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Date: Thu, 09 Feb 2012 08:04:14 +1100
In-Reply-To: <4F32B354.7030306@linux.vnet.ibm.com>
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com> <1327613953.24487.9.camel@pasglop>
 <4F32B354.7030306@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nitin Gupta <ngupta@vflare.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> You can look at https://lkml.org/lkml/2012/1/9/389 in zsmalloc-main.c,
> zs_[un]map_object() functions for the currently uses of set_pte() and
> __flush_tlb_one().
> 
> > set_pte() is long gone on all archs really (or if it's still there it's
> > not meant to be used as is), use set_pte_at().
> 
> Problem with set_pte_at() for us is that we don't have an mm_struct to pass
> because the mapping is not for a userspace process but for the kernel itself.

Then use init_mm

> However, I do think this is the portable function we need to be using. Just
> need to figure out what to pass in for the mm_struct param.
> 
> > __flush_tlb_one() doesn't mean anything as an arch independent
> > functionality. We have a local_flush_tlb_page() that -might- do what you
> > want but why in hell is that patch not using proper existing
> > interfaces ?
> 
> flush_tlb_page() is the portable function we should be using.  However,
> again, it requires a vma_area_struct.  I'm not sure what we should be
> passing there.

Do you need this to be CPU local flush or global ? In the later, 
flush_tlb_kernel_range() is the right API.

If you want per-cpu, we'll have to add a new arch hook.

Cheers,
Ben.
