Return-Path: <linuxppc-dev+bounces-22406-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3CECD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:48:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5DP5Wz2z3bps;
	Wed, 10 Jun 2026 22:48:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095701;
	cv=none; b=oi+Z7D0wT1ytupJokxFxEmeaR0SU9o/GXYsQJmd+aB5cVwnOA1tUg6TpcX1KVWMpoN42hOtdy422mtzOdBhr+T5oJ08mXrDS0NfkBgpKJrtpohB40HoV8RtmtiK+aTU0qdFMP/+zjZ/OQm7IItn5MBwLp/J6r9no4NXxs5Toa1IESiJt/8ZeyR58fX7YCgOdWuzkMPzws+u6W77bSnGI+O2NwZvEkE+4ddVu2VHZVZ/cGx37P23f0Z67NneHiqwuMl5zs/B+Vxbmo/M9+uy4TK9wnnw1J9giqEi3HRO/mUcd2PYB/CZg53ZckKyPyru/GbD+XrJbnEu5yfxxWkAZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095701; c=relaxed/relaxed;
	bh=o8+a22vFLAJgAuwgI2KpSatIpPOW4GGFBsrZIpdJO1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0/JBmrwgqLsRmSIV5sB+jzNO41jZARk6+5GevDzvKbUoX1RHl2eG52L082Bgygge97jln/YWC+r8xGogiqZGp/Morielzir/VQ/j0AJ2AcOnCJ0reuYMwHYP8rKgFLl6O/UC/cuzXO8D6vgcSpuzTQ0n4fOkc4undWNyAuSLUsAmHMlJASXZwQsf9OV4JkOuxzLk1ctRv2aGYWl0lvc1kSIPCBjNFUdQO4uIN5CPUnEKQPfqJ5pekcbaDUxfmSoIiGRT87uFfPVIRsJ2S2xQJWzZagRfjqlC47nA948K0X/RovC9vhx4N7CZwke5It0VCYOlA7rnu/UGyGvTMznsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WlA8qw8n; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WlA8qw8n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5DP0wM2z3bpm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:48:21 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-36da151a152so4675563a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095699; x=1781700499; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8+a22vFLAJgAuwgI2KpSatIpPOW4GGFBsrZIpdJO1g=;
        b=WlA8qw8nRkEGEGxcapq32jAJaWpZJvTdOO5QLQUmLThQizBMhtcoZtpDi5LUk5iZd0
         AWRFtgGqVjKnzESLA6qsoKDXgGIG7nuK0zSZmHzWXEUfla3e1rfT99oWrDMHqSW7STS7
         8WX/9htsFCl5z2M98druE6lxEDf2YWolIP2ej6uhlmHTs1D2sHPaqOoKsCTj6H/AeiY0
         W5cJaXYL0omEw2iYjLOvx2nGBfWutR0jhEjSITGuojthmCwt525UWyXW3w4XO3Vy4HAc
         A3xqTiyTiy94k3WN0ywVYbimcjJu2SMqmjrpeRX8ia1E8sJEG6kGsczJWd81u6FF9psz
         UXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095699; x=1781700499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8+a22vFLAJgAuwgI2KpSatIpPOW4GGFBsrZIpdJO1g=;
        b=QeQ1p5EmEPO6ahOSPq+jeo+/LKniOUGi54JhGFCmB1Vu8JPbY8rDnQo2n4FQJ3rh8L
         /tCgGUmKMbLQ8jXtxT5ButQJIJQASJzoRPZfVPBba5UU9QrTfpvQaOXKljKgAwTJbZaf
         mydfSn10Hm996hDT1dH5A9x7drwHVwbf/xIu44L1y22hR5bVj/NwVCs0wNbmz5n7jgTn
         qz0nkLvFKE5KpPMVgXfQWVfdrdj2gbdy6J/6barSDLwqB9HH7GfZD39DMm0QGTgpyLVd
         biPgU+ckeh1p14TfAOIOhFbD0p/erdvmzoHiLFNfAecBnk2f/B73ZqoeuRuFa/W+Lklc
         tt1g==
