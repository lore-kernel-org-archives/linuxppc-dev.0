Return-Path: <linuxppc-dev+bounces-18692-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DDBF532E5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:35:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0fB6Cjyz3cZG;
	Tue, 24 Mar 2026 17:35:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774334130;
	cv=none; b=ccKhc4/Zt2PH2sY80vq5ejvcOUgxbi9UZrJRBptes5IiHTI/75adeoJtJuC1hOf6J3s9AzTsbH+zPxk8tRlGCfBBgioGLd4aSbbrSCONDAmtOo19LfbQzScIn99YtUqBjEVElwh3Bc+YXHFmQUnG8q0wYFfOWXvndDqQNd3tMkRnJx/WgCizb1cM6rH84zV+5ZZiPVtodVwQBDBl6GvfYFiYieI2NoVoqQDTemgm9NugLVu2y5J1fKoWW52b9+RBPFCpIIaU+L2c6jvvVgwMoZWwFVTFRseQ5VNdoJZf+yllb1bjV3FnazwCzfjRSdWdz24uVs6RTyWM30EaC4CTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774334130; c=relaxed/relaxed;
	bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOjyENxmWPPqyNtMoX/Y4ZHR3QQK2U1q4ID2C8t9cWPiB6VjdsVKAhz8llyxcpLtzTNJW34sZWGB0zPawQ9burTIny4b38S/Wea4vj5Uv6T0IO72iHsyK9XM/ErFP0NSPINZEP7JKYREK2yp8NWTrXT0LOBfuILHZYy3Nu8G5xk3r2TbeveT8es+AUSUiSyGopw1IGEjsznUWnTVjIL+3vEkJHxEK6y5U/XPOwTblJgY/Iklh/BeyPLec4UaXD+ePCrr6PXhKz1zdVHarphaDl6c6gNe7+A4aqoqFJQJcgHkydjxGtxwZF/7qQRyM80ftT3pFORW/8jw00kia/xj5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ry94KfbS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=safinaskar@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ry94KfbS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=safinaskar@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0f94zv2z3cZp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:35:29 +1100 (AEDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-439c56e822eso830748f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 23:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774334125; x=1774938925; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=ry94KfbSxbH1GsPHON9icdk3o1yZjCifqAayj42U/3361shgQZxrkAit+6QzO0PkVi
         JNPC+tudYDG/2VCiWftZ73JWYHdqdP9jPiav+qp3kHSzlrrQJXF599ADf865jrfaBa0f
         qnFgtJHTJqFbWeXjo8NLh0aE+s0TH7gaSNMRdmnwHDxLbu9BYXELdpl2ps+G6jdEVZ4u
         e+iwSZzOIP2iIiCKCL6cXFYEHr8lqpMf2hKSOBXz4u3VJP8NKhekwUlmjcRTc9RL3Kqs
         DvaMeFlh9fTVy3/7BXztVLTlOCA6XIXVpshQp7esSxB4mk1zprg9yTGJU2DtZdg36iys
         H1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334125; x=1774938925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=P0mUt/5V9iiZbSMpxg4mWFiV6S7cjcj5MWQU2KkbqNQuOVylwAaA2b4DnzAo07stba
         L8W5BBP1wYGrdW1tIrYNrTV0xG0cS/BLHptLAmwdkZM4QXz+tOOm6Sqf34Q2/2ikQnVc
         M4GMWdBFkxVbNx1jyFi6CSHhdVYjp/uAR50yIq2hl69ibRTphWJ2Jt6Fk197b8CHp2fL
         3qYU6/EE1GfklaO9uvvHpf8C3HfBjxROo2cpqVWuVDZRCZsKupiomeOnGwpOpW+5k2LI
         F0ZivkdX+1zcj523JrIdkUx1dGR92hWV4bRru7CVchBImjxufs3qkZ+mYXIu/AG1JaGk
         WhSg==
X-Forwarded-Encrypted: i=1; AJvYcCVbfTeG6Y6533oB1vLRlAZAMmbBIOMYnmEJgD+2j24TOayVhtjkpgw/CUfLQ/sptc9U+7zZ4AAc983vPpc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwhHVW1iilQnjrWXlVzvcVbiPVXmoKTLXGZHZjpWiRgVDzj5r6a
	ATvGIzW3UFfNJYiUpQJHdcVa8dT0BsCCBAUC38X2U4xIJjVNffOHnBDE
X-Gm-Gg: ATEYQzw3AaWZ2psVooaSvtetdy/PGZ2E7QBWpnnW6aFhXqgOue+1Ga4jjO55UFnIBSu
	9xnigI+RFgGiRBENCpooSUYs0TVycB60RrF8DMXytKkYsZDSzvHMQQoFP4elL9ppa6utc1SHo2j
	n2pz9Hlstq2gkuQ03+OkwMySbCQll7P8BkKBnhm2WepjDNxcHNkZ5J9NFkIVQ90znCV4NV53UMs
	JBfjirPl1Aydb5wmInIDbdGnMTspx9DGGlg9NlZE9Rag6HCjhwf3VDCXhC5M2Va1kIA6GCxAIDC
	YU/v1KFp4Ws4Xs6cU9OAVUqRsU6U6zND2GYKuBpp3rO/WiAvq3gf1im+Ev+nlApWaYuy4vyCeZX
	IvtRnx5lLmOrbWxmpJlnsJrHDxHHLn3ZSazbnC6ckiwcE8N5SnJQii+rPmt2j6zkFuX6ajPLwCW
	ydIlzJf3WB9i7VjCtfN1E=
X-Received: by 2002:a05:6000:1aca:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-43b6423fabamr24225594f8f.14.1774334124571;
        Mon, 23 Mar 2026 23:35:24 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43b6470380asm34457509f8f.24.2026.03.23.23.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 23:35:23 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: ruanjinjie@huawei.com
Cc: devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	x86@kernel.org
Subject: Re: [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Date: Tue, 24 Mar 2026 09:35:18 +0300
Message-ID: <20260324063519.3258161-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323072745.2481719-1-ruanjinjie@huawei.com>
References: <20260323072745.2481719-1-ruanjinjie@huawei.com>
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

Please, remove me from CC list in future versions of this patchset

-- 
Askar Safin

