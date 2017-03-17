Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vktWN4dPBzDqc3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 16:02:40 +1100 (AEDT)
From: Michael Ellerman <michael@ellerman.id.au>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] powerpc/pseries: Don't give a warning when HPT resizing
 isn't available
In-Reply-To: <20170317011119.31091-1-david@gibson.dropbear.id.au>
References: <20170317011119.31091-1-david@gibson.dropbear.id.au>
Date: Fri, 17 Mar 2017 16:02:35 +1100
Message-ID: <87tw6sbims.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <david@gibson.dropbear.id.au> writes:

> As of 438cc81a41 "powerpc/pseries: Automatically resize HPT for memory hot
> add/remove" when running on the pseries platform, we always attempt to
> use the PAPR extension to resize the hashed page table (HPT) when we add
> or remove memory.
>
> This is fine, but when the extension is available we'll give a harmless,
> but scary warning.  This patch suppresses the warning in this case.  It
> will still warn if the feature is supposed to be available, but didn't
> work.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Kind of cosmetic, but getting an error message on every memory hot
> plug/unplug attempt if your host doesn't support HPT resizing is
> pretty ugly.  So I think this is a candidate for quick inclusion.

Yeah thanks, I forgot I was going to send a patch for it.

I was thinking of doing the following instead, or maybe we can do both?

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 251060cf1713..8b1fe895daa3 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -751,7 +751,9 @@ void __init hpte_init_pseries(void)
 	mmu_hash_ops.flush_hash_range	 = pSeries_lpar_flush_hash_range;
 	mmu_hash_ops.hpte_clear_all      = pseries_hpte_clear_all;
 	mmu_hash_ops.hugepage_invalidate = pSeries_lpar_hugepage_invalidate;
-	mmu_hash_ops.resize_hpt		 = pseries_lpar_resize_hpt;
+
+	if (firmware_has_feature(FW_FEATURE_HPT_RESIZE))
+		mmu_hash_ops.resize_hpt = pseries_lpar_resize_hpt;
 }
 
 void radix_init_pseries(void)


cheers
