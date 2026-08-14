Return-Path: <linuxppc-dev+bounces-25870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BFEC5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:32:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM5nx6Hdqz2yx7;
	Sat, 15 Aug 2026 01:32:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786720454;
	cv=none; b=No2mJ6xCowVTQQD59DNS82QDZPgWPSGtUxxyZk9AujgjWinHfwZke1E7nPQEjeXbQ24VVyiPX3RuBRmyLp8kCkta6Dt0F+UjYOUAgnPHVoqRRQrVHM9PI++wxU+9vYFrgPMNBRO+3ZnU/hSk4PoYf7TgpofbaLUpNz5gHRCk5jgDyGUC1wIoqhlIGStkJNRLMoEuIJxu+VrL2+VfXN6T/8RKdWZwAHHpHu1Wj587DhX6l+7Mr2ZTTW78biV8/TP5iLMZJ4loZCiAdGno+CUaH4SuVQnrjDyBY9Xm8qryX/ozjVJq7+qOOywfptfQUAr78qi0KF+QtKMY6ur+1B40hA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786720454; c=relaxed/relaxed;
	bh=QwrpjQ4RLs0fxaL+2HIhI7tahvYcqYH+F4/hh3arkZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANcNK7deYX6jasjxjKer0m+IMjKLKxHwajKP6qFswLPzTyFdnCFBS8IbKj0mtfq2wWQ2Wxa03gZvxndWOzRxWKWfosfs1WhKBgxFXDpxj5dcPsv2vf8pBmVPQ44TnGh+4bty04URU4pCqobn9k1k72hegoKhXG/sBuFDpeS86/avw4P/jpmXPpAFb4jmpfBCdv09YD9EAua0ZRXvatbGDWaA0DylJR2d9QhhpAFNdMqk+rQrrpLY7M2Xox10W99ScXWqCQdAVNx/5EwNRPevq1yZIPEbw0nPqrxbKic1k1DKpY6xpHXuk/tZbAC+d/CLXSxtbn+XkqLECqHEKm3+Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l5HcxgJ+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l5HcxgJ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM5Nj4JzSz2yRP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 01:14:13 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cedda2ce6fso8161785ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720451; x=1787325251; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwrpjQ4RLs0fxaL+2HIhI7tahvYcqYH+F4/hh3arkZI=;
        b=l5HcxgJ+fpwVdRxQjP6ebxuYQfi7hcFN+Pco70LeK89hN7gmrrt9lWVYX5aHwlbxcL
         hL3W1D3BpoNXUtqjDpY/riGr3ZXh0pB6AlObKHrGuOtquVIDM+oWebuaMEVKgvaiXAoA
         aJWBFvMMbCdsYBPveRbnBRb6VmJB9GdiuESHTT/xrXK+BRuyiR+6f4BSqI0mMpqdOzud
         Hxy5+g9Uo/w0rWp7f07RQHwsAf/A1jz/JkuS0+NwdEcSX8vyt5jvo7WdPDt3uhOsJLxO
         53pJt2ro/O4EphhbicpjgaK5JB2RrDGPc3zvdf4zdiiWOHHh8bUZew5kaioTwolwzjEC
         8v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720451; x=1787325251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwrpjQ4RLs0fxaL+2HIhI7tahvYcqYH+F4/hh3arkZI=;
        b=BzLRJ4yg3YCKleZss1BH2XO1ufhmIv/VI7In6o9XVjXmH1l4mGUEZnUUp3Ga32zkZ+
         9hTITu/KHUxVfDlvrsI4JTtoFD2mlK1jNEKrxZ32NhCnK1QCon1j/HlWnCxg7ERQdDAF
         VlLXdHGjquOScIg/OgN2F671FnwPY+7nQldcKewDi2FtW2HECinRpxw7KpcJhlvHnP3C
         GoFcGKCjsryeP3HcuQKwwqWq4CcsiZp54c4iuSqfytBgK+7Y1wvGGeeap3F/HTRga3D7
         n6zA/TCILT3Zb5c9F6qQCqd9IMr1zokX7Rr/8LQviK4PuZLK8PkrJXdoDYPJ+uVWtn9H
         Fpbg==
X-Gm-Message-State: AOJu0YwaOiD+/01ZfDdEVASk8jL8kFtb7FDQtyGM1Jvq/N+M+Qan4gKO
	p/Pr1nAsp4AcPov+iHq8Y7Xsn02tnNVClYYmhu+xlhCY9USt+5ykWDa4
X-Gm-Gg: AR+sD13PU/F/1YpRbkVkEwbNO2GrF20ZWmKQUQmNwlmzxqc2eRRo55SEGs6+8r00GVb
	hmsAh2LMyQPpV/b/vpmccQ4f13XzxfOvCkHO1hock7o6k+bPGISumd9BSSzFj0SHUoqGf6b291d
	iPXYb3NPtVcHNmKCtU6bHyxWo45Qh5xGwDCWdW/MUX3ohAlp3sx59Wo78zKGIpi3SsYwfCa3cAj
	xUGp+/emDP3eeih8sVOBuptGm+2EDcjESyKeK5DuAkU9iRZejHnjLRKiGh6N6Fc2CfaOO6hFszH
	+4YWeUYI83BLxKQbvPBACImjbhR21969DqIxRKrWOjmCGsHx4dWQw1OX2o5YD5w6RVr0Myy2yFV
	jnZ6nxQetWf5IKx0EcUrGcZw9vtBGyxOwOAnlf2ELHlLhcKR5FWMhbvuzkQQhW725wP/vPqgg9W
	YuwYpyExOIZnMD18yXGkUkwAOYO00RRvVDuT2VVwwlpssB+Bm1VZWMFZH27dMiiq6lM5VXpw==
