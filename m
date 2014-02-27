Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 932A82C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 10:41:06 +1100 (EST)
Date: Thu, 27 Feb 2014 15:41:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: numa: bugfix for LAST_CPUPID_NOT_IN_PAGE_FLAGS
Message-Id: <20140227154104.4e3572f1d9e2692d431d1a4e@linux-foundation.org>
In-Reply-To: <87k3cifgzz.fsf@linux.vnet.ibm.com>
References: <1391563546-26052-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20140213152009.b16a30d2a5b5c5706fc8952a@linux-foundation.org>
 <87k3cifgzz.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>, Liu Ping Fan <qemulist@gmail.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 26 Feb 2014 13:22:16 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Wed,  5 Feb 2014 09:25:46 +0800 Liu Ping Fan <qemulist@gmail.com> wrote:
> >
> >> When doing some numa tests on powerpc, I triggered an oops bug. I find
> >> it is caused by using page->_last_cpupid.  It should be initialized as
> >> "-1 & LAST_CPUPID_MASK", but not "-1". Otherwise, in task_numa_fault(),
> >> we will miss the checking (last_cpupid == (-1 & LAST_CPUPID_MASK)).
> >> And finally cause an oops bug in task_numa_group(), since the online cpu is
> >> less than possible cpu.
> >
> > I grabbed this.  I added this to the changelog:
> >
> > : PPC needs the LAST_CPUPID_NOT_IN_PAGE_FLAGS case because ppc needs to
> > : support a large physical address region, up to 2^46 but small section size
> > : (2^24).  So when NR_CPUS grows up, it is easily to cause
> > : not-in-page-flags.
> >
> > to hopefully address Peter's observation.
> >
> > How should we proceed with this?  I'm getting the impression that numa
> > balancing on ppc is a dead duck in 3.14, so perhaps this and 
> >
> > powerpc-mm-add-new-set-flag-argument-to-pte-pmd-update-function.patch
> > mm-dirty-accountable-change-only-apply-to-non-prot-numa-case.patch
> > mm-use-ptep-pmdp_set_numa-for-updating-_page_numa-bit.patch
> >
> 
> All these are already in 3.14  ?

Yes.

> > are 3.15-rc1 material?
> >
> 
> We should push the first hunk to 3.14. I will wait for Liu to redo the
> patch. BTW this should happen only when SPARSE_VMEMMAP is not
> specified. Srikar had reported the issue here
> 
> http://mid.gmane.org/20140219180200.GA29257@linux.vnet.ibm.com
> 
> #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> #define SECTIONS_WIDTH		SECTIONS_SHIFT
> #else
> #define SECTIONS_WIDTH		0
> #endif
> 

I'm lost.  What patch are you talking about?  The first hunk of what?

I assume we're talking about
mm-numa-bugfix-for-last_cpupid_not_in_page_flags.patch, which I had
queued for 3.14.  I'll put it on hold until there's some clarity here.
