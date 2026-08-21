Return-Path: <linuxppc-dev+bounces-26033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED48C5DF89
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 11:52:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRJZf3MQ5z2yDs;
	Fri, 21 Aug 2026 21:52:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787313146;
	cv=none; b=NP/d6TC7LnNFm6GD0cGcHLofs8KgFzzj2z1SzPRosL6Wt5N2yMx5IIbmVSyKVAjXprCY7uNtz8sTtonM1NC3gNHNDZDBJacALHkEgLnRV2j6Es+CrOj36TcthdWAI1i8wUjjaO0WawsId7b2LcCl6moVi8e5sN5suonDSezFInz2dQJ7VopepxDshgJCEc/+GLWw+9uepORVikJ4DnGRXzb76QR1s0yjh6FRK/09WNILIE/ex06nOVnZcumUTWg2KcFUEs4om6oCArdKT4RVdicgcYwbnFZ4tYJT3S1hojrvhLvkHIMEBoGARLxU2tUNXYhBiKEbtZyufdL1Pshj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787313146; c=relaxed/relaxed;
	bh=rb7T7qQ245v3lAPAAQlownuvidcAdgxgItOpVQHp7Vc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XUcIceR0QKqlzY69sd3dwmocoPX49p/Ge19uAk1KPIAoAPmyNkl3tkADLd3/EzPu9z7RDE30UIuVyb0IBa63ZIHOSuZJtOwd7zuD7PLdcWVxCc3nORQvaSCxg32BIdhJiJvA9JJn6+yjhex8crvasEsRhgBE1x1WXOvqH9VTr2mwbbHyWCaWZm+ULu2EPDikhjJDPy09mGUP92q7MSkoD8tB5VB153yRPn0jF36iZmOV/o2Pzc9Zv/URw61CQQSvxC91msifYWtxUY5tLBZIqkPdFihh4+4lfurdGvJqQ7bYJKEwsmFQ5V89z4iFjq59S9+trInI+IHGC8zvKJHNKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N87+Z5et; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N87+Z5et;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRJZd2JKFz2xtt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 21:52:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A1DA43540;
	Fri, 21 Aug 2026 11:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8F41F000E9;
	Fri, 21 Aug 2026 11:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787313143;
	bh=rb7T7qQ245v3lAPAAQlownuvidcAdgxgItOpVQHp7Vc=;
	h=From:Subject:Date:To:Cc;
	b=N87+Z5et1fyU2ko/O1Cr71bw/e1K0Y7lpQCiWriodjuayeS/brKGIl1542vcGrf2Z
	 xge0SPDDp1GQRsiBorLLtEdwFaStNffwCFw2LumAYgWUg5Mzoczk1KqWRChl/WM4Ri
	 F7nT2FMjO4ukNidMdBUFSBpPogxm9NUCgtRcL7reZ1ilzpx6ku00PTiLZPQBUK90pD
	 HitWCGTO62xHJaJFosV+UPcOk+Zr8uOAI77jkhDKJxuoBcRm5IDqSVDdPfDuaocAH7
	 IIRuv87wFvfGEvqQP1CyLnVpNDExhYjEorWyBu+krI0/kRMa/VepjtBKni1PpZUBU0
	 3hh+8ZYVXFSgg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/6] coredump: select memory types per request
Date: Fri, 21 Aug 2026 13:52:01 +0200
Message-Id: <20260821-work-coredump-filter-v1-0-91f9a73ef03e@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNwQ6CMBBEf4Xs2UXaEKL+ivFQ2i2sYku2oCaEf
 5dKPL7JzLwFEglTgkuxgNCLE8ewgToUYHsTOkJ2G4OudFOdtMJ3lAfaKOTm54ieh4kElT/7qnb
 katXANh2FPH9+t9fbzmlu72Sn/JUbrUmErZhg+xxF4Y4DmmE4ZkH5F5S7oMx1WNcvIfRFQK8AA
 AA=
X-Change-ID: 20260821-work-coredump-filter-1f9f04ded416
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2728; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CHr7/siqtsybsuSIZJlmc8HwuFWlZjKE7BJt0/blPig=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR1WH/84HubVVHmBJtE9xLerU7/XEQL7/bYs6czXBFxW
 aq6+FJ/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ+HGH477Pw8fqop+wVjlsn
 bN7mr/gu5QRj2sXG7JbMFf8OfxM7GsvwP27l7X3GebocW1vniZotDclou3m9Y+Xs6tXn3hSstfn
 4jA0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently /proc/<pid>/coredump_filter determines what types of memory
are included in a coredump produced by <pid>. This is fairly static. The
coredump server has no easy way to configure what memory to dump even
though it can figure out all the necessary details to make an informed
decision.

Add a new COREDUMP_MEMORY_TYPES feature bit. If the coredump server
raises it the kernel will dump memory types raised in the
coredump_ack->memory_types member. Zero is valid and causes the creation
of a coredump that just includes the program headers and notes but no
memory apart from the mappings that are always dumped.

struct coredump_req gains @memory_types which is set to the default
memory types that are included in the coredump. This can be overridden by
raising bits in coredump_ack->memory_types. It also gains
@memory_types_mask which contains a bitmask of all memory types the
kernel knows about. A coredump server may only raise bits in
coredump_ack->memory_types that are raised in
coredump_req->memory_types_mask.

struct coredump_ack grows too. If COREDUMP_MEMORY_TYPES is raised in
@mask the kernel dumps the memory types set in the @memory_types mask.
Zero is valid and dumps no memory apart from the mappings that are
always dumped. A coredump server wanting to add or drop memory types
instead of outright replacing it should simply copy
coredump_req->memory_types and then mask off or raise types as needed.

@memory_types must be zero if COREDUMP_MEMORY_TYPES isn't raised.
COREDUMP_MEMORY_TYPES requires COREDUMP_KERNEL and an ack of at least
COREDUMP_ACK_SIZE_VER1 bytes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (6):
      coredump: select memory types to include
      tools: sync coredump.h header
      selftests/coredump: simplify the refusal tests
      selftests/coredump: test COREDUMP_MEMORY_TYPES
      selftests/coredump: improve coredump size negotiation tests
      selftests/coredump: test failed handshakes

 Documentation/filesystems/proc.rst                 |    4 +
 fs/coredump.c                                      |  114 +-
 include/linux/coredump.h                           |    4 +-
 include/uapi/linux/coredump.h                      |   70 +-
 tools/include/uapi/linux/coredump.h                |   70 +-
 .../coredump/coredump_socket_protocol_test.c       | 1224 ++++++++++++--------
 .../selftests/coredump/coredump_test_helpers.c     |  279 ++++-
 .../selftests/coredump/coredump_test_helpers.h     |   26 +
 8 files changed, 1274 insertions(+), 517 deletions(-)
---
base-commit: 19f075830e5d874749f55d837fc4e8af98df0559
change-id: 20260821-work-coredump-filter-1f9f04ded416


