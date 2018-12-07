Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E780FC65BAF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:10:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CE82082D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ornqZ8Y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CE82082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439zWs1nrMzDr0d
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:10:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ornqZ8Y7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ornqZ8Y7"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yy90mYvzDrWQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:44:17 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id gn14so1159967plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DbPqPcd4WIKnhVkwlfCIadFdzwDFLEQDHrX3PfHEBIg=;
 b=ornqZ8Y7u/vnhxIPLZLmMINaCBfmQTKFL+oZFhvnsfoWjMtNta070DKhmPEuR6trlT
 CvD98lJQspK+vBPH2A0jZxtMxOssjuh+wBkGLIewN5IBrk1Ol+wbJX2WdOF+wxqXJ6rY
 YR4eNbLSznIIqsvtnjtOMNmFkpTGpl6/8z+aqxLGpU98XkIduGCXxYgmxXO2Y+y003zf
 TxppfA38+TWXoOkdFRu29cXdaz2VTm4b5Ie5kTdpa4jAa25fRSn2cMgjtGme1zY4N+F3
 6VedS38IbJmKeN1nTyQH7t3s/bqpumKdGNtK4fub1zvAJy+GJmeo8nxK7C/+vIqHQ8UX
 C7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DbPqPcd4WIKnhVkwlfCIadFdzwDFLEQDHrX3PfHEBIg=;
 b=ZidwhAz16gMwxijbFUY+J2ytwcZQksb/SI4eMj6yN3nncqrrXJGW2Fzc2mwdkX99vB
 i+GPs2S9X25+lMYFkIuhz+41w8x/atOoX4kJoBTKGxx7AgnzxB4o/VaU3Yv6iM3M9n0u
 UYJKiLtp6PlbyZwCd34imck9My/Io1iHynsy3Ww3qj8K+08v1510gRbAIzsNjYXLk3AY
 3lJAhI7QdXwmVPBlrOX1io46fh3Y6pz1bgcXnpK/olqw6vx1I/A9w4GWlLhY8P/YvAXC
 tO41yJixQ18LxvoJyyoeENXmdGQpcyuZW+KOzk/LaIvex8Y9fMYzFgBhe/OUq90bzgBe
 C8vw==
X-Gm-Message-State: AA+aEWa2OI93Fk0OO37SeHHaUNJUNzIEL3NJK+TfS7JFJ2LqdVFRdGcH
 lVlpLksTdQOxhnCzRFVRAOI=
X-Google-Smtp-Source: AFSGD/VPcSK6ZwppF9eO4vHJjx7Tb4A21YfFIclX6hpIrX3StcHfQU3+XKnNlbovqLUBRwZNfhe1ew==
X-Received: by 2002:a17:902:298a:: with SMTP id
 h10mr654466plb.312.1544154255507; 
 Thu, 06 Dec 2018 19:44:15 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.44.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:44:15 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 8/8] KVM: PPC: Book3S HV: Allow passthrough of an emulated
 device to an L3 guest
Date: Fri,  7 Dec 2018 14:43:26 +1100
Message-Id: <20181207034326.3564-10-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181207034326.3564-1-sjitindarsingh@gmail.com>
References: <20181207034326.3564-1-sjitindarsingh@gmail.com>
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

