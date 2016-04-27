Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvvnd1FdmzDqZ9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 19:30:12 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 03:30:10 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3AADF1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 03:29:54 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3R9U8X746072040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 02:30:08 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3R9U8Bb027261
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 03:30:08 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
In-Reply-To: <87mvofedtd.fsf@skywalker.in.ibm.com>
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461704701.3135.68.camel@kernel.crashing.org> <571FE8C1.4030903@gmail.com>
 <1461711943.3135.72.camel@kernel.crashing.org> <57200F4A.4070104@gmail.com>
 <1461721589.3586.0.camel@kernel.crashing.org>
 <87mvofedtd.fsf@skywalker.in.ibm.com>
Date: Wed, 27 Apr 2016 15:00:03 +0530
Message-ID: <87k2jje6w4.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>
>> On Wed, 2016-04-27 at 11:00 +1000, Balbir Singh wrote:
>>> Just basic testing across CPUs with various mm features=C2=A0
>>> enabled/disabled. Just for sanity
>>
>> I still don't think it's worth scattering the change. Either the jump
>> label works or it doesn't ... The only problem is make sure we identify
>> all the pre-boot ones but that's about it.
>>
>
> There are two ways to do this. One is to follow the approach listed
> below done by Kevin, which is to do the jump_label_init early during boot=
 and
> switch both cpu and mmu feature check to plain jump label.
>
> http://mid.gmane.org/1440415228-8006-1-git-send-email-haokexin@gmail.com
>
> I already found one use case of cpu_has_feature before that
> jump_label_init. In this approach we need to carefully audit all the
> cpu/mmu_has_feature calls to make sure they don't get called before
> jump_label_init. A missed conversion mean we miss a cpu/mmu feature
> check.
>
>
> Other option is to follow the patch I posted above, with the simple
> change of renaming mmu_feature_enabled to mmu_has_feature. So we can
> use it in early boot without really worrying about when we init jump
> label.
>
> What do you suggest we follow ?
>

Something simple as below ?

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/includ=
e/asm/book3s/64/mmu.h
index 696b7c5cc31f..0835a8f9904b 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -23,7 +23,7 @@ struct mmu_psize_def {
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
=20
-#define radix_enabled() mmu_feature_enabled(MMU_FTR_RADIX)
+#define radix_enabled() mmu_has_feature(MMU_FTR_RADIX)
=20
 #endif /* __ASSEMBLY__ */
=20
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index fdb70dc218e5..d4b726f5bd4a 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -115,7 +115,7 @@
 DECLARE_PER_CPU(int, next_tlbcam_idx);
 #endif
=20
-static inline int mmu_has_feature(unsigned long feature)
+static inline int __mmu_has_feature(unsigned long feature)
 {
 	return (cur_cpu_spec->mmu_features & feature);
 }
@@ -145,7 +145,7 @@ static inline void assert_pte_locked(struct mm_struct *=
mm, unsigned long addr)
 #endif /* !CONFIG_DEBUG_VM */
=20
 #ifdef HAVE_JUMP_LABEL
-static __always_inline bool mmu_feature_enabled(unsigned long feature)
+static __always_inline bool mmu_has_feature(unsigned long feature)
 {
 	asm_volatile_goto("1:\n\t"
 			  ".pushsection __mmu_ftr_fixup_c,  \"a\"\n\t"
@@ -155,7 +155,7 @@ static __always_inline bool mmu_feature_enabled(unsigne=
d long feature)
 			  JUMP_ENTRY_TYPE "%l[l_false]\n\t"
 			  ".popsection\n\t"
 			  : : "i"(feature) : : l_true, l_false);
-	if (mmu_has_feature(feature))
+	if (__mmu_has_feature(feature))
 l_true:
 		return true;
 l_false:
