Return-Path: <cl@linux.com>
Received: from resqmta-ch2-12v.sys.comcast.net
 (resqmta-ch2-12v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdwY805f5zDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 04:17:15 +1000 (AEST)
Date: Thu, 1 Jun 2017 13:16:08 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Hugh Dickins <hughd@google.com>
cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <alpine.LSU.2.11.1706011002130.3014@eggly.anvils>
Message-ID: <alpine.DEB.2.20.1706011306560.11993@east.gentwo.org>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
 <87h9014j7t.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
 <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
 <alpine.DEB.2.20.1706011027310.8835@east.gentwo.org>
 <alpine.LSU.2.11.1706011002130.3014@eggly.anvils>
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 1 Jun 2017, Hugh Dickins wrote:

> CONFIG_SLUB_DEBUG_ON=y.  My SLAB|SLUB config options are
>
> CONFIG_SLUB_DEBUG=y
> # CONFIG_SLUB_MEMCG_SYSFS_ON is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> CONFIG_SLUB_CPU_PARTIAL=y
> CONFIG_SLABINFO=y
> # CONFIG_SLUB_DEBUG_ON is not set
> CONFIG_SLUB_STATS=y

Thats fine.

> But I think you are now surprised, when I say no slub_debug options
> were on.  Here's the output from /sys/kernel/slab/pgtable-2^12/*
> (before I tried the new kernel with Aneesh's fix patch)
> in case they tell you anything...
>
> pgtable-2^12/poison:0
> pgtable-2^12/red_zone:0
> pgtable-2^12/reserved:0
> pgtable-2^12/sanity_checks:0
> pgtable-2^12/store_user:0

Ok so debugging was off but the slab cache has a ctor callback which
mandates that the free pointer cannot use the free object space when
the object is not in use. Thus the size of the object must be increased to
accomodate the freepointer.
