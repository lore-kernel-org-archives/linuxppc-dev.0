Return-Path: <linuxppc-dev+bounces-22473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284A1CD98CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:48:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbdB038tMz3bqh;
	Thu, 11 Jun 2026 19:48:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781171288;
	cv=none; b=nnYlitLN2O02NHL6AGvECSMiUMshU8mYiamB+fbB/XFUJqXQGymREwzivZ+CYb3l8jM5CcK2+Yhhbi3qivmiChzItiGF2X45gaCp2J9PxXBeXrkTU3AyoswRX+CsYh2zpi37Fa5L4CCZ5BhVhBDUgHmFOA0U6cIFGEeGtJYn7Y5JJMeG72e02JGPNlaiNo5yw4+J9HntBzwGZA2FTlYJywLvq86xUosA5PvwhkvFNk5wqyFHz+1XA+QInKqrtD2asruwpsFqEcndr4F8FNz7B/upm6yBZmgtgBDgbNK7ior85zsDECXfGPCewpsMFaUbL1mHYXNWY6FcuZ7JqQe+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781171288; c=relaxed/relaxed;
	bh=Qg2kMEb5Xe0fF/D4cKsU6T2DOScJQxYsttzCFMpVKwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JJRZ9z5X92u4qCMeFyGVRI9GI0S2yw7dsUdd6ISZ4ylNZZ9OlPZSgeOiIAtTEjfN8rvkKi++P1cxPBm9hygBH4MeTj4eDwA2WbUkqhX8LDrpGyvKbjeYo1TDEwAK4VwbfQ0uhLiEtFLsfLBMqVtjD5dZHOqWPQxccvhMnp8LV8TAu2wBB0ivjEhyCzA/wXcz0TNCDyEBO/1ffK8r/wArTfMKv9QCg99eg4lrFybFyzwmdwHFyxkqszVB+H/umMdS/jV4+SR2B2gPn7grHSuGzvJix0XmRsKiWq9qVIZCfA0aNmkZCgLVELYTyNgF+wUKyj8F2r+Qs8SctzBS6ITKCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JGXHKoVM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JGXHKoVM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbd9z17MDz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 19:48:06 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2c0c35980fdso76015995ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781171284; x=1781776084; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg2kMEb5Xe0fF/D4cKsU6T2DOScJQxYsttzCFMpVKwQ=;
        b=JGXHKoVMkKH6qsW6vjdDerVoXc1jgJMhUJlWvs4ZmOv8gkP4oZArFKoARddmFTfUvk
         3j36nVvyxiuKaNVcJR4Ueml6gT29NgwN380oDxt1bIMrCzforKZ9XPCYB94bANnpPoZV
         z6bHR5LshEKhlEwZHI35rfeJyDzRxxyE3JNsF5L8oPDyQI5bwpJeZ7hfSp7ZBaZQ+SDy
         v88O8Zqr2Jx4lwK2Wo2M/uB1zAh4OekZgkFkp7Pwh9XDmIkOnWif1zW3/+ZTcIsXQ5tk
         8oJB/hJo195+aLdVNPhseJwITCHKpIf0B6NUBs2ou/KFxxh3Rk8Jn/e4Sz0mqzc9R+rW
         8Sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171284; x=1781776084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg2kMEb5Xe0fF/D4cKsU6T2DOScJQxYsttzCFMpVKwQ=;
        b=M1SFe6t1RNKxKMmBhSUF2cRgvlPc96ao9pa5OjlrE8495GxEkqvPq0o2jK82+3pDqF
         mOkdCOSOeqE3N+VhUbEfQ7zVPvQ1ZDilHwB2DEqYGzaqRrdHnjgdj+kSD8VnBzXXVcGF
         rSOmpBxy0na7NGOMzacyzg4124ZcZMVj+aSpzklKGdjLD+zOVtRq1qmwFy9RRutI0tGK
         roOaarA9fG8pnX0Xhr3JOqwEoL8YuA5NGQYf+Z16Izqty6oXzEXLVi3tg20/zkW0GpLe
         ReHqvMC5xVfUxlnRJZpwSMJ4SREXNYF3Hx3iV9Cr8jI4OpGUSdE9HJWYdHt0CxrPw3R/
         wimg==
