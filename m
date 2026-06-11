Return-Path: <linuxppc-dev+bounces-22476-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74F1CD98D2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:48:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbdBK3ZV8z3brC;
	Thu, 11 Jun 2026 19:48:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781171305;
	cv=none; b=E6MxJNSZIXcbZ+0rS+ONni57myu3YdB54wFoCVwpFsas5UbMYLOiz/ZX6w30U0zTmUpi2vDnomBwQBgsJTKZrC5AQp1Lvtdub4Y+jlJvggxBNQ4NAOExew6VKL+HVC6fcgyVr9HWn5YUS5747OuOkfN+0rTfOhjybpWyb/AdAPDPJykSE/RlDc08KEQV9KNPD9O0bFuIvPZToFfptUfn1S8rZJu1JkZ5SwngmyFF/faQWWfpfbXtFpfsJdOY8sHFDE7Mm9Zwayzh3Wz5V9GYo+kUUdqf5K+l5/MVTD7ATto0SBXXyUKl9gOrhBRilNlWq12KO7UjZT2rGkgqspKALw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781171305; c=relaxed/relaxed;
	bh=I5UsMmNx5K2MhulwAdPqrD4ef826gnyJGcd1eOHt5Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jf+T6XHieb1zM0kHHw6YcQHmL5IOsUAKBZD1jgzTUIE0neff9DboOs3HJGPDRBhy22eT+7OARZhncMqXGv1EtWvHsj8XqYVoAnYPFP+nKkX+Ibgm5WngLtja3lh0KnOJeIu+WpZ6I7tBkK/yr5YZhlWUOfte3vr8vlJKpCisI24CkG4zTNbVL7Sy5Vk6wx6tWWk77v4EK0laUm/4Xy4GNWivkucTgTm0TgB3Y5kema2HwaaPaWiLumQhFDB5NzWoQrvVnTloVP1abpmLioRwORhX8UOxhU2yNq9ezDyeEvf/UCHc51VpsuCwJHmsTIe1Ct89Xz5QXNh68CZ1eDlPwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=atfKZd1q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=atfKZd1q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbdBJ5kZJz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 19:48:24 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2bf125989f2so58376805ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781171303; x=1781776103; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5UsMmNx5K2MhulwAdPqrD4ef826gnyJGcd1eOHt5Pg=;
        b=atfKZd1qpPV3AE5LeXZRnQZMuM25mV64utiDiukJ9SpJeZgs/hHYQKcK34+11lNUdB
         NeKx68/ZdmzvSFq6UMCvEqOwuio75mwKlR4d+RMWlN1UaZlwHRZ5dJ9kQop5olS1h/yg
         FfvmL5dbSUZemkQHs0ZYOAvMdkLa//yXQ63wFT6b4Ys1g1hKG9d6BloWqcZZsZnKQtUA
         zGIMAgOpLBWOfgFSeQf9mNqfKVMFFwdXN7AZJZtN26gaqvqNKeKwJGDk0r7odq2YAMSF
         2NxPUXH410IPq+BR/zZw+UTdJ90SgH5DuLgnz6oZj6MHp1o8atnVPUfqTceefbL3TOF6
         b15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171303; x=1781776103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5UsMmNx5K2MhulwAdPqrD4ef826gnyJGcd1eOHt5Pg=;
        b=gPhwtCKLH+NXAy1vY9UHnpRm1So0NA9jiK/VwIJK4kEhgDQK0jlvQsNbkiiR9IOeHi
         9LeOSmNHdk/qmvIqhUNfjQDpabHRJ8mZF3cWO5VgiG5uit0v1rzJ+PExDLcZISziN/rn
         PFEkEoTRBcaFZChzN4gyWXwwR2iwyeilsAMeBZ+hFrt8mVCW/SvgP9JpX/bWArTY0pFs
         jdzxhKallPYBbrsPKsesH7EnwU4duZdeleK89lawxsus4qpDmQsao1HQYZlXKvLJLxqH
         edoc/GW63upqPW7Vg4PMhoIN8fI9uOfGvw7Rv7lxeKSCU2IYrYuFeyvmCXbCA3Cc/4K1
         Kwng==
X-Forwarded-Encrypted: i=1; AFNElJ9OJWRJ//zRR5k5BbGySYWn5jPiRT5SRuque6NWHuK5qDXwEZ0AIs/OoDkVq8q1P7WmEoLPBQZ5asUzNzQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxxQo+AOYFMAwdkhZnMVIzY879kK4jNK3sPi1IbnbMKHgjbgvim
	ZbXs1fy9Mxzag+WrwZ8SWQu+U1w1iUYYqBk/5dXJiIBygk8rXdoxvwzr
X-Gm-Gg: Acq92OHOIkjPZ0dlN7yo0lyxeMCfcy5UDE0GNHVt8nwFP4bLycp5m7WDU9dpnkoO9MF
	jBdR4fNgfdYC0fux2Zhv4XT/hH4+aqtQ3EoGspeOp+TTqy1Ck6f4g2Axey9JcX67lALcDjVtG7n
	ePk6+kxMcTTcusyFdqi89+2Rf3AMQcTt4hYixNa63bDv+tMgKdQBKznDjFv3dEhNnQTbBQK535P
	6sKt9i8FoyqAV4Hka5Us/57CNPZfv4MC9azHpSfu0nanDB+g2cGhhSF9eMw8revomXMU0O2PR9x
	/nDlNt6ZFfvB32MVrML0fCyW9MloDwi73Zt4IfAs83DsjSmFD7VHSOMLwfyxegs4z6VPuVcDEqF
	s2fJUF2YhqGbdgOhshRb/q2wK/U+EFrXntGVsz2HnzKe9WiEWqw59taXrc4PxU5Pyj0YFLgmE1O
	4BsUbUmK/cOJ14YdOfG71FWdRxLXZDnJsvFT216W5IIjI=
X-Received: by 2002:a17:902:d581:b0:2c0:b9a1:6493 with SMTP id d9443c01a7336-2c2f072df8dmr24320965ad.10.1781171302591;
        Thu, 11 Jun 2026 02:48:22 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm283324905ad.60.2026.06.11.02.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:48:21 -0700 (PDT)
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
Subject: [PATCH v2 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
Date: Thu, 11 Jun 2026 15:17:53 +0530
Message-Id: <3abf510d24c8ef17bd5e324cccc5e03e548afade.1781170904.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1781170904.git.ritesh.list@gmail.com>
References: <cover.1781170904.git.ritesh.list@gmail.com>
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

THP_SWAP avoids splitting of a transparent huge folio into 32 smaller
64K folios (Radix-64K pagesize / 2M PMD) or into 256 smaller 64K folios
(Hash-64K pagesize / 16M PMD), during swapout. This improves the
swapping performance since all the bookking & I/O submission happens
once per large folio. More details at [1].

PowerPC Book3S64 could not enable this before because PMD_ORDER is
selected at runtime depending upon the chosen MMU. The earlier patches
in this series turn SWAPFILE_CLUSTER into a runtime value and introduce
an ARCH_MAX_PMD_ORDER upperbound override for SWAP_NR_ORDERS. With those
changes, we can now enable THP SWAP for Book3S64.

This increases bandwidth throughput with zram backend for swapout by
40-50% with Radix and 100-130% with Hash (Tested by Sayali)

[1]: https://lore.kernel.org/all/20170515112522.32457-2-ying.huang@intel.com/

Tested-by: Sayali Patil <sayalip@linux.ibm.com>
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


