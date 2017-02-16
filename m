Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP58g1kYDzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:59:47 +1100 (AEDT)
In-Reply-To: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [1/3] powerpc/mm/radix: Update pte update sequence for pte clear
 case
Message-Id: <3vP58g0xpqz9s9x@ozlabs.org>
Date: Thu, 16 Feb 2017 16:59:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-09 at 02:58:19 UTC, "Aneesh Kumar K.V" wrote:
> In the kernel we do follow the below sequence in different code paths.
> pte = ptep_get_clear(ptep)
> ....
> set_pte_at(ptep, pte)
> 
> We do that for mremap, autonuma protection update and softdirty clearing. This
> implies our optimization to skip a tlb flush when clearing a pte update is
> not valid, because for DD1 system that followup set_pte_at will be done witout
> doing the required tlbflush. Fix that by always doing the dd1 style pte update
> irrespective of new_pte value. In a later patch we will optimize the application
> exit case.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Tested-by: Michael Neuling <mikey@neuling.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ca94573b9c69d224e50e1084a27767

cheers
