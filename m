Return-Path: <linuxppc-dev+bounces-25889-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127FFC5B572
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Aug 2026 13:55:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNHY11kVDz2xtt;
	Sun, 16 Aug 2026 23:55:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786817555;
	cv=none; b=CWVaxdSwPo6pVLHwrs4B3bimZvKN4/GxLSuFs7+ZfSO/bwfBzTJohUQMH9SGbb+H8ZDz8JUaeoPLufnhggmrW/JkvY38ovPOoX0na4D5iWtSgB/iR29tZtr/TXOjjnMaat4tP4V7vb1quU2eZ+WTWUTPaxPAd5YQcez0C4jlfVerdeTfU5Vp60jIb3qRjkV81n/nYyzdQWu/65twrvwAs4mgZeW5d4wu6JbTTe1+s53poyY/VvY5BWsu9M0iQTvFwr/h0jZZpG/ziPuLZ4le9o/LnGVz3r9r5PFYISObx3MWU5jzcK8RWVZaWUCZBhlWaJbFH1Dxv7iXdjFRRYpS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786817555; c=relaxed/relaxed;
	bh=xW2LYIDQQYDFwK3J1a0pZQU3BluSHf7AesdfpfaEO4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHSWcAa5j7s638s+FLfdqflcImX0PvhO2W2Q/ntTorspy+0kzEkg+ImmYW0GMPvGpR57Yl/jCVfP5o1TRgS0799lcEX037xRGqKPeAroUs23+ly0g1wWUiaahJwR9j/ZeE8gc8ZNHeaHGNRJL8BvVqfBSCzqlkq2GJWSFvcE1o0eLmCliJFbrd6eJhCD3mom39D7MGGUFVtL5s22rTSvf3pMkxU9CwpQ/wtyNSg2ejyjSkPm2tngegC3EarMz3clTdzcSGv1oJ6EcZIdKRKJq6L0B4HqQ646/N2zuynEsTABmEa9IuDiaLYPVCHvLy+9DX4luzx0vkbPm/B5Qt3Zwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X8ubeoL+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X8ubeoL+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=dragonliu2018@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMnJ14gNTz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 04:12:32 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2194999a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817549; x=1787422349; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xW2LYIDQQYDFwK3J1a0pZQU3BluSHf7AesdfpfaEO4A=;
        b=X8ubeoL+rj8/pg3ZjqdUecIrZVHXWvsAUPTHYoSBmnq990+rg7KW1RNJ3wqsDMNR7/
         R5uS0QGQMnPrW8Sikgcu4f9bmjUExLlKjap5irFFol9uDFhjgQNxmVQ1YgF7mymP+aox
         fof11fs88zz1wojj60sxr9oqCVZ7j7PvTME94hOx6+L4vsD9+z5KNms5PhsIRK1vysAv
         O3hL8Va03DhISMaZDxH8zlWOW+lCAvobKimdDKTuB+VXBi5QtgUbAQemxaKt9pdWy45t
         NJxb8R4M8a19HukbPZ1OhsmGMzQG0TlVqtvnsJz1R0rQ7hhDmPphymKkWzONABBFaqSy
         z/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817549; x=1787422349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xW2LYIDQQYDFwK3J1a0pZQU3BluSHf7AesdfpfaEO4A=;
        b=YUhWSHPLZnPwlnGvE0VrFaiIY8orgLAOgCV17Bg7QcubbubO4/QJE7jytqRu8qpiRU
         ie/eQTU3zQMQWw26nEgMRTVLVYzV5fv2sSgYob2qYY04YyoAq+gbJbT7R/JboUz8ks55
         GSu9SZ7Juve0r+IcGEK+6clnPe9JdopuUwd4nSSNiH+oSMuYtsJ4lt8Pdu0xsmVZofyX
         MdauyRwmfqWazfh/bbm6aGRnbUEOtfPIPchudcsg27VAVFHiogPs6hVBJ886suTFmG5K
         7qim1x3lk3M+eSynHb9c+BC2+oFqcjLXmUFp5eNficdPPUTdJ/+pTDC80xUYXVY/o/85
         e8uA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+AM7tcuR2KJ3jYzhD3j2K4fIRWBZq6JnaYxipHJjE2MCWVYUw5JXzgTtd88ELYLaP6bFqLkFQFNHimLI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjjV2dk6pxcVPrAlWD8un8YgInl4w72Mh2dpbcpc8ZPE/rUwGl
	hu1FKNfjQr4gPWxCiQm1MBGFCLojyMrWgvWta8VCA7ODvH1ok55BASLy