X-Gm-Message-State: AOJu0Ywqzf9OvyPdquqTcyCYWM5yGH1kyquf9FK2vM/S9MpoRHmF1zDx
	/SqevpeDb7y204MtvqqcnPjAdFXSQ9Wf8EADG6gX+h28E9v9NRgBe+tP
X-Gm-Gg: Acq92OEQydjEBnxP1fnV0nbA04gshXn8NGBiWdOCCopFwGln8LudB8PuUSvvRgpd2uZ
	MLwLiLXRJd77skXklTSbBH9LFfVcYUKcs2vpLPwkE3rf1SVAGs+df1NcQfzho4OrKMtcW25Yj1b
	0dG5l7fDAEUIOiHvSd/cHzyUPgiUOYvY8zOVYwAuWpQ/U/DBcDboLyX0W8Y0QTpinmTNss9Y1Mh
	9o1OhyTBsT3mp0EXKrRuBX28eNN95vR6fTRqoNxfx6q9kwUbe39ZriOW0CSR4kEkkCgmUxziRYR
	TNm51+CdMXe/AGrCUmPqeKOuNGgqXKvWwaqXPZLktsjQ9d4KLVgNwmtByDE1mljtgHsp3dBpeQj
	TDrhww8CI36CkuORWW4ZlDXmafDU/X0Y1w+vxSSAAlqbf/HEL16JLHtqDa6hFOj0UlOvtinLc1Z
	qp/MVmmCFXJFX3AG15FZ+idwXDGBwqRRqD3lPAFmawhcoO3CK8vXL9k5e3YtSpD/BNgmvLK11o
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-370eee03facmr24853662a91.8.1781095699281;
        Wed, 10 Jun 2026 05:48:19 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:18 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 07/10] KVM: PPC: selftests: Use s64 instead of int64_t
Date: Wed, 10 Jun 2026 18:17:23 +0530
Message-ID: <851c5eaf017e29795adc5681ea568a78182cc0ac.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
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

commit 286e8903aed14 ("KVM: selftests: Use s64 instead of int64_t")
made this change from int64_t -> s64 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.
It uses the same method describes in above commit.

  git ls-files tools/testing/selftests/kvm | xargs sed -i 's/int64_t/s64/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/powerpc/hcall.h | 6 +++---
 tools/testing/selftests/kvm/lib/powerpc/hcall.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
index f923b3f5e233..21b2bf9180f1 100644
--- a/tools/testing/selftests/kvm/include/powerpc/hcall.h
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -10,8 +10,8 @@
 /* Ucalls use unimplemented PAPR hcall 0 which exits KVM */
 #define H_UCALL	0
 
-int64_t hcall0(u64 token);
-int64_t hcall1(u64 token, u64 arg1);
-int64_t hcall2(u64 token, u64 arg1, u64 arg2);
+s64 hcall0(u64 token);
+s64 hcall1(u64 token, u64 arg1);
+s64 hcall2(u64 token, u64 arg1, u64 arg2);
 
 #endif
diff --git a/tools/testing/selftests/kvm/lib/powerpc/hcall.c b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
index cd10022572a5..d5f5282654ee 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/hcall.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
@@ -5,7 +5,7 @@
 #include "kvm_util.h"
 #include "hcall.h"
 
-int64_t hcall0(u64 token)
+s64 hcall0(u64 token)
 {
 	register uintptr_t r3 asm ("r3") = token;
 
@@ -17,7 +17,7 @@ int64_t hcall0(u64 token)
 	return r3;
 }
 
-int64_t hcall1(u64 token, u64 arg1)
+s64 hcall1(u64 token, u64 arg1)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
@@ -30,7 +30,7 @@ int64_t hcall1(u64 token, u64 arg1)
 	return r3;
 }
 
-int64_t hcall2(u64 token, u64 arg1, u64 arg2)
+s64 hcall2(u64 token, u64 arg1, u64 arg2)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
-- 
2.50.1 (Apple Git-155)


