Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB433606A334
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skU5Ojtm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTRpq369dz2xnZ;
	Wed, 18 Nov 2026 01:25:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794925539;
	cv=none; b=Sb0z5v2m9L9WDDaZQCIqLfXk3JaMZIO7VfseU7+O9Zhr47yA34two9Kq0LLEJd3+2JSFS6hudkRr68eQhOJGBXhLYD/oR86WUgkwZ0Us6Qw80yyAygYX4GLobw/l/SnWowPSHqwG8mxsMZCDelcylbByzBPA3YZioKT+h8LvkBC6BSMi4yy5qvQvETQnDTofl3GkyZ4HAMmg3UYgRoEavQ99ntsNIeeGaTh1BmUwjoTeEvnMdWsDcDOS8T7mkrod/1bQa1kKHwcQTBywtPqayj3i9rRNBMnD0liMkOz/Xq5yy5ziO6NrUMQeyc2H9eKzusD7mPJAtFoiz0hgAZk3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794925539; c=relaxed/relaxed;
	bh=VuZddKkmAmaYgOMBa+Lzz2VPLUuC+ZWxc4bgcJWjLWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U6ReVnSkDY/e8b1wgrs8Ke8LvmxXUK8jCq+gcymzfwVRfF9fSSU8ADRUFJhhKw0CFp/dtvHg0xNh2NUcgdyuR6NbVhEY5eaYEy+bJ2MOj9POarFd/9usayko6zPcjPL2ViyzdAyxTEQ5mmDPiZq0AaakFEn6q9jzMFG79r6j1TyiMalXrva4BOa3hPEt8HeJC5Fi/nkj5Xy27YSjDJufh7kzhgAwK1ijApr4qASiCSuKHsCi//eTec86D6VuScAPzz60PzTlWJ4S1oyPnNmMuVnRWoi3gMLCnzXgTuEdItzEuFk7GNyK9bsJcZDUJscHWoZbB/iAfB8KIBr8TiERDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skU5Ojtm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skU5Ojtm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRpp196Fz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:25:36 +1100 (AEDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-71ab5e64742so3616814eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925534; x=1795530334; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VuZddKkmAmaYgOMBa+Lzz2VPLUuC+ZWxc4bgcJWjLWw=;
        b=skU5OjtmiXzTiv27CjD1GP7ZktzvoRQZKPcXoA8RU2pEerRWipej5TfdSrbsy3ey4R
         Hx2adzqWnT9PpxP5lBIhK5RKIWxQm1+xYz7seeNOoSeM6gPR99JlqpKW5W7NJxDBndxu
         3DrJdG4BUzcJzby90mv9mLHXhbsNqxKNEoulqUIlTffePCfPGEHI55Vad0OvdtOS3iOw
         2MY+YfnM/sRKQTj9fHra+1Xvyw74tVPCmK48WoOcLGvfIrg2/4N8/P3yPfuicz5rd4sE
         8K+hlK+h8GtvbKmwoOuEhhZ6o0OPoqcspz+ZKcnTEyf8kGkgxpDHSGR5AWeZ7STsewMJ
         DQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925534; x=1795530334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VuZddKkmAmaYgOMBa+Lzz2VPLUuC+ZWxc4bgcJWjLWw=;
        b=A3H0t51AVd1aWMrnShp3WyAu1BvcF1JOvdk1nVpJsvZl7hB40Sf5kL3ubw5rtkokD4
         ryLy9ZOJ4Zc0lmrJttWo5a7YnIiivRayMsUyzxYPd+4Uu8wl+92xxjGt4yyI71C8l8qx
         u4LxG6jBx5PGjHUoGM/sNoBpIUwv6DoXCNcb9+7xii3NaH1MtnbALEguZzLYk+hdG7Gd
         V0GlMDQ2t+nUzhfU9Is2JsTN+SMsrIU5t29P6B7o0/vz2LPjcpv5sGLLXNBgwsfXpM8E
         wViipAwMHnMwhquCGcqo/PvWZxsYBc0qOsI79RVI+Qcu7lSXmYUqpuYbmtymsE4NdK67
         IjNA==
