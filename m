Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ln4X3WmkzF1RW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 00:49:32 +1000 (AEST)
In-Reply-To: <20180410085126.15882-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/8xx: Build fix with Hugetlbfs enabled
Message-Id: <40Ln4X20xCz9s3Z@ozlabs.org>
Date: Thu, 12 Apr 2018 00:49:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-10 at 08:51:26 UTC, "Aneesh Kumar K.V" wrote:
> 8xx use slice code when hugetlbfs is enabled. We missed a header include on
> 8xx which resulted in the below build failure.
> 
> config: mpc885_ads_defconfig + CONFIG_HUGETLBFS
> 
>    CC      arch/powerpc/mm/slice.o
> arch/powerpc/mm/slice.c: In function 'slice_get_unmapped_area':
> arch/powerpc/mm/slice.c:655:2: error: implicit declaration of function 'need_extra_context' [-Werror=implicit-function-declaration]
> arch/powerpc/mm/slice.c:656:3: error: implicit declaration of function 'alloc_extended_context' [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors
> make[1]: *** [arch/powerpc/mm/slice.o] Error 1
> make: *** [arch/powerpc/mm] Error 2
> 
> on PPC64 the mmu_context.h was included via linux/pkeys.h
> 
> CC: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/032900e62c176d75923baf95ad880e

cheers