X-Received: by 2002:a17:903:292:b0:2d5:276e:3e21 with SMTP id d9443c01a7336-2d5276e49b0mr56410185ad.23.1786720451133;
        Fri, 14 Aug 2026 08:14:11 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aec22f98sm11006395ad.84.2026.08.14.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:14:10 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 14 Aug 2026 23:13:41 +0800
Subject: [PATCH 3/3] powerpc/spufs: fix backwards coredump skip from
 undersized notes
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-spufs-groupa-v1-3-f38f7549ce20@gmail.com>
References: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
In-Reply-To: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@ozlabs.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786720431; l=3216;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=kmE7rvL6rE2nTVpZ7i0QDNXuT7Q9+9BkFYard4CiRO8=;
 b=ejsdnLFdgUK5znL13j1wUljuO6RMq2kZ8mUgFDOuS4cbOhUkMQm9bGTRz0kLkctS2m8wT13GK
 C1dMqOTe7oWD4oTXdnZrT50XHPTdlb9D01JY8wF4kfvqdKaqvp5IOyE
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

spufs_arch_write_note() positions the next coredump note with

	dump_skip_to(cprm, roundup(cprm->pos - ret + sz, 4));

where sz is the note's declared spufs_coredump_read[].size and ret is the
number of bytes the dump callback actually emitted. It also stores sz in
en.n_descsz and reserves roundup(sz, 4) bytes in spufs_ctx_note_size().

Three entries declare sizeof(u32) but their dump callbacks emit a u64:

  - "signal1"/"signal2" emit sizeof(ctx->csa.spu_chnldata_RW[n]), and
    spu_chnldata_RW is u64;
  - "ibox_info" emits sizeof(ctx->csa.priv2.puint_mb_R), and puint_mb_R
    is u64.

The mismatch only bites when the dump emits data: each callback returns 0
unless a signal/mailbox entry is pending. When one is present ret (8)
exceeds sz (4), so roundup(cprm->pos - ret + sz, 4) lands *before*
cprm->pos and dump_skip_to() computes a size_t to_skip that underflows to
nearly SIZE_MAX. The following dump_emit() then fails, truncating the core
dump on a regular file (or, on a pipe, zero-filling up to RLIMIT_CORE
before aborting). n_descsz is likewise understated, and
spufs_ctx_note_size() under-reserves the note by four bytes.

Declare these three notes as sizeof(u64) to match what the callbacks emit.
For signal1/signal2 this is also what the runtime read returns; ibox_info's
puint_mb_R is a genuine u64 field, so its 8-byte dump is in-bounds (its file
exposes only the low u32). "mbox_info" (pu_mb_R, u32) and "wbox_info" (emits
at most its declared 4 * sizeof(u32) and pads forward) are already
consistent and left unchanged.

Fixes: 5456ffdee666 ("powerpc/spufs: simplify spufs core dumping")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 8c7515140efb..7d8c733ccac0 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2588,14 +2588,14 @@ const struct spufs_coredump_reader spufs_coredump_read[] = {
 	{ "decr", NULL, spufs_decr_get, 19 },
 	{ "decr_status", NULL, spufs_decr_status_get, 19 },
 	{ "mem", spufs_mem_dump, NULL, LS_SIZE, },
-	{ "signal1", spufs_signal1_dump, NULL, sizeof(u32) },
+	{ "signal1", spufs_signal1_dump, NULL, sizeof(u64) },
 	{ "signal1_type", NULL, spufs_signal1_type_get, 19 },
-	{ "signal2", spufs_signal2_dump, NULL, sizeof(u32) },
+	{ "signal2", spufs_signal2_dump, NULL, sizeof(u64) },
 	{ "signal2_type", NULL, spufs_signal2_type_get, 19 },
 	{ "event_mask", NULL, spufs_event_mask_get, 19 },
 	{ "event_status", NULL, spufs_event_status_get, 19 },
 	{ "mbox_info", spufs_mbox_info_dump, NULL, sizeof(u32) },
-	{ "ibox_info", spufs_ibox_info_dump, NULL, sizeof(u32) },
+	{ "ibox_info", spufs_ibox_info_dump, NULL, sizeof(u64) },
 	{ "wbox_info", spufs_wbox_info_dump, NULL, 4 * sizeof(u32)},
 	{ "dma_info", spufs_dma_info_dump, NULL, sizeof(struct spu_dma_info)},
 	{ "proxydma_info", spufs_proxydma_info_dump,

-- 
2.34.1


