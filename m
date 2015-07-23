Return-Path: <rientjes@google.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 697351A0709
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2015 06:27:21 +1000 (AEST)
Received: by pacan13 with SMTP id an13so1649121pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 13:27:17 -0700 (PDT)
Date: Thu, 23 Jul 2015 13:27:15 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Christoph Lameter <cl@linux.com>
cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 cbe-oss-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Mel Gorman <mgorman@suse.de>, Greg Thelen <gthelen@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Cliff Whickman <cpw@sgi.com>,
 Robin Holt <robinmholt@gmail.com>
Subject: Re: [PATCH] mm: rename and document alloc_pages_exact_node
In-Reply-To: <alpine.DEB.2.11.1507230855510.12258@east.gentwo.org>
Message-ID: <alpine.DEB.2.10.1507231322510.31024@chino.kir.corp.google.com>
References: <1437486951-19898-1-git-send-email-vbabka@suse.cz>
 <alpine.DEB.2.10.1507211428160.3833@chino.kir.corp.google.com>
 <55AF7F64.1040602@suse.cz>
 <alpine.DEB.2.10.1507221445130.21468@chino.kir.corp.google.com>
 <alpine.DEB.2.11.1507230855510.12258@east.gentwo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Jul 2015, Christoph Lameter wrote:

> > The only possible downside would be existing users of
> > alloc_pages_node() that are calling it with an offline node.  Since it's a
> > VM_BUG_ON() that would catch that, I think it should be changed to a
> > VM_WARN_ON() and eventually fixed up because it's nonsensical.
> > VM_BUG_ON() here should be avoided.
> 
> The offline node thing could be addresses by using numa_mem_id()?
> 

I was concerned about any callers that were passing an offline node, not 
NUMA_NO_NODE, today.  One of the alloc-node functions has a VM_BUG_ON() 
for it, the other silently calls node_zonelist() on it.

I suppose the final alloc_pages_node() implementation could be

        if (nid == NUMA_NO_NODE || VM_WARN_ON(!node_online(nid)))
                nid = numa_mem_id();

        VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
        return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));

though.
