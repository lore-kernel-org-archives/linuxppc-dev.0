Return-Path: <srs0=b651=4p=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMXV262v3zDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 18:24:42 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wMXV25RbPz8tCv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 18:24:42 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wMXV21KLSz9s3T
 for <linuxppc-dev@ozlabs.org>; Tue,  9 May 2017 18:24:41 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v498IrPJ049448
 for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2017 04:24:39 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ab02hrhdh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 09 May 2017 04:24:39 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 9 May 2017 04:24:39 -0400
Subject: Re: [PATCH] powerpc/mm/book3s/64: Rework page table geometry for
 lower memory usage
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1494317148-18554-1-git-send-email-mpe@ellerman.id.au>
Cc: bsingharora@gmail.com, paulus@samba.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 9 May 2017 13:54:33 +0530
MIME-Version: 1.0
In-Reply-To: <1494317148-18554-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3f36d44c-a8a9-09d4-70f3-9e6088b9676a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 09 May 2017 01:35 PM, Michael Ellerman wrote:
> Recently in commit f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB")
> we increased the virtual address space for user processes to 128TB by default,
> and up to 512TB if user space opts in.
>
> This obviously required expanding the range of the Linux page tables. For Book3s
> 64-bit using hash and with PAGE_SIZE=64K, we increased the PGD to 2^15 entries.
> This meant we could cover the full address range, while still being able to
> insert a 16G hugepage at the PGD level and a 16M hugepage in the PMD.
>
> The downside of that geometry is that it uses a lot of memory for the PGD, and
> in particular makes the PGD a 4-page allocation, which means it's much more
> likely to fail under memory pressure.
>
> Instead we can make the PMD larger, so that a single PUD entry maps 16G,
> allowing the 16G hugepages to sit at that level in the tree. We're then able to
> split the remaining bits between the PUG and PGD. We make the PGD slightly
> larger as that results in lower memory usage for typical programs.
>
> When THP is enabled the PMD actually doubles in size, to 2^11 entries, or 2^14
> bytes, which is large but still < PAGE_SIZE.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 214219dff87c..9732837aaae8 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -2,9 +2,9 @@
>  #define _ASM_POWERPC_BOOK3S_64_HASH_64K_H
>
>  #define H_PTE_INDEX_SIZE  8
> -#define H_PMD_INDEX_SIZE  5
> -#define H_PUD_INDEX_SIZE  5
> -#define H_PGD_INDEX_SIZE  15
> +#define H_PMD_INDEX_SIZE  10
> +#define H_PUD_INDEX_SIZE  7
> +#define H_PGD_INDEX_SIZE  8
>
>  /*
>   * 64k aligned address free up few of the lower bits of RPN for us
>
