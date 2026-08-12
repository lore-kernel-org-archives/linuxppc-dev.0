Return-Path: <linuxppc-dev+bounces-25758-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC85C5B56A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 05:48:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKcwm4Kp6z3bvf;
	Wed, 12 Aug 2026 15:48:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786513704;
	cv=none; b=Kx1f0z5hvnCHHo9jONm4DZ+JEU6/AVIag/LfTbCji02LQQyt5n9HhIyJ7yzjIK2v1HKoWr2idBsHGmdkq8NeKwxxiTuLeCXsyeP3QlIAGmVSKPxcVloAKSn+zZdFcuEjCJwHHCtcZv6G4O+UfHuglrDaBrQ9zpsqPvz9TZWT2HaUtgFWS/Nl0krzjLlUKxs6TTZWVy1RjLGrATh7IhsJw2YZxFRIF3YYG+z+ai1fVBffg9zOpyYdDUAE+t8q7LHi+gZ50Zj0z8ZtCBWFU8VlK8Uvwqkxe89t0tTSK1X/p3R4W6x/A8Q8dMS5BfnUZy+fE61Ye5H27t4Cbvas8wZDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786513704; c=relaxed/relaxed;
	bh=/bgmyo/bKsTEQh6NAcRdCSKe8JJe453h4nOor5LcdEA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NXFIyWYHJrNlOIqr4ck4x1+QYPNIr5CVt0cVhvMdnXAUChcNeR0Z6VICPDSFMwGBd8AZvcGhZ8Vnsss4pW62eBj5gRbc+WzQ8uBEC5TiczW0H8+fWr9mZ68qTWU/llAmE4ZW5qPPTeN89U4VCy4mkJKvIwIXi6O4KHsD0cfj/BoDBQZQ45jIVAD04aGc0dghKrBvDD2VUbAl+eq8ZYCSVlp3f+Ig0kyf9N1Mk/kKpweu4g8UOUGcROJuEwaxU8ItLlRu6ud9QIOoCJ2GJ4lfspOBHqT6+RnQB/HCTLx0QLpimriNenYate2im+vqs7r6jQAwjzOBaQNYzOk59GyBQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=otpnH+Z2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=otpnH+Z2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKcwk2HDrz3bsR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 15:48:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C632B4356F;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EA43C2BCB9;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786513696;
	bh=0Zo7Rbv+zcD+9wkog421wT1HYw9FSZDE+BW1aRtXh1o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=otpnH+Z2B4gaP84TTqLX83SaFosEn7R/2P1CEjDwioA9LCYEEb8kRkPkYYF9ZVezK
	 6AGbsPtkQ/r275HWOwXiOa1WaNZ2l/dPMQ/92YbANBuHLlcJkooaEDKK7O4XGsUu+9
	 Tg4yge8rCIKi3Ib8/3He7kY/CazH0rzYDtz3fICrXHSNMEbbB2/pmscqk9ezVqOD+C
	 EWF/NzxNkiSQQu9lXhs2v6AV+xDCsF4YmZL0tfOV2fnXjcBJJ2gNP11knWyrrKFG6l
	 G2fTu0a4dq7g9CTxfPUFj0CNilw1zV4ubTWLmVQyePlFVya0rIYsvPMXYs4C6IYJuI
	 AF12IQhpULc0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F7C5B56A;
	Wed, 12 Aug 2026 05:48:16 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/5] powerpc/spufs: fix a leak, an OOB read and three
 context lifetime/locking bugs
Date: Wed, 12 Aug 2026 13:48:06 +0800
Message-Id: <20260812-spufs-fixes-v1-0-449e201d9f64@outlook.com>
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
X-B4-Tracking: v=1; b=H4sIABYJfGoC/x3LTQqAIBBA4avErBP8AbOuEi3ExpqNiUMRiHdPW
 n48XgXGQsiwDBUKPsR0pQ41DhBOnw4UtHeDltpKp7TgfEcWkV5kEfyEyjhrlJuhH7ngH/qwbq1
 944gqs10AAAA=
