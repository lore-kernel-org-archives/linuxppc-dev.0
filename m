Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB07C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 19:44:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9952063F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 19:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVVgYwid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9952063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z2km6L71zDqP2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 06:44:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="IVVgYwid"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z2QB45dbzDqXP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 06:29:38 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E3ED62176F;
 Tue,  8 Jan 2019 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546975765;
 bh=0AlTjQqK+uPi0Cm75wSlmaonb8yASqHjdCao1vhi/LM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IVVgYwidPfnd2oh2JHC7XOj4ZVOBHfE7tlamvBln8MAVfUEuzV2xNlgYhcezup9Gg
 9CArMYa4GnSc+pNIKolhHfTRt/vNFoKxpyw9Ur+sP785UnVE6vA0PgZMOSNMxoxA4V
 D62mfjEbNxdzGO1ognbUNo8Z3xoz+4r1pZgnQkzs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 107/117] KVM: PPC: Book3S HV: Align gfn to L1
 page size when inserting nest-rmap entry
Date: Tue,  8 Jan 2019 14:26:15 -0500
Message-Id: <20190108192628.121270-107-sashal@kernel.org>
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

[ Upstream commit 8400f8740651c1a3081c30b46004451c448f4d5f ]

Nested rmap entries are used to store the translation from L1 gpa to L2
gpa when entries are inserted into the shadow (nested) page tables. This
rmap list is located by indexing the rmap array in the memslot by L1
gfn. When we come to search for these entries we only know the L1 page size
(which could be PAGE_SIZE, 2M or a 1G page) and so can only select a gfn
aligned to that size. This means that when we insert the entry, so we can
find it later, we need to align the gfn we use to select the rmap list
in which to insert the entry to L1 page size as well.

By not doing this we were missing nested rmap entries when modifying L1
ptes which were for a page also passed through to an L2 guest.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 401d2ecbebc5..fc64535e4c00 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1220,6 +1220,8 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 			return ret;
 		shift = kvmppc_radix_level_to_shift(level);
 	}
+	/* Align gfn to the start of the page */
+	gfn = (gpa & ~((1UL << shift) - 1)) >> PAGE_SHIFT;
 
 	/* 3. Compute the pte we need to insert for nest_gpa -> host r_addr */
 
-- 
2.19.1

