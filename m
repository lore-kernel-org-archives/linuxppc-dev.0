Return-Path: <hughd@google.com>
Received: from mail-oi0-x230.google.com (mail-oi0-x230.google.com
 [IPv6:2607:f8b0:4003:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdvLJ5MKnzDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 03:22:48 +1000 (AEST)
Received: by mail-oi0-x230.google.com with SMTP id w10so62473067oif.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 10:22:48 -0700 (PDT)
Date: Thu, 1 Jun 2017 10:22:43 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Christoph Lameter <cl@linux.com>
cc: Hugh Dickins <hughd@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <alpine.DEB.2.20.1706011027310.8835@east.gentwo.org>
Message-ID: <alpine.LSU.2.11.1706011002130.3014@eggly.anvils>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
 <87h9014j7t.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
 <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
 <alpine.DEB.2.20.1706011027310.8835@east.gentwo.org>
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

On Thu, 1 Jun 2017, Christoph Lameter wrote:
> 
> > > I am curious as to what is going on there. Do you have the output from
> > > these failed allocations?
> >
> > I thought the relevant output was in my mail.  I did skip the Mem-Info
> > dump, since that just seemed noise in this case: we know memory can get
> > fragmented.  What more output are you looking for?
> 
> The output for the failing allocations when you disabling debugging. For
> that I would think that you need remove(!) the slub_debug statement on the kernel
> command line. You can verify that debug is off by inspecting the values in
> /sys/kernel/slab/<yourcache>/<debug option>

The output was with debugging disabled.  Except when I tried adding that
slub_debug=O on the kernel command line, as the warning suggested, I did
not have any slub_debug statement on the command line; and did not have
CONFIG_SLUB_DEBUG_ON=y.  My SLAB|SLUB config options are

CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SLABINFO=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_SLUB_STATS=y

> 
> > But it was still order 4 when booted with slub_debug=O, which surprised me.
> > And that surprises you too?  If so, then we ought to dig into it further.
> 
> No it does no longer. I dont think slub_debug=O does disable debugging
> (frankly I am not sure what it does). Please do not specify any debug options.

But I think you are now surprised, when I say no slub_debug options
were on.  Here's the output from /sys/kernel/slab/pgtable-2^12/*
(before I tried the new kernel with Aneesh's fix patch)
in case they tell you anything...

pgtable-2^12/aliases:0
pgtable-2^12/align:32768
grep: pgtable-2^12/alloc_calls: Function not implemented
pgtable-2^12/alloc_fastpath:5847 C0=1587 C1=1449 C2=1392 C3=1419
pgtable-2^12/alloc_from_partial:12637 C0=3292 C1=3020 C2=3051 C3=3274
pgtable-2^12/alloc_node_mismatch:0
pgtable-2^12/alloc_refill:41038 C0=10600 C1=10025 C2=10191 C3=10222
pgtable-2^12/alloc_slab:517 C0=148 C1=110 C2=105 C3=154
pgtable-2^12/alloc_slowpath:54203 C0=14041 C1=13157 C2=13349 C3=13656
pgtable-2^12/cache_dma:0
pgtable-2^12/cmpxchg_double_cpu_fail:0
pgtable-2^12/cmpxchg_double_fail:0
pgtable-2^12/cpu_partial:2
pgtable-2^12/cpu_partial_alloc:25894 C0=6719 C1=6334 C2=6288 C3=6553
pgtable-2^12/cpu_partial_drain:8441 C0=2035 C1=2211 C2=2268 C3=1927
pgtable-2^12/cpu_partial_free:38987 C0=9642 C1=10042 C2=10132 C3=9171
pgtable-2^12/cpu_partial_node:12237 C0=3183 C1=2928 C2=2961 C3=3165
pgtable-2^12/cpu_slabs:11
pgtable-2^12/cpuslab_flush:17 C0=5 C2=4 C3=8
pgtable-2^12/ctor:pgd_ctor+0x0/0x18
pgtable-2^12/deactivate_bypass:39027 C0=10153 C1=9463 C2=9439 C3=9972
pgtable-2^12/deactivate_empty:446 C0=98 C1=118 C2=123 C3=107
pgtable-2^12/deactivate_full:16 C0=5 C2=3 C3=8
pgtable-2^12/deactivate_remote_frees:0
pgtable-2^12/deactivate_to_head:1 C2=1
pgtable-2^12/deactivate_to_tail:0
pgtable-2^12/destroy_by_rcu:0
pgtable-2^12/free_add_partial:24877 C0=6007 C1=6515 C2=6681 C3=5674
grep: pgtable-2^12/free_calls: Function not implemented
pgtable-2^12/free_fastpath:5849 C0=1587 C1=1449 C2=1394 C3=1419
pgtable-2^12/free_frozen:15145 C0=3989 C1=3701 C2=3683 C3=3772
pgtable-2^12/free_remove_partial:0
pgtable-2^12/free_slab:446 C0=98 C1=118 C2=123 C3=107
pgtable-2^12/free_slowpath:54132 C0=13631 C1=13743 C2=13815 C3=12943
pgtable-2^12/hwcache_align:0
pgtable-2^12/min_partial:8
pgtable-2^12/object_size:32768
pgtable-2^12/objects:67
pgtable-2^12/objects_partial:0
pgtable-2^12/objs_per_slab:1
pgtable-2^12/order:4
pgtable-2^12/order_fallback:13 C0=2 C1=1 C2=5 C3=5
pgtable-2^12/partial:4
pgtable-2^12/poison:0
pgtable-2^12/reclaim_account:0
pgtable-2^12/red_zone:0
pgtable-2^12/reserved:0
pgtable-2^12/sanity_checks:0
pgtable-2^12/slab_size:65536
pgtable-2^12/slabs:71
pgtable-2^12/slabs_cpu_partial:7(7) C0=1(1) C1=3(3) C2=1(1) C3=2(2)
pgtable-2^12/store_user:0
pgtable-2^12/total_objects:71
pgtable-2^12/trace:0

Hugh
