Return-Path: <linuxppc-dev+bounces-27115-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B349C79FA1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 07:04:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh5CC4m5dz2yjN;
	Fri, 11 Sep 2026 17:04:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789110295;
	cv=none; b=ZbJV3j+vO0IbIU5Mrp/JqZFDRBrpiZTfZqP828yYm4Bk3puREt4YMXBVy+YZI+1vAaS775lXn0fHSpCrw4GXpE6Q59Pwx8hd+FQOEesJHbuvbpdzW2Vklpdy/X2mcBjTZys+XbVxv3DFkkTzCJdcexqm0tcJUlhJiZJMt0HS9n+2uOIRLqXH6FbfHZVHDSGqsH/k4bhaJ3G8VI+py/DGI4Ze2JNcyVFqUW/KakNABn0Vpjb6biqlENFu69qsd9ULUZkQZFTI/qV21eqX80RJrK30TOg6hgxKFxamWealMmUdfuWYzt/c2V/KWAZankMQcqKd9C0eJ8+hxNsL4PsNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789110295; c=relaxed/relaxed;
	bh=Mupi7f/R8vSLK7yP3tvVdaLvmeD/LZPxEKzcTyfibm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dBgxecKbD/oG3OO0+xyJoPXS2Ap+XyryKmjPi4idz9ErrAxvYvSp1S2J7yT0BTDHC+S0MzIhHmLzFalZgRf00/zub3Hgdh0uFprh19X9l1VP5tSByRV4hlHFgL14VaqZCrqOeZTVLmtLnm9f2nYFP1Y3KI7ysWTfFRUQ9DHRXm7pmiIjtelans1j0YuZtCPAd4bWmyWwBDPewkuYRM4QzSh2uEuXlMhFufMjLZZBVx74+Oo9FD5D2cc1/BLAPVlmsi0e5ZKO4O8GmeDtm1ivXQtz2gVVHuACh9uyoubGEFVrUhZqwqRXrBq/bbLlrSWKWjIKPHczq/ThSq9HW9acuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aQSGkEQm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3eaijagukdew025p2u22uzs.q20zw18b33q-rs9zw676.2dzop6.25u@flex--morbo.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aQSGkEQm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--morbo.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3eaijagukdew025p2u22uzs.q20zw18b33q-rs9zw676.2dzop6.25u@flex--morbo.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh5CB1KPXz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 17:04:53 +1000 (AEST)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cc1b8088202so608060a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 00:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789110290; x=1789715090; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mupi7f/R8vSLK7yP3tvVdaLvmeD/LZPxEKzcTyfibm0=;
        b=aQSGkEQm6gOhqyUBkcGkO5EtyB3FYh+GXNi65H31CXbT1ETKGE1vDXUEi0AOePOLrf
         QmyhcSyvAylc6PRUpHRihiW/YMfI5n1AqC74EXtANXeYeBvF5T546zqznI3pEs6nJui6
         peuzA41oCDMSjQe3QYsDd77gPpFEPHTTxKhlQ2dMp6qsveKq5zEMJOux8NJC43s4ohs4
         6BLFBJ1o0P2Z3XhlXHyrn69LRVwTHPSbq2gY2gyS2OVQOSC7g/IljLOtJK+v+FwAXwF8
         5ZQ2dAiCtpn70uhkiNorLrbVqVkuW9jgjsP5LZgjBaEf36YGf95xCgPvCxtJtQ64FCCI
         TCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789110290; x=1789715090;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mupi7f/R8vSLK7yP3tvVdaLvmeD/LZPxEKzcTyfibm0=;
        b=bAsCfvqWB1AsybUGL2LunyvKMxD91qFwoCzNTJI4niy7tV18fHfDkKDhgD56wt3AEN
         6X0yamY52OX7OEOKV8f4Nulib2s4ZrW45Cq6iRYcrWve+iYDmTDwyODk5x1FcFHRCE9D
         Zc01dfl0QH80oXVNWDVzx/XmnzxkHw42t0RZIaHZq7YbPtSZKSf543U+o6zwzbk3Shf1
         4Tnk+Piw0nLdo/1Wc0FcygdYoRU+1WxbpEaCIhwfmSWMMRlpbNNU1ChRzDDNmSTYcIk8
         BxYPyCeoQU4Tl8/eZIQEWIaiu85Z2cpJnBooMcfYS7YgJ0WW89pN/BJq6ZPMKz0iI0cx
         E2uQ==
X-Forwarded-Encrypted: i=1; AKwUvByT19X0FUsoBo6iuiexrR+v3+5DkriYHcyrYM3+PMiBq7F5VtZpQk/2855lh1AToVq/+gIMiOL27euOsc0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nbqapDvS7ANFVhahtUZGAexMMCzgdsS0YqLzB+KImAQLscvHYf
	MaIz3oPY7HONB6d7uMH04fv3VyyhpVtd8ssNQl3CqsLXN0PiUMCEtRlkByiaEYAOjus/UIcwteS
	i
X-Received: from plri7.prod.google.com ([2002:a17:903:32c7:b0:2dd:334f:920d])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccd:b0:2d8:d4d3:da50
 with SMTP id d9443c01a7336-2dd2a471a7fmr72805325ad.20.1789110289759; Fri, 11
 Sep 2026 00:04:49 -0700 (PDT)
Date: Fri, 11 Sep 2026 07:03:45 +0000
In-Reply-To: <20260911070346.801948-1-morbo@google.com>
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
Mime-Version: 1.0
References: <20260911070346.801948-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260911070346.801948-8-morbo@google.com>
Subject: [PATCH 7/7] powerpc/word-at-a-time: Instrument load_unaligned_zeropad()
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Convert powerpc to the arch_load_unaligned_zeropad() /
load_unaligned_zeropad() split introduced for x86 earlier in this
series, so KASAN/KCSAN also see reads through load_unaligned_zeropad()
on this architecture.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/include/asm/word-at-a-time.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 54653a863414..9a09620ca776 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -164,7 +164,7 @@ static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits,
 #define FIXUP_SECTION ".fixup"
 #endif
 
-static inline unsigned long load_unaligned_zeropad(const void *addr)
+static inline unsigned long arch_load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, offset, tmp;
 
@@ -203,4 +203,6 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 
 #undef FIXUP_SECTION
 
+#include <asm-generic/word-at-a-time-instrumented.h>
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
-- 
2.47.3


