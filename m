Return-Path: <cl@linux.com>
Received: from resqmta-ch2-11v.sys.comcast.net
 (resqmta-ch2-11v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdCCP3rb9zDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 00:14:25 +1000 (AEST)
Date: Wed, 31 May 2017 09:06:03 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Hugh Dickins <hughd@google.com>
cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
Message-ID: <alpine.DEB.2.20.1705310902340.14920@east.gentwo.org>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 30 May 2017, Hugh Dickins wrote:

> I wanted to try removing CONFIG_SLUB_DEBUG, but didn't succeed in that:
> it seemed to be a hard requirement for something, but I didn't find what.

CONFIG_SLUB_DEBUG does not enable debugging. It only includes the code to
be able to enable it at runtime.

> I did try CONFIG_SLAB=y instead of SLUB: that lowers these allocations to
> the expected order:3, which then results in OOM-killing rather than direct
> allocation failure, because of the PAGE_ALLOC_COSTLY_ORDER 3 cutoff.  But
> makes no real difference to the outcome: swapping loads still abort early.

SLAB uses order 3 and SLUB order 4??? That needs to be tracked down.

Why are the slab allocators used to create slab caches for large object
sizes?

> Relying on order:3 or order:4 allocations is just too optimistic: ppc64
> with 4k pages would do better not to expect to support a 128TB userspace.

I thought you had these huge 64k page sizes?
