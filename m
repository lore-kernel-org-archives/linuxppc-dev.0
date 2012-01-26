Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BEEE2100810
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 08:39:25 +1100 (EST)
Message-ID: <1327613953.24487.9.camel@pasglop>
Subject: Re: tlb flushing on Power
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2012 08:39:13 +1100
In-Reply-To: <4F216620.2010509@linux.vnet.ibm.com>
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-01-26 at 08:41 -0600, Brian King wrote:
> CC'ing linuxppc-dev...
> 
> 
> On 01/26/2012 08:18 AM, Seth Jennings wrote:
> > Hey Dave,
> > 
> > So I submitted the zsmalloc patches to lkml at the beginning
> > of the year
> > 
> > https://lkml.org/lkml/2012/1/9/389
> > 
> > I found there are two functions Nitin used in the mapping
> > functions that are not supported in the powerpc arch:
> > set_pte() and __flush_tlb_one().

 .../...

The arch management of page tables can be tricky indeed :-) I need to
have a better understanding of what you are doing to see how I can try
to adapt it to power.

set_pte() is long gone on all archs really (or if it's still there it's
not meant to be used as is), use set_pte_at().

__flush_tlb_one() doesn't mean anything as an arch independent
functionality. We have a local_flush_tlb_page() that -might- do what you
want but why in hell is that patch not using proper existing
interfaces ?

Can you explain to me a bit more the whole business in this patch set
about doing kmap_atomic() vs. manually trying to populate the PTEs ? Why
not just use two kmap atomic entries ? If interrupts are disabled
kmap_atomic() should give you contiguous ones I suppose (unless NMIs are
allowed to use kmap_atomic, are they ?)

Cheers,
Ben.