X-Change-ID: 20260812-spufs-fixes-ca7e13863189
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Paul Mackerras <paulus@ozlabs.org>, 
 Luke Browning <lukebr@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=0Zo7Rbv+zcD+9wkog421wT1HYw9FSZDE+BW1aRtXh1o=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBpOWdkFERvEYwJmvRSO3btAjG3R6dgMLstH69ZwK
 qs0fG/R/9ZRysIgxsUgK6bIcrzg0jcL3y26W3y2JMPMYWUCGcLAxSkAEzkpyMjw06uz4DDPme39
 V1dKnnuo3ux4/pNRl0zvpdR/FrlLNlXPYWTY80/ekcMqdvE0VQ4ZgUbDGanupqeu/dtasY3nmnm
 e4H8OAAfuRww=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

This series fixes five independent bugs in spufs.

The first two are simple and directly reachable by an unprivileged user:

 - Patch 1 frees the struct spufs_fs_context allocated by
   ->init_fs_context(). Nothing ever released it, so every spufs
   fs_context leaks it, and fsopen() reaches ->init_fs_context() before
   sget_fc() rejects the mount for the lack of FS_USERNS_MOUNT.

 - Patch 2 removes a double sizeof(u32) scaling in
   spufs_wbox_info_read(). The value handed to
   simple_read_from_buffer() as the length of available data reaches 64
   for a 16-byte on-stack buffer, so a read past offset 16 copies up to
   48 bytes of adjacent kernel stack to userspace. The mailbox
   occupancy that gates this is set by writing the context's own wbox
   file, and wbox_info is mode 0444.

The remaining three are concurrency bugs in the context scheduler and
the fault path - one object lifetime race, and two around
ctx->state_mutex:

 - Patch 3 takes a reference on contexts returned by
   grab_runnable_context(). The runqueue holds no reference of its own,
   and once the context is unlinked the owner's spu_del_from_rq()
   becomes a no-op, so it can close and free the context while the
   scheduler still holds the pointer - a use-after-free window spanning
   a full context save. The BUG_ON(!list_empty(&ctx->rq)) in
   destroy_spu_context() cannot catch it, because list_del_init() has
   already emptied ctx->rq.

 - Patch 4 retests ctx->state after spu_deactivate() in
   spu_acquire_saved(). __spu_deactivate() drops state_mutex
   internally, so the earlier test is stale on return; a second reader
   can consume the single SPU_SCHED_WAS_ACTIVE bit and rebind the
   context, leaving the first acquirer reading a save image the SPU is
   still writing and then hitting the BUG_ON() in spu_release_saved()
   with state_mutex held.

 - Patch 5 releases state_mutex before re-taking mmap_lock in
   spufs_ps_fault(). Every other spufs fault path takes the two locks
   in the opposite order, and three threads sharing an mm can close the
   cycle; because spusched_tick() takes the same state_mutex, one
   wedged context also stalls SPU scheduling for the whole node.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (5):
      powerpc/spufs: fix memory leak of spufs_fs_context in spufs_free_fc()
      powerpc/spufs: fix out-of-bounds read in spufs_wbox_info_read()
      powerpc/spufs: take a reference on contexts pulled off the runqueue
      powerpc/spufs: fix context state race in spu_acquire_saved()
      powerpc/spufs: fix mmap_lock/state_mutex lock inversion

 arch/powerpc/platforms/cell/spufs/context.c | 4 ++--
 arch/powerpc/platforms/cell/spufs/file.c    | 6 ++++--
 arch/powerpc/platforms/cell/spufs/inode.c   | 1 +
 arch/powerpc/platforms/cell/spufs/sched.c   | 9 ++++++++-
 4 files changed, 15 insertions(+), 5 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260812-spufs-fixes-ca7e13863189

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>



