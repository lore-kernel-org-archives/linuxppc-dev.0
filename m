Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F7911A028E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 20:31:53 +1100 (AEDT)
Date: Fri, 21 Nov 2014 09:31:41 +0000
From: Mel Gorman <mgorman@suse.de>
To: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH 0/10] Replace _PAGE_NUMA with PAGE_NONE protections v2
Message-ID: <20141121093141.GU2725@suse.de>
References: <1416478790-27522-1-git-send-email-mgorman@suse.de>
 <546E6221.5000409@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <546E6221.5000409@oracle.com>
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>, Dave Jones <davej@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2014 at 04:50:25PM -0500, Sasha Levin wrote:
> On 11/20/2014 05:19 AM, Mel Gorman wrote:
> > V1 failed while running under kvm-tools very quickly and a second report
> > indicated that it happens on bare metal as well. This version survived
> > an overnight run of trinity running under kvm-tools here but verification
> > from Sasha would be appreciated.
> 
> Hi Mel,
> 
> I tried giving it a spin, but it won't apply at all on the latest -mm
> tree:
> 
> $ git am -3 numa/*
> Applying: mm: numa: Do not dereference pmd outside of the lock during NUMA hinting fault
> Applying: mm: Add p[te|md] protnone helpers for use by NUMA balancing
> Applying: mm: Convert p[te|md]_numa users to p[te|md]_protnone_numa
> fatal: sha1 information is lacking or useless (mm/huge_memory.c).
> Repository lacks necessary blobs to fall back on 3-way merge.
> Cannot fall back to three-way merge.
> 
> Did I miss a prerequisite?
> 

No. V2 was still against 3.18-rc4 as that was what I had vanilla kernel
test data for. V3 will be against latest mmotm.

-- 
Mel Gorman
SUSE Labs
