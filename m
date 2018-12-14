Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E1EC67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 05:52:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE57420645
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 05:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ParHppv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE57420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GKSj6ZtfzDqfD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 16:52:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ParHppv5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ParHppv5"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GJz25BBqzDr9M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 16:30:06 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id 64so2252763pfr.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 21:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nTpXPuR5nNBn4IJKLUkxEzOqae3TZevqo5p6ZkxTOqs=;
 b=ParHppv5ngEFUloWa+UXwi5BmComGUJ4tQ+QZvXxdYFamyMWUzshnksCxkOnH06EEA
 8neJGHRwxVvZwo5hZINYGb+Xj735spYhgLCNFudFTxIDop1IdS+QrAccyD0/jmmpUOyq
 cpC4CwTLX1iqarz8G1/D44KWlai79dPrGIB2uP6Oky41pKIWBUnBcm0jvBPziOqUdP98
 OjuXZe64i0C51bwGapO/n5kvFZwe1McL/4B9L6kQclhcAkKhp9nDQaYORRoaPX02IqCd
 3pynMWukZeB+DhzaCH9JGgUztm0ra56XZDDoJinRYO2REO2vVOi5iSP7HRf5VVL2FsN3
 JSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nTpXPuR5nNBn4IJKLUkxEzOqae3TZevqo5p6ZkxTOqs=;
 b=daPlMZsUEoah6Z85VIwmMuPAvDqNCDzXKL3tUzllCKFYPRofo9vV/gHezmVtRs06v3
 dEgSg5HYLPbOXRNkInLtYMo/Coeu/lpoKt7yYcQfwhsb+TJT57zzCuJT2n9G5vn0htgK
 vKBIDGZLqRw5FkT/2iVex40i3pRXqv4Gwmc5/xC+9weOlL/LSi/DlrXd8XMQfyOXih2T
 kIx07cntogLYGEXrxqIkqJCZfeanTF/psSDgXuV1vQhcljZl8u7pxe5hLyU7f8ebRH05
 CaUlyJyCDEJ5KUDek6J08pWo2xXJKlwyrRxgjg/Q2PgNxgmp9/+fYChwr/+pmzfJIhyN
 C3Uw==
X-Gm-Message-State: AA+aEWZAOmhSGFf1fRdp1rqfysSDWpBsQoB0EPNHP2zXYidfao7q4EYW
 +0z5vtzjpUDXSHR2OKmhXIo=
X-Google-Smtp-Source: AFSGD/W5YSFkAFVbAXrhVq9mugjvHCM94u2N7MR5GQmjjmzPCLJPbrtF/gWdKQaBoNdcXwQ6yryhFw==
X-Received: by 2002:a63:e348:: with SMTP id o8mr1534306pgj.158.1544765404738; 
 Thu, 13 Dec 2018 21:30:04 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d21sm5358697pgv.37.2018.12.13.21.30.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 21:30:03 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V4 8/8] KVM: PPC: Book3S HV: Allow passthrough of an emulated
 device to an L3 guest
Date: Fri, 14 Dec 2018 16:29:10 +1100
Message-Id: <20181214052910.23639-9-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181214052910.23639-1-sjitindarsingh@gmail.com>
References: <20181214052910.23639-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, sjitindarsingh@gmail.com,
 kvm@vger.kernel.org
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
index da89d10e5886..8522b034a4b2 100644
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
+					  __pa(to), __pa(from), n);
 
 	quadrant = 1;
 	if (!pid)
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 5903175751b4..a9db12cbc0fa 100644
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

