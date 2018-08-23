Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x63733JZzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 00:18:43 +1000 (AEST)
In-Reply-To: <20180822171605.15054-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/mm/books3s: Add new pte bit to mark pte temporarily
 invalid.
Message-Id: <41x6366MjYz9s7X@ozlabs.org>
Date: Fri, 24 Aug 2018 00:18:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-08-22 at 17:16:04 UTC, "Aneesh Kumar K.V" wrote:
> When splitting a huge pmd pte, we need to mark the pmd entry invalid. We
> can do that by clearing _PAGE_PRESENT bit. But then that will be taken as a
> swap pte. In order to differentiate between the two use a software pte bit
> when invalidating.
> 
> For regular pte, due to bd5050e38aec ("powerpc/mm/radix: Change pte relax
> sequence to handle nest MMU hang") we need to mark the pte entry invalid when
> relaxing access permission. Instead of marking pte_none which can result in
> different page table walk routines possibly skipping this pte entry, invalidate
> it but still keep it marked present.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bd0dbb73e01306a1060e56f81e5fe2

cheers
