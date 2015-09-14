Return-Path: <nacc@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E49071A2BFB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 02:29:54 +1000 (AEST)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D4091400CB
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 02:29:53 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 14 Sep 2015 10:26:21 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 523E83E40076
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 10:25:25 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8EGO9LL3604796
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 09:24:17 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8EGOpUN026209
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 10:24:52 -0600
Date: Mon, 14 Sep 2015 09:24:26 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 mikey@neuling.org
Subject: Re: [RFC] powerpc/hugetlb: Add warning message when gpage allocation
 request fails
Message-ID: <20150914162426.GA54362@linux.vnet.ibm.com>
References: <1442212051-15235-1-git-send-email-khandual@linux.vnet.ibm.com>
 <87egi1f7t6.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87egi1f7t6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14.09.2015 [18:59:25 +0530], Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
> > When a 16GB huge page is requested on POWER platform through kernel command
> > line interface, it silently fails because of the lack of any gigantic pages
> > on the system which the platform should have communicated through 16GB memory
> > blocks in the device tree during boot time. For example
> >
> > [    0.480940] HugeTLB registered 16 GB page size, pre-allocated 0 pages
> > [    0.480945] HugeTLB registered 16 MB page size, pre-allocated 16 pages
> >
> > This adds a warning message during alloc_bootmem_huge_page request both on
> > book3e and book3s powerpc platforms. After this change
> >
> > [    0.000000] Gigantic HugeTLB page not available
> > [    0.473417] HugeTLB registered 16 GB page size, pre-allocated 0 pages
> > [    0.473423] HugeTLB registered 16 MB page size, pre-allocated 16 pages
> 
> 
> That info is already part of the second line isn't it ? ie
> 
> [    0.473417] HugeTLB registered 16 GB page size, pre-allocated 0 pages
> 
> pre-allocated 0 pages indicate we didn't allocate anything. So why do we
> need to add more details fo kernel output ?

Agreed, the '0 pages' message indicates we failed to pre-allocate any
pages. The 'pre-allocate' messages are specifically about the kernel
command-line requests for hugepages.

Not sure I understand the motivation for this?

-Nish
