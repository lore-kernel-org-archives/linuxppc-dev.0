Return-Path: <sebott@linux.vnet.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F11FA1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 21:12:56 +1100 (AEDT)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sebott@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 10:12:52 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D89641B08061
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 10:13:03 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CACnTj21168346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 10:12:49 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CACdjC010058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 03:12:48 -0700
Date: Fri, 12 Feb 2016 11:12:34 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160212100137.GE25087@arm.com>
Message-ID: <alpine.LFD.2.20.1602121106140.1773@schleppi>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad> <20160212100137.GE25087@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 12 Feb 2016, Will Deacon wrote:
> On Thu, Feb 11, 2016 at 08:57:02PM +0100, Gerald Schaefer wrote:
> > On Thu, 11 Feb 2016 21:09:42 +0200
> > "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> > > On Thu, Feb 11, 2016 at 07:22:23PM +0100, Gerald Schaefer wrote:
> > > > Sebastian Ott reported random kernel crashes beginning with v4.5-rc1 and
> > > > he also bisected this to commit 61f5d698 "mm: re-enable THP". Further
> > > > review of the THP rework patches, which cannot be bisected, revealed
> > > > commit fecffad "s390, thp: remove infrastructure for handling splitting PMDs"
> > > > (and also similar commits for other archs).
> > > > 
> > > > This commit removes the THP splitting bit and also the architecture
> > > > implementation of pmdp_splitting_flush(), which took care of the IPI for
> > > > fast_gup serialization. The commit message says
> > > > 
> > > >     pmdp_splitting_flush() is not needed too: on splitting PMD we will do
> > > >     pmdp_clear_flush() + set_pte_at().  pmdp_clear_flush() will do IPI as
> > > >     needed for fast_gup
> > > > 
> > > > The assumption that a TLB flush will also produce an IPI is wrong on s390,
> > > > and maybe also on other architectures, and I thought that this was actually
> > > > the main reason for having an arch-specific pmdp_splitting_flush().
> > > > 
> > > > At least PowerPC and ARM also had an individual implementation of
> > > > pmdp_splitting_flush() that used kick_all_cpus_sync() instead of a TLB
> > > > flush to send the IPI, and those were also removed. Putting the arch
> > > > maintainers and mailing lists on cc to verify.
> > > > 
> > > > On s390 this will break the IPI serialization against fast_gup, which
> > > > would certainly explain the random kernel crashes, please revert or fix
> > > > the pmdp_splitting_flush() removal.
> > > 
> > > Sorry for that.
> > > 
> > > I believe, the problem was already addressed for PowerPC:
> > > 
> > > http://lkml.kernel.org/g/454980831-16631-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com
> > > 
> > > I think kick_all_cpus_sync() in arch-specific pmdp_invalidate() would do
> > > the trick, right?
> > 
> > Hmm, not sure about that. After pmdp_invalidate(), a pmd_none() check in
> > fast_gup will still return false, because the pmd is not empty (at least
> > on s390). So I don't see spontaneously how it will help fast_gup to break
> > out to the slow path in case of THP splitting.
> > 
> > > 
> > > If yes, I'll prepare patch tomorrow (some sleep required).
> > > 
> > 
> > We'll check if adding kick_all_cpus_sync() to pmdp_invalidate() helps.
> > It would also be good if Martin has a look at this, he'll return on
> > Monday.
> 
> Do you have a reliable way to trigger the "random kernel crashes"? We've not
> seen anything reported on arm64, but I don't see why we wouldn't be affected
> by the same bug and it would be good to confirm and validate a fix.

My testcase was compiling the kernel. Most of the time my test system
didn't survive a single compile run. During bisect I did at least 20
compile runs to flag a commit as good.

Sebastian
