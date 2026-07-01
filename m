Return-Path: <linuxppc-dev+bounces-23313-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC8FC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 17:19:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr6FN6zg4z2yfS;
	Thu, 02 Jul 2026 03:19:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782926360;
	cv=none; b=K9cJT/HAQjvtAoiLbHptGVd34WX/tHZw109MRTUd8/fDHlOtDWPtFxj1zsU0LK4LvmOqmQ6qWtEQuOdh1DyBDbg+QzOoxX3sIdAH00Y5H4ZEOItws5QHvsyXwhv3VEKer6YTZPL5WEgu8UOIL+MiFGHBcfUntwJDM44+p4R4Q/81hptt6JJ/Gg+LCyax96OgxySvWPwdUpIsn2nzq02Hj2PfAsUnREhIrrdrqc2gQIHCY0mW6/Zi8z4bI36fHNROcanT73tC26B4WniZZmd76ZKOd/upkZ5qlyn3649kkbGcQftc6RTHv33LVYw/73u8xQBr9lyDa0y4FR3eBZQX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782926360; c=relaxed/relaxed;
	bh=obKytdSgK8DmwXqyL+Uzle0RrtZhdlqOEa7faS72rK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1gkzPeEAD/M39GNuPM7xR55fKMy8nsfigJxmKbyInOWtu/sbNiojifMIggg2SlRFD+r0REu6uhGjjNRhYC/bRY25osOXShNLhVNcJVpGkec76IUAPPrBD3/uQKDajZkN1s0kR0h9ueNnaJNU0Hy1hLL+U34pU9mCC2m+qLmIsP1WVkysguW/m/mMxdnyMZB3B90/drXO6PdbXdeTVR9BYQ/O4p+MlvQok1Mt2qTv3+Y1U6N1AddHZeLkwU/WgimhrcJANds5wSh6gOQlvAjGKUrc5x75L/xfV5phiry7aLCYdYxaVoftRu5fHq3WTCs9Kl2o+zyFQzTl8oOUFDidw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=anDIf+b2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=anDIf+b2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr6FN1D8pz2yfN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 03:19:19 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-84794e800f4so495065b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782926358; x=1783531158; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obKytdSgK8DmwXqyL+Uzle0RrtZhdlqOEa7faS72rK8=;
        b=anDIf+b2Xa+lBrU4MDaKTZq53I/9IczlHP/GLpbQWH4eEOL1C0rh780t6R7nrUpY1m
         X0lTyEjv/uvXNe9KGQWSsO6anpj6SjcB7iscC4vmXckr9BMWCgsAh19zvRWf9F4V7P60
         HYcFU31aAVZfm3ri30yGIUZC2YGvykP51Zjc7nbcRrYdaaHxWWH8RtJRBKQ4kk0k+oB1
         hiQHVL08prAovrbTsCcjJH2nMNVt9ZKVIqoFXNpCSYNEYsxAuZPHsPwYIvXYXkKOoMcp
         fMX+O152VIT54Pmv6JyEKztME7lCMtJiqiRrqEeB+GLeDyyywOA+uwFi2IQNYXO0U7y4
         zRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782926358; x=1783531158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obKytdSgK8DmwXqyL+Uzle0RrtZhdlqOEa7faS72rK8=;
        b=R4grAaujflNJtSAKr2uXKktjkl601d6jfK3l2bS0tN0Rw0mXIG/yoiEhXu4WAJXPTW
         U4CBYLGZ1Un3vdkRmYeprsRJv22dCDOnj+j3RQIjVcd3uHVxd2/lnNOpTMnbz6uo5GFl
         /DTvZozGDw87BtJFRZJZXoiuGAC0z+0Q3vSIDb+yWcLTfFUV4GKl3XuTCzjeo+vK/y/+
         pepPdn/qm2IDxTUPPbqv7iqnDAEkqPZggZj0IY0/lZbZIAe1q1biDfOvvz+zQY9R3gTR
         vK+jDU5eFhy6ACV6GJO+vKJqfoa0Hxn8pvJTJZoC1HiRuWcevTOLDuaFi09HcEFJlehZ
         Q0QQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ikE6GOnFulh2QCHK2f34uRYTuCQs9RFBqosDduchen3X26KvakC3qoHFBH+udcQzDkVAwMLgNsYv/w4w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzfCEdelXSSEquu1pR5SCo9ec5uSTtV1impTdl2w3GUpeba7byw
	kPfRUyKZUPtik8cfRTJOmloU61klTm/i+PNLYKp3uMwrowHK+wSt6ewD
X-Gm-Gg: AfdE7ck43/juJbY9a1D9Mh6l+vpnPJ3F3DRZiokN7L2FLwjx6EiRBDC+f0mvJKYLFqx
	o78P/wqZKTMhSuBRnRmeLTgOlCf/lIR+o+PHvl1XOZ/VTE7apRj4VE0U6KFaL3cGnJeKsjOIExC
	EJQqeJUcjDssqHTJb3ug5Ujok02V7cJp+LEhUHsYkV3h7bVyTYni5uNp2kMyNdIqXhhe0zJCa7q
	HKfo6/j4fFrB3njTRLfwa/POETp8lwclDmfKkCviWASCxLnyUciVgH9Rbn9hqkZpi7Sjd5Aguea
	alO8NzS42ne7pjr412LIyqZd6yMscwreKoXAlybC4Nvq7nXZ2RAP+82nFjpgRnMgEFguEoBKqQw
	bo67pdFeiO7rkmthR1PToujy6Rqlh8tiFzp7vtw8pb3opnYfKdqDxjICopkjKZElykwE8vyHe2F
	udGwfUwz4=
X-Received: by 2002:a05:6a00:b4e:b0:847:7f0e:1ac6 with SMTP id d2e1a72fcca58-847c5070041mr1582243b3a.19.1782926357933;
        Wed, 01 Jul 2026 10:19:17 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94ab79sm105719b3a.31.2026.07.01.10.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:19:17 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: akpm@linux-foundation.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Rich Felker <dalias@libc.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 3/4] powerpc/numa: set node_possible_map from node_online_map
Date: Thu,  2 Jul 2026 02:18:50 +0900
Message-ID: <20260701171851.2447626-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701171851.2447626-1-ekffu200098@gmail.com>
References: <20260701171851.2447626-1-ekffu200098@gmail.com>
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

mem_topology_setup() intersects node_possible_map with node_online_map.
Nothing sets node_possible_map before this, so it is NODE_MASK_ALL and
the result is just node_online_map.

In preparation for changing node_possible_map's initial value,
mem_topology_setup() no longer depends on it.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f4cf3ae036de..2fdecae90a01 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1179,7 +1179,7 @@ void __init mem_topology_setup(void)
 	 * that we expect to make use of for this platform's affinity
 	 * calculations.
 	 */
-	nodes_and(node_possible_map, node_possible_map, node_online_map);
+	node_possible_map = node_online_map;
 
 	find_possible_nodes();
 
-- 
2.43.0


