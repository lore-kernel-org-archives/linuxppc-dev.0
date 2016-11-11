Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFMM91l3szDvmg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 12:11:49 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id n85so312603pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 17:11:49 -0800 (PST)
Subject: Re: [PATCH] powerpc/mm: Move hpte encode routine to platform specific
 files
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161110092423.20137-1-aneesh.kumar@linux.vnet.ibm.com>
 <4be06fb7-dbef-2c99-c6b5-ed56edf51bbd@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <8f4553b4-a943-bebd-3344-f4d833d32abe@gmail.com>
Date: Fri, 11 Nov 2016 12:11:42 +1100
MIME-Version: 1.0
In-Reply-To: <4be06fb7-dbef-2c99-c6b5-ed56edf51bbd@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/11/16 10:54, Balbir Singh wrote:
> 
> 
> On 10/11/16 20:24, Aneesh Kumar K.V wrote:
>> They differ between powernv and pseries. While we are at it copy
>> a version for ps3 too. For now this is same as what we have for pSeries.
>>
>> Fixes: 50de596de8be6 ("powerpc/mm/hash: Add support for Power9 Hash")
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> 
> I have not looked at the patch closely, but do we want all of this
> duplication. I was wondering if instead of
> 
> cpu_has_feature() we could firmware_has_feature() for now
> 

Basically something like

Not-yet-signed-off-by: Balbir Singh <bsingharora@gmail.com>


diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index ac6d26e..2b23366 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -282,7 +282,8 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
 	 */
 	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
 	v <<= HPTE_V_AVPN_SHIFT;
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+	if (!cpu_has_feature(CPU_FTR_ARCH_300) ||
+		firmware_has_feature(FW_FEATURE_LPAR))
 		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
 }
@@ -310,7 +311,8 @@ static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
 					  int actual_psize, int ssize)
 {
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+		!firmware_has_feature(FW_FEATURE_LPAR))
 		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
 
 	/* A 4K page needs no special encoding */