X-Gm-Gg: AR+sD102khPFRYNCzpvus+f4oRTlEF/jEJoAR1PNFN3mZcv0DRxMXoqcuFELBVeT3ir
	qzM2Y27jePxdu1WCBP0jDgRy761qxbdHiZXr9TdpVQTEqsFl8O4eGRmCr6x3pRyPlTA57f5yOf+
	2oU5ki4ownqMSxGD0qPjIvIkCX4jFhufty6/G+s1JnqkkpToMu41Rn7uhCi/J21CqQSaKUhVhuJ
	4VEkFurLsCmeH+jpDZcZOtc0XJuVbNrYWAwx+tXQCFzPzou11bupVkK66N83pzNX7AM9ioV0kL9
	m1exgXYz+fB9+639C1xOsXcXWSKCXsoAUhbWjfjNZmazulKxpDgtExQRSsm5uZIP2PokydXoO9c
	33F1X4cTnNera0/5BcQ+V9dO42axjMzQESHtOnpFwTryVzl5smwOpwH0Hjiu1ZikpOLmNbHa6mC
	e6Iw97wM3xipy69ecl693AtdosWzPitluabvc8aUn9u5fTH3CHp2iwE6hWUQbJLTvJDE56LpgAU
	nUkkx3pY//c0gne1flnvcWhVf0=
X-Received: by 2002:a17:90b:4ec6:b0:38d:e658:5959 with SMTP id 98e67ed59e1d1-3933b80052cmr15988255a91.5.1786817549396;
        Sat, 15 Aug 2026 11:12:29 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.12.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:12:28 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: andi.shyti@kernel.org,
	chris.packham@alliedtelesis.co.nz,
	jochen@scram.de,
	maddy@linux.ibm.com,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com
Cc: mpe@ellerman.id.uk, npiggin@gmail.com, chleroy@kernel.org,
	grant.likely@secretlab.ca, neelegup@linux.vnet.ibm.com,
	benh@kernel.crashing.org, wsa@kernel.org, stigge@antcom.de,
	linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 0/5] i2c: fix device_node refcount leaks in 5 bus drivers
Date: Sun, 16 Aug 2026 02:11:59 +0800
Message-ID: <20260815181204.2321-1-dragonliu2018@gmail.com>
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

This series fixes device_node refcount leaks in 5 i2c bus drivers that
share the same bug pattern:

  adap->dev.of_node = of_node_get(pdev->dev.of_node);

Each driver calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
none of them drop it in the probe error paths nor in the remove()
callback.

device_release() does not call of_node_put(), and
i2c_adapter_dev_release() only completes a struct, so the extra
reference is never released, leaking the device_node on every probe
failure and every adapter removal.

Additionally, in the remove() callbacks, i2c_del_adapter() clears
adap->dev with memset() at the end (commit bd4bc3dbded9 ("i2c: Clear
i2c_adapter.dev on adapter removal")), which zeroes adap->dev.of_node
before of_node_put() runs, turning it into a no-op.  The fix caches the
pointer before calling i2c_del_adapter(), the same approach used in
i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3 ("mtd: core:
Fix refcount error in del_mtd_device()")).

A related fix for the i2c-qcom-cci driver has already been submitted
separately:

  https://lore.kernel.org/linux-i2c/20260815140931.53297-1-dragonliu2018@gmail.com/

These 5 drivers are the remaining i2c bus drivers that use of_node_get()
on the adapter device; all other drivers either assign of_node directly
(without taking an extra reference) or don't use Device Tree at all.

Each patch has its own Fixes: tag pointing to the commit that introduced
of_node_get() in the respective driver, and requests stable backport via
Cc: stable@vger.kernel.org.

Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
hardware available for runtime testing.

Liu Zhenlong (5):
  i2c: mpc: fix device_node refcount leak in fsl_i2c_probe()/fsl_i2c_remove()
  i2c: cpm: fix device_node refcount leak in cpm_i2c_probe()/cpm_i2c_remove()
  i2c: ibm_iic: fix device_node refcount leak in iic_probe()/iic_remove()
  i2c: opal: fix device_node refcount leak in i2c_opal_probe/remove()
  i2c: pnx: fix device_node refcount leak in i2c_pnx_probe()/i2c_pnx_remove()

 drivers/i2c/busses/i2c-cpm.c     |  3 +++
 drivers/i2c/busses/i2c-ibm_iic.c |  4 ++++
 drivers/i2c/busses/i2c-mpc.c     |  6 +++++-
 drivers/i2c/busses/i2c-opal.c    |  6 +++++-
 drivers/i2c/busses/i2c-pnx.c     | 15 ++++++++++++---
 5 files changed, 29 insertions(+), 5 deletions(-)

--
2.55.0

