Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 569A01A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 09:55:38 +1000 (AEST)
Message-ID: <1442274938.6342.3.camel@ellerman.id.au>
Subject: Re: [RFC] powerpc/hugetlb: Add warning message when gpage
 allocation request fails
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, mikey@neuling.org, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Tue, 15 Sep 2015 09:55:38 +1000
In-Reply-To: <20150914162426.GA54362@linux.vnet.ibm.com>
References: <1442212051-15235-1-git-send-email-khandual@linux.vnet.ibm.com>
 <87egi1f7t6.fsf@linux.vnet.ibm.com>
 <20150914162426.GA54362@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-14 at 09:24 -0700, Nishanth Aravamudan wrote:
> On 14.09.2015 [18:59:25 +0530], Aneesh Kumar K.V wrote:
> > Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> > 
> > > When a 16GB huge page is requested on POWER platform through kernel command
> > > line interface, it silently fails because of the lack of any gigantic pages
> > > on the system which the platform should have communicated through 16GB memory
> > > blocks in the device tree during boot time. For example
> > >
> > > [    0.480940] HugeTLB registered 16 GB page size, pre-allocated 0 pages
> > > [    0.480945] HugeTLB registered 16 MB page size, pre-allocated 16 pages
> > >
> > > This adds a warning message during alloc_bootmem_huge_page request both on
> > > book3e and book3s powerpc platforms. After this change
> > >
> > > [    0.000000] Gigantic HugeTLB page not available
> > > [    0.473417] HugeTLB registered 16 GB page size, pre-allocated 0 pages
> > > [    0.473423] HugeTLB registered 16 MB page size, pre-allocated 16 pages
> > 
> > That info is already part of the second line isn't it ? ie
> > 
> > [    0.473417] HugeTLB registered 16 GB page size, pre-allocated 0 pages
> > 
> > pre-allocated 0 pages indicate we didn't allocate anything. So why do we
> > need to add more details fo kernel output ?
> 
> Agreed, the '0 pages' message indicates we failed to pre-allocate any
> pages. The 'pre-allocate' messages are specifically about the kernel
> command-line requests for hugepages.

Yeah, that's sufficient. We don't need more boot-time log spam.

All the info you need should be in /sys/kernel/mm anyway. If it's not, then
that is something we should fix.

cheers
