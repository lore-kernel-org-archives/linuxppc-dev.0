Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0109.outbound.protection.outlook.com [157.56.111.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AC261A0A40
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 07:49:11 +1000 (AEST)
Message-ID: <1442872135.19102.184.camel@freescale.com>
Subject: Re: [PATCH 00/31] powerpc/mm: Update page table format for book3s 64
From: Scott Wood <scottwood@freescale.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 21 Sep 2015 16:48:55 -0500
In-Reply-To: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 12:10 +0530, Aneesh Kumar K.V wrote:
> Hi All,
> 
> This patch series attempt to update book3s 64 linux page table format to
> make it more flexible. Our current pte format is very restrictive and we
> overload multiple pte bits. This is due to the non-availability of free bits
> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
> series free up pte_t of 11 bits by moving 4K subpage tracking to the
> lower half of PTE page. The pte format is updated such that we have a
> better method for identifying a pte entry at pmd level. This will also 
> enable
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

40x and 8xx are not booke.  Is there a better name that can be used for this 
directory?  Maybe "nohash", similar to arch/powerpc/mm/tlb_nohash.c?

-Scott
