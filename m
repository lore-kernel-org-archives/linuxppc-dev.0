Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 6C6712C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 10:20:11 +1100 (EST)
Date: Thu, 13 Feb 2014 15:20:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Liu Ping Fan <qemulist@gmail.com>
Subject: Re: [PATCH] mm: numa: bugfix for LAST_CPUPID_NOT_IN_PAGE_FLAGS
Message-Id: <20140213152009.b16a30d2a5b5c5706fc8952a@linux-foundation.org>
In-Reply-To: <1391563546-26052-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1391563546-26052-1-git-send-email-pingfank@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  5 Feb 2014 09:25:46 +0800 Liu Ping Fan <qemulist@gmail.com> wrote:

> When doing some numa tests on powerpc, I triggered an oops bug. I find
> it is caused by using page->_last_cpupid.  It should be initialized as
> "-1 & LAST_CPUPID_MASK", but not "-1". Otherwise, in task_numa_fault(),
> we will miss the checking (last_cpupid == (-1 & LAST_CPUPID_MASK)).
> And finally cause an oops bug in task_numa_group(), since the online cpu is
> less than possible cpu.

I grabbed this.  I added this to the changelog:

: PPC needs the LAST_CPUPID_NOT_IN_PAGE_FLAGS case because ppc needs to
: support a large physical address region, up to 2^46 but small section size
: (2^24).  So when NR_CPUS grows up, it is easily to cause
: not-in-page-flags.

to hopefully address Peter's observation.

How should we proceed with this?  I'm getting the impression that numa
balancing on ppc is a dead duck in 3.14, so perhaps this and 

powerpc-mm-add-new-set-flag-argument-to-pte-pmd-update-function.patch
mm-dirty-accountable-change-only-apply-to-non-prot-numa-case.patch
mm-use-ptep-pmdp_set_numa-for-updating-_page_numa-bit.patch

are 3.15-rc1 material?
