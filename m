Return-Path: <linuxppc-dev+bounces-17927-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4D9FCA16A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 18:15:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV4tZ6MSDz3cB5;
	Tue, 10 Mar 2026 05:15:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773080118;
	cv=none; b=QQes/iC1UBlIIeBJ8wtB/heGWSiamSzzhtIgLv3xmBE0hKOugXVlRtV1JqMfXOQdokDg1lY2nVx3DeV6uC3Hc55Ws3VkGLOW1xrOLCUlMiIQJD4qi8XHY6cQvqMzyB+13a9KzQqPczzVPIUf8DQIc5EvSJjuwSlSTCCiWsmHUuSvaj8Yiigcs/0NYvU3X7JG0bQ0JyifGwdsXA8BXbJCArRt3MsGQx9aal7bE6BED8my9zHGtv/poykvTJVjWqGo/eEKjW+DOi0y9PgCBnScWQnax4Y5Zz+2UngPOYFvhbJhqFGFMYAqF3aPlPQzfGVdkDF+8SgPEI/vCb4QyZi7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773080118; c=relaxed/relaxed;
	bh=EThQZPAn5p3HZn+053ZBuFvMa7mmWDdxd++vERoQwoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXTxOiZ2FEPVRYa8lK5WEu6imkSilHIIsNmofNj+jIQp7UYpSXxO+cuteafLTznAsRezqE0EWo+s2omh7UpYff42+13vWjae1LTxIVnO7kN2nRCWQPmRcxtwxbDIbdXQQyQGFb1pcC+lRj3f2p+ypuw6vfsFDR5+o12DQebW6pX267vnKrM0msRi7x2igmTtChPwDS0xpnbNKqtiilJzV0dRjmCxQ0YGa6hqiUluasWmsARODrRCpzCqDIB39WcItFruxdHne9YUqCdE5lw2T24dCt7hB9oYMu6eiHDB8qkYCxOOr8p9xGZr4LMA00ybnPQYkfQT+sucd3imCSSX1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iVSXlX0b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iVSXlX0b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV4tZ12gPz3cBW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 05:15:18 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8299f1ca894so1940938b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773080116; x=1773684916; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EThQZPAn5p3HZn+053ZBuFvMa7mmWDdxd++vERoQwoM=;
        b=iVSXlX0bjkYWkn1GnlcyF2kn/vwmJWX7v1NgdRXGw76dexFHmlzpIRj067rd1F5iMo
         qMjpEJ/2sahwQfPtRMcIdmhxAqBV/7MyR/mW+BROKHqYCuKpsaHYNBkzV0AT4mIBE12f
         SWF+njIFa7+R8AtDgVV0FXl/ASwe9Bp3+LjTqecU0OSPcXv+OxSsM1H93r4t4V+hKQym
         paA8vzSViPpk9FSTomu4xsrVXMExWOPSwu95o8H0vUnCEr2iYp+8YiT2Ni+P+KWLrcqf
         AoWk0WTnayUSZOPKHt4PfH0xqI9W5ofqHjl5H0jBx5bW1twJu1CYg5yIIfHgcoc4ksYL
         UVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773080116; x=1773684916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EThQZPAn5p3HZn+053ZBuFvMa7mmWDdxd++vERoQwoM=;
        b=sp5XdZ35WGMLY9tcFX5R1AeZhf1PCsDsISFENo5dSuO9aHHh7dZYZRSarw8EzYL1Gu
         04Q5xLZRUT6109DlUN4t30vGnwzH1pD8EONft8T+H4WNHzkLkiFSKRFSiEO36p6wGx8x
         4RrPqdhZuJErrPglrKhLqvzlxSiZKRFecwOvltttbowTdsOZ2WHCSKyUDf6fJeks/lVd
         /6OZnpNZuHdEvL/Arq8bDO4BsRQfnzPhRjO0rNAG3ANmoioScZEe5uJJ/nsapMmcc6y7
         aPiXrCGcSCbK9rz5et3otp7oA14UhkUGXVgoSzo97KTycoi/kzmmhdUd6HeZylF7zupt
         tGww==
X-Gm-Message-State: AOJu0Yx/J7PGzHooEDYCGSKNWOZJPpyXijSBKc8fUF15ULfDd5fUdLnS
	DusHI6fYhA9VBjx3JBnIVEHdMq1wSrr2t0RCc2ZBvPTzABX8djcg4uF+T6p+YMqy
