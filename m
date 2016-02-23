Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FE61A0416
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 20:26:31 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 02:26:29 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D2DB63E40044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 02:26:25 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N9QPL422282298
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 09:26:25 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N9QOYR017119
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 04:26:24 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 00/18] Book3s abstraction in preparation for new MMU
 model
In-Reply-To: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2016 14:56:20 +0530
Message-ID: <87povnhj5v.fsf@linux.vnet.ibm.com>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Hello,
>
> This series mostly consisting of code movement. One new thing added in this series
> is to switch book3s 64 to 4 level page table. The changes are done to accomodate
> the upcoming new memory model in future powerpc chips. The details of the new
> MMU model can be found at
>
>  http://ibm.biz/power-isa3 (Needs registration). I am including a summary of the changes below.
>
> ISA 3.0 adds support for the radix tree style of MMU with full
> virtualization and related control mechanisms that manage its
> coexistence with the HPT. Radix-using operating systems will
> manage their own translation tables instead of relying on hcalls.
>
> Radix style MMU model requires us to do a 4 level page table
> with 64K and 4K page size. The table index size different page size
> is listed below
>
> PGD -> 13 bits
> PUD -> 9 (1G hugepage)
> PMD -> 9 (2M huge page)
> PTE -> 5 (for 64k), 9 (for 4k)
>
> We also require the page table to be in big endian format.
>
> Changes from V3:
>  * rebase on top of PTE bits movement patch series
>  * Drop all the hash linux abstraction patches
>  * Keep only 4 level table and other code movement patches.
>
> Changes from V2:
>  * rebase to latest kernel
>  * Update commit messages
>  * address review comments
>
> Changes from V1:
> * move patches adding helpers to the next series
>
>
> NOTE:
>  This is lightly tested. Right now 4K linux page size is what is being tested. Once that is done
>  I will have to do 64K linux page size tests.
>

Tested the below tests with 4K page size and 64K page size
* libhugetlbfs test
* ltp mm tests
* kernel build in loop (testing thp collapse and split)

-aneesh
