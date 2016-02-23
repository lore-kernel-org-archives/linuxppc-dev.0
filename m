Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB57B1A0514
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:59:47 +1100 (AEDT)
Message-ID: <1456192777.2463.131.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 22 Feb 2016 19:59:37 -0600
In-Reply-To: <87zivaxbll.fsf@linux.vnet.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87zivaxbll.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH V2 00/29] Book3s abstraction in preparation for new MMU
 model
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-09 at 18:52 +0530, Aneesh Kumar K.V wrote:
> 
> Hi Scott,
> 
> I missed adding you on CC:, Can you take a look at this and make sure we
> are not breaking anything on freescale.

I'm having trouble getting it to apply cleanly.  Do you have a git tree I can
test?

-Scott

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > Hello,
> > 
> > This is a large series, mostly consisting of code movement. No new
> > features
> > are done in this series. The changes are done to accomodate the upcoming
> > new memory
> > model in future powerpc chips. The details of the new MMU model can be
> > found at
> > 
> >  http://ibm.biz/power-isa3 (Needs registration). I am including a summary
> > of the changes below.
> > 
> > ISA 3.0 adds support for the radix tree style of MMU with full
> > virtualization and related control mechanisms that manage its
> > coexistence with the HPT. Radix-using operating systems will
> > manage their own translation tables instead of relying on hcalls.
> > 
> > Radix style MMU model requires us to do a 4 level page table
> > with 64K and 4K page size. The table index size different page size
> > is listed below
> > 
> > PGD -> 13 bits
> > PUD -> 9 (1G hugepage)
> > PMD -> 9 (2M huge page)
> > PTE -> 5 (for 64k), 9 (for 4k)
> > 
> > We also require the page table to be in big endian format.
> > 
> > The changes proposed in this series enables us to support both
> > hash page table and radix tree style MMU using a single kernel
> > with limited impact. The idea is to change core page table
> > accessors to static inline functions and later hotpatch them
> > to switch to hash or radix tree functions. For ex:
> > 
> > static inline int pte_write(pte_t pte)
> > {
> >        if (radix_enabled())
> >                return rpte_write(pte);
> >         return hlpte_write(pte);
> > }
> > 
> > On boot we will hotpatch the code so as to avoid conditional operation.
> > 
> > The other two major change propsed in this series is to switch hash
> > linux page table to a 4 level table in big endian format. This is
> > done so that functions like pte_val(), pud_populate() doesn't need
> > hotpatching and thereby helps in limiting runtime impact of the changes.
> > 
> > I didn't included the radix related changes in this series. You can
> > find them at https://github.com/kvaneesh/linux/commits/radix-mmu-v1
> > 
> > Changes from V1:
> > * move patches adding helpers to the next series
> > 
> 
> 
> Thanks
> -aneesh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
