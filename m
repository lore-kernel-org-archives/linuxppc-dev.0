Return-Path: <SRS0=ebkI=PJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A2DC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jan 2019 03:57:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93A9208E3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jan 2019 03:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93A9208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43TL3f5w4HzDqJ2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jan 2019 14:57:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43TL1B54b1zDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jan 2019 14:55:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43TL1B3r5vz9s3l; Tue,  1 Jan 2019 14:55:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43TL1B3MCBz9sBn; Tue,  1 Jan 2019 14:55:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] KVM: PPC: Book3S HV: radix: Fix uninitialized var build error
Date: Tue,  1 Jan 2019 14:55:13 +1100
Message-Id: <20190101035513.12444-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
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
Cc: paulus@samba.org, kvm-ppc@vger.kernel.org, sjitindarsingh@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Old GCCs (4.6.3 at least), aren't able to follow the logic in
__kvmhv_copy_tofrom_guest_radix() and warn that old_pid is used
uninitialized:

  arch/powerpc/kvm/book3s_64_mmu_radix.c:75:3: error: 'old_pid' may be
  used uninitialized in this function

The logic is OK, we only use old_pid if quadrant == 1, and in that
case it has definitely be initialised, eg:

	if (quadrant == 1) {
		old_pid = mfspr(SPRN_PID);
	...
	if (quadrant == 1 && pid != old_pid)
		mtspr(SPRN_PID, old_pid);

Annotate it to fix the error.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index fb88167a402a..1b821c6efdef 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -33,8 +33,8 @@ unsigned long __kvmhv_copy_tofrom_guest_radix(int lpid, int pid,
 					      gva_t eaddr, void *to, void *from,
 					      unsigned long n)
 {
+	int uninitialized_var(old_pid), old_lpid;
 	unsigned long quadrant, ret = n;
-	int old_pid, old_lpid;
 	bool is_load = !!to;
 
 	/* Can't access quadrants 1 or 2 in non-HV mode, call the HV to do it */
-- 
2.17.2