X-Forwarded-Encrypted: i=1; AFNElJ+8HR7tydoZ77uezYjxEu0Fo/vYvcul+ryijJvlHyAUe/NoT0ekj3GGGrUC4rUb/vT+BX44Q/tNMj2EvTs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxUa12Hm0jSHAVm9/8SZ0wDh03I+PUmakpPxbk4Pgy0KV4zvWKu
	Xic80G90wmQr9e26j3C/Webpb6EQhsD1XhYdR8a5kZwkoHkYavav5SWW
X-Gm-Gg: Acq92OHDMdLzE5yNB489S5ZSL/qDJPpFizCo1GnG1aBTbhuPtVrS1puzwP7qPH82hWv
	DkwUYlG8tAXQe3pNxsdBeGYK41WdOrHy6/u8pdMgfNi294NPRqfnBxaLmdEM7hXacUe7ma/r5k8
	oNvRh3ptJKk+dQM2+CLC8HUsOiUIZj4Lyi4NyxYgGsa4bbw4k0EeDHev82Itmi3z5XwvVFUHOBW
	fbDYqctiYTpAa62HfjwKsZ0kiVkdGi4t4GB+y34JPf6djX3T3ZltYPyeqWTNl0QEtTBmHvsm9EW
	GYILJZ619GK8vC5coNL0MgI1AyFw/tZFnFTdMqlBmAeFyHQ+annHtcxaEA62bg1cNylrUXA+gN/
	ooqbpzByKIONDF/U1Twwv1foxzQgEMgEzxw5rBbEtxNqva/EtoCR2BhaSk0n21pjU1aK6nwZoDi
	LXqFhWiUdQOR+Veh3TKJKcu8PEVG0AhTg73LGzIrY108I=
X-Received: by 2002:a17:902:cccd:b0:2c0:c262:b917 with SMTP id d9443c01a7336-2c2f0059f43mr23628295ad.5.1781171284217;
        Thu, 11 Jun 2026 02:48:04 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm283324905ad.60.2026.06.11.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:48:03 -0700 (PDT)
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
Subject: [PATCH v2 0/3] mm, swap: Enable THP SWAP for PowerPC Book3S64
Date: Thu, 11 Jun 2026 15:17:50 +0530
Message-Id: <cover.1781170904.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

On PowerPC Book3S64, MMU is selected at runtime, so macros like PMD_SHIFT
are effectively runtime variables in the Book3S64 code. THP swap code uses
these macros for e.g. to size some of its array data structures based on
PMD_ORDER. This patch series makes that usage dependent on the runtime
variable and provides an upper-bound architecture override for cases (e.g.
SWAP_NR_ORDERS), where the runtime conversion is not considered beneficial.

This series increases bandwidth throughput with zram backend for swapout by
around 40-50% with Radix and 100-130% with Hash (Tested by Sayali)

Note that this patch series is based out of linux-next (next-20260608).

RFC -> v2:
==========
1. Send the unused leftovers change in swap.h separately [1]
2. Changed RFC Patch-3 design from runtime SWAP_NR_ORDERS to arch override
   (ARCH_MAX_PMD_ORDER) - suggested by Youngjun
3. Dropped RFC tag

[1]: https://lore.kernel.org/linux-mm/68591daf0d679e5a0072d63751f187d14613e2b0.1781146877.git.ritesh.list@gmail.com/
[RFC]: https://lore.kernel.org/linux-mm/cover.1781000840.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (3):
  mm, swap: make SWAPFILE_CLUSTER runtime
  mm, swap: allow archs to override SWAP_NR_ORDERS via ARCH_MAX_PMD_ORDER
  powerpc: Kconfig: Enable THP_SWAP on Book3S64

 arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 include/linux/swap.h                         | 12 ++++++++-
 mm/swap.h                                    |  5 ++--
 mm/swap_table.h                              |  6 ++---
 mm/swapfile.c                                | 27 ++++++++++++++++----
 6 files changed, 46 insertions(+), 12 deletions(-)

--
2.39.5


