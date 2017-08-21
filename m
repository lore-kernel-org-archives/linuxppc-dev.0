Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbZXr4s51zDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 23:39:08 +1000 (AEST)
In-Reply-To: <20170727062455.15404-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v3,1/3] powerpc/mm: Rename find_linux_pte_or_hugepte
Message-Id: <3xbZXr2tPHz9sRW@ozlabs.org>
Date: Mon, 21 Aug 2017 23:39:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-27 at 06:24:53 UTC, "Aneesh Kumar K.V" wrote:
> Add newer helpers to make the function usage simpler. It is always recommended
> to use find_current_mm_pte() for walking the page table. If we cannot use
> find_current_mm_pte(), it should be documented why the said usage of
> __find_linux_pte() is safe against a parallel THP split.
> 
> For now we have KVM code using __find_linux_pte(). This is because kvm code ends
> up calling __find_linux_pte() in real mode with MSR_EE=0 but with PACA soft_enabled =
> 1. We may want to fix that later and make sure we keep the MSR_EE and  PACA
> soft_enabled in sync. When we do that we can switch kvm to use find_linux_pte().
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next and topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/94171b19c3f1f4d9d4c0e3aaa1aa16

cheers
