Return-Path: <linuxppc-dev+bounces-22336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFB5CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:20:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZTzp2xCcz3bpp;
	Tue, 09 Jun 2026 23:20:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781011222;
	cv=none; b=ows8j9zt/W3kBa0ODCRG6XQYZ4mOpIyBOFi7J4DBZ6VWIg33PWLgWLe7alWkxLjpHBvo++YJBZR93l+fOBL90wF+zEnyvIGAcl8m1Ee8IIAjdXGpDY+he1lKuR5Zn74iBKxsHlNIUXiwctm60zJD/JkYg8uWt+rMSWMaetlBy9A7KK7oXLZn8ZUvCGCl9ihascc+RVioVbag5RM53moFOrKuEwXK8JNR1smmZaCaWyzv/BEokMuTijbItii9aUZsC1a7Lslm/wXTKbEKgY1tM9zRqk57BReTkAHGcU81ExXpwLW9Fzxriesr5kzHrd6QCSZoPBU1UiP3S0okMCkn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781011222; c=relaxed/relaxed;
	bh=jX8gUYszHwfQV68ROQgc9IwTeEh025uy+uGQInBFAe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPTCMx1hWGPP8TJuzIR+9Qf21parfTnBXjV1SFklp7sn32yVwfVGbo6BdOhIXuJyaRttc6dnoKp1Y7j36oguMa5vV/96p0WmGVd/9ZHr+n4n/Jc0pWHK/x2RsHbqGLWRGzRg8Qz0ZbhCBCHgcOFSP/CV3KWFFdB/M3OWLXQRQIKV1qXzaK/S1GinV0CBKFmZj9HYffO+0h5bepjCpSupL4zKlh6OJTrzVbUpo9uDQv7IU8kiZtdhpj1LSvie0UrhKw9DmwI7wIi6xHxWKvwhRJ3fNoF91P5J0hBN3rkdEFXWHaO/Xu/KBaCR/xGK80uHRQMdtAtpua9G8Ui2FM+rzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LY9MAhYL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LY9MAhYL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZTzn5zLfz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:20:21 +1000 (AEST)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-304c520fe9aso9057467eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011220; x=1781616020; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jX8gUYszHwfQV68ROQgc9IwTeEh025uy+uGQInBFAe4=;
        b=LY9MAhYLy9KuPhopMVzB0vVxCkYf4Hlh1VCAuLQZdTkVYny6zmcK/MXLa9+Y/CZLhl
         qY8wvClWV6fPtwAVgzFxqD/ozti/VA5mqECFbxGIUIZkfoJZTtrs/mkEW1WT9LVZuIv+
         2GQkGptd0/R5VXgEyI/Y9lvTU+AHDjLPQvLdHyNcBuXvMXS7lScsRY0xmf4P493+nBK9
         d0gGtWg8u0G0Md5yST+JwFnblPl+ZFO2RIVcCMxpPL6SPyNuR7RonU5mbouY5Xnr/vG8
         lJK9BdvbqpGG9H19aJY7/2WLNvHtU+pEwAzPn/jMV5f+XcAadrNXX1KJcE0dSmR/L7SE
         oFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011220; x=1781616020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jX8gUYszHwfQV68ROQgc9IwTeEh025uy+uGQInBFAe4=;
        b=ZSb7rI147WW+tOw+qRLYaObBLawhwHdtyHFmeEneiDDth1Ex7Jj6fqW/IImodY//Gg
         wvFHcOTfrSIAFvyxXw9xCyi4zSc18uEbFd71/dcyBFUHEz013Fd6JgLnfnoLGKkeKazb
         0v7RTSuXtBAlOzVMO1Pkd2BG3UMN5su8LUQGOSENwiS2ESoCgELGWTrlzmNeowpusXzk
         6yWsO2mUhs46GYSZctgyXn9GngaCuJqgXW+tJgFJMfzabKtL+OPlC6FoueWyuEt/MzTJ
         1l/RCCtnRrG0kVUpnuQooji9aDLI3YnhITIbTjccRplunKlp2Jx+qpHv+dhK65UJRMSx
         q09A==
X-Forwarded-Encrypted: i=1; AFNElJ+3413KP6b6givWilM0jTvzvv/MOwnQcmIr+VDZimS2s8pPQJrizJoR+LLxH/DMxyeCjFaJWH16wmQm+ZY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywtgnlr2Z7wuQsOCo2poPGF13Yvoo/I9rfSWdt+IBN/CDOXiPn+
	GogVWFza17aq+jIAiAwhdSF9c4/Bruj1yjQgJ3bqWHVdHDef5gj4mITP
X-Gm-Gg: Acq92OHEP10OFiAX0IKJRcQW1fhnSIpjpjviDuhoM5tb8DyDCAJJjclqLArq6d2zw82
	ilqNlRqQzQVP3MAY9oPvIWnp1dCfol+JRFAfORNbsCIafnoVNMhEeckemkZ/kjZCzqu8Vq+o7i0
	fu7DiSAv5Qre6dD+u4+5ImoHUFzNNuIwRjE3h8eQ8tnDYEHdBrerlBcOhVjvELtf05RHzktt2zJ
	X0qjNG8oXnk4+zAHivVBdx+1lh/3iIYz3WWeqP4nfONptDAUX8v5fWbCcyS4Vt+5VT+Mxnn7wDo
	6VnAYeG3NrM5BMHbCP1tAYil8O2uQkvg/FC8SWK0e4nsW+Wy0LrykpYgzH9V/Ncgp+kInfAFpLo
	P7+pIicSZydVISIO7ebEzJ25jVw4AIHtEbVLMAeABJg+AIvVdWi54RtgGquQr2LClDG+Q9BNB+v
	296gnfFC1VtkJ7ojWWWtIaqq49DuWvdoJ78M0XMd/ftWtJqfqieGrufJCRFWNWnOOPm8DNK3s=
X-Received: by 2002:a05:7301:1010:b0:304:2af3:5ffa with SMTP id 5a478bee46e88-3077b759566mr12644279eec.19.1781011219664;
        Tue, 09 Jun 2026 06:20:19 -0700 (PDT)
Received: from localhost.localdomain ([129.41.58.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm27162467eec.6.2026.06.09.06.20.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 06:20:19 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sayali Patil <sayalip@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 4/4] powerpc: Kconfig: Enable THP_SWAP on Book3S64
Date: Tue,  9 Jun 2026 18:49:34 +0530
Message-ID: <2eed2ccf40bd017cc55459523bb18c110b907bbf.1781000840.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781000840.git.ritesh.list@gmail.com>
References: <cover.1781000840.git.ritesh.list@gmail.com>
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

This enables THP_SWAP support for Book3S64.

The performance testing of this patch series on Book3S64 with zram has shown
around 40-50% improvement in case of Radix. We will be doing some performance
testing on Hash too and will soon update the results.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index bac02c83bb3e..48f74bd22343 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -113,6 +113,7 @@ config PPC_THP
        select HAVE_ARCH_TRANSPARENT_HUGEPAGE
        select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
        select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
+       select ARCH_WANTS_THP_SWAP	if TRANSPARENT_HUGEPAGE

 choice
 	prompt "CPU selection"
--
2.39.5


