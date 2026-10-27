Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B47606A333
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FfZF2yTs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDlm36ZKlz2y7r;
	Wed, 28 Oct 2026 09:39:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1245"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793140755;
	cv=none; b=etTBO2/d88dekGqyexRsXuaJZr01JSUfopy/cBOzhU8p9twKFPTjBV6aNltZ3KrbtIgahhDc3xCP67HWR4tPpL6iaI9m8DIvqf9VFZwsIfGtdw8eimRYvSJzz0DR2MIgI2daJcZbSW42J3qWQsGT3Ll+UsLE0LhPNT2fLU+FEUVlr/BtkfLc4oRDzeNkErihBApReM0ZOoBZLeGDlJBqXiO4KUnvY1YuiJNM5DzUVUcJaROJfiq99HNq/bkn8p59VzOxC9rQU5/m8QdeZODrBMxySM/cZ+2Q1BUNhlPYXJA5OcPB8B0Ku9pYfOJ1BdJzZl2RdnLXqnlBl31ZxWwgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793140755; c=relaxed/relaxed;
	bh=pEmx5PL3tlnBiGr2rjVOl0G+YHkBW7VB5cziBEiH9l0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LGBdbDNMIpOvtCEmIR6/XK1ZPW4CqeTueVHi2Clmd0hLh8wGHIdIRr4LA6rktXyT9/uiTDU0aloOAnCqA9tW0lSz4YwIp2N+fGUHR469Tbv5yQ4Siiccy4kUhTgQM/5NzEBywrBUdqLIOwSk3gc1w4HoDixC55GCAhy3r4H/cQv8CMfcysrjHAzXQZNXNNPKK6EOv00963JXmr92+0n/NcytF0X3O4EYuMCwBS0wz7QWTLQTp8E8JRlCJ4+HTtXHRc4uN4Tz2C6phm+H8MIq+gruqtb9oY7+NAQOegRQeSkB20Wsjk9QqVKbh1h3pU9Y9xG1DI25Ms68hpYdFhZ6Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FfZF2yTs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1245; helo=mail-dl1-x1245.google.com; envelope-from=3dcjhagckdd8jsphfsthpphmf.dpnmjovyqqd-efwmjtut.p0mbct.psh@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FfZF2yTs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1245; helo=mail-dl1-x1245.google.com; envelope-from=3dcjhagckdd8jsphfsthpphmf.dpnmjovyqqd-efwmjtut.p0mbct.psh@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1245.google.com (mail-dl1-x1245.google.com [IPv6:2607:f8b0:4864:20::1245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDlm05wvKz2xSZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:39:11 +1100 (AEDT)
Received: by mail-dl1-x1245.google.com with SMTP id a92af1059eb24-1a2f2ea3c3cso596002c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140749; x=1793745549; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pEmx5PL3tlnBiGr2rjVOl0G+YHkBW7VB5cziBEiH9l0=;
        b=FfZF2yTsb24RpgXkOS8U6HOCUfHeH6u2knWQYSXv2zVqM4MIbv3ksgSyjmaGyoxxPB
         Ub1vY30e2zj/NlXEuAUHhBlBjNFhhhrmBqbylTWAXc0ulJvhpRFy5+DV5bsaaHUXD9W9
         NnBIz2Ehk6YuW6f6ZDt1RKf6AwAue8xCedey+J8JKYp+WD2crvIuyREQ/s8uP6PLCPTb
         QGXisVKN/EBEhAkCejmoN05eMCyRu/BHrTMncJnNelh4pWmbvUjYtc9rrSblaO7g/0H/
         id6WseGh/27x97XVEa/dQeX9Q87owQDMDtmyaxP6+rHbFa4ZG2Ru3EOs4SXQaOKwj1sY
         rFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140749; x=1793745549;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEmx5PL3tlnBiGr2rjVOl0G+YHkBW7VB5cziBEiH9l0=;
        b=X+EtHxoB6EoXaDIG6nLUiXOv8okKzlaVJqzyLQPseOAtLTGz04s8isi/UPh7TuV2R4
         2DgVFHS+fXO8JcEuCWlTtwOFYTQyHgTkaY6gHFekqxI2JF4qbpJuACzrtq7euLCR1HJ+
         lZo/W0f/XhdsFHsqeVQLOGEIKg7m823cn1dwW4u3VpoAcpzhazEugJb0oVChswXnUecl
         MtyedUx6MMlgkyy4ebqADWYggVyxrA/zMN6hAraDgOa0F+ut8OID4oxn9vPYxVzhF8u3
         aEtMOgKR8xzmn4IxhpT1p1oYpqDhCWzBbg6cyu7ossyAiBzgM99x31kNzRj6kolTaGXq
         rtSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIeUNKFtxD075teKpt2fXGBNee8ci/OrMikP2fhJGVQLNHTBIwNWEFAyhTsexokp9LSC8L8O19o0F9mKg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKxyswZLjgXG09jneUEoS75tFLM9qDJOYiplz7XZFNqmIRIDM3A
	EUlnG37kDzytna8rerML0xlr9Jh/7NMHdW4A0JU5uNES83FT9/SzzBSL4cPHAGytd1gaZPTSs2d
	ujGl5V+hhUw==
X-Received: from dli9.prod.google.com ([2002:a05:7022:289:b0:1a1:da78:f9b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6989:b0:165:90af:a25f
 with SMTP id a92af1059eb24-1a6cfa0c447mr941563c88.41.1793140748444; Tue, 27
 Oct 2026 15:39:08 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:35 -0700
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
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-1-irogers@google.com>
Subject: [PATCH v2 0/9] Add __must_init and require explicit kobj_type::release
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang supports the 'require_explicit_initialization' attribute on struct
fields to enforce that the field is explicitly initialized when an
aggregate object is constructed, emitting -Wuninitialized-explicit-init
(enabled by default) if the field is omitted.

Following discussion at the Linux Plumbers Conference [1], patch 1 adds
the attribute to include/linux/compiler_attributes.h as __must_init. In
v1 it was called __require_explicit_initialization. Kees picked up that
patch with a first seq_file user [2], and in that thread Greg suggested
the shorter __must_init spelling, which Kees and Miguel agreed to. As
the attribute did not land in the v7.4 merge window, Kees asked that
this series carry the renamed attribute. The Acked-by/Reviewed-by tags
on patch 1 were given for the original spelling; the rename is
mechanical.

As Documentation/core-api/kobject.rst notes:
  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the
  code is flawed."

Annotating struct kobj_type::release caught struct kobj_type definitions
across the tree that omitted .release:
- Patches 2-8 fix struct kobj_type definitions where dynamically
  allocated kobjects, ksets, or enclosing structures were either leaked
  on kobject_put(), freed prematurely before kobject release, or missing
  proper static initializers.
- Patch 9 annotates struct kobj_type::release with __must_init and
  explicitly sets .release = NULL (with explanatory comments prefixed
  with "Pre-existing:") on the remaining legacy struct kobj_type
  definitions whose kobjects are static, per-CPU, permanent firmware
  structures, or embedded in devm- or parent-managed structures.

Note on tool use: An LLM coding assistant was used to help audit the
compiler diagnostics across the tree, draft the fixes and changelog
descriptions, and verify builds and review feedback.

Changes in v2:
- Rebased on v7.3-16928-g83f32c773255 (v7.4 merge window).
- Patch 1: Rename __require_explicit_initialization to __must_init per
  Greg Kroah-Hartman; document the Clang >= 20 requirement per Miguel
  Ojeda; note the Clang gap for file-scope objects without an
  initializer reported by Kees Cook; add tags from v1 and from Kees's
  posting.
- Move LLM assistance attribution from Assisted-by tags to this cover
  letter per commit 1e035297ffda ("docs: remove Assisted-by
  references").
- Patch 4 (cpufreq): Use "cpufreq: governor:" prefix, drop Fixes tag,
  fix typo, and remove the redundant runtime assignment in
  cpufreq_dbs_governor_init() per Zhongqiu Han.
- Dropped v1 patch 5 (ACPI: CPPC), already fixed upstream by
  commit 27954e29d7de ("ACPI: CPPC: Release CPC descriptors through
  kobject").
- Patch 5 (dlm): Call kobject_del() before dlm_recoverd_stop() in
  release_lockspace() and the new_lockspace() error path, and wait on a
  new ls_kobj_done completion before freeing the lockspace or dropping
  the module reference, avoiding races with delayed kobject release.
- Dropped v1 patch 8 (s390/sclp_mem) per Sumanth Korikkar: the
  /sys/firmware/memory/memoryX kobjects are permanent, so sclp_mem.c is
  folded into patch 9 with .release = NULL.
- Patch 7 (ubifs): Add Tested-by and Reviewed-by from Zhihao Cheng.
- Patch 8 (drm/amdkfd): Check q->kobj.state_in_sysfs before
  kobject_del() in kfd_procfs_del_queue().
- Patch 9 (kobject): Cover sclp_mem.c and the new amdgpu_ualink.c
  ualink_xcp_info_ktype, fix the overlay-sysfs.c comment, and prefix
  legacy .release = NULL comments with "Pre-existing:".
- Patch 9 (kobject): The ioat, kunpeng_hccs and omapfb display comments
  now say that the existing teardown can use-after-free under
  CONFIG_DEBUG_KOBJECT_RELEASE (reported by Sashiko). Fixing those
  drivers is left to follow-up patches.

v1: https://lore.kernel.org/all/20261013223946.1836757-1-irogers@google.com/
[1] https://lpc.events/event/20/contributions/2392/
[2] https://lore.kernel.org/lkml/20261014225811.i.852-kees@kernel.org/

Ian Rogers (9):
  Compiler Attributes: Add __must_init macro
  powerpc/secvar: Add missing kobject release callback to secvar_ktype
  sh: sq: Add missing kobject release callback to ktype_percpu_entry
  cpufreq: governor: Initialize kobj_type release callback statically
  dlm: Free dlm_ls in kobject release callback
  xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
  ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
  drm/amdkfd: Free queue in procfs_queue_type kobject release callback
  kobject: Require explicit initialization of struct kobj_type::release

 Documentation/conf.py                         |  1 +
 arch/arm64/kernel/cpuinfo.c                   |  5 ++++
 arch/powerpc/kernel/secvar-sysfs.c            |  6 +++++
 arch/sh/kernel/cpu/sh4/sq.c                   |  6 +++++
 drivers/acpi/sysfs.c                          |  2 ++
 drivers/cpufreq/cpufreq_conservative.c        |  5 +++-
 drivers/cpufreq/cpufreq_governor.c            |  4 +--
 drivers/cpufreq/cpufreq_governor.h            |  1 +
 drivers/cpufreq/cpufreq_ondemand.c            |  5 +++-
 drivers/dma/ioat/sysfs.c                      |  7 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       | 10 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 12 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  5 +++-
 drivers/infiniband/hw/hfi1/sysfs.c            |  5 ++++
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |  2 ++
 drivers/parisc/pdc_stable.c                   |  5 ++++
 drivers/power/supply/ab8500_fg.c              |  5 ++++
 drivers/s390/char/sclp_mem.c                  |  2 ++
 drivers/soc/hisilicon/kunpeng_hccs.c          | 21 +++++++++++++++
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  7 +++++
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  5 ++++
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  5 ++++
 drivers/xen/sys-hypervisor.c                  |  6 +++++
 fs/dlm/dlm_internal.h                         |  1 +
 fs/dlm/lockspace.c                            | 26 ++++++++++++++-----
 fs/erofs/sysfs.c                              | 10 +++++++
 fs/f2fs/sysfs.c                               | 15 +++++++++++
 fs/ocfs2/cluster/masklog.c                    |  5 ++++
 fs/ubifs/sysfs.c                              | 24 +++++------------
 include/linux/compiler_attributes.h           | 12 +++++++++
 include/linux/kobject.h                       |  2 +-
 scripts/checkpatch.pl                         |  1 +
 tools/lib/python/kdoc/xforms_lists.py         |  1 +
 34 files changed, 202 insertions(+), 32 deletions(-)


base-commit: 83f32c773255720a661aa45d83e36278135f23f5
-- 
2.56.0.313.g2479322e68-goog


