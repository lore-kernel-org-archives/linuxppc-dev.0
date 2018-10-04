Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CCC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:36:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BE6205C9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="FgWmovSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BE6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qsny5TyczDrS2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 22:36:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="FgWmovSl";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QrvX6p24zF3Jq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="FgWmovSl"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42QrvX5hdvzB4Mj; Thu,  4 Oct 2018 21:56:24 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42QrvX3thcz9sj3;
 Thu,  4 Oct 2018 21:56:24 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654184; bh=Cd+zrEQ3x6D1MSIsyaX/9Wnk3ETIaCk3BO882T7G/4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FgWmovSlUDnPk9qjov7uXJKFuHoy75wQfzePCSXT7uVgkUGVc+xBtGILOnkccs+Cz
 rCqJevqL9MJ4vBWeTt8TkuRro7sD4vADwdslbFO2CzDeKHyeOwVfmIqScfKi/Q+xWH
 pHtm74OQNyi4jJV0T9zZpeudoON0xVJS6cQ1db+Ba70+QdjvgQ/WRX23bPNMA8nmA1
 fRGiXZ3SI9erkN7I1oSW+/0Telt8hxb6UgsXAuiOS+V5HCxPD7fZScw8m0n8G4Qtzf
 Rqd2/SmHqRTovZRVp5tg6OIXF901QAA7LLwVlUuwtYFq+HpTseD2w7IyZLpGBJ1Vf0
 VQ5sgezLm4QvQ==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 13/32] KVM: PPC: Book3S HV: Clear partition table entry on
 vm teardown
Date: Thu,  4 Oct 2018 21:55:50 +1000
Message-Id: <1538654169-15602-14-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

When destroying a VM we return the LPID to the pool, however we never
zero the partition table entry. This is instead done when we reallocate
the LPID.

Zero the partition table entry on VM teardown before returning the LPID
to the pool. This means if we were running as a nested hypervisor the
real hypervisor could use this to determine when it can free resources.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 01a0532..ca0e4f4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4501,13 +4501,19 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 
 	kvmppc_free_vcores(kvm);
 
-	kvmppc_free_lpid(kvm->arch.lpid);
 
 	if (kvm_is_radix(kvm))
 		kvmppc_free_radix(kvm);
 	else
 		kvmppc_free_hpt(&kvm->arch.hpt);
 
+	/* Perform global invalidation and return lpid to the pool */
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		kvm->arch.process_table = 0;
+		kvmppc_setup_partition_table(kvm);
+	}
+	kvmppc_free_lpid(kvm->arch.lpid);
+
 	kvmppc_free_pimap(kvm);
 }
 
-- 
2.7.4

