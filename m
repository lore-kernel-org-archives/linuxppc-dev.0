Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KNsS50wszDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 18:35:05 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w398Z1j8102983
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Apr 2018 04:35:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h8033j6xu-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 04:34:49 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 9 Apr 2018 02:33:59 -0600
Subject: Re: [PATCH V6 2/4] powerpc/mm: Add support for handling > 512TB
 address in SLB miss
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180326100450.18614-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180326100450.18614-3-aneesh.kumar@linux.vnet.ibm.com>
 <e593156a-d06a-9f1d-c2d3-564553c24cce@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Mon, 9 Apr 2018 14:03:51 +0530
MIME-Version: 1.0
In-Reply-To: <e593156a-d06a-9f1d-c2d3-564553c24cce@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d3d9108d-38a3-0caf-8944-4ee422090421@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/09/2018 12:49 PM, Christophe LEROY wrote:
> 
> 
> Le 26/03/2018 à 12:04, Aneesh Kumar K.V a écrit :
>> For addresses above 512TB we allocate additional mmu contexts. To make
>> it all easy, addresses above 512TB are handled with IR/DR=1 and with
>> stack frame setup.
>>
>> The mmu_context_t is also updated to track the new extended_ids. To
>> support upto 4PB we need a total 8 contexts.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> [mpe: Minor formatting tweaks and comment wording, switch BUG to WARN
>>        in get_ea_context().]
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Compilation fails on mpc885_ads_defconfig + CONFIG_HUGETLBFS :
> 
>    CC      arch/powerpc/mm/slice.o
> arch/powerpc/mm/slice.c: In function 'slice_get_unmapped_area':
> arch/powerpc/mm/slice.c:655:2: error: implicit declaration of function 
> 'need_extra_context' [-Werror=implicit-function-declaration]
> arch/powerpc/mm/slice.c:656:3: error: implicit declaration of function 
> 'alloc_extended_context' [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors
> make[1]: *** [arch/powerpc/mm/slice.o] Error 1
> make: *** [arch/powerpc/mm] Error 2


something like below?

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 9cd87d1..205fe55 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -35,6 +35,7 @@
  #include <asm/mmu.h>
  #include <asm/copro.h>
  #include <asm/hugetlb.h>
+#include <asm/mmu_context.h>

  static DEFINE_SPINLOCK(slice_convert_lock);


PPC64 was including that header via include/linux/pkeys.h

-aneesh
