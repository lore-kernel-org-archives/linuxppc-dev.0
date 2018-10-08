Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DB6C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:55:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BE620878
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="RRVFv7qS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BE620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TB1x2Zb4zF39j
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:55:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="RRVFv7qS";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T8BH2q73zF37W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:32:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="RRVFv7qS"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T8BH0pJmzB4NK; Mon,  8 Oct 2018 16:32:07 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T8BG3nQpz9sjH;
 Mon,  8 Oct 2018 16:32:06 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976726; bh=fyHv0GCD+Et+4zw6D3GPjoWgkEExjyndaObDOP4I6xk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RRVFv7qSPMor/IZOcWH7WIe5DwfszRG7U21HoXHvdfYZz12yp+9DAg9KQn03ZD0Bh
 3y30joIt/FOCL/WZ/CvseUsy+5GlOIzYGZvv6jKc0pyeR34qP5uu53ff/QAqUp1kw0
 KdBkLow7WdKO+w0AJNH/JAZqsU7Y+ZXeZXQnAyL8q9dAZOiaFn/ZEke9EvAOq+rmWQ
 Ag00audCgwwa6zIoAGQk2xgG8F4PoQOf1Ygt/Kidixc0Y9Lm3mMgHiB11obz8CjRQu
 LI/2TYr0VKDDykUUrmt6bHzuHnD/xJYypLu38RkkJgYRjcvWDNjyULJkKDaZPUUtZb
 5nZKx9Ma4BlnQ==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 33/33] KVM: PPC: Book3S HV: Add NO_HASH flag to
 GET_SMMU_INFO ioctl result
Date: Mon,  8 Oct 2018 16:31:19 +1100
Message-Id: <1538976679-1363-34-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
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

This adds a KVM_PPC_NO_HASH flag to the flags field of the
kvm_ppc_smmu_info struct, and arranges for it to be set when
running as a nested hypervisor, as an unambiguous indication
to userspace that HPT guests are not supported.  Reporting the
KVM_CAP_PPC_MMU_HASH_V3 capability as false could be taken as
indicating only that the new HPT features in ISA V3.0 are not
supported, leaving it ambiguous whether pre-V3.0 HPT features
are supported.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 Documentation/virtual/kvm/api.txt | 4 ++++
 arch/powerpc/kvm/book3s_hv.c      | 4 ++++
 include/uapi/linux/kvm.h          | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index fde48b6..df98b63 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2270,6 +2270,10 @@ The supported flags are:
         The emulated MMU supports 1T segments in addition to the
         standard 256M ones.
 
+    - KVM_PPC_NO_HASH
+	This flag indicates that HPT guests are not supported by KVM,
+	thus all guests must use radix MMU mode.
+
 The "slb_size" field indicates how many SLB entries are supported
 
 The "sps" array contains 8 entries indicating the supported base
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index fa61647..f565403 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4245,6 +4245,10 @@ static int kvm_vm_ioctl_get_smmu_info_hv(struct kvm *kvm,
 	kvmppc_add_seg_page_size(&sps, 16, SLB_VSID_L | SLB_VSID_LP_01);
 	kvmppc_add_seg_page_size(&sps, 24, SLB_VSID_L);
 
+	/* If running as a nested hypervisor, we don't support HPT guests */
+	if (kvmhv_on_pseries())
+		info->flags |= KVM_PPC_NO_HASH;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d9cec6b..7f2ff3a 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -719,6 +719,7 @@ struct kvm_ppc_one_seg_page_size {
 
 #define KVM_PPC_PAGE_SIZES_REAL		0x00000001
 #define KVM_PPC_1T_SEGMENTS		0x00000002
+#define KVM_PPC_NO_HASH			0x00000004
 
 struct kvm_ppc_smmu_info {
 	__u64 flags;
-- 
2.7.4

