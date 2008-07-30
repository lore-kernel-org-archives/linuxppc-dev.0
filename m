Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0521BDE2B5
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 03:34:26 +1000 (EST)
Date: Wed, 30 Jul 2008 10:34:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
Message-Id: <20080730103407.b110afc2.akpm@linux-foundation.org>
In-Reply-To: <20080730172317.GA14138@csn.ul.ie>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<20080730014308.2a447e71.akpm@linux-foundation.org>
	<20080730172317.GA14138@csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Eric Munson <ebmunson@us.ibm.com>,
	libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 30 Jul 2008 18:23:18 +0100 Mel Gorman <mel@csn.ul.ie> wrote:

> On (30/07/08 01:43), Andrew Morton didst pronounce:
> > On Mon, 28 Jul 2008 12:17:10 -0700 Eric Munson <ebmunson@us.ibm.com> wrote:
> > 
> > > Certain workloads benefit if their data or text segments are backed by
> > > huge pages.
> > 
> > oh.  As this is a performance patch, it would be much better if its
> > description contained some performance measurement results!  Please.
> > 
> 
> I ran these patches through STREAM (http://www.cs.virginia.edu/stream/).
> STREAM itself was patched to allocate data from the stack instead of statically
> for the test. They completed without any problem on x86, x86_64 and PPC64
> and each test showed a performance gain from using hugepages.  I can post
> the raw figures but they are not currently in an eye-friendly format. Here
> are some plots of the data though;
> 
> x86: http://www.csn.ul.ie/~mel/postings/stack-backing-20080730/x86-stream-stack.ps
> x86_64: http://www.csn.ul.ie/~mel/postings/stack-backing-20080730/x86_64-stream-stack.ps
> ppc64-small: http://www.csn.ul.ie/~mel/postings/stack-backing-20080730/ppc64-small-stream-stack.ps
> ppc64-large: http://www.csn.ul.ie/~mel/postings/stack-backing-20080730/ppc64-large-stream-stack.ps
> 
> The test was to run STREAM with different array sizes (plotted on X-axis)
> and measure the average throughput (y-axis). In each case, backing the stack
> with large pages with a performance gain.

So about a 10% speedup on x86 for most STREAM configurations.  Handy -
that's somewhat larger than most hugepage-conversions, iirc.

Do we expect that this change will be replicated in other
memory-intensive apps?  (I do).
