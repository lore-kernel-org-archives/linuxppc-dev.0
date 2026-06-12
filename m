Return-Path: <linuxppc-dev+bounces-22583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF88ACD98CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 18:10:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcSGX55xWz3bs2;
	Sat, 13 Jun 2026 04:09:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781287796;
	cv=none; b=XETjP4QxEfrT+tE+3TnAH3ERmQzal4jX3uyLbZ+CYj02wjxqdVeEgK1TZwSt/oGOd2RTDKH7Vm6bIU0FwKsJl4siV9NriH4A17F5RRj3gZMo0u+jsLshUW9C9b8FRryvpcaexp2QykTApRbjvaWdML0wkA8E8AHopKsvzCeW73XIXFIXgGqKC2BFCySzb9lSf3PYjs1uEh3w7ib2vtnX3L/1F07SEf6+kB2n1TPuAzx3I3Fa2KI/S5nxXYyFmSZ7/4slEkdRuA2jf6finru3aAAK+GPuklwIvdz2REirNKJ3Tv46moumlOEwpmpgZjzNOyJCYC468HKBpaZWOke41A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781287796; c=relaxed/relaxed;
	bh=I5UsMmNx5K2MhulwAdPqrD4ef826gnyJGcd1eOHt5Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlDEuUNS6AYFroYapwhOEye+AWTCWAecoer849Kvp9c8u5qbLafoSd36lygx22Go6nfjB72AajfoNh3aqJKUkRhoJD+HzApyoJugOoxrgWB9/pvmyiP0hTgnC1hRwfaJux7GcFyjiOXV6xJ9qBCVQQRuUPojU+6MxZ/67LkMJs+Tc8hkcz6ziTtOQWT5+ONaZcLK3W+dE1WcAWdIBtKCLm93r5jWZ9sWiU+KpXUzmt8FGv9FPTdV692zo7y25GG3ewKbMUTsdzTZIBGdFyLs1EOmcF3oq5Z1xLzna355dcvfZZtKZgW+ljzJMN2LECcrmoiWYPk5gGFhULDIN8udhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rzk/dnUz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rzk/dnUz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcSGX0lhcz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 04:09:55 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2c0a5354da1so11411145ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781287794; x=1781892594; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5UsMmNx5K2MhulwAdPqrD4ef826gnyJGcd1eOHt5Pg=;
        b=rzk/dnUzcB0vvS5t+ul9h5O+atjAC4O9pi4R9rw4UhQawzQHV/CMkrxTpiY7LsiAnn
         vJr95nb5mWCLVSHbTvyQBmktNGA9HIIpYYvxcxvGZTe4/IdoI4LgP1Ebbe7SEP+HLlxf
         R8QPdvBDMUKvFF1cdDmQGG+MbQn0Pn5IUGRTbjLyiCpu6c7Dc3hCeZ82Q4vXwQpVHOWG
         av5eas5DEPibrvznMprGAXJH7S2FIOWokDBBn39ysajwS6vLifY5QQLL7wQ4buA65x89
         WnImK1NZ87kRYFYm1xCOEZeTqN/7Y9wlzEH2QEqrfcHCYTi+FEspTZLycAMaZERb07Ba
         6AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287794; x=1781892594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5UsMmNx5K2MhulwAdPqrD4ef826gnyJGcd1eOHt5Pg=;
        b=O1w5yUwAr4GTdTpsMFfkMRLHupQxa8J5eOLQXRKKBi+OFtrzXFTJpD1qT9iqOhBCTV
         asiE5XbDI0dZmOmRIdTZIeHhh1HKmOuhZ/X3p5aFEVFIqhyWFv33vRx4SJACMLsrZa3G
         trJ4uFdUQijT5pc8CoIrlXYueoGSC9SgI8CysI1QhrKsKoFK3ajGsA2iAkja1Y0hYYS7
         hNQWYeAwY7Ure+uhdA4r62+Zb7lECsaC5vZVAuHzAxc5BbbdHsvmUVpFGo6mvZ+17VL6
         miF2zjvs22TFVQ+EgPnp3rCem/akWcY6mADWOeKk1fQGldAB1eklPu5wtvObZ6RsN7sc
         7eKA==
X-Forwarded-Encrypted: i=1; AFNElJ/CGLc9Y/lc0UlqYde3hcBOtONaw4JnJmX3KcKSaG/pxPNOKNLTUGoWlLMh8xA+fmzUWEjgPX2oZ/teidk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0WuM4hppwZWx3/GHfcoILCYS7Jh7sKOBD5QchPk3wu5I+cXP6
	dv27RUOfbUoL+bxtUpRaDY/sqLIEX94gjXaxpieQkkzAR2VHkxbBjRMs
X-Gm-Gg: Acq92OFPKDIJ1PfuVJi7NteO9VVmbFqU8lc3GMv9LaU531g2ckSzP0vLXx6ELiyfZeC
	B0+IRjd58OubsJqNkGzRndQ69z9TmXDxtD7HSSjihBAIXJreg+Ifg5c+Hkh1byJazq8TLxvV1pJ
	bOc8Er4BGnXapqwNTFI1Zj7k517craUyITjRMY1xDP8xWrr6qh7/ar1Y2bWyPxKPLJmpUE1d0Nf
	bjW8pOT2CE7DK4Cx/YEYDO6eJ3LMQ+FN6at+fjKksy2i/Gn87tMlRReuWLuL9B53Yv7e8SXGqaF
	rdiUDtHgzia0Fhg6TfztmB0C24fWTBDmQxiIkluIk2RJ/7Zet+oi63LXswoSZbREauAWwmT+krX
	PAEX8fm0B4WGtr1BlBrHheAQALciA6JTcdDLrZ6CJV9fGx6sVTnVE39zFq7DxIRl/qbExzcw8YY
	ynUgORMsElsiEYU6DYN19xo+z5ZT3IpZQJ
X-Received: by 2002:a17:903:b8f:b0:2c0:c262:b924 with SMTP id d9443c01a7336-2c42e834bd0mr32424725ad.13.1781287794124;
        Fri, 12 Jun 2026 11:09:54 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c70easm38956975ad.25.2026.06.12.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:09:53 -0700 (PDT)
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
Subject: [PATCH v3 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
Date: Fri, 12 Jun 2026 23:39:17 +0530
Message-Id: <4c2b2590251be875cac2acea434a60e1c0f5c343.1781287298.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1781287297.git.ritesh.list@gmail.com>
References: <cover.1781287297.git.ritesh.list@gmail.com>
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


