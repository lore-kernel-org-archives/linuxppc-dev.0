Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A749BC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BBF2063F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpFC4Cug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BBF2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z2pB74JgzDqP2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 06:46:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="SpFC4Cug"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z2QB45k0zDqXD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 06:29:38 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 09A75217D9;
 Tue,  8 Jan 2019 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546975766;
 bh=zpKBx+Mr14lsVMT+rVCB0LfSUJmnEFxpb6RSAuLos4Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SpFC4CugkqmPKPAVlEurMKIGmTyJ2r/Wl4v+bpgRX7tQlS2jENpE2NwYUbFuMo5ih
 V3cqWOosPVPWv6V0bcjXF0AXRMtfx5YqwE9onIeZXi2znmuFOysoa8lnrB4XhlcTcC
 ghh6MnlWX+pflUnDAZDaiLdeAgM7kRw+LFW/0muQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 108/117] KVM: PPC: Book3S HV: Apply combination
 of host and l1 pte rc for nested guest
Date: Tue,  8 Jan 2019 14:26:16 -0500
Message-Id: <20190108192628.121270-108-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

[ Upstream commit 8b23eee4e55a32a2b51a180dfd27a8d214acc7a1 ]

The shadow page table contains ptes for translations from nested guest
address to host address. Currently when creating these ptes we take the
rc bits from the pte for the L1 guest address to host address
translation. This is incorrect as we must also factor in the rc bits
from the pte for the nested guest address to L1 guest address
translation (as contained in the L1 guest partition table for the nested
guest).

By not calculating these bits correctly L1 may not have been correctly
notified when it needed to update its rc bits in the partition table it
maintains for its nested guest.

Modify the code so that the rc bits in the resultant pte for the L2->L0
translation are the 'and' of the rc bits in the L2->L1 pte and the L1->L0
pte, also accounting for whether this was a write access when setting
the dirty bit.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index fc64535e4c00..f8176ae3a5a7 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1229,6 +1229,9 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 	perm |= gpte.may_read ? 0UL : _PAGE_READ;
 	perm |= gpte.may_write ? 0UL : _PAGE_WRITE;
 	perm |= gpte.may_execute ? 0UL : _PAGE_EXEC;
+	/* Only set accessed/dirty (rc) bits if set in host and l1 guest ptes */
+	perm |= (gpte.rc & _PAGE_ACCESSED) ? 0UL : _PAGE_ACCESSED;
+	perm |= ((gpte.rc & _PAGE_DIRTY) && writing) ? 0UL : _PAGE_DIRTY;
 	pte = __pte(pte_val(pte) & ~perm);
 
 	/* What size pte can we insert? */
-- 
2.19.1

