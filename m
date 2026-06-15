Return-Path: <linuxppc-dev+bounces-22621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D79CCD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:39:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4p66DKBz3bsK;
	Mon, 15 Jun 2026 19:39:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516366;
	cv=none; b=Q3/7Hla7HRbDwLcxfkU7ij2sbQq/ilWqy2sZ7ueTgeIPKjlfLCXxkRBhaCFkV1VTJHy0TEEdcdyJFREEwhB2UN/g7PLK+omPtnK+2MLyapVMO6y0bgTGa7aAUTd+yyxE9XTAJGBbQxvbjvlSRL1jyCZ5005aGeG7OPqEs/aNdNo5Zb2ohZqnMscgDslz92uyAz89h98hu79y2jGiVY8w6z4QZUYD0R/cVwkT3XUSBbRBlANhy6fEfRF0NL6riEnt2XTK4W45jTe6ojcKRNEml//9SlvlhodCbj0nhuuC4JVB18PMQwzwMDi4r3FkDg7oEAnPZg9oQJXtZ7L1S6zaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516366; c=relaxed/relaxed;
	bh=v8RfSoNGjMJMgs5qfUtbdb1xy6XGXw4boE+GRcRxWog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AqzJCmLqOJDO8JoeWGUKMD2Fl+b/dyeTRE8qCi3kSQCRr9FxZSR9NQhcs1S8C1fnZK0NC7slljw+W3eZTvN7vN6IIArPFtZKcXf6WpCcb+TPeFXl3UKmkx+u+BUit1mZrQMy1GHTCubkXActtwYhTEgAFFbhKx4ceFdpm0d31xNdAgAMbwuEe2r/0/x2vYZ2UsZ0my1nRPb4gYQxWkJvWzh4Ufj0W0aBaYtiKvbOrV8AwugCiDBr6/0dDypZY28Ks09Svmvvzt5nI7ZgoDEqP9sDDPIEaDa+f4ODWAI8B/Wp/SWEPSARhOemU8KZ1zbUq5+TgCJ1pvQbfPfvKkDPcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z4oSgwpI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z4oSgwpI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4p5616Mz3brl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:39:24 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-36b9033d230so1698676a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516363; x=1782121163; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8RfSoNGjMJMgs5qfUtbdb1xy6XGXw4boE+GRcRxWog=;
        b=Z4oSgwpI7S0SMUgoeFLYIe1v3vekXd+37x7fq58ZMyjhjaUMYRO/q8JUaUKMKxogtu
         6mzD5m8ereRDjJud5VbIw0EW1bijUA85q8WemUgTb0ZrM0S2VhwLRqTM5ju28t6JgnnX
         YnaovkU+7VpRKxzt2yimQRU2pDG/SlqTlqsWmjuTtOpHLZcUxgWvt1HYxwnuCiRc4E03
         Goo/u2IyKbdne4J43JOeNl/CFgJMPWbW7DKSlYjNUYZ6PyTkIB0QxLdmJMK5xf/2CDOE
         /d/x6E+sI1mDg2T5TcVCMOc7CtnamnU5sXek0DslkBU9l5yHNx2v3de3UP+G3vURVui/
         gyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516363; x=1782121163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8RfSoNGjMJMgs5qfUtbdb1xy6XGXw4boE+GRcRxWog=;
        b=e/qTtGmXSUcBgbjBCSBVNbW/6SKN9oc8ldtnDzzWrLjKkpe1hhEZ7Bfs9pCkchr00h
         Z1ZaXbR3ywwg1XfcLJA2YRoxZTBxr2vs3q+bY/fr56kvVy39tFVuPRaIH+Gyt1DNyY1D
         GJ0ciXdWK9Q54B9MprdfRXp5lFjQeO2Ld8//FWwhIk4A1r/1lWobjqgKV745j7ZYlMVa
         bU9wcgQhhERnWfi/u0Ho7x2GVWk7cxN25hHuOvrnvhsBzgQTZf9GDJVXk4SjYJtIdmsa
         a3dewEc52bP8B5Zu4IzURtxdPQ/9HCW+h75CbjDe6LaB3Bdu8qUdhhdcjUgwpBeaE6xv
         ZN9w==
