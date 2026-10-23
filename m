Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C31606A319
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L2n8dDeq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9mDX3Z1Zz2xlZ;
	Fri, 23 Oct 2026 12:50:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792720204;
	cv=none; b=jWl+VPmyP9IcqHZTrRi0VJKWDYgY08zQvkQ9qTxjNrgS6heOMce+B5WVspAU818uSCdr4myjSrw8FK9/dc4XIypxNVd5dmzjWz1dh41XDPpy4y6vCbjMg27d99FJ8W+DSCcSpS5R1qmGbWFDrI3HMoE4OdfBVbJs4+71bCXQ92RbMn8IMo7EgjlOVYM+qb5mFNDj2sWZ/cQVf6zH2xe2Nj92d8qe2m2OZBnr5f4aR+ENZW2mHcBdxtm8KzDXHTC+ZZNCHk3DCTKGGoKF61As/dl6/arf7K+pMMrCNC5G/anVROgEOliTUhXByh8yWH5u9Kw8GidQ8I/gDW/C04Y4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792720204; c=relaxed/relaxed;
	bh=+p8cIpnt0YjLXT/3n6WuKQxFq68+6JJEn3PVDsIrB3s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dF60YTWOzBQzTvhnkAXBct/+ynteen95KqdeUXOYQCw4sPDX8e8VXCw0d+uOzfKYeBSzmPOOQsat1HVmmEgmOLsBmyYBg9UrOuownp0rcMSufiESyTn+s3kFN1iNNhqK/ceySEPRW638VvhotcuqCT05jo7JjhbxNVM7LklolGHCNX/0ahBu/aZ0v7XLK1/dojQqrexN++i/xyYIUA+SRXhoLW8Su+7X4cgvGRK0q9MPLhGVnH2Sy1Hx6rveP4FwdONm98R8w78bcygkburk/Hkpr0Gd0Kl8HhfQd6cB4nldHhIbP6He7/viN70BK7QMcPB5DsiAqjIazbnIGqx48A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L2n8dDeq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L2n8dDeq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9mDV6SD2z2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 12:50:01 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-353804b591eso742842eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792720198; x=1793324998; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+p8cIpnt0YjLXT/3n6WuKQxFq68+6JJEn3PVDsIrB3s=;
        b=L2n8dDeqlO4J7gtyjKxmPGqCY/eUJZ0Fbi76ENxlAlkNGrf4mNx9JCR4ni1nsnzysP
         +7GtZ6ehoMgQwIs51XLRSOVXSeHao+Hqnx4+0z7pUKlgpxHBhcvWVkv8F8gsDGdvi/fV
         nxwAQHXZZkVdyCTInTjs2NQGRJGtNWpF4Ur4DNGf4pTSwXphj8qyExuPChZBqcO1Q8Dh
         0k9qQdQzlm+PpU/DvOj+UwiV3HCoRIX2VowIp838XkbyFJDxWrvqCI1FKcUBXo51zRi5
         JrYN5VTKMSIvVZy5AInFBTqgsKRHE36wQ06PzWS7oMzVJI2NIKAkISjjyzklSy80Suvu
         Jd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720198; x=1793324998;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+p8cIpnt0YjLXT/3n6WuKQxFq68+6JJEn3PVDsIrB3s=;
        b=nE2+yWFISz7O66btuk/DBrziyxHXra6hukN/rzMyZS1y/E6WJFO4gp5KPvLmL1ASIR
         6+KrVaVqREQ+cp++Uik1oPYpmX76xZCL6KaFuRrMf/50YlYZiR/Ro5mva14RRlksIifv
         RZkxdTj44npGWMF5ostzNCykLQsv61qTBGKz2RQCQNaE1/9U9gRWZlwk+FjH1wUeVUID
         pT/L8axYGtlT5tpXEu+7Y4MIw5t1xfkKcoyyQaTl5b3+pkDXwS0xZhgb/0BL+LSpyw7F
         xeD8yV9g8EzGHKwvNj4HbcVe2wHmPXlRwnvagncefpqxlkAteDVdnpNv24Fo0TpIvxe3
         NzBg==
X-Forwarded-Encrypted: i=1; AKwUvBzfcLar4+4r38fJIIjOzCM/4PRItMmYvtYfuMrs06CIIApW6h0OO6lcsm25BOl4OxNmsMwV5VAkVZi4E7A=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIi3xkk5qB9C6ryOdHENgtKIP5Jee/bfKK2ZD+BWVJMJEXooPq0
	KqSTZkt07dPX3+0MQiDR7z7TwnHrU2hBtpq3pJ6PIyWa8oCdRn2AKVAQ