X-Gm-Gg: ATEYQzwZKYwNYjkziu4AaoCQiFZrx6sPMTC/aU1wqIYnHWlzHNeNVycqol7O0LidlHB
	KDxLBofzP2c88J6mVw8tJEWp/mlT3N4FV4C5IRjGgrUhZ/PJXqlphVh2tJyYKj2Fek4b+O5l6ve
	tpX2z4wNfzv933WoVZ+qkqg1Q3yN7FhrrIr6TgWPs3qkVs9j0hyw472TwI67Ghd3OUPCVgSN19n
	cZaIUSReipN5UrEd6gX5AT/7J424+xStgUYxyJPHlxzLtsR8Jou8TWeWG9/cFGGMB0ALBbG5jKS
	a/KMWaicZ8K5egfQQNQGWLdns7LGw32MC+C5bS2O/lT8lifbN+M7btNkgweYgVVDJEIoYoUVA3f
	R8ozSaV6iZ17Cn2CaV/z5fl+gixM15eDBRu5M2CLG2jGb61pjEY00/UwOGeIlhAVRrp/vX5SS3l
	9MlqEqSIKa6CEKj1HkNolPeqVhYtEFIiMQC/SEy6/vPjdPDhXKMur996f96na12e7w
X-Received: by 2002:a05:6a00:a883:b0:829:a127:530 with SMTP id d2e1a72fcca58-829a2f33534mr10152414b3a.31.1773080115444;
        Mon, 09 Mar 2026 11:15:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f29:53c8:742c:4036:d7c6:9024])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a46765a6sm10775477b3a.29.2026.03.09.11.15.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Mar 2026 11:15:14 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 07/10] powerpc/64s: Rename tlbie_va_lpid to tlbie_va_pid_lpid
Date: Mon,  9 Mar 2026 23:44:30 +0530
Message-ID: <0a0b2cf23b9522f891f9a0f976bbdc5c8e6f6d8b.1773078178.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1773078178.git.ritesh.list@gmail.com>
References: <cover.1773078178.git.ritesh.list@gmail.com>
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

It only make sense to rename these functions, so it's better reflect what
they are supposed to do. For e.g. __tlbie_va_pid_lpid name better reflect
that it is invalidating tlbie using VA, PID and LPID.

No functional change in this patch.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_tlb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 339bd276840b..1adf20798ca6 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -1411,7 +1411,7 @@ static __always_inline void __tlbie_pid_lpid(unsigned long pid,
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
-static __always_inline void __tlbie_va_lpid(unsigned long va, unsigned long pid,
+static __always_inline void __tlbie_va_pid_lpid(unsigned long va, unsigned long pid,
 					    unsigned long lpid,
 					    unsigned long ap, unsigned long ric)
 {
@@ -1443,7 +1443,7 @@ static inline void fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
 
 	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
 		asm volatile("ptesync" : : : "memory");
-		__tlbie_va_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
+		__tlbie_va_pid_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
 				RIC_FLUSH_TLB);
 	}
 }
@@ -1474,7 +1474,7 @@ static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
 	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 }
 
-static inline void fixup_tlbie_va_range_lpid(unsigned long va,
+static inline void fixup_tlbie_va_range_pid_lpid(unsigned long va,
 					     unsigned long pid,
 					     unsigned long lpid,
 					     unsigned long ap)
@@ -1486,11 +1486,11 @@ static inline void fixup_tlbie_va_range_lpid(unsigned long va,
 
 	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
 		asm volatile("ptesync" : : : "memory");
-		__tlbie_va_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
+		__tlbie_va_pid_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
 	}
 }
 
-static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
+static inline void __tlbie_va_range_pid_lpid(unsigned long start, unsigned long end,
 					 unsigned long pid, unsigned long lpid,
 					 unsigned long page_size,
 					 unsigned long psize)
@@ -1499,12 +1499,12 @@ static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
 	unsigned long ap = mmu_get_ap(psize);
 
 	for (addr = start; addr < end; addr += page_size)
-		__tlbie_va_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
+		__tlbie_va_pid_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
 
-	fixup_tlbie_va_range_lpid(addr - page_size, pid, lpid, ap);
+	fixup_tlbie_va_range_pid_lpid(addr - page_size, pid, lpid, ap);
 }
 
-static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
+static inline void _tlbie_va_range_pid_lpid(unsigned long start, unsigned long end,
 					unsigned long pid, unsigned long lpid,
 					unsigned long page_size,
 					unsigned long psize, bool also_pwc)
@@ -1512,7 +1512,7 @@ static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
 	asm volatile("ptesync" : : : "memory");
 	if (also_pwc)
 		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
-	__tlbie_va_range_lpid(start, end, pid, lpid, page_size, psize);
+	__tlbie_va_range_pid_lpid(start, end, pid, lpid, page_size, psize);
 	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 }
 
@@ -1563,7 +1563,7 @@ void do_h_rpt_invalidate_prt(unsigned long pid, unsigned long lpid,
 			_tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
 			return;
 		}
-		_tlbie_va_range_lpid(start, end, pid, lpid,
+		_tlbie_va_range_pid_lpid(start, end, pid, lpid,
 				     (1UL << def->shift), psize, false);
 	}
 }
-- 
2.50.1 (Apple Git-155)


