Return-Path: <linuxppc-dev+bounces-28390-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DBDC9833E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htdHZ4t0xz30Sx;
	Mon, 28 Sep 2026 20:45:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790592314;
	cv=none; b=O+24WEjFIsQtSaPdW/fFG0NfGNMXl5tRSEDTHA6dS+o85cmgpJhAb11AunkZKV8vWrMHNpidaBw3yBjBBwQHp5x8+sNzOSNgzYWlAuNk6S4Chsxt+zIIOL5/GbsLh5g3xsMgTR6N6vML6TNKT850CQouvP5oaXjMNOfDnmQn24fnNn2DTqo70UmX+v5c2ADbD7YpBaZibvzv04zqYtX427yzcvDqVztfljZwzZK8LjQ+zxH3ThYm6brgmuHF2bXFHFySNMB9EAYFK4ZRyKxg00j8BwlsFCB5r5BhwOIZfvxHJU0MEaH5Vd1yYpcw3CAKt8EO1+AdWpV+ImhKJY5ojg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790592314; c=relaxed/relaxed;
	bh=FRWWslO+/BIQXfzsm8/OFu4CVVZ4h6+o4ax7yTxGRKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8Kl1Av0DuI8IlWiTJVbGKtVQlL4fIcRglGU5Qkj3z7DlaL5KSAsOJkmr+5mSzU5nalKgYOnFrgbGNOlcJ0MlSDm6qt4YyPbbyHy+ciY0TL/ShKt7t2d2HBtJmM4f24yYlcpcEVP0OJWcuvDKJOsrZONeNfcxqc2EFBx5dYIQnCU1ZGu1rSYP3DD0fWCa/pNrhTcitYXRSvMfiFFgVymqr2iDujCCqjRJbKxyCVbo7R3H2GNxNRMgD//+XyLEbogFvfeAVkgOfyWR0M31mFE6c1N8/7fXLLmJEsYO6dy55ubHXL6xZymJULtEjiP35nmFY/jJRcl9y1l+DHp3V9TUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rSUBf2Ul; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rSUBf2Ul;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com [IPv6:2607:f8b0:4864:39::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htdHY6jpYz2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 20:45:13 +1000 (AEST)
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-398cb5615deso2351490a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592312; x=1791197112; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRWWslO+/BIQXfzsm8/OFu4CVVZ4h6+o4ax7yTxGRKw=;
        b=rSUBf2Ul6j/6YOee7S5A9NMFoS18/xv/Jt3guv6CmHFyKTKTApXL5bfRVH1CosOYrJ
         pAIebgJoyKuSsoA+79ycVgsnsJ3iR0Iq4zZNxf+5fFTI6gg+KnOdTfyLYmQa4L7MdvcN
         RlEudP9L2ThzwozgPEQk8oNh+25rS3hhJnVwpGEHfD4utrRfT7GCx8IWF4AOM70oU1ds
         x1E6QZKZoaexj39lV7vJ5o52dx51a7ZBauHQd+SwX4PYqGOXcRR+DHamcJnxQqG6FRm2
         xDDj2HZMNc0YPa6wa4Uzv3XF6HqEghHigGJWCNUboZ2wjRm4uir0kNocjRIyL2LDFbSJ
         qiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592312; x=1791197112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FRWWslO+/BIQXfzsm8/OFu4CVVZ4h6+o4ax7yTxGRKw=;
        b=uSudAv1LFuvq61+Wztr9YgoemAm+46NBuqYii4wUadUaCqo8IY/BqMDTDtsLbn4wlI
         YXq76d9UBXxXf73MaeJN/b/ETNdt6yRErkNB4uqQZE0MwZGJJW/uXl+hNCmu11Rinl3N
         /Fz9LWtLM2fTeRiKinDiDSzXCjcDIkZGxE1E/qFGrFc6QT79m1Dj12eLGE0xpzW4tTHY
         oqGc92a+SwXOqxlSDJ0QE1yEFt6pqgbrsaQyNftFvGeYWHS89PUbIjGvWwyyNeYlFo5J
         fQo5GIGDuZE9lmTrYjmNXhpHEhn1OcBDgPUPLCBXdgZ9BI1cU9moXjzK6LXJHxHBn4Uj
         dtOQ==
