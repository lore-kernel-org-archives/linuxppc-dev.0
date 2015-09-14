Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C8E71A2BD5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 23:32:31 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93E2714076E
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 23:32:30 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 14 Sep 2015 18:59:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 45741125801B
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 18:59:09 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8EDTWSI51249338
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 18:59:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8EDTV96010363
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 18:59:32 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: Re: [RFC] powerpc/hugetlb: Add warning message when gpage allocation
 request fails
In-Reply-To: <1442212051-15235-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1442212051-15235-1-git-send-email-khandual@linux.vnet.ibm.com>
Date: Mon, 14 Sep 2015 18:59:25 +0530
Message-ID: <87egi1f7t6.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> When a 16GB huge page is requested on POWER platform through kernel command
> line interface, it silently fails because of the lack of any gigantic pages
> on the system which the platform should have communicated through 16GB memory
> blocks in the device tree during boot time. For example
>
> [    0.480940] HugeTLB registered 16 GB page size, pre-allocated 0 pages
> [    0.480945] HugeTLB registered 16 MB page size, pre-allocated 16 pages
>
> This adds a warning message during alloc_bootmem_huge_page request both on
> book3e and book3s powerpc platforms. After this change
>
> [    0.000000] Gigantic HugeTLB page not available
> [    0.473417] HugeTLB registered 16 GB page size, pre-allocated 0 pages
> [    0.473423] HugeTLB registered 16 MB page size, pre-allocated 16 pages


That info is already part of the second line isn't it ? ie

[    0.473417] HugeTLB registered 16 GB page size, pre-allocated 0 pages

pre-allocated 0 pages indicate we didn't allocate anything. So why do we
need to add more details fo kernel output ?

-aneesh
