Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B613C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:21:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EEA2081C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCj3Qsy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EEA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Cqdr4JnbzDqKf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCj3Qsy6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCj3Qsy6"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cq8036ckzDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:59:12 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id i12so4710615pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 19:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DbPqPcd4WIKnhVkwlfCIadFdzwDFLEQDHrX3PfHEBIg=;
 b=SCj3Qsy6YhoCBKhmR0TPSiBJfVS2aVrMCz4+d6m5ZNm1UotopnHhCbVSsNpl5OFS3W
 1s5MhXhx7T7AUY9Nn24j+cvRSz1G/QH8rhqwVqNWh9jKatj086u09+2v/iLPqW/zOo0L
 IulwvNFsqmAUllLnU0hgNm+at1u82lfR11j7QE46TfhC5CrEP2eHAJ1Yu08nwN0bC0Nw
 p/28f9o+0ZKa71GJqvZMr8OZGSMI1BsQAKch8ER/4Bw7NkJhdjvX5DQVfHqPLXos+Sdh
 1sEZnXlyakRbmQ7xQxiGv45nqMsbUpiWlTmcO7H76KeLApfCdhsiyeV4t6+3cMPazdxg
 JUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DbPqPcd4WIKnhVkwlfCIadFdzwDFLEQDHrX3PfHEBIg=;
 b=edGOL32Y1yO2nSc2q0RfVjLvOOx5DBhuehUkkxUcKL+D+l1zXf/9rK6iiHmETcTxvl
 oxgIbeIAYbaffZbrR7KY3R5t6QsLiaryFNoKrsutKR+1nOZkiwwhdFjj28wfUXlT6AZw
 s5xbetUtFuG8kri61fJAxUaPk/Tla7BhuqOLzA3jF/2J9vnb1UbqH2Z22k6s9FO2g7pC
 Wjgucutvp+vAU7EC88Am2hPJfmI1puIxoROIoMBQE/CZAtKeHNEc12rt9VuFG+HtenmM
 wL+pD2B3jONd0E/ep1F9IsmJw3GHG5Np+ANivEZB3Wx47DHs/5sCMlJExU+GLCPQQwOR
 tPjw==
X-Gm-Message-State: AA+aEWbwJNash38jD/7CpaHznXk/pRv/OgnuAoibuAVOirgbrqf9cy4f
 5NFz4HuZ1SBKyTs+VqewoOI0u6Bv
X-Google-Smtp-Source: AFSGD/VP/xdVZj30p2ZzaxdpdfaUGnh4zxaUNDXlid5n1TjLuf/sMKo/Ozgys89W3ybYhvyC3OuVaQ==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr11080980pfn.125.1544414350889; 
 Sun, 09 Dec 2018 19:59:10 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f6sm14291899pfg.188.2018.12.09.19.59.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 19:59:10 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V2 8/8] KVM: PPC: Book3S HV: Allow passthrough of an emulated
 device to an L3 guest
Date: Mon, 10 Dec 2018 14:58:25 +1100
Message-Id: <20181210035825.29404-9-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181210035825.29404-1-sjitindarsingh@gmail.com>
References: <20181210035825.29404-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 sjitindarsingh@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Previously when a device was being emulated by an L1 guest for an L2
guest, that device couldn't then be passed through to an L3 guest. This
was because the L1 guest had no method for accessing L3 memory.

The hcall H_COPY_TOFROM_GUEST provides this access. Thus this setup for
passthrough can now be allowed.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 9 ++++-----
 arch/powerpc/kvm/book3s_hv_nested.c    | 5 -----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index da89d10e5886..cf16e9d207a5 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -37,11 +37,10 @@ unsigned long __kvmhv_copy_tofrom_guest_radix(int lpid, int pid,
 	int old_pid, old_lpid;
 	bool is_load = !!to;
 
-	/* Can't access quadrants 1 or 2 in non-HV mode */
-	if (kvmhv_on_pseries()) {
-		/* TODO h-call */
-		return -EPERM;
-	}
+	/* Can't access quadrants 1 or 2 in non-HV mode, call the HV to do it */
+	if (kvmhv_on_pseries())
+		return plpar_hcall_norets(H_COPY_TOFROM_GUEST, lpid, pid, eaddr,
+					  to, from, n);
 
 	quadrant = 1;
 	if (!pid)
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index f54301fcfbe4..acde90eb56f7 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1284,11 +1284,6 @@ static long int __kvmhv_nested_page_fault(struct kvm_run *run,
 		}
 
 		/* passthrough of emulated MMIO case */
-		if (kvmhv_on_pseries()) {
-			pr_err("emulated MMIO passthrough?\n");
-			return -EINVAL;
-		}
-
 		return kvmppc_hv_emulate_mmio(run, vcpu, gpa, ea, writing);
 	}
 	if (memslot->flags & KVM_MEM_READONLY) {
-- 
2.13.6

