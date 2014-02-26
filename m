Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7ECA42C009B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 18:52:26 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Feb 2014 13:22:21 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E24781258053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 13:24:23 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1Q7q3ZI9240920
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 13:22:04 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1Q7qHJH023983
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 13:22:18 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Liu Ping Fan <qemulist@gmail.com>
Subject: Re: [PATCH] mm: numa: bugfix for LAST_CPUPID_NOT_IN_PAGE_FLAGS
In-Reply-To: <20140213152009.b16a30d2a5b5c5706fc8952a@linux-foundation.org>
References: <1391563546-26052-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20140213152009.b16a30d2a5b5c5706fc8952a@linux-foundation.org>
Date: Wed, 26 Feb 2014 13:22:16 +0530
Message-ID: <87k3cifgzz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed,  5 Feb 2014 09:25:46 +0800 Liu Ping Fan <qemulist@gmail.com> wrote:
>
>> When doing some numa tests on powerpc, I triggered an oops bug. I find
>> it is caused by using page->_last_cpupid.  It should be initialized as
>> "-1 & LAST_CPUPID_MASK", but not "-1". Otherwise, in task_numa_fault(),
>> we will miss the checking (last_cpupid == (-1 & LAST_CPUPID_MASK)).
>> And finally cause an oops bug in task_numa_group(), since the online cpu is
>> less than possible cpu.
>
> I grabbed this.  I added this to the changelog:
>
> : PPC needs the LAST_CPUPID_NOT_IN_PAGE_FLAGS case because ppc needs to
> : support a large physical address region, up to 2^46 but small section size
> : (2^24).  So when NR_CPUS grows up, it is easily to cause
> : not-in-page-flags.
>
> to hopefully address Peter's observation.
>
> How should we proceed with this?  I'm getting the impression that numa
> balancing on ppc is a dead duck in 3.14, so perhaps this and 
>
> powerpc-mm-add-new-set-flag-argument-to-pte-pmd-update-function.patch
> mm-dirty-accountable-change-only-apply-to-non-prot-numa-case.patch
> mm-use-ptep-pmdp_set_numa-for-updating-_page_numa-bit.patch
>

All these are already in 3.14  ?

> are 3.15-rc1 material?
>

We should push the first hunk to 3.14. I will wait for Liu to redo the
patch. BTW this should happen only when SPARSE_VMEMMAP is not
specified. Srikar had reported the issue here

http://mid.gmane.org/20140219180200.GA29257@linux.vnet.ibm.com

#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
#define SECTIONS_WIDTH		SECTIONS_SHIFT
#else
#define SECTIONS_WIDTH		0
#endif

-aneesh
