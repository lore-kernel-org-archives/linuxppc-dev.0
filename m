Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 556C21007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2012 10:12:47 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 1 Mar 2012 16:12:42 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id ADB113E40047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 16:12:21 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q21NCLGi174646
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Mar 2012 16:12:21 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q21NCJfo002674
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Mar 2012 16:12:20 -0700
Date: Thu, 1 Mar 2012 15:12:16 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] bootmem/sparsemem: remove limit constraint in
 alloc_bootmem_section
Message-ID: <20120301231216.GA3252@linux.vnet.ibm.com>
References: <1330112038-18951-1-git-send-email-nacc@us.ibm.com>
 <20120228154732.GE1199@suse.de>
 <20120229181233.GF5136@linux.vnet.ibm.com>
 <20120229152830.22fc72a2.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120229152830.22fc72a2.akpm@linux-foundation.org>
Cc: Anton Blanchard <anton@au1.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
 stable@vger.kernel.org, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29.02.2012 [15:28:30 -0800], Andrew Morton wrote:
> On Wed, 29 Feb 2012 10:12:33 -0800
> Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:
> 
> > While testing AMS (Active Memory Sharing) / CMO (Cooperative Memory
> > Overcommit) on powerpc, we tripped the following:
> > 
> > kernel BUG at mm/bootmem.c:483!
> >
> > ...
> > 
> > This is
> > 
> >         BUG_ON(limit && goal + size > limit);
> > 
> > and after some debugging, it seems that
> > 
> > 	goal = 0x7ffff000000
> > 	limit = 0x80000000000
> > 
> > and sparse_early_usemaps_alloc_node ->
> > sparse_early_usemaps_alloc_pgdat_section calls
> > 
> > 	return alloc_bootmem_section(usemap_size() * count, section_nr);
> > 
> > This is on a system with 8TB available via the AMS pool, and as a quirk
> > of AMS in firmware, all of that memory shows up in node 0. So, we end up
> > with an allocation that will fail the goal/limit constraints. In theory,
> > we could "fall-back" to alloc_bootmem_node() in
> > sparse_early_usemaps_alloc_node(), but since we actually have HOTREMOVE
> > defined, we'll BUG_ON() instead. A simple solution appears to be to
> > unconditionally remove the limit condition in alloc_bootmem_section,
> > meaning allocations are allowed to cross section boundaries (necessary
> > for systems of this size).
> > 
> > Johannes Weiner pointed out that if alloc_bootmem_section() no longer
> > guarantees section-locality, we need check_usemap_section_nr() to print
> > possible cross-dependencies between node descriptors and the usemaps
> > allocated through it. That makes the two loops in
> > sparse_early_usemaps_alloc_node() identical, so re-factor the code a
> > bit.
> 
> The patch is a bit scary now, so I think we should merge it into
> 3.4-rc1 and then backport it into 3.3.1 if nothing blows up.
> 
> Do you think it should be backported into 3.3.x?  Earlier kernels?

Upon review, it would be good if we can get it pushed back to kernels
3.0.x, 3.1.x and 3.2.x.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
