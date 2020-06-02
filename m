Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22453C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:55:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D95E2072F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D95E2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bh8P3hdhzDqVB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:55:01 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bh6j4BHyzDqS0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2020 15:53:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49bh6j07cVz9sSg;
 Tue,  2 Jun 2020 15:53:32 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kvm: Enable support for ISA v3.1 guests
Date: Tue,  2 Jun 2020 15:53:25 +1000
Message-Id: <20200602055325.6102-1-alistair@popple.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: ravi.bangoria@linux.ibm.com, mikey@neuling.org, kvm-ppc@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adds support for emulating ISAv3.1 guests by adding the appropriate PCR
and FSCR bits.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/asm/reg.h |  1 +
 arch/powerpc/kvm/book3s_hv.c   | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 773f76402392..d77040d0588a 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1348,6 +1348,7 @@
 #define PVR_ARCH_206p	0x0f100003
 #define PVR_ARCH_207	0x0f000004
 #define PVR_ARCH_300	0x0f000005
+#define PVR_ARCH_31	0x0f000006
 
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 93493f0cbfe8..359bb2ed43e1 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -345,7 +345,7 @@ static void kvmppc_set_pvr_hv(struct kvm_vcpu *vcpu, u32 pvr)
 }
 
 /* Dummy value used in computing PCR value below */
-#define PCR_ARCH_300	(PCR_ARCH_207 << 1)
+#define PCR_ARCH_31    (PCR_ARCH_300 << 1)
 
 static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 {
@@ -353,7 +353,9 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
 	/* We can (emulate) our own architecture version and anything older */
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (cpu_has_feature(CPU_FTR_ARCH_31))
+		host_pcr_bit = PCR_ARCH_31;
+	else if (cpu_has_feature(CPU_FTR_ARCH_300))
 		host_pcr_bit = PCR_ARCH_300;
 	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		host_pcr_bit = PCR_ARCH_207;
@@ -379,6 +381,9 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 		case PVR_ARCH_300:
 			guest_pcr_bit = PCR_ARCH_300;
 			break;
+		case PVR_ARCH_31:
+			guest_pcr_bit = PCR_ARCH_31;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -2318,7 +2323,7 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 	 * to trap and then we emulate them.
 	 */
 	vcpu->arch.hfscr = HFSCR_TAR | HFSCR_EBB | HFSCR_PM | HFSCR_BHRB |
-		HFSCR_DSCR | HFSCR_VECVSX | HFSCR_FP;
+		HFSCR_DSCR | HFSCR_VECVSX | HFSCR_FP | HFSCR_PREFIX;
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
 		vcpu->arch.hfscr &= mfspr(SPRN_HFSCR);
 		if (cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
-- 
2.20.1

