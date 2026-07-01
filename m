Return-Path: <linuxppc-dev+bounces-23312-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FAFC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 17:19:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr6F85NZjz2yfS;
	Thu, 02 Jul 2026 03:19:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782926348;
	cv=none; b=dcBKSA74o0W/eKwFYnTYkZTdVfaAHESEXSNRTnh3oIJ6vBOpBxaBGT1g1DfNIf/qqPIhq5mDTQC/8b4KADecL7QOsKb0NixpXRnQkJkFyS2ZBxF49wjgZwlgqldYOWyyJMfV1QHkLU1C0n8rXjpPr0R3JGSyM9wuBe4wrV0FMayAf01BKEuUIiXS2BqzbY4ToHWGyOjOVNrYz+1bx/3KIm+SbwsGjQcWZH9BmXM2c8rHV1cxDKi1LJXicIwfTfDlVXbb4rvsGHfmCvhIFCv2y7XcN1R/6JIByCMcAVPrrz7pM+2bFSB+ZfupoFtC/1SNJXdjuU7cbfHnHWF7PDRwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782926348; c=relaxed/relaxed;
	bh=OVZjtpTrxXxAVguXYAz4E7mi5sWPqKxrHjlHEoMDU8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aaayu7p74pzd6zbXASO7dZPh2aXQTuMa03kbKkX3DBAPyv5Ka3hEttzZJUL08HKv634W2UUlQjd7wzO3qVXth7EVN9vtfQcIULqvZtIGFuKxvr5sy+seaTATE0s8n5aMqlRjy7Sf2wtV5ANQ+9JT3FExp2ERp3o6o9VbSnxnkrQBIoR5PuH4WLUmTwQEEZwyXCSN5OGPxF4MgLao83S+d0xisk8KZqY3XNgrYDw3wsX+DRmT+FA14YFANoHqLZLGzr9l9L3h9iPVjQ/w9yS//cXzaehHnVeggKdzI9/u8tRCCYfKe28NHOUUSSrHSkXd5OrNYMNP0POs67ngd/NZ1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gbc786pw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gbc786pw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr6F76jDCz2yfN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 03:19:07 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-847a483e344so595202b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782926345; x=1783531145; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVZjtpTrxXxAVguXYAz4E7mi5sWPqKxrHjlHEoMDU8Q=;
        b=gbc786pwmy84hcAxygjFZV3rEkDBrB8EIn9/jjH3khKRMqtWAfbcP4iC23gmW3Jrfs
         GVV4LkGClGTG3PzeAKf+BkCyBPPbFzYiodV/mFwmRhJ0rGFXHYVj5GsH7jY6OeOFQpH3
         10LLRpD3FXv3i2cS7ob4dD90KX2Sbpm59T+2j+SBPY9ACXLlWmX2/gjlhfDoP+k4jr9j
         MO5OxfbpGHst6woQQlg8O0Yz5zAUh8exLblal7aZ6cVxnpDtVMoGTV3UD1rHDpMbQlBE
         VEJf/vrwI+qnZL90kZWAAjpjH9xzzVKmEg9tIrIgvZWtVbWck5auRVUAth+d7D1jsjQY
         3glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782926345; x=1783531145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVZjtpTrxXxAVguXYAz4E7mi5sWPqKxrHjlHEoMDU8Q=;
        b=P4TOPCEp0U7IDWhFsUeVQFgyPTDV91xcGNlhe/GTLXrVmulu9XHc1tccTeEk0ceOeh
         W9wwmeCypIDFNVAIsQ9VjWbtQRF2VRXDfAvhnuDpVyxmNzwRVcn07r0dFF7UHg81cVcN
         r+vKx3uvkjog6UL9wrq26hfmMZugGoz5uz2ndQz6ATRJNXLkeYmA7bjUU221EtoYFdZt
         5x9IC1Hurf61P6ZTl9Z2mXUAVK8yv4Cq8n9ueT6tWkrNwu0HyJa4Go5FGKhGRay3f8rm
         zy8g+J+38tC7mcCBx3X1bfTzLQXeslF72hdcHdowY6nYkvJ01krN4wiqIymlVTVvJ6gJ
         tzCQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoKjNlY/OxRoIf7pQVuv0rSd9CC2lUAsQwefHAopcd77LpTxeIKjXJrQEDszIE9S4yGdHupLVmZqGhYno=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6UZqOYSPK3RY3rnKCcFHXSJCas3rfYf6QQjdTNZYRPTF2opFt
	0ycCBNzmN65Jw3etqTTIKFiXnJNZaxhV2xN02jF32skUhVxZkKyZI2ll
