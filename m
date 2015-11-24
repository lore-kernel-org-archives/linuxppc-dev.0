Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF5EB1A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 17:49:28 +1100 (AEDT)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 12:19:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E8CE9E004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 12:19:56 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAO6mwjh30736490
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 12:19:00 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAO6mvZg019796
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 12:18:58 +0530
Message-ID: <56540859.7090306@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 12:18:57 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 00/31] powerpc/mm: Update page table format for book3s
 64
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> Hi All,
> 
> This patch series attempt to update book3s 64 linux page table format to
> make it more flexible. Our current pte format is very restrictive and we
> overload multiple pte bits. This is due to the non-availability of free bits
> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
> series free up pte_t of 11 bits by moving 4K subpage tracking to the
> lower half of PTE page. The pte format is updated such that we have a
> better method for identifying a pte entry at pmd level. This will also enable
> us to implement hugetlb migration(not yet done in this series).
> 
> Before making the changes to the pte format, I am splitting the
> pte header definition such that we now have the below layout for headers
> 
> book3s
>    32
>      hash.h pgtable.h
>    64
>      hash.h  pgtable.h hash-4k.h hash-64k.h
> booke
>   32
>      pgtable.h pte-40x.h pte-44x.h pte-8xx.h pte-fsl-booke.h
>   64
>     pgtable-4k.h  pgtable-64k.h  pgtable.h
> 
> I have done the header split such that booke headers and modified to the minimum so as to avoid
> causing breakage in booke.
> 
> The patch series can also be found at
> https://github.com/kvaneesh/linux.git book3s-pte-format

Aneesh,

The second commit on the tree branch (faa65ca8e) does not match
with the second patch posted as part of the series. Has the
tree been updated with the latest v5 patches ?

[02/31] powerpc/mm: move pte headers to book3s directory (part 2)