X-Gm-Message-State: APuU4Z8ctB3uckvi9fVz12hdg6stxhP1zjpCrxrBChSHBGNlw3XANAZY
	JwnrXMK4t5tXvv3YR7GMA6FmE8HdHMDqd0tLhMV2/ZxSrblKopzVij1rONZI8CwO
X-Gm-Gg: AYBFou1RiHcuMi+agAfUfZmwD2fmIcM2nWOYiTrj1F/g1Xskh0MfdNE0pPz7mtWq6MM
	DlwKLpWp1mJluRmORCZkMfED2d/SxOKH2wuDZ379DVdJAyrzxTEC8F8DwAGGYRFfbHJWLnK3iv8
	+s7C13IQzrtvz0zMA/wArz+iw8xTZtQEhF10vR4Shq45E6OAxH6LEe5uJo0QTlu6NEmUrOi2qEM
	9pBZsAjIGyN4KQvXcaeWohwzKxNgViH6K2ylyQhCkWreMgF0co4Hc/c8m2rCQTpG4jsQewm7XdA
	txRQ3u5hIMFUX3VCMTN8Tl/Zhy88Q+sQsXExXB0E+x0Am3JiBR9CPDmTmy37dkVwIx5om1ITyFb
	Yask6U4u/mBmPt6eFrfoXqh+PcykW6YB6Fk6ONwGOxWx/GWVKZIq79kUJtS1QkCdK1lJkwZRjGO
	2MIBDuaC6ugikpDMmRjQbQvOGdUF5C0oidQ8FFz0sgXlUQv5FcenCqX+q3Hq1Q010CU4coF9F05
	iofsvzUjvJZIeXcmwOeGlk7hOo6hK91XgdJ12bm/UZHdXPVMuI1d8zkgKe16bD7b1y2jJqT4kjS
	C1vgGW3vKzW2sdAC0hIyJl8TMork27qMig==
X-Received: by 2002:a05:6820:8914:20b0:700:da68:739a with SMTP id 006d021491bc7-71ab5032398mr6453455eaf.47.1794925532060;
        Tue, 17 Nov 2026 06:25:32 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71af0a8a18csm5313709eaf.4.2026.11.17.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:25:31 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 0/4]: powerpc: Misc fixes for debug kernel splats
Date: Tue, 17 Nov 2026 19:55:16 +0530
Message-Id: <cover.1794924821.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enabling debug options like PROVE_LOCKING, DEBUG_PREEMPT and
DEBUG_ATOMIC_SLEEP on powerpc64 showed these warnings.

Main motivation for me to look into this was - many folks internally reported
that after generic entry/exit feature, they aren't able to use lockdep because
of the warning splat it generates during boot, after which lockdep gets
disabled.

Therefore this series is an attempt to fix the warnings which are generated
- when we enable these various debug config options.

v1 -> v2:
========
1. Patch-4 fixes a pre-exiting issue pointed out by Sashiko.
2. Patch-2 and patch-3 from previous revision is re-arranged.
3. Patch-2 change smp_processor_id() to raw_smp_processor_id() since preemption
   is already off - (From Shrikanth)

(Sorry about a quick v2 re-spin. The main reason for this was, a new patch-4
which Sashiko pointed out as a pre-existing issue).

Ritesh Harjani (IBM) (4):
  powerpc/64: Leave lockdep hardirq context around replayed interrupts
  powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
  powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
  powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails

 arch/powerpc/kernel/irq_64.c   | 11 +++---
 arch/powerpc/kernel/watchdog.c |  8 +++-
 arch/powerpc/perf/kvm-hv-pmu.c | 69 ++++++++++++++++------------------
 3 files changed, 44 insertions(+), 44 deletions(-)

--
2.39.5


