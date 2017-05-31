Return-Path: <cl@linux.com>
Received: from resqmta-ch2-02v.sys.comcast.net
 (resqmta-ch2-02v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdCGl1WYCzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 00:17:18 +1000 (AEST)
Date: Wed, 31 May 2017 09:09:04 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Hugh Dickins <hughd@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <87h9014j7t.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
 <87h9014j7t.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 31 May 2017, Michael Ellerman wrote:

> > SLUB: Unable to allocate memory on node -1, gfp=0x14000c0(GFP_KERNEL)
> >   cache: pgtable-2^12, object size: 32768, buffer size: 65536, default order: 4, min order: 4
> >   pgtable-2^12 debugging increased min order, use slub_debug=O to disable.

Ahh. Ok debugging increased the object size to an order 4. This should be
order 3 without debugging.

> > I did try booting with slub_debug=O as the message suggested, but that
> > made no difference: it still hoped for but failed on order:4 allocations.

I am curious as to what is going on there. Do you have the output from
these failed allocations?
