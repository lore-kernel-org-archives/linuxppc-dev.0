Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w793z5BF5zDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 15:07:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: herbert@gondor.apana.org.au
Cc: linuxppc-dev@ozlabs.org,
	dja@axtens.net
Subject: [PATCH] powerpc/crypto/crct10dif-vpmsum: Fix missing preempt_disable()
Date: Wed, 19 Apr 2017 15:07:38 +1000
Message-Id: <1492578458-26252-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In crct10dif_vpmsum() we call enable_kernel_altivec() without first
disabling preemption, which is not allowed.

It used to be sufficient just to call pagefault_disable(), because that
also disabled preemption. But the two were decoupled in commit 8222dbe21e79
("sched/preempt, mm/fault: Decouple preemption from the page fault
logic") in mid 2015.

The crct10dif-vpmsum code inherited this bug from the crc32c-vpmsum code
on which it was modelled.

So add the missing preempt_disable/enable(). We should also call
disable_kernel_fp(), although it does nothing by default, there is a
debug switch to make it active and all enables should be paired with
disables.

Fixes: b01df1c16c9a ("crypto: powerpc - Add CRC-T10DIF acceleration")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/crypto/crct10dif-vpmsum_glue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/crypto/crct10dif-vpmsum_glue.c b/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
index bebfc329f746..02ea277863d1 100644
--- a/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
+++ b/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
@@ -44,10 +44,13 @@ static u16 crct10dif_vpmsum(u16 crci, unsigned char const *p, size_t len)
 
 	if (len & ~VMX_ALIGN_MASK) {
 		crc <<= 16;
+		preempt_disable();
 		pagefault_disable();
 		enable_kernel_altivec();
 		crc = __crct10dif_vpmsum(crc, p, len & ~VMX_ALIGN_MASK);
+		disable_kernel_altivec();
 		pagefault_enable();
+		preempt_enable();
 		crc >>= 16;
 	}
 
-- 
2.7.4
