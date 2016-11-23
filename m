Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNzQw5nGQzDw1F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 21:41:28 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uANAench130805
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 05:41:26 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26w6aehw3f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 05:41:26 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 23 Nov 2016 03:41:23 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: RE: [V2,10/68] powerpc/mm: Update _PAGE_KERNEL_RO
In-Reply-To: <rep.1421449714.geoff@infradead.org>
References: <1460182444-2468-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <rep.1421449714.geoff@infradead.org>
Date: Wed, 23 Nov 2016 16:11:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874m2yiilt.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geoff Levand <geoff@infradead.org> writes:

> Hi Aneesh,
>
>> --- a/arch/powerpc/platforms/ps3/spu.c
>> +++ b/arch/powerpc/platforms/ps3/spu.c
>> @@ -205,7 +205,7 @@ static void spu_unmap(struct spu *spu)
>>  static int __init setup_areas(struct spu *spu)
>>  {
>>  	struct table {char* name; unsigned long addr; unsigned long size;};
>> -	static const unsigned long shadow_flags = _PAGE_NO_CACHE | 3;
>> +	unsigned long shadow_flags = pgprot_val(pgprot_noncached_wc(PAGE_KERNEL_RO));
>>  
>>  	spu_pdata(spu)->shadow = __ioremap(spu_pdata(spu)->shadow_addr,
>>  					   sizeof(struct spe_shadow),
>
> This shadow_flags setting doesn't work correctly for PS3.  The PS3's LV1
> hypervisor wants the shadow reg pte bits N=1 and PP=11, so (rflags & 7) == 7.
> It also doesn't want bit 0x8000000000000000 set.  So maybe these:
>
>   (HPTE_R_N | HPTE_R_PP & ~HPTE_R_PP0)
>
> For what its worth, this is the error for v4.8:
>
>   ps3_hpte_insert:result=LV1_ILLEGAL_PARAMETER_VALUE (-17) vpn=7e4fa575c0000 pa=300000003000 ix=bae0 v=7e4fa575c001 r=8000300000003126
>
> I tried different shadow_flags settings to try to get htab_convert_pte_flags()
> to give me the right pte bits, but couldn't find anything that would work.
>
> Here's the only thing I could get to work:
>
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -222,6 +222,12 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
>  		 */
>  		rflags |= HPTE_R_M;
>
> +	if ((pteflags & 0xc000300000000000UL) == 0xc000300000000000UL) {
> +		pr_info("%s: bad rflags: pteflags= %lx => rflags=%lx\n",
> +			__func__, pteflags, rflags);
> +		return 0x127;
> +	}
> +
>  	return rflags;
>  }
>
> And here's the output of that:
>
>  htab_convert_pte_flags: bad rflags: pteflags= c00030000000393c => rflags=8000000000000126
>  htab_convert_pte_flags: bad rflags: pteflags= c00030000000593c => rflags=8000000000000126
>  htab_convert_pte_flags: bad rflags: pteflags= c00030000000793c => rflags=8000000000000126
>  htab_convert_pte_flags: bad rflags: pteflags= c00030000000993c => rflags=8000000000000126
>  htab_convert_pte_flags: bad rflags: pteflags= c00030000000b93c => rflags=8000000000000126
>  htab_convert_pte_flags: bad rflags: pteflags= c00030000000d93c => rflags=8000000000000126
>
> Actually, the problem started with (6a119eae942c "powerpc/mm: Add a _PAGE_PTE bit"),
> but I could fix that by using 'shadow_flags =  (_PAGE_PRESENT | _PAGE_NO_CACHE | _PAGE_USER)'.
>
> Please let me know what I need for shadow_flags to get those pte bits set.

Can you try this patch ?

commit 43e05fa840330f0f2deae1e8cc2effd5df68079f
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Wed Nov 23 15:23:05 2016 +0530

    powerpc/mm: Kernel RO fixup for cell
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e88368354e49..c13242bf3098 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -27,6 +27,11 @@
 /*
  * Individual features below.
  */
+/*
+ * kernel read only support
+ * We added the ppp value 0b110 in ISA 2.04
+ */
+#define MMU_FTR_KERNEL_RO		ASM_CONST(0x00004000)
 
 /*
  * We need to clear top 16bits of va (from the remaining 64 bits )in
@@ -103,10 +108,10 @@
 #define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
 #define MMU_FTRS_PPC970		MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA
 #define MMU_FTRS_POWER5		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
-#define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
-#define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
-#define MMU_FTRS_POWER8		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
-#define MMU_FTRS_POWER9		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
+#define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
+#define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
+#define MMU_FTRS_POWER8		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
+#define MMU_FTRS_POWER9		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
 #define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
 				MMU_FTR_CI_LARGE_PAGE
 #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5503078090cd..78dabf065ba9 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -193,8 +193,12 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 		/*
 		 * Kernel read only mapped with ppp bits 0b110
 		 */
-		if (!(pteflags & _PAGE_WRITE))
-			rflags |= (HPTE_R_PP0 | 0x2);
+		if (!(pteflags & _PAGE_WRITE)) {
+			if (mmu_has_feature(MMU_FTR_KERNEL_RO))
+				rflags |= (HPTE_R_PP0 | 0x2);
+			else
+				rflags |= 0x3;
+		}
 	} else {
 		if (pteflags & _PAGE_RWX)
 			rflags |= 0x2;