X-Gm-Message-State: AFq9FYK0PkG838fXMTCV9T4GIQCDfvts5AxMKIpi3r5m+5bstaEhXhr3
	pa2nqqE0ezFBZhd0A8Hd+C2bTD4UP8GJemTz2X8xgHiOgDq1CYOKTdbpLLbiykLP
X-Gm-Gg: AYBFou0o2jHkbJPRVgpO2Tu6JKdMqiCrcQuS1yyY+FZkmNzqZSlKah4FHtH2kvZc4XP
	EcT7dHQ16EYXl2NatZguMi1tnthllxJQhEGx5BX6X5bs64/CjxANxtJjkUiDZkXbiqaaPfYSNZU
	1iwWpuV4nr/WUhKpTLH/cDRRINKFWb08JU4/32y36NzcvkO8IFUdWu8I5nSiENjf6yF4/b3YsD7
	cDR1HbOQ3vTmLqqZqfkeIrL8XQqszAL6Od5DWkfTZBdXXZnQmryBMDFlDYEADE7lPv36iVDCWuB
	43LhjMHvLdcdBCrl7YzZ91wsRDgombnDv4jcRiNHNCIWTEO+8Rbw3DPX9te3TNKsXbYDbGVPXdj
	IfDU4vy5gH5nBUIZFk9bqL3axVW/40gvn+DaLBX5WfTNOE1Q9feP/H01uIztnYS5xI3kdWshpXs
	zurconFES7i24KgFV8pp8RfcK68g5M6ge9RylthcttBOizYTdLRhSuJKgBIwiyTohHOrkTivchJ
	mNwcugc5kjTohozXkxlWJ0WU8IGDIf+lLQEy6IinAsP37qczbJwz33KBo8oZw==
X-Received: by 2002:a17:90a:164f:b0:3a0:a912:e775 with SMTP id 98e67ed59e1d1-3a0a912eb90mr5962250a91.54.1790592311558;
        Mon, 28 Sep 2026 03:45:11 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm27071975a91.12.2026.09.28.03.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:45:10 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 5/6] powerpc/mm: Rework nohash TLB broadcast locking
Date: Mon, 28 Sep 2026 16:14:35 +0530
Message-Id: <d14bf0c33cac4a54601e0c2e4019a373ba342530.1790590014.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790590014.git.ritesh.list@gmail.com>
References: <cover.1790590014.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang's context analysis reports:
  mmu_context.c:141:2: error: releasing raw_spinlock 'context_lock' that was not held [-Werror,-Wthread-safety-analysis]
  mmu_context.c:147:1: error: raw_spinlock 'context_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]

  tlb.c:257:4: error: raw_spinlock 'tlbivax_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  tlb.c:259:5: error: releasing raw_spinlock 'tlbivax_lock' that was not held [-Werror,-Wthread-safety-analysis]

This reworks the locking in __flush_tlb_page() a bit to satisfy clang
context analyzer requirement.
Also steal_context_smp() drops the context_lock, so it needs to be
annotated with __must_hold to inform the clang analyzer that this
function holds the context_lock.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/nohash/mmu_context.c | 1 +
 arch/powerpc/mm/nohash/tlb.c         | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/nohash/mmu_context.c b/arch/powerpc/mm/nohash/mmu_context.c
index 28a96a10c907..bdbe1f55f388 100644
--- a/arch/powerpc/mm/nohash/mmu_context.c
+++ b/arch/powerpc/mm/nohash/mmu_context.c
@@ -95,6 +95,7 @@ static DEFINE_RAW_SPINLOCK(context_lock);
  *  -- benh
  */
 static unsigned int steal_context_smp(unsigned int id)
+			__must_hold(&context_lock)
 {
 	struct mm_struct *mm;
 	unsigned int cpu, max, i;
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 07a2db16c2b1..9297549aef41 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -252,11 +252,13 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 		/* If broadcast tlbivax is supported, use it */
 		if (mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
 			int lock = mmu_has_feature(MMU_FTR_LOCK_BCAST_INVAL);
-			if (lock)
+			if (lock) {
 				raw_spin_lock(&tlbivax_lock);
-			_tlbivax_bcast(vmaddr, pid, tsize, ind);
-			if (lock)
+				_tlbivax_bcast(vmaddr, pid, tsize, ind);
 				raw_spin_unlock(&tlbivax_lock);
+			} else {
+				_tlbivax_bcast(vmaddr, pid, tsize, ind);
+			}
 			goto bail;
 		} else {
 			struct tlb_flush_param p = {
-- 
2.39.5


