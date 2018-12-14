Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20A4C67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:34:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112AD2075B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH2hXA/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112AD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GGPM0419zDqjL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:34:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DH2hXA/O";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DH2hXA/O"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GFvd42N9zDr61
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 14:11:57 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id z9so2109708pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 19:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nTpXPuR5nNBn4IJKLUkxEzOqae3TZevqo5p6ZkxTOqs=;
 b=DH2hXA/O0IwsUHOP103J9FwXCHjK83qEXPF8uiSoO032dSFufeYUdGcAj3NQLyztU4
 3Aa4e1rRIPeUWEKyDXwV31IzFgSR3j5Ew0Blmo3nx5xfw/pBJdklDO3KVY9AgeBKaZeh
 Dk2vQH5OsNZRXXb7Ys6BlbncJQVtClYVdjXKMyzRJ9fSoMKD+4zR+qkVKHS1RihC723o
 6EAUFPb1qo5a7CEsWK3DLQqNKZDMcHQWNJivYTiKwGUKUr09V99pjyVa5fzwi4wh0l3h
 SKfoVbl/tb0hKp+6qpXpBCTTMwHhcTaXm3OSGbauusI2cONr9gzLAjYetRFWNTOOb2gE
 puFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nTpXPuR5nNBn4IJKLUkxEzOqae3TZevqo5p6ZkxTOqs=;
 b=X9JKyoM3gDVlAxu79ffMXNY7IRBdauByiyNumYqp7COLNG2FZIAg7RWFF0RZXQ+Akr
 bUUOZwOVvxBRh+W/g0m8ApdR8rtP5+FAWfdzKp3ZtwQsLxvdpiU/4Hiozi+IVdMZzwLX
 ixrdPg/tHzqVRlQu6AQcO+UGv9jWfx2ExsSIuAAQhdhoDGC5Ixto+oyyWxggBBKulBI+
 OSbQuTL3X2Oj1MDzXw4Pwe6PFN/jJm+HwjuyXNgr6IxRgZbnRX6PoQLUqPheGTg+dsvC
 FffLdSEbtKjh6HHVJVrikJEzO1h3K7IlOJKiLE/jEMNuQKsswIR+r3QJUZMMbNDD3Tmu
 5dYQ==
X-Gm-Message-State: AA+aEWZl77FWNR2rEUC4VhvzjOmvKEN9vwFinxmz5ZPVQe34aFkv1PD9
 qol2IkTd5hPUc5PTv5FyrhM=
X-Google-Smtp-Source: AFSGD/WHJRxIUoIaHsYCHzDuX8bi+/+jkuFifyesmWS0BB92qplQPetk9tXaTeIRw7fF2ivO1BAR8w==
X-Received: by 2002:aa7:87ce:: with SMTP id i14mr1317248pfo.20.1544757116001; 
 Thu, 13 Dec 2018 19:11:56 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e188sm4079326pfg.130.2018.12.13.19.11.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 19:11:55 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V3 8/8] KVM: PPC: Book3S HV: Allow passthrough of an emulated
 device to an L3 guest
Date: Fri, 14 Dec 2018 14:11:09 +1100
Message-Id: <20181214031109.14464-9-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181214031109.14464-1-sjitindarsingh@gmail.com>
References: <20181214031109.14464-1-sjitindarsingh@gmail.com>
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

