Return-Path: <kirill.shutemov@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id AB9931A0048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 06:12:59 +1100 (AEDT)
Date: Thu, 11 Feb 2016 22:12:53 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
Message-ID: <20160211191253.GA8589@black.fi.intel.com>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160211190942.GA10244@node.shutemov.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 11, 2016 at 09:09:42PM +0200, Kirill A. Shutemov wrote:
> On Thu, Feb 11, 2016 at 07:22:23PM +0100, Gerald Schaefer wrote:
> > Hi,
> > 
> > Sebastian Ott reported random kernel crashes beginning with v4.5-rc1 and
> > he also bisected this to commit 61f5d698 "mm: re-enable THP". Further
> > review of the THP rework patches, which cannot be bisected, revealed
> > commit fecffad "s390, thp: remove infrastructure for handling splitting PMDs"
> > (and also similar commits for other archs).
> > 
> > This commit removes the THP splitting bit and also the architecture
> > implementation of pmdp_splitting_flush(), which took care of the IPI for
> > fast_gup serialization. The commit message says
> > 
> >     pmdp_splitting_flush() is not needed too: on splitting PMD we will do
> >     pmdp_clear_flush() + set_pte_at().  pmdp_clear_flush() will do IPI as
> >     needed for fast_gup
> > 
> > The assumption that a TLB flush will also produce an IPI is wrong on s390,
> > and maybe also on other architectures, and I thought that this was actually
> > the main reason for having an arch-specific pmdp_splitting_flush().
> > 
> > At least PowerPC and ARM also had an individual implementation of
> > pmdp_splitting_flush() that used kick_all_cpus_sync() instead of a TLB
> > flush to send the IPI, and those were also removed. Putting the arch
> > maintainers and mailing lists on cc to verify.
> > 
> > On s390 this will break the IPI serialization against fast_gup, which
> > would certainly explain the random kernel crashes, please revert or fix
> > the pmdp_splitting_flush() removal.
> 
> Sorry for that.
> 
> I believe, the problem was already addressed for PowerPC:
> 
> http://lkml.kernel.org/g/454980831-16631-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

Correct link is

http://lkml.kernel.org/g/1454980831-16631-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

-- 
 Kirill A. Shutemov
