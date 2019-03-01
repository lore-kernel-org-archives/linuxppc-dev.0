Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BD4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 03:28:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C7920854
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 03:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNrE0o0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C7920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449ZdW1LQrzDq6j
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 14:28:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZNrE0o0D"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449ZYf60gczDqSN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 14:25:26 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id i20so10723672pfo.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 19:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=kSXMDmSZ0U/9ToDD2qigO/uCuNo5s5LDXsit/OEBhR0=;
 b=ZNrE0o0DE/oQNgfJrQhx996PXjF9kPC5uNE1wR90RbVFYiph3xJKVYxovuAyHWCehw
 Vs9pO7YlEs3jm/mUmrQ+0Ufw3biHULGvWLJPnY+N7lis0OhosSIbY2kkziXylMgXCmfo
 QkQT/wLUO/wzj0rARQp9dQU6VGW8prceCJfYSzpooKJWkkCQRwEz6iiThpZHBrVml7XR
 5CBx0Fx8xHSmEF1SVCzAfhWRyWKRF5J9t8Yj9IZ+RJby1SmJYOJGU/peBsWopZDSGy0M
 ptDclMFQy/IGgvmmRa3thTYy4xA03daQBatEHBgL2VyKCVoeVyYqdhHURDsIEHM4DlCp
 ilfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kSXMDmSZ0U/9ToDD2qigO/uCuNo5s5LDXsit/OEBhR0=;
 b=rURtOBGQbn4lrsC05VqBw5OMnQwGyEIRD2Ux1l+1Vz5vvdzWiOLclJDGQeOhJsa7sk
 aLzxBathJItCREhWDLnCrFCJUFcUAcRVAQaeOLKaVyY8CsXKpHNhT3VwfdB9bEQA5ug7
 0RYGzH2wBkVFplVeaLf9+AvikPSDKlD0o6f9Cx+yR6Wgk+TH16BEf87XQ9YCdFjOUOPp
 tG+IC91zfUUGCq4Z31HzU9nKmAVT5Nt5eW8LZ3XQ68qDnOuaa549NDOPJqrlq38sLvWp
 C7uHRjjpzXqyZiU65Oupjiy1oGMjA50fyW9IBiOQiKDThw9MSvrFM0/F//RjNVsDjWHt
 iLRg==
X-Gm-Message-State: AHQUAub62pIr98wWaLPmyqfN4eFCqZrYnYEtZmCTFQG0EFLw36m4Acqc
 inqi8qltguG1o+j1pRq4Dmg=
X-Google-Smtp-Source: AHgI3IYa9w1AFEgYUs1OfnIaP36lMVxKY+iPl+vBen7kWA/kv75ejgQ+8yyy5OfmQO5MKbDyL9ou3A==
X-Received: by 2002:a62:4188:: with SMTP id g8mr3320286pfd.205.1551410724623; 
 Thu, 28 Feb 2019 19:25:24 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h64sm39767948pfj.40.2019.02.28.19.25.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 28 Feb 2019 19:25:24 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: powerpc: Add count cache flush parameters to
 kvmppc_get_cpu_char()
Date: Fri,  1 Mar 2019 14:25:16 +1100
Message-Id: <20190301032516.29919-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
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
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST &
KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE to the characteristics returned from
the H_GET_CPU_CHARACTERISTICS H-CALL, as queried from either the
hypervisor or the device tree.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/uapi/asm/kvm.h |  2 ++
 arch/powerpc/kvm/powerpc.c          | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 8c876c166ef2..26ca425f4c2c 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -463,10 +463,12 @@ struct kvm_ppc_cpu_char {
 #define KVM_PPC_CPU_CHAR_BR_HINT_HONOURED	(1ULL << 58)
 #define KVM_PPC_CPU_CHAR_MTTRIG_THR_RECONF	(1ULL << 57)
 #define KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS	(1ULL << 56)
+#define KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST	(1ull << 54)
 
 #define KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY	(1ULL << 63)
 #define KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR		(1ULL << 62)
 #define KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ULL << 61)
+#define KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58)
 
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b90a7d154180..a99dcac91e50 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -2189,10 +2189,12 @@ static int pseries_get_cpu_char(struct kvm_ppc_cpu_char *cp)
 			KVM_PPC_CPU_CHAR_L1D_THREAD_PRIV |
 			KVM_PPC_CPU_CHAR_BR_HINT_HONOURED |
 			KVM_PPC_CPU_CHAR_MTTRIG_THR_RECONF |
-			KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS;
+			KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS |
+			KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST;
 		cp->behaviour_mask = KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY |
 			KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR |
-			KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR;
+			KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR |
+			KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE;
 	}
 	return 0;
 }
@@ -2251,12 +2253,16 @@ static int kvmppc_get_cpu_char(struct kvm_ppc_cpu_char *cp)
 		if (have_fw_feat(fw_features, "enabled",
 				 "fw-count-cache-disabled"))
 			cp->character |= KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS;
+		if (have_fw_feat(fw_features, "enabled",
+				 "fw-count-cache-flush-bcctr2,0,0"))
+			cp->character |= KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST;
 		cp->character_mask = KVM_PPC_CPU_CHAR_SPEC_BAR_ORI31 |
 			KVM_PPC_CPU_CHAR_BCCTRL_SERIALISED |
 			KVM_PPC_CPU_CHAR_L1D_FLUSH_ORI30 |
 			KVM_PPC_CPU_CHAR_L1D_FLUSH_TRIG2 |
 			KVM_PPC_CPU_CHAR_L1D_THREAD_PRIV |
-			KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS;
+			KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS |
+			KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST;
 
 		if (have_fw_feat(fw_features, "enabled",
 				 "speculation-policy-favor-security"))
@@ -2267,9 +2273,13 @@ static int kvmppc_get_cpu_char(struct kvm_ppc_cpu_char *cp)
 		if (!have_fw_feat(fw_features, "disabled",
 				  "needs-spec-barrier-for-bound-checks"))
 			cp->behaviour |= KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR;
+		if (have_fw_feat(fw_features, "enabled",
+				 "needs-count-cache-flush-on-context-switch"))
+			cp->behaviour |= KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE;
 		cp->behaviour_mask = KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY |
 			KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR |
-			KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR;
+			KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR |
+			KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE;
 
 		of_node_put(fw_features);
 	}
-- 
2.13.6

