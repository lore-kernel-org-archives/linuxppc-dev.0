Return-Path: <mgorman@techsingularity.net>
Received: from outbound-smtp08.blacknight.com (outbound-smtp08.blacknight.com
 [46.22.139.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D05E1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 19:43:52 +1100 (AEDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
 by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id
 6BBFC1C4FBB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 08:34:10 +0000 (GMT)
Date: Thu, 3 Mar 2016 08:34:08 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Li Zhang <zhlcindy@gmail.com>
Cc: mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Li Zhang <zhlcindy@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 1/2] mm: meminit: initialise more memory for
 inode/dentry hash tables in early boot
Message-ID: <20160303083408.GI2854@techsingularity.net>
References: <1456988501-29046-1-git-send-email-zhlcindy@gmail.com>
 <1456988501-29046-2-git-send-email-zhlcindy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1456988501-29046-2-git-send-email-zhlcindy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 03, 2016 at 03:01:40PM +0800, Li Zhang wrote:
> From: Li Zhang <zhlcindy@linux.vnet.ibm.com>
> 
> This patch is based on Mel Gorman's old patch in the mailing list,
> https://lkml.org/lkml/2015/5/5/280 which is dicussed but it is
> fixed with a completion to wait for all memory initialised in
> page_alloc_init_late(). It is to fix the oom problem on X86
> with 24TB memory which allocates memory in late initialisation.
> But for Power platform with 32TB memory, it causes a call trace
> in vfs_caches_init->inode_init() and inode hash table needs more
> memory.
> So this patch allocates 1GB for 0.25TB/node for large system
> as it is mentioned in https://lkml.org/lkml/2015/5/1/627
> 

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
