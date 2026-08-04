Return-Path: <linuxppc-dev+bounces-25342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5658C55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:51:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDnM666SCz2ygL;
	Tue, 04 Aug 2026 18:50:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785833458;
	cv=none; b=SynieKpLcC3S6hOn+FDrW2qzWYN74snGQMsA/PcCXGWSSdWnbDNOJqvImtZ7eUK5vQKrtDoa4M72RY0gQUjVgJ0CgcQIrCRGoh+SZ4vPt7QLcjzWlu2ywZGbwDmoNx2hkCxsX2hGExH2mXiUYuKV+mlh1HPywvV/8zn6jTqtwcQFmQ+wKdb7GpP4NboqJdqOUG/EKF0q+TcM3x87dLk8X3iKh/lgA5sXEFbwVHuw2uwsWZlhybO0lHjsIz9ABosHvNlJ6QHTCXMY/6nl/ivgl/740RPXKqeyIEqrJMBEhNtGGB/1sIRYyiJjs/2ae2z/bygVYMy2lwki1YmxBbbutA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785833458; c=relaxed/relaxed;
	bh=RrMCYawXL6KCjbDwRFZg6C1NRPO4sM4DSoJn7AKTi/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DJOm4ukR1B1CeQrWtiTc58LbsI1t5J5NZEW302sMNYN0OpSiu+qCUmKkXYHOY+ZY8rmesUlH9PKKcOOmTbx8zJA8GcPWEgQkwluFZR/SQsawhiI0TYOsJDZKQ/hwm5pDaWJ12PTsylBvO6C4MOTRTdLhVLuqOcTtlW8dSFKIKY9qdu0rhPO/GiKP8qdEPTpX4KMFoZ5NWZHkK6HbPcZb8fcHEBX5rpgJQacGol8+H+xR1Wi7eZB/pO6lQGTw7Tj15JGwHp/6xUhCN4cE726Tx9xE8m1f43Pjdan80FpxbdZ5P7E6hU2skDYEvNgRxmr2sAOIGtcGHNooDUuqA5wNNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OLcXzo1i; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OLcXzo1i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDnM55DyFz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 18:50:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E995343EF1;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73784C2BCF4;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=QCVnxSeHlT4Kk1BbHgcw8WESABILpZ1Gcclv0+B9Efw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OLcXzo1idtKnk8lzZal02RNT+eUz4MI3Ioe0BNjTFy4iox0ffrj4MlEQvK+PMG8XQ
	 sXACspI43lIxCEEUDQSOzfNHubxUxpbAZ/pumHdLnJ7OQxvPmt5k1gut8Lv3TKmJx3
	 d5J2JmQfRGqY9H8t5S6mJVTgMimG/hrrQUIENHpdQXhhWszpm8EFwagOMN+28yTRLh
	 P+z3veI4f4GGe75wZnrGXfZ/tFzeO71tSlQpnw7GPdJZzcs/vuv9208b+DlJZ/GOyc
	 w6dWnHR8Qb8Vt3cEUwM5Dd1ep29vzqviEXJgLd2EP6HQuLWzfebjrkTv+5a9H9Qc65
	 i3yJ/r/sWz4KA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDA9C55184;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH v2 0/5] powerpc/spufs: assorted fixes
Date: Tue, 04 Aug 2026 16:50:37 +0800
Message-Id: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
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
X-B4-Tracking: v=1; b=H4sIAN2ncWoC/12MQQ7CIBBFr9LMWgwMBBtX3sN0UXGwE7XTQG00D
 XcXu3T5/n95K2RKTBmOzQqJFs4sYwXcNRCGfryR4mtlQI1etxpV5DdlFa213gRzwZ6gulOi7aj
 quas8cJ4lfbbsYn7rf2ExSquD9a1D65yO7iSv+SFy3wd5QldK+QKRXSXYnAAAAA==
X-Change-ID: 20260802-fixes-f33361c1b2ae
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@ozlabs.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2656;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=QCVnxSeHlT4Kk1BbHgcw8WESABILpZ1Gcclv0+B9Efw=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlry/5/e87ufmR/BnWtfHpHIHrQyawX+Nw/ekRF
 PCw42+Jt0tHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATEQoieF/lJoy52nuRazf
 itafO39H+rGWU6HqsR8PvjXzbolcde3db4Y/HOoCK16bHTHdpGSwISJGZsOK8hPsiUGXzzs/4ry
 wT/cYPwBdQU1U
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

Five independent fixes for spufs. There is no dependency between them,
so they can be applied or dropped individually.

  1/5  spufs_coredump_extra_notes_write() never drops the reference taken
       by coredump_next_context(), so every SPE context written into a
       core dump leaks a spu_context. The matching ..._size() path gets
       this right.

  2/5  do_spu_run() copies out an uninitialized 'status' on the paths
       where spufs_run_spu() returns before assigning it, leaking four
       bytes of kernel stack to userspace.

  3/5  spufs_setattr() calls setattr_copy() without setattr_prepare().
       notify_change() leaves that check to the filesystem, so mode and
       ownership of a context's files can be changed without the usual
       authorization.

  4/5  spufs_create_gang() calls unuse_gang() with the parent directory's
       i_rwsem held for write, and the resulting simple_recursive_removal()
       takes it again as I_MUTEX_CHILD. The task deadlocks against itself
       and leaves the spufs directory write-locked.

  5/5  The mailbox read/write handlers hold ctx->state_mutex across
       put_user()/get_user(), so a userfaultfd region or FUSE-backed user
       buffer can stall the context lock for an arbitrary time.

Patches 1-4 are tagged for stable. 5/5 is deliberately not: it changes the
atomicity of multi-element mailbox transfers rather than just adding a
check, so it seems better to let it soak in mainline first.

Build-tested only. I have no Cell or PS3 hardware, so none of this has
been exercised at runtime.

---
Changes in v2:
- Add an Assisted-by: trailer to each patch identifying the tooling, as
  requested by Arnd.
- Drop 3/6 from v1 (bound NPC against local store size).
- Link to v1: https://lore.kernel.org/r/20260802-fixes-v1-0-7368423440f4@outlook.com

---
Junrui Luo (5):
      powerpc/spufs: fix spu_context leak in coredump
      powerpc/spufs: don't leak kernel stack via spu_run
      powerpc/spufs: check permissions in spufs_setattr()
      powerpc/spufs: fix deadlock on gang creation failure
      powerpc/spufs: don't hold state_mutex during user access

 arch/powerpc/platforms/cell/spufs/coredump.c |  6 +++-
 arch/powerpc/platforms/cell/spufs/file.c     | 52 ++++++++++++++++------------
 arch/powerpc/platforms/cell/spufs/inode.c    | 21 +++++++----
 arch/powerpc/platforms/cell/spufs/syscalls.c |  2 +-
 4 files changed, 50 insertions(+), 31 deletions(-)
---
base-commit: 02dc699f83d04069fdabc996fc22d47cda47a4a9
change-id: 20260802-fixes-f33361c1b2ae

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>



