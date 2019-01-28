Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE07DC282CD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 23:41:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57D52175B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 23:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57D52175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pR445MW3zDqLR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 10:41:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gentoo.org
 (client-ip=2001:470:ea4a:1:5054:ff:fec7:86e4; helo=smtp.gentoo.org;
 envelope-from=chrisadr@gentoo.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gentoo.org
X-Greylist: delayed 374 seconds by postgrey-1.36 at bilbo;
 Tue, 29 Jan 2019 10:40:19 AEDT
Received: from smtp.gentoo.org (woodpecker.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pR2C3JtPzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 10:40:19 +1100 (AEDT)
Received: from gentoo.cpe.tdp.com (unknown [181.67.136.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: chrisadr)
 by smtp.gentoo.org (Postfix) with ESMTPSA id D00E8335D40;
 Mon, 28 Jan 2019 23:33:51 +0000 (UTC)
From: Christopher Diaz Riveros <chrisadr@gentoo.org>
To: paulus@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [patch-next] KVM: PPC: Book3S HV: Use kzalloc_node
Date: Mon, 28 Jan 2019 18:33:09 -0500
Message-Id: <20190128233309.14447-1-chrisadr@gentoo.org>
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
Cc: Christopher Diaz Riveros <chrisadr@gentoo.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes coccinelle warning:

/arch/powerpc/kvm/book3s_hv.c:5345:3-15: WARNING: kzalloc_node should be used for sibling_subcore_state, instead of kmalloc_node/memset

Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>
---
 arch/powerpc/kvm/book3s_hv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5a066fc299e1..fc59bfa892c9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5342,14 +5342,11 @@ static int kvm_init_subcore_bitmap(void)
 			continue;
 
 		sibling_subcore_state =
-			kmalloc_node(sizeof(struct sibling_subcore_state),
+			kzalloc_node(sizeof(struct sibling_subcore_state),
 							GFP_KERNEL, node);
 		if (!sibling_subcore_state)
 			return -ENOMEM;
 
-		memset(sibling_subcore_state, 0,
-				sizeof(struct sibling_subcore_state));
-
 		for (j = 0; j < threads_per_core; j++) {
 			int cpu = first_cpu + j;
 
-- 
2.20.1

