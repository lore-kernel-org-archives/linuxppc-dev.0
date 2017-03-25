Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vrCyP15rzzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Mar 2017 08:26:05 +1100 (AEDT)
Date: Sat, 25 Mar 2017 14:25:58 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net
Subject: Re: [v2 0/5] parallelized "struct page" zeroing
Message-ID: <20170325212558.GA1288@bombadil.infradead.org>
References: <1490383192-981017-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490383192-981017-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 24, 2017 at 03:19:47PM -0400, Pavel Tatashin wrote:
> Changelog:
> 	v1 - v2
> 	- Per request, added s390 to deferred "struct page" zeroing
> 	- Collected performance data on x86 which proofs the importance to
> 	  keep memset() as prefetch (see below).
> 
> When deferred struct page initialization feature is enabled, we get a
> performance gain of initializing vmemmap in parallel after other CPUs are
> started. However, we still zero the memory for vmemmap using one boot CPU.
> This patch-set fixes the memset-zeroing limitation by deferring it as well.
> 
> Performance gain on SPARC with 32T:
> base:	https://hastebin.com/ozanelatat.go
> fix:	https://hastebin.com/utonawukof.go
> 
> As you can see without the fix it takes: 97.89s to boot
> With the fix it takes: 46.91 to boot.
> 
> Performance gain on x86 with 1T:
> base:	https://hastebin.com/uvifasohon.pas
> fix:	https://hastebin.com/anodiqaguj.pas
> 
> On Intel we save 10.66s/T while on SPARC we save 1.59s/T. Intel has
> twice as many pages, and also fewer nodes than SPARC (sparc 32 nodes, vs.
> intel 8 nodes).
> 
> It takes one thread 11.25s to zero vmemmap on Intel for 1T, so it should
> take additional 11.25 / 8 = 1.4s  (this machine has 8 nodes) per node to
> initialize the memory, but it takes only additional 0.456s per node, which
> means on Intel we also benefit from having memset() and initializing all
> other fields in one place.

My question was how long it takes if you memset in neither place.
