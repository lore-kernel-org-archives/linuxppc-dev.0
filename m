Return-Path: <linuxppc-dev+bounces-25203-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15770C55171
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 15:52:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCkns1wkPz309L;
	Mon, 03 Aug 2026 01:52:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785685921;
	cv=none; b=noVnFjQMlguALfsmn+A0Il/2TMO27271m3dYlD95oKaYqU3P0AnBbGYYF11v9prbQlRsH01BKYV4yRFqBoMg3cPbzcshrbKuLERU2ZYyQYdwr6Le4P2d+ylFJb1HUQ62t0zLZncdG+BtoeL9gyvEjPbS25cQIJFMO19Wu9T6UTn3tVqd27ruPJn5Sq5eNW6xf7KUlPqVRwY/kImihBomaA8V81onA+Whyo5zLMKo5J2WPe+wTni258nh3JDAVgZfq73JxMboReHdgbmdSUgVn/QM0ztcapS+cg0uNJwN9LfzYk9sghgYPWBAer/hM8oFt4rWEUzYpLoTJK/PoIIsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785685921; c=relaxed/relaxed;
	bh=ogSPMMgz6C+Qlfaj2dVxDg2LBpmqLL6PNIePvSMxopc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EA9K3OjhdB7qPwJ9wME0hI1IIowMfqehUwAYqIOARIYzsf9ww2VpTEfwcz5YAVmYVAz+jqcLtKOoUNj+DNE78/6Iw2DOKMJ4UKZ2HCoJ81z+jO+4xILaesI4yclILcjwOm1jECtLfWRwUb8pY4xAqqRUNsRNRE3Iol4TcwHb+TntvvdlQq/fcYEi+Y3rLbw7U+jeIQGjbJ+RRhEzXQLzk8tb/qRKNzgok+08JZ3zNUREfy1zsdekde3wOKio2GyM0hPAkfRcqLl/EcPWbJPpZvDF7tS5SFxLV7f3v3RKnUecD4soSRROOX1DmuI5EQQCbpOKirt06RNHPW+1dktLGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l6hi3wN+; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l6hi3wN+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCknr2PY8z2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 01:52:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E4749405FA;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB265C19425;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685913;
	bh=D3ZdLkxeKQ+GTih21pSwwkDXOkOvUZicqpK0qWxiBCY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l6hi3wN+YBvMo85IRRDgokeengpqq9mDBexOg49poSywFuR+3bKEAZq4jQfoXwoGo
	 k7vGBvUyIWXBoHPXFZE2HQ4qfKjFkcn2NRVmkwbmihHJ/e5OPaMEtpJ5eoF+IMZ10J
	 s82WMSZMhJv5p8lkpX9f521T8t9h5awKNC/0aPwmAH2RVV2ky0tSNuMhQGJ8mVR9mn
	 D8E4Ry7zEru4vyTjG9ArestSxK5soR/YFbKm3NFDz4cpeLxJfFww/9WD95EufKrSHl
	 Ue0ABGVh+wk/Kg9GAnklJS/f9MsHoWqoE2waP1fAxD9kTLYxbAqAshfT/H0z3mQIzt
	 6ZBAjsaW5RcFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62C4C55171;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/6] powerpc/spufs: assorted fixes
Date: Sun, 02 Aug 2026 23:51:38 +0800
Message-Id: <20260802-fixes-v1-0-7368423440f4@outlook.com>
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
X-B4-Tracking: v=1; b=H4sIAIpnb2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMj3bTMitRi3TRjY2Mzw2TDJKPEVCWg2oKiVLAEUGl0bG0tABNQmaV
 XAAAA
X-Change-ID: 20260802-fixes-f33361c1b2ae
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Mackerras <paulus@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=D3ZdLkxeKQ+GTih21pSwwkDXOkOvUZicqpK0qWxiBCY=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz0aWk8f0qquGarOzbMrX/o+01iK+91zkc2ndpez
 HErJv65tLCjlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJiLEyfA/TGeRYOUegUNz
 fpgLbjgR/WxWfG6LgGWTS62dxFRPBbsMhv+5q+ydUxz/LE8/Znav8sDslIxt274FHZo19YvO6qX
 XhabyAADeT0oh
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

Six independent fixes for spufs. There is no dependency between them,
so they can be applied or dropped individually.

  1/6  spufs_coredump_extra_notes_write() never drops the reference taken
       by coredump_next_context(), so every SPE context written into a
       core dump leaks a spu_context. The matching ..._size() path gets
       this right.

  2/6  do_spu_run() copies out an uninitialized 'status' on the paths
       where spufs_run_spu() returns before assigning it, leaking four
       bytes of kernel stack to userspace.

  3/6  spu_process_callback() only aligns the NPC value, never bounds it,
       before using it as an offset into the local store. The register is
       userspace-controlled, so the following in_be32() can be driven far
       past the 256K mapping.

  4/6  spufs_setattr() calls setattr_copy() without setattr_prepare().
       notify_change() leaves that check to the filesystem, so mode and
       ownership of a context's files can be changed without the usual
       authorization.

  5/6  spufs_create_gang() calls unuse_gang() with the parent directory's
       i_rwsem held for write, and the resulting simple_recursive_removal()
       takes it again as I_MUTEX_CHILD. The task deadlocks against itself
       and leaves the spufs directory write-locked.

  6/6  The mailbox read/write handlers hold ctx->state_mutex across
       put_user()/get_user(), so a userfaultfd region or FUSE-backed user
       buffer can stall the context lock for an arbitrary time.

Patches 1-5 are tagged for stable. 6/6 is deliberately not: it changes the
atomicity of multi-element mailbox transfers rather than just adding a
check, so it seems better to let it soak in mainline first.

Build-tested only. I have no Cell or PS3 hardware, so none of this has
been exercised at runtime.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (6):
      powerpc/spufs: fix spu_context leak in coredump
      powerpc/spufs: don't leak kernel stack via spu_run
      powerpc/spufs: bound NPC against local store size
      powerpc/spufs: check permissions in spufs_setattr()
      powerpc/spufs: fix deadlock on gang creation failure
      powerpc/spufs: don't hold state_mutex during user access

 arch/powerpc/platforms/cell/spufs/coredump.c |  6 +++-
 arch/powerpc/platforms/cell/spufs/file.c     | 52 ++++++++++++++++------------
 arch/powerpc/platforms/cell/spufs/inode.c    | 21 +++++++----
 arch/powerpc/platforms/cell/spufs/run.c      |  2 ++
 arch/powerpc/platforms/cell/spufs/syscalls.c |  2 +-
 5 files changed, 52 insertions(+), 31 deletions(-)
---
base-commit: 02dc699f83d04069fdabc996fc22d47cda47a4a9
change-id: 20260802-fixes-f33361c1b2ae

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>