X-Gm-Gg: AfdE7ck+HuUL+H33oII89fBnatRcntKKKNHs01rayUpqp+E1zYfxHKRR2ie/L0Dk5/g
	uwWUG80kKvxnjLaGtQtEEnvJbHr7aNvyZ6MPoSNF2f1t2HISlW7uxYhenZl+uU5Lz3SOL0L5ttf
	XyckSwFRu8zB3Xx0ix1rDaJoMOau3HmrYfBhw30Jm7XyJnlWT2mSL+O8K+AztfA2r7XZpxtJFtL
	A9lwVHzG5f8tue8uhQp41Mlg4xMv0HIhctTBnmvD1KDtU69l2grEEiLXR6FWkPihOm25cFOczKd
	vMN9EZBYY47vYK+oFM6ap7mFlSZP8LbSp56dU4H90Srqs1iJO3ddADezTsaLmX212GfhhqCQVyX
	uW7wAcXlnh288eD8xpURLuuOHDiahYfZCdbhnUNLxAkrw+B9baGatm1rMJMvNayQAOBw3RUnFuT
	Qb/FH4q9E=
X-Received: by 2002:a05:6a00:948e:b0:846:a04:acdc with SMTP id d2e1a72fcca58-847a831fb33mr4758788b3a.26.1782926345049;
        Wed, 01 Jul 2026 10:19:05 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94ab79sm105719b3a.31.2026.07.01.10.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:19:04 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: akpm@linux-foundation.org,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Yury Norov <yury.norov@gmail.com>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Brendan Jackman <jackmanb@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	sparclinux@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 0/4] treewide, mm: initialize node_possible_map like the other node maps
Date: Thu,  2 Jul 2026 02:18:47 +0900
Message-ID: <20260701171851.2447626-1-ekffu200098@gmail.com>
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

While reviewing an earlier series [1], Andrew asked why we carefully
initialize node_possible_map at compile time, then zero it within __init
code anyway.

node_possible_map, aliased by node_states[N_POSSIBLE], is initialized to
NODE_MASK_ALL at compile time, unlike the other entries, which are
initialized with only node 0 set.

Architectures that use numa_memblks set node_possible_map from
numa_nodes_parsed, so the compile-time value is meaningless for them.

However, a few architectures that do not use numa_memblks do not set
node_possible_map on their own. Once these architectures set
node_possible_map to match their own topology, the NODE_MASK_ALL
initialization can be removed.

Patches 1-2 handle sparc64 and sh, which do not set node_possible_map
themselves. Both set node_online_map from their topology, so set
node_possible_map from node_online_map.

Patch 3 handles powerpc, which sets node_possible_map by intersecting it
with node_online_map. Nothing sets node_possible_map before this, so it is
still NODE_MASK_ALL and the intersection is just node_online_map. Once
patch 4 changes that initial value, the intersection would no longer be
node_online_map, so assign node_online_map directly.

Patch 4 initializes node_possible_map with only node 0 set, like the other
node_states[] entries. NODE_MASK_ALL is then no longer used, so remove it
and its only helper NODE_MASK_LAST_WORD.

[1] https://lore.kernel.org/all/20260624204030.3c8baa67713b6ca1d537baba@linux-foundation.org/

Sang-Heon Jeon (4):
  sparc64: set node_possible_map in bootmem_init_numa()
  sh: set node_possible_map in do_init_bootmem()
  powerpc/numa: set node_possible_map from node_online_map
  mm/page_alloc: initialize node_possible_map like the other node maps

 arch/powerpc/mm/numa.c   |  2 +-
 arch/sh/mm/init.c        |  2 ++
 arch/sparc/mm/init_64.c  |  2 ++
 include/linux/nodemask.h | 20 --------------------
 mm/page_alloc.c          |  2 +-
 5 files changed, 6 insertions(+), 22 deletions(-)

-- 
2.43.0