X-Forwarded-Encrypted: i=1; AFNElJ+7QnxpEj9ZmcuABV23F0NpktGsNx2TAR480WHh/n1jaY9MOQor2oeeuGeXO/GUOUW3IaY+2lKpCamZV+I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJA6aN0Fo6X85Uv67mnPbOIu0ZnLcAg2qWdYjZtLuMW6VPIwF8
	wxqn6FgfrkAhgy6KbZI/oDLgQ4v2kAwLCKOjh5awSMmgHijcqS3lfcb9
X-Gm-Gg: Acq92OEwaJLS2+TktP1oa6ybSztC8CaTChyzl0jhgGok9Kd4/xqMfdklpiArpQlu5iJ
	tlMeyogenvmh5sG9ZvT9aj7TPRDBdMm2iZKdjt3FLRjHfeLd3BoA2K2OroVmTYVWQlhmpx2trbo
	G34G8vfJMKV3fB5zTY7zGK2mkb/DH4v1xrM5ChpxnXGAyJtQ74iNdKnihVtvR1vdTf7ehBekgNI
	UAwyuS56L0PrjnnxSAlLCu3/YunPACe4Y74F5dvkwwD/VqsCmxDjNJyLgHJ11i/FTG4m1BJF//d
	Wa/TQ8hS0zv6E3r+zf5mmbA1rYnzqLOK5ZjUMQp5SovbOtYXDsFv23v3md6G20nR87lad0uh/Pj
	htLEQlr8NBmr+Gz7p7VrO2GoNcIjd8/W5tjHxoND3OhJx3LTh0qAc7hzQ//lLurp6Zkk2LgD6XM
	jEYvuiw92BLayxiCfPOJtEMUj/Hv8XiKdVLvM9izSDyVqQFwWzGfdBKbe8jTdd8Yx0XkT1
X-Received: by 2002:a17:90b:3e8e:b0:369:74b3:a103 with SMTP id 98e67ed59e1d1-379edacfef0mr11864728a91.8.1781516362913;
        Mon, 15 Jun 2026 02:39:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:39:22 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 00/11] ASoC: fsl: Use guard() for mutex & spin locks
Date: Mon, 15 Jun 2026 16:38:13 +0700
Message-ID: <20260615093824.115751-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series converts mutex and spinlock handling in the FSL sound drivers
to use guard() helpers.
The changes are code cleanup only and should have no functional impact.

Compile tested only.

Changes in v2:
 - mpc5200_psc_ac97: Fix scoped_guard() usage by replacing
   scoped_guard(mutex_lock, ...) with scoped_guard(mutex, ...).
 - Added compile testing for mpc5200_dma and mpc5200_psc_ac97,
   which were not compile-tested in v1.

Best regards,
Phuc


bui duc phuc (11):
  ASoC: fsl_asrc: Use guard() for spin locks
  ASoC: fsl_audmix: Use guard() for spin locks
  ASoC: fsl_easrc: Use guard() for spin locks
  ASoC: fsl_esai: Use guard() for spin locks
  ASoC: fsl_spdif: Use guard() for spin locks
  ASoC: fsl_ssi: Use guard() for mutex locks
  ASoC: fsl_xcvr: Use guard() for spin locks
  ASoC: imx-audio-rpmsg: Use guard() for spin locks
  ASoC: fsl_rpmsg: Use guard() for mutex & spin locks
  ASoC: fsl: mpc5200_dma: Use guard() for spin locks
  ASoC: fsl: mpc5200_psc_ac97: Use guard() for mutex locks

 sound/soc/fsl/fsl_asrc.c         | 10 +----
 sound/soc/fsl/fsl_audmix.c       | 11 ++---
 sound/soc/fsl/fsl_easrc.c        | 36 +++++------------
 sound/soc/fsl/fsl_esai.c         | 16 +++-----
 sound/soc/fsl/fsl_spdif.c        |  8 +---
 sound/soc/fsl/fsl_ssi.c          | 13 ++----
 sound/soc/fsl/fsl_xcvr.c         | 29 ++++++--------
 sound/soc/fsl/imx-audio-rpmsg.c  | 25 ++++++------
 sound/soc/fsl/imx-pcm-rpmsg.c    | 69 ++++++++++++++------------------
 sound/soc/fsl/mpc5200_dma.c      | 56 +++++++++++++-------------
 sound/soc/fsl/mpc5200_psc_ac97.c | 34 ++++++----------
 11 files changed, 121 insertions(+), 186 deletions(-)

-- 
2.43.0


