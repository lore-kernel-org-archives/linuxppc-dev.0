Return-Path: <linuxppc-dev+bounces-23786-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD99BC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:26:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwB4q4f9nz308T;
	Wed, 08 Jul 2026 18:26:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499163;
	cv=none; b=EOiZ8nmle+i1nqlPH9vt596hlWbSO34bKJuiX3KwCfUyVvnYek2G0ldMoGeTa+sAUO+680bcTaaAq6rg4yjXgHVC0t2GqQenmuo/GKEcSt7njXKXdaoQMoHo5ARiixg298J9G0oQm+EhxqwCRIgzLU7+34+FiEZq8HqfqjkJBUOXRj4N/zPcQEJvPW3bYmghOX6wM4mw9gPCg4jd97Qqx6+vW36n2IQmt8Y6oHwmK2frYyjsdjyy9vEPNXCh+yeSjx1+Uti4yy7WJR2N/ZHe4j3wOlZZe/JUZKtt9EUrRaJkbg9PIEce7S5SdMu2s7vTbDU0+T8McMqg7kObR2I9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499163; c=relaxed/relaxed;
	bh=N7/TgPupofOaFBPAX2pw0tL7gzCEKb6TKZTW3jPqY/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE4hM92VmIKHEfdGSHtyXv1Nf1moglA8VCfWdfylu9eh9jhfNvNfxzDECAYkteczr/lYMXchSgJAGtdz0cWKkd1ShQGxl6bUjn/i/gXB31ZxudF8jqEcxoa5Qz/QzKjQ8IdO0hYfMd+2y5W8y9WEheEw0KZHO3oa1UB9OY7orWS4Bm1OvhqCdAbnMLR2EBzpWhsi0iSw2WHf8PRK+tEIFDunk3LZQr6h1KCouZWGUmEdou9+fKpqw/lJJ0ZeyjZwfXHE7N5b2DZ9Sx3VsIpkP+kA+aiIIRZH9pT3ERsLC17hdT4Soi9DCHrAiFMxaGpLhCOsiYb9pJNr1uZqJz1w0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iygK9V55; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iygK9V55;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwB4q049cz3054
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:26:02 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-384c94c9414so386194a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783499161; x=1784103961; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N7/TgPupofOaFBPAX2pw0tL7gzCEKb6TKZTW3jPqY/0=;
        b=iygK9V55iGjowh5xwPag4FT6MfDRNg+ShixUPalHcRXpcBL77G0XYuXubTDYffiAzz
         Z1efrf7541Gxlr/SQxqB91TjgzylFAPRfgreHVmIASYL7e8IiknbniAA2s+eefRLS9ad
         RmQFL1RW17qSx6JuPYCUhSNRDkfxPIEiVI+7athWIWK3sgTATNvqLOFTRJ5oEHmE5zVs
         iUDTSeGzRveig8Fu6Pmig+UPbgPY7WMwIpGBkCcsgjaKEh4Mx4yEskRWLkyPoq6EW+Bt
         wNP6ABlIIWUHKoWn49VBFRsLzwnV36QeGj+DQfeOtk+EXNjTuVCuxSb0O3EA7d5EirF/
         kDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499161; x=1784103961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=N7/TgPupofOaFBPAX2pw0tL7gzCEKb6TKZTW3jPqY/0=;
        b=WabL6qRZKfJjuZz88TPOGd5a49TS8vrcxJn02+s4pXuo7ejTopzPDwv0DtSdhwKR+2
         HpzRDLPJRX23atrf7PQHkIrbOJs9QFZYdt8X0GOKz/PojS+8XAPErpaPYDLhRZ9pITTc
         NAOXRC3SFq1+X0byV0EK9eInvrL57nuKIzwdWfPaXko+KG783TYQI9KSs+RT/y9v3Vlu
         1wsQeCmmZusBGUp+nTwhB9WQQon2HHxHkZbK/OQr2SJiXmfUjRN6x7qTzHWpEoII/DJy
         zh+CU628NVajyafvAE8Fj+YB2quhPpPA6N3MAOwLnbMLZNqDyKXOucs1MfndesCaJJ8N
         PkxA==
X-Forwarded-Encrypted: i=1; AHgh+RrLaXkv1OLfyeexPreoiXw+f+Yo2yXHzUIChDTZuDyhJi3eohDJZisHL5d8DtOrwsb2dy6fO/kD08CKIOA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxISCnAtI+UVAbbWZY0XV6IBfm6fgL/Sy9YXDU1aZZVOfPPeP0d
	bwalBJNjdTEXuCMWSwEuXZvQWgvRHs2WTHqVxzbDNTZeaE/01iScyNLE
X-Gm-Gg: AfdE7cnriTbKONNX1UiPG4EZOU+Qvz11iV1Tuoj6sxWkdXh5mBw/2tXpiVh8eMF/GBr
	bANlVh7mENoyHkFstRjWhxPe6QZXBkicqyY8vzCAz6hzuHZq5c9oEwyShFvRqZGYTtTqJ9cVufc
	7degUEWwwohBdxrWZ0kAQQAbYAkFrj2EcCKL9Dc2/p3mNYzwMGXTIOFoQt+pbfnPVj4cQI0of0s
	9dHqZVno/7vAesqtIuwFkrX2a9SvW+lfM3yqO78oeWVqDxV9RwH7o2RSanErrLxC+Bo32XR22/8
	OgVDMdx+dqzsofld4e7n9i4WmvFV64LRZ9TFcwCnQpLbtOGS74i8zBJjvCrONKbFNCSsUpzIuiG
	IHn0/YW3jrmZrAfV9WudVPiJ/50+J2DoHrh2U/dvYOe/PmTFDqcvcrpl/Fu6eCcpRLB5nRXbLX6
	6QwSQRM0sM86+D7vKdQMv/lO9GcsXXL6DgiHK45X/bQLnA9+m21PSo9i4x4fSOBXWlhw==
X-Received: by 2002:a17:90b:2d89:b0:387:e0db:bc23 with SMTP id 98e67ed59e1d1-389420ad00emr1735318a91.35.1783499161101;
        Wed, 08 Jul 2026 01:26:01 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm19975117eec.0.2026.07.08.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:26:00 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	nsc@kernel.org,
	japo@linux.ibm.com,
	mkchauras@gmail.com,
	lina+kernel@asahilina.net,
	j@jannau.net,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V17 4/7] rust/powerpc: Set min rustc version for powerpc
Date: Wed,  8 Jul 2026 13:54:51 +0530
Message-ID: <20260708082454.1254320-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708082454.1254320-1-mkchauras@gmail.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
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

Minimum `rustc` version required for powerpc is 1.95 as some critical
features required for compiling rust code for kernel are not there.

For example Stable inline asm support which got merged in 1.95.

Link: https://github.com/rust-lang/rust/pull/147996
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 scripts/min-tool-version.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 031f2192b390..99bfdcaa3396 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -33,6 +33,8 @@ llvm)
 rustc)
 	if [ "$SRCARCH" = "s390" ]; then
 		echo 1.96.0
+	elif [ "$ARCH" = powerpc ]; then
+		echo 1.95.0
 	else
 		echo 1.85.0
 	fi
-- 
2.55.0


