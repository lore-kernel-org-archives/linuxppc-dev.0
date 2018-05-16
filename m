Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mFrn06g5zF14s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 23:38:49 +1000 (AEST)
In-Reply-To: <20180510130913.23931-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: rashmica.g@gmail.com, anton@samba.org
Subject: Re: powerpc/powernv: Fix memtrace build when NUMA=n
Message-Id: <40mFrm49N5z9s4r@ozlabs.org>
Date: Wed, 16 May 2018 23:38:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-10 at 13:09:13 UTC, Michael Ellerman wrote:
> Currently memtrace doesn't build if NUMA=n:
> 
>   In function ‘memtrace_alloc_node’:
>   arch/powerpc/platforms/powernv/memtrace.c:134:6:
>   error: the address of ‘contig_page_data’ will always evaluate as ‘true’
>     if (!NODE_DATA(nid) || !node_spanned_pages(nid))
>         ^
> 
> This is because for NUMA=n NODE_DATA(nid) points to an always
> allocated structure, contig_page_data.
> 
> But even in the NUMA=y case memtrace_alloc_node() is only called for
> online nodes, and we should always have a NODE_DATA() allocated for an
> online node. So remove the (hopefully) overly paranoid check, which
> also means we can build when NUMA=n.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/8ccb442dec0ab53eefb5a607e405f7

cheers