X-Gm-Gg: AYBFou1adjxWUkoTieb+rsOeSY3ntcrSwOzPBg6ArSJr+eh9jlkjxZbWpCO0qq5H/Hm
	ZZeA/lCZT5ev7aJx89x0qcu0PtWF83UjykNtXTptQ2LwzIW+FOu7YTKfSnlCA/xarlcdKOY2nKC
	kZSKJj3dpC4OzxdopR2Bruva9tltZedeTzodfoixVrgrqOB8U1+DMlt9Wdz++QT1N77GymEpj8x
	9LE5J46YyAWbLUDWoQAuYA3dTFvDzuz3oaWEVIPkktawKBV36FtFq3T/r1HopRdzoDEC3FqayTl
	lll1q8R77PudIhgiPEDc3CB1ahoaThAsey2b45IXhcN8f2wKVFaBpQAXPBNzDrUCKevRya0bF6Z
	NveGebC755iial3Xa/eXIbJdnmATjkoRKEIpHYv/qVIYT9GPbJ3KVrZ65yqP+TfuIl6ePpjdoyL
	6l2+UAkUS6Hiu4PRsNzYHTykSZFYreecwpmq++yrEm3ZxYHEoMSWL1wiG7qiZ4pcrwSiVoYTbIR
	VTcZQ5UzHCgPBJplsME3nQXoJHcXtXOzzqLeHTVLzgTLTUTr04=
X-Received: by 2002:a05:7300:c00d:10b0:35f:4780:518e with SMTP id 5a478bee46e88-369d97155f0mr1233857eec.16.1792720198309;
        Thu, 22 Oct 2026 18:49:58 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9c0e60dsm1971091eec.2.2026.10.22.18.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:49:57 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v2 0/2] word-at-a-time: let KASAN see
 load_unaligned_zeropad()
Date: Fri, 23 Oct 2026 09:49:47 +0800
Message-Id: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADu92moC/5WNSw6CMBBAr0Jm7Zi2khJdeQ/DYqQDTBRK2oofw
 t2t3MDle4v3FogchCOcigUCzxLFjxnMroCmp7FjFJcZjDJWK33E66PDpw8OKSFhkoHxw8FP5PB
 GkUak1pRWldYyW8iZKXArr21xqTP3EpMP7+0465/9Iz5rVNgaTQd2lsqqOncDyX3f+AHqdV2/W
 tfq3NAAAAA=
To: Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, Peter Collingbourne <peter@pcc.me.uk>
X-Mailer: b4 0.13.0
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

load_unaligned_zeropad() is inline assembly, so KASAN and KCSAN never
see the word loads that sized_strscpy(), the dcache name compare, path
name hashing and x86 csum_partial() do through it. While reviewing a
strscpy() KASAN fix, Peter Collingbourne suggested checking the first
byte inside load_unaligned_zeropad() itself, as read_word_at_a_time()
does [1].

Patch 1 adds that check on the six architectures that implement
load_unaligned_zeropad(). Patch 2 adds a KASAN KUnit case for it.

[1] https://lore.kernel.org/r/CAPQLkRhXZwozmfhNd_PEx1ihwdH1_5qthP6PANYJ_m-v9vfQTw@mail.gmail.com

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Call instrument_read() instead of open-coding it (Andrey Ryabinin)
- Keep Marco Elver's Reviewed-by, as the check itself is unchanged
- Rebase onto 7be4bc52fd9e, which drops the big-endian branch of the
  arm64 header and rewrites the s390 load_unaligned_zeropad()

v1: https://lore.kernel.org/r/20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com

---
Qiliang Yuan (2):
      word-at-a-time: check the first byte in load_unaligned_zeropad()
      kasan/test: cover load_unaligned_zeropad()

 arch/arm/include/asm/word-at-a-time.h              |  5 +++++
 arch/arm64/include/asm/word-at-a-time.h            |  4 ++++
 arch/powerpc/include/asm/word-at-a-time.h          |  4 ++++
 arch/riscv/include/asm/word-at-a-time.h            |  4 ++++
 arch/s390/include/asm/word-at-a-time.h             |  4 ++++
 arch/x86/include/asm/word-at-a-time.h              |  4 ++++
 mm/kasan/kasan_test_c.c                            | 24 ++++++++++++++++++++++
 .../powerpc/primitives/linux/instrumented.h        |  3 +++
 8 files changed, 52 insertions(+)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261019-bug-word-at-a-time-zeropad-kasan-af2460466ee6

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


