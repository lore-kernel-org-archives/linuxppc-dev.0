Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLtJk6VrdzDvs7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Nov 2016 11:43:50 +1100 (AEDT)
Message-Id: <rep.1421449714.geoff@infradead.org>
In-Reply-To: <1460182444-2468-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
From: Geoff Levand <geoff@infradead.org>
Subject: RE: [V2,10/68] powerpc/mm: Update _PAGE_KERNEL_RO
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Sun, 20 Nov 2016 00:43:45 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

> --- a/arch/powerpc/platforms/ps3/spu.c
> +++ b/arch/powerpc/platforms/ps3/spu.c
> @@ -205,7 +205,7 @@ static void spu_unmap(struct spu *spu)
>  static int __init setup_areas(struct spu *spu)
>  {
>  	struct table {char* name; unsigned long addr; unsigned long size;};
> -	static const unsigned long shadow_flags = _PAGE_NO_CACHE | 3;
> +	unsigned long shadow_flags = pgprot_val(pgprot_noncached_wc(PAGE_KERNEL_RO));
>  
>  	spu_pdata(spu)->shadow = __ioremap(spu_pdata(spu)->shadow_addr,
>  					   sizeof(struct spe_shadow),

This shadow_flags setting doesn't work correctly for PS3.  The PS3's LV1
hypervisor wants the shadow reg pte bits N=1 and PP=11, so (rflags & 7) == 7.
It also doesn't want bit 0x8000000000000000 set.  So maybe these:

  (HPTE_R_N | HPTE_R_PP & ~HPTE_R_PP0)

For what its worth, this is the error for v4.8:

  ps3_hpte_insert:result=LV1_ILLEGAL_PARAMETER_VALUE (-17) vpn=7e4fa575c0000 pa=300000003000 ix=bae0 v=7e4fa575c001 r=8000300000003126

I tried different shadow_flags settings to try to get htab_convert_pte_flags()
to give me the right pte bits, but couldn't find anything that would work.

Here's the only thing I could get to work:

--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -222,6 +222,12 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 		 */
 		rflags |= HPTE_R_M;
 
+	if ((pteflags & 0xc000300000000000UL) == 0xc000300000000000UL) {
+		pr_info("%s: bad rflags: pteflags= %lx => rflags=%lx\n",
+			__func__, pteflags, rflags);
+		return 0x127;
+	}
+
 	return rflags;
 }

And here's the output of that:

 htab_convert_pte_flags: bad rflags: pteflags= c00030000000393c => rflags=8000000000000126
 htab_convert_pte_flags: bad rflags: pteflags= c00030000000593c => rflags=8000000000000126
 htab_convert_pte_flags: bad rflags: pteflags= c00030000000793c => rflags=8000000000000126
 htab_convert_pte_flags: bad rflags: pteflags= c00030000000993c => rflags=8000000000000126
 htab_convert_pte_flags: bad rflags: pteflags= c00030000000b93c => rflags=8000000000000126
 htab_convert_pte_flags: bad rflags: pteflags= c00030000000d93c => rflags=8000000000000126

Actually, the problem started with (6a119eae942c "powerpc/mm: Add a _PAGE_PTE bit"),
but I could fix that by using 'shadow_flags =  (_PAGE_PRESENT | _PAGE_NO_CACHE | _PAGE_USER)'.

Please let me know what I need for shadow_flags to get those pte bits set.

-Geoff
