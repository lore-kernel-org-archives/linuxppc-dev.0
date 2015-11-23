Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 227F41A009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:29:04 +1100 (AEDT)
Message-ID: <1448321325.4574.19.camel@kernel.crashing.org>
Subject: Re: [PATCH V5 00/31] powerpc/mm: Update page table format for
 book3s 64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, Scott Wood <scottwood@freescale.com>, Denis Kirjanov
 <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Nov 2015 10:28:45 +1100
In-Reply-To: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Mon, 2015-11-23 at 15:52 +0530, Aneesh Kumar K.V wrote:
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

This series actually completely removes the tracking of the subages,
right ? IE, it also halves the memory footprint of page tables, doesn't
it ?

Cheers,
Ben.
