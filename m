Return-Path: <linuxppc-dev+bounces-15429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6C6D1D48A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Jan 2026 20:42:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnH0F1JMcz2yFk;
	Fri, 09 Jan 2026 07:42:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767868728;
	cv=none; b=fypAVbS1e4a6HS5qs34zWbtUXTlCXdJP5daqbs3p2grPhxbCoehAHYv+ar0/jfKi7ROipDI+/+Bp3ge7OL5CAjzPrzMK3vdc72hkzD6e+AtLsMjB9SdzXsJvyRQBJ4JdHpqMjRfE2R8gZVTHl4IbvVRC03ag69LVENInbXmNZcU4dqr0EHwSEx3IMDHfhoLszEgHn59c+aOEHAmdw1BnKxVnYGz3ToI2qny4rEq/KHAAEz/NjAonCqD/EtyTxB+5wH0xO8zDrXNVHNGGIg8oKpOEVHLDDow7t33CwmukEZiLamhAEHlOPYix8ZqZO0XZlKAE6NSEufeoOunx/IkDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767868728; c=relaxed/relaxed;
	bh=8XgrIXfTIHEeqcAXLdtftIJs4zNxs/4EHKGLYJ7O0pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMjarlJL06IEiJgySDF+iQAvNZhN4z3lqbkfTCvZsDzi/4F62mzLEZISt2O+O71APctrRCBpnfZmuTLT+vbaw9KkWXMalYfRAnm4OA3au9+bRdht2ifp6b6dpMltaHQIeFpiNX0OD1KU5fucjB/PSreeDSBrZhfVhIbnhCNjms/zpax/Gd4tUvuO3u06TDqNrBbPA/OG+Xo1hrD0Kz4ak1MwJLKHeNor70iSsMPlCJoMTftKNujT4B0L1tPZJqyhHuDVkNN42azzid9MJmCHnOD/Q8086JhdNaj3J8R5zOBlg5aMxNSxxFtpn0CSgu/+INu5UvJ/iMH+vcNSh8JLnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d/meoZRb; dkim-atps=neutral; spf=pass (client-ip=209.85.214.170; helo=mail-pl1-f170.google.com; envelope-from=atharvatiwarilinuxdev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d/meoZRb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.170; helo=mail-pl1-f170.google.com; envelope-from=atharvatiwarilinuxdev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dn1bX2gFDz2yGL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jan 2026 21:38:48 +1100 (AEDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a137692691so23255855ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jan 2026 02:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767868665; x=1768473465; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XgrIXfTIHEeqcAXLdtftIJs4zNxs/4EHKGLYJ7O0pY=;
        b=d/meoZRbwG3E0ODNGd+0vx2VlvPIeVxT4ywVLodMRoD82FUEqBjntQXWKuUzlTPYmZ
         y3yYwyjm7yHNxl6mXVPiMVgm2JkOYlIMwp0O15KYk5mwYwvk1pa9S9QLPmRx2xT56pdR
         GtWohsG6j7ZaNkK9hL+W0PnMvzbiL7vLrAyhh8jyMbGfAFGkGzfzsh9YoiO5PQ5Ingzo
         1Z+k5XsAGd0x6fP6EhCsSXGNIETi/RgeMepZlYyqNJJSQCr6dHIaMut5VlGp1k/13QCW
         VCbDoLGc9reExfg3ukKR4bDyq17N2AsiVHtyvpySfa4FQS95LXFOTXlgbN5N2LwPyEnc
         M0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868665; x=1768473465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8XgrIXfTIHEeqcAXLdtftIJs4zNxs/4EHKGLYJ7O0pY=;
        b=oy/uVsuIN/wfobUrv+lQSEYmmPrZqnI1Z05GfQYCOUfnipQx8CTF1fmUgR9u5kItXc
         u8Vb5CC4sRxTDxeyuhxZ6VsnLlVPlD4kY7c2GyiWl56ZSOOLVWY8JLP+Sq2Y8rDJ7gWI
         PeVyJaPNCVFgwBrzj/gahsrmmATjWOhIXAZpy3w1UQsTOHOxy+VUhTDEQz2x1RhIb1dG
         gpDTEA+q0Hf6nb/ZX2HF4H4XJ6KStfDuN0hybbfYju7muqpOc+CIqsBwsjN61keC8081
         QuHLzUlwCgNdKDKjhK5lxzmgXFPzIISqgRzCcyC/MrxgAnQwp9nZX/iYLaNBexFnWv4e
         /gqA==
X-Forwarded-Encrypted: i=1; AJvYcCVMLvmzusDoN7Yg4S5EuA+I6+Wuoy4VWaJ0iAfwpMLKS2zmC5ZkxtEB7TI9YXLAcoii2v8jTXQNgI5XCEw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQpnPbeaqnh3gjptw3dP/XcLn6TLlHG4XDLEYqqRZDm1xfDgGF
	bi5nIHsQ5sbtbkTOXnLHCc+RTPN+qJIKySETHRK+TZnjDRJ9ki4kcb8=
X-Gm-Gg: AY/fxX6Gc+cbYz8UoZu3eWdf5MLpm3qYyiW5u4jnXsO309gzyS0U48TpWUw/IkB4uWa
	Lz336YPD/Re6zM8YZIM2y/v/BD09ClHQXpQIivyS5iVhciS4wsCwBzo0vQvu0iMxokAmxvA36FJ
	pHZjWsbYcJtNCZg8SPiIZIQkX9LzVur12v8hClRtcXjzH4+NNPhWLPxCTHI4nAxsPXEsNfdSNTW
	XkQ4Vz0D+miJbwRPHBx8tk5O9k4WEnXO1xp9GjZAfxyX8qJ8n/c0UbVvWovfMqpSyvwWkkanIUC
	RjlZNKxQvcZDDrgWVQb57s/Z+L3l1wcLQyORheF8kEuu29cYeGuuQV4XBTKtXGt1jWCfBIzdJKt
	5Tqaz8JpdXG2q77Y76Io5ItbnufrW26egdDrEV1BStnhxNHNgH4UDMIK4K63wLJSXyCEDW/+e9H
	NUDNZQt83osXENhr0AD13zjxHPGw==
X-Google-Smtp-Source: AGHT+IGBiNiGrFGtYU8HT43NWGc2t0TFwfrtWF8Wa/A1LiAqZWj9WgccZwKFE3lQHdocchAraz0Tow==
X-Received: by 2002:a17:903:3806:b0:2a1:3dae:8f22 with SMTP id d9443c01a7336-2a3ee5211demr49620495ad.61.1767868665505;
        Thu, 08 Jan 2026 02:37:45 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492esm76742965ad.98.2026.01.08.02.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:37:45 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	feng.tang@linux.alibaba.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mingo@redhat.com,
	oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	tglx@linutronix.de,
	westeri@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Thu,  8 Jan 2026 10:37:36 +0000
Message-ID: <20260108103736.3433-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108095303.GQ2275908@black.igk.intel.com>
References: <20260108095303.GQ2275908@black.igk.intel.com>
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

I Cloned and compiled the kernel yesterday
(which unfourtunatly did not fix anything),
and after testing i did the macOS update which bricked the linux install

