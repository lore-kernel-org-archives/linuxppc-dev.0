Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B92892C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 17:02:06 +1000 (EST)
Message-ID: <1366008995.24994.25.camel@pasglop>
Subject: Re: [RFC PATCH v2 3/4] powerpc: Don't bolt the hpte in
 kernel_map_linear_page()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Mon, 15 Apr 2013 08:56:35 +0200
In-Reply-To: <20130415035031.GA7494@iris.ozlabs.ibm.com>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1365733021-28912-4-git-send-email-zhong@linux.vnet.ibm.com>
 <20130415035031.GA7494@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-04-15 at 13:50 +1000, Paul Mackerras wrote:
> On Fri, Apr 12, 2013 at 10:16:59AM +0800, Li Zhong wrote:
> > It seems that in kernel_unmap_linear_page(), it only checks whether there
> > is a map in the linear_map_hash_slots array, so seems we don't need bolt
> > the hpte.
> 
> I don't exactly understand your rationale here, but I don't think it's
> safe not to have linear mapping pages bolted.  Basically, if a page
> will be used in the process of calling hash_page to demand-fault an
> HPTE into the hash table, then that page needs to be bolted, otherwise
> we can get an infinite recursion of HPT misses.  That includes all
> kernel stack pages, among other things, so I think we need to leave
> the HPTE_V_BOLTED in there.

I suspect Li's confusion comes from the fact that he doesn't realizes
that we might evict random hash slots. If the linear mapping hash
entries could only be thrown out via kernel_unmap_linear_page() then his
comment would make sense. However this isn't the case.

Li: When faulting something in, if both the primary and secondary
buckets are full, we "somewhat randomly" evict the content of a slot and
replace it. However we only do that on non-bolted slots.

This is why the linear mapping (and the vmemmap) must be bolted.

Cheers,
Ben.
