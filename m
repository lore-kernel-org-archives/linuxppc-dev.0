Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C79EB1A0344
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:34:31 +1100 (AEDT)
Message-ID: <1456374864.5360.33.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 24 Feb 2016 22:34:24 -0600
In-Reply-To: <87povnhj5v.fsf@linux.vnet.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87povnhj5v.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH V4 00/18] Book3s abstraction in preparation for new MMU
 model
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-23 at 14:56 +0530, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > Hello,
> > 
> > This series mostly consisting of code movement. One new thing added in
> > this series
> > is to switch book3s 64 to 4 level page table. The changes are done to
> > accomodate
> > the upcoming new memory model in future powerpc chips. The details of the
> > new
> > MMU model can be found at
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
> > Changes from V3:
> >  * rebase on top of PTE bits movement patch series
> >  * Drop all the hash linux abstraction patches
> >  * Keep only 4 level table and other code movement patches.
> > 
> > Changes from V2:
> >  * rebase to latest kernel
> >  * Update commit messages
> >  * address review comments
> > 
> > Changes from V1:
> > * move patches adding helpers to the next series
> > 
> > 
> > NOTE:
> >  This is lightly tested. Right now 4K linux page size is what is being
> > tested. Once that is done
> >  I will have to do 64K linux page size tests.
> > 
> 
> Tested the below tests with 4K page size and 64K page size
> * libhugetlbfs test
> * ltp mm tests
> * kernel build in loop (testing thp collapse and split)

I did some basic tests on book3e (32 and 64 bit) and didn't see any problems
with this version of the patchset.

-Scott
