Return-Path: <linuxppc-dev+bounces-28346-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793C8C9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 21:35:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htHmg3TL9z2yMn;
	Mon, 28 Sep 2026 07:35:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790544947;
	cv=none; b=CP0/PFYnrcfyfL173gseJcJzWckwcyzIXlXWCBvo6t/y1gonY+6JoJq7cUq2vFy8Vo3SDHFPdwrPTXZFpl4qDRS2AtXw456gEvHi5sAEwKhEIeDJYLbde+4YccqAypvX5sc3FW0zuU5qo+4Cw6sYBmm4JBNP0DEdj42yHB74JfjjrzZwGdRRwuaKHN9AZURlyvr57a4JmGcG7oBtNMgmvtllO420lpDl2Nw+bGhP8vI2vjFM+WxFDa71VN5miYI8bECTfW7TgER0KtdVbYXkiC4RoF3u4w3PcYLVyblvXPwH5EAFQ+MWc8ccHKNTvxLFuUBOU49zCKDq0LGZeRr1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790544947; c=relaxed/relaxed;
	bh=AHG5gy18gjuCwzJfjLviwlZCw2IziSSdFW1ln1v/Sk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3ljAPSrzg2irmu+ietH0jmeqbeX0+wjSvj+AUV3v93vQDThR0cp9tYG1FabiljmkjLK3U98TSV8b/E5CxNBKPMx9KWALEzhweIfTBIrRWSdlVFD/rUmIFKY0zvF5785wzJwu2Lo8Ey8GJ1j95IgnuZwjhj+ri8B6MHrsQevY+cs6hs0VjZ7hiaFz4nVcQPPyoijPCQH4lnSLKrLG3hgVAB1PnyM7vyGnrI/eJaqA662knKjmX78cSz/wMJh6mC+HoK0fsPUiqrS2EjMmUEhWMtaQyHmIOiPvgq+qwPU6MSwgtppA7B/6ZB8gbp1tAUJ61FcQSmTCX7wQoXabTiuIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i08SfG1m; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i08SfG1m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htHmf2LQHz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 07:35:45 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-398a147688bso1758713a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790544943; x=1791149743; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AHG5gy18gjuCwzJfjLviwlZCw2IziSSdFW1ln1v/Sk8=;
        b=i08SfG1mvkJOnJRsdYWzXIzOs6LNkihwBD7zRKbsfvqzpBedP9by0t2niTGuTy0M6e
         f2Aznw6TlRy/n8RPMzf2NU5CFvEq/rWgA04suyI8NXMUGa2I+RGF2DsZeqbwq8oNGbzl
         GA8gho/VAKZV6kyVw/9BlBycIJtDJyuEjaYvBXTD3Bx7iqHlkj+fmPnMqeMINMrRSlO4
         FKVG7uhs1e6EBhsVBRP4MWGUejDECV9dBmudZRAZYbipymzTGVSAZQ3W3ulOal2G62ih
         qNDsR3W1/579Uard0UOBuCNlUmcPC5xT2Jyj0PcRmJo4MEiFo15JsP+5OuY1JIShybme
         9Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790544943; x=1791149743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHG5gy18gjuCwzJfjLviwlZCw2IziSSdFW1ln1v/Sk8=;
        b=suvnR2kT/jIvI1Rh+T74FFwqkDv/RzFLfXBt4xhc9ZdzHTjpqRRfQJYrZ748LiNq3P
         jGQS0GUMQmj8brdqlhFMBTS5LBhfz0YmmEbXIkTOPtRAz7A9UTU2YZUyFuP0CK8lpzcH
         /C4VyYOkmfkxghx62ijCXhoKvhzsERqcxzqMk2K7D0kPXl3S0NjO4kW4XkORxGG8aKxF
         iZ5KG18IUz21yEm8xNz+KD+sO2gxRs1Tbi1LO9Yowqk5glZLx9f+1MrapAkPthsjD1WT
         eg1J5LBDvPQ6d6U0x0V2n81mzsFKxSu+xJeXGbRbcdBYELOFIEunEj7b42pjN11AnJAu
         Pbew==
X-Gm-Message-State: AFq9FYLEwzVBjuy574q7mMfngFljxYBUisPnKtgzmh6iXhwdz9gt7WOl
	bMmtyhZckKqbgbed+NwCOKBHOAqQAasVsvU3X/69ZRFaXH42hmCT9xaxC/HbzpNk
X-Gm-Gg: AYBFou13XfZo6+rZFfzYqLl6XgoyiQThmKmfFX7qqgLl5TQW6kS29NU7hO/3Z8do46S
	oYCHLCI6cDqghbbn1YSKY7tvleO9pGI2Dh81mM2kqudOwuVPaOcjMSOdbsCX7YWYhZN+8wTSkYm
	G0v0KyDPBUO+E4nL2o9zdzSBZ/jee5cMi/hVkQmScWUA2a8yQJuVYWygA2nVUt3bXkI88+EiD/t
	yUI9yrkZpv74ZBmR1+GsSHblp9NUeU5hAHH/ysfafNLHF9/DaYfyBLl5qKjYsGwvaAPCdSVTHmy
	1s6EgfDNC83Y474E84v3wJ+7lpiV4L2YF97QdCDNJ5oQ4S3Ap+S3ngNMELYhUN0pFV2oDMbZzIX
	hKmCQcPVBihLQPnxcNM6wG4Y7PtfGMKF8JfeqpUJqcEEmznuCMwKEoxS2UwyTa72GfYakONjieP
	k0fAdvrsCMQS6mK3HyET9KjEVWKw9d/eeN4o59EtiZKlp/cI+abH1qBLlS5Q1C860/7lmtE1ZxW
	rAkoMSuHV5629tYurB4pX+dZF36AQ87oEBR8DsB3FAMiibshdMreKk4z5VZPrL7es/9C4/7ezUs
	M7KVLdkOU9W13KUcQsXaOg6oA7zYaZDN0ZPjk/zJFCgZnD3v
X-Received: by 2002:a17:90a:ec83:b0:39e:21a7:5dff with SMTP id 98e67ed59e1d1-3a098d453aamr8865147a91.11.1790544942679;
        Sun, 27 Sep 2026 14:35:42 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976cacbesm22806038a91.13.2026.09.27.14.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:35:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: dts: eiger: add placeholder reg to ndfc node
Date: Sun, 27 Sep 2026 14:35:40 -0700
Message-ID: <20260927213540.132854-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The ndfc node of eiger.dts has no reg property, U-Boot fills it in at
runtime.  The new IBM NDFC binding makes it required, so dtbs_check
now reports

  ndfc@1,0 (ibm,ndfc): 'reg' is a required property

Add a zeroed placeholder, as the nor_flash@0,0 node in the same file
already does.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/boot/dts/eiger.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/eiger.dts b/arch/powerpc/boot/dts/eiger.dts
index dc4d74c523ec..7260cdde281a 100644
--- a/arch/powerpc/boot/dts/eiger.dts
+++ b/arch/powerpc/boot/dts/eiger.dts
@@ -196,7 +196,7 @@ partition@3fa0000 {
 
 				ndfc@1,0 {
 					compatible = "ibm,ndfc";
-					/* reg property is supplied by U-boot */
+					reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by U-Boot */
 					ccr = <0x00003000>;
 					bank-settings = <0x80002222>;
 					#address-cells = <1>;
-- 
2.55.0


