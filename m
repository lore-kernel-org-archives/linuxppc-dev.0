Return-Path: <linuxppc-dev+bounces-28385-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0CFCA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:44:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htdHF2MdMz2yMK;
	Mon, 28 Sep 2026 20:44:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790592297;
	cv=none; b=YDg6fwgQQzHk1qNyCqPR78OibysIA7qOBrFphGZkRqimYIp9q4gK1WwN5b5SLqmYpBF3Xwz+biPUdprDuEPR09Lp/J7K0ogiliLobdkuMnXb/Caaqs0rTnhYsdOFu0qLbGZ2uW+vxwK24aUj8JI/NPw3GlQgXEVsgs+DFPR4OXZmvNg8Ef4Q81kPeVUcmNoqEZMZ39LL7bwVY/SLvX8RK0c8/lT0z3V6gG/5an/RhgmowxGqOUHdCSgEXmsct4cxppWt244jikuZKJnjlLs5/8qljgUzWl+XeZ7mbP4cK5tnfcImy1cxCn/TAKLTnSCeo9ZbH7hdXSTVdLewfvSKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790592297; c=relaxed/relaxed;
	bh=w3u++Y/y+jB+aifVfMts5mY66Lv7aHX/LkoLWAAVmgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lS4nbj9A3vWmjDZBq7Ey0Wt0s84Rp8zaqIPgLJPh5rsb6PZWmNCIo6xfAzd3d1yNJtmq8uXR9eX4DHLHNXrP/lOjDav/7vMAHpGEw7i6c5/q5B2RmzauzVhXjpBxfAat+glfoVtdVSCvA/OLSJEZEIXwu2VW5Omb5xE9H6Vrw9/MY6a9cDvJ5Pd8xfyzn+i3x6i9KgcpoRXT7Id/bDB48j/hb/DuELO7HO4Q0Wb+UuWBwNL2rhTLxDR2lxx6M08syNWocAl5AY8aH7IQdwY2DGgzC6xNFb+X2TrcQPDXYB26r+wSLmXIl77bHBidXVimd0v4yk998L0NheZrET0jwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l6AN+P88; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l6AN+P88;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x2b.google.com (mail-pz2-x2b.google.com [IPv6:2607:f8b0:4864:3b::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htdHC3ky6z2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 20:44:54 +1000 (AEST)
Received: by mail-pz2-x2b.google.com with SMTP id 41be03b00d2f7-cc7979d1dedso704321a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592291; x=1791197091; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w3u++Y/y+jB+aifVfMts5mY66Lv7aHX/LkoLWAAVmgQ=;
        b=l6AN+P883+VxNSaFHPJ7UQHY0Ia7SMz8bbWWilT9/wLqBKadlzTc2LvYkG58RuYg9v
         msOX6Wu51bIbDZgqvgK91onVhAGMpVJziBRquP5ihI96dVNIaJbTtkSDZ7ct19qUidDh
         ofCB9u/hgZ31VMIdix3ps/EkDOqymbb6RknKipaRV7qCk6KD4VfP+8omZ7Szeitiw277
         7+NHZxvH+BseCIxSUaMggr8hqbsFIaa7+Fphw101cFuuv1zljrM5QumIMi/FkAEnkWNb
         90686DsptIXIoUfILjfn9UtJ4AJGpmzyrXMJ59L6qf5NnFiSI4ix9t6QC1qC/eNUlpZk
         5nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592291; x=1791197091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3u++Y/y+jB+aifVfMts5mY66Lv7aHX/LkoLWAAVmgQ=;
        b=cbh7HjnI/t0nEgcOoT/RMAs7AiaXxrKUKot1UN4MCwzojqfMlTs3ntaszexw/siyZB
         TkKwk5xxLDBtWBPc27VUbQt12qRdGBrQMRYoDQyE3PgbW2mg44wWpNT50wQvjSTRStSZ
         JUEUwhx/CnGGXRqKEUASCP0scUkVdf24hOlFUEFda7QzaUwtN8UFOxWAH5MyVKAmsTbc
         yaAiRQ+OvkPOgrEuVkFB/GwnaJW1s5ocD5Nr5njj4kwLLKPalqLUa+UdKooEYnKpG/Of
         mbBQ/FJn0pipppdzSmA3jq2abxyMakLR2bD/f94LkEvTj59hgc6nlkKCDTD0L+G6Asma
         Q1HA==
X-Gm-Message-State: AFq9FYL0rjiJtNFxXw/6b0jNnWDGpDggmmwRjZ3BluHehPFOv/LJtsc6
	VO3VOhGrzhu7/I8JB+GTgMd3XZ3L14Q6dIGqsoYzuxC+NkCxZfWQXj0pagoG1w==
X-Gm-Gg: AYBFou3JkBfW1uLBJErKSZ8bsgWg5AbluyEYtXIZoeJwYX2fnjwIMIBS6VgP1Tj+n9E
	eMd/mGe/4iJuJvDNXu6kN364YAsWcVBcfS/OpoGVeJiyGVlYJ0ZVOu0gYiIpo+uqZxf2rvwsSUI
	bulB4yT0cNrxAi16/Eiurvxt69wyEbG9l82emtO34QoE4IIeOzZYSg9WJKd6WIx9930KzL7qpJs
	0Y4cpBoFbpkJl7ZYI/8mXSebXfLj+/B3fBm7m8k+QbQpNQ1Ejp+oTVR1w1YQrPRl2WPcTyuiB4Q
	lCqKyIx/HeBY3Ac0fBFP8JaGQ1e4WOZD9pv2nEpZPG7t6ks3g9U+h5AnL6U/MBpexzepYaqGndS
	4zwmTOfbh9vN8W0UyjVoCtC5szEfP/bh/k0B9BcwUjy3rXpfUsjMgjDKQffp0kQZXHnJNUrpDi7
	gwibvIFtch5lyn14bx+9LevSanSGliMIBrARnYV0JMr4TCZv3Hije4C9bBorgb9XtGUfD9HYyD5
	P+2sA5d2sDbdv5tk6WIcDSVX6sHnymBzPqez/0V8Tv/NnSlgD7/H7LvQUDcUusfmkglldI=
X-Received: by 2002:a17:90b:224e:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3a0cbe2a16cmr6640422a91.63.1790592291593;
        Mon, 28 Sep 2026 03:44:51 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm27071975a91.12.2026.09.28.03.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:44:50 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 0/6] powerpc/mm: Enable clang context analysis
Date: Mon, 28 Sep 2026 16:14:30 +0530
Message-Id: <cover.1790590014.git.ritesh.list@gmail.com>
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

Lock acquire and release checking used to be done with Sparse. That support was
removed [1] and replaced with Clang context analysis [2].

Note that enabling this caught a real locking rcu bug in arch/powerpc/mm
(Patch-1). Note, more invasive checkers to check what each lock protects
is deferred for later enablement.

This is based on top of previous powerpc/powernv,pseries Clang context analysis
enablement series [3].

The series was build tested with LLVM/Clang 23.x

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")
[3]: https://lore.kernel.org/linuxppc-dev/cover.1790517984.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (6):
  powerpc/mm/book3s64: unlock RCU before returning from mm_iommu_is_devmem()
  powerpc/mm/book3s64: Rework tlbie() to remove conditional locking
  powerpc/mm/book3s64: Rework native_flush_hash_range() to remove conditional locking
  powerpc/mm/book3s64: Annotate the subpage-protection PTE lock
  powerpc/mm: Rework nohash TLB broadcast locking
  powerpc/mm: Enable context analysis

 arch/powerpc/mm/Makefile                |   2 +
 arch/powerpc/mm/book3s32/Makefile       |   2 +
 arch/powerpc/mm/book3s64/Makefile       |   2 +
 arch/powerpc/mm/book3s64/hash_native.c  | 122 +++++++++++++++---------
 arch/powerpc/mm/book3s64/iommu_api.c    |   6 +-
 arch/powerpc/mm/book3s64/subpage_prot.c |   2 +
 arch/powerpc/mm/nohash/Makefile         |   2 +
 arch/powerpc/mm/nohash/mmu_context.c    |   1 +
 arch/powerpc/mm/nohash/tlb.c            |   8 +-
 9 files changed, 98 insertions(+), 49 deletions(-)

--
2.39.5


