Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9A606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kcFT6gJz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDlmW5NBtz2yYK;
	Wed, 28 Oct 2026 09:39:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1345"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793140779;
	cv=none; b=igUHaosDED03ntu9Ajnus9pSzTMcAouTfDTqKMrhjF1Z6AGhqJLcupSb8l5CkGlc0ItQIkw1QacbiyDnlyrigFr0fMr7qh43Ks4Lq7DRFePdKeTqEQ57QV1W2GMsdle2Es8SNsNy8f6YFUr9VO03hzgd560Ud8te0AtAJs9YCwxK3EuWqIAizZgDNKmpCiUfd0WazJcxK61WKcWdqqfCPR2NVhxiJT5tPJuIrCRYgSU9DXPk+IuBhWM/79FfiNjtIMzW0UrtLzZuqwS1oKb8qHzu+pu8+kpGCUzRXx5Ykv7Z6IjH6OTtx4MXMbJi8Nag5vgM7ou0VRe1TM8JGMI24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793140779; c=relaxed/relaxed;
	bh=36a0/HoL8yXBAoRB1lx62HZinWx8I5wnTQwOiZ4VBGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=biWRsVWQ+D8lyR2DU13h51n0PUFLE507kFzEMC41B4xVw/7wb+1MM1BfyyP+NqiPwBC9MMQYQLx84oNFmheDrmFKzNdCIwMeujCZjpntRZamwmJRIa8B8XrxcuGZLDd5A72J9hwRLyioAumHuHAuBA+VnvVxdPbmw9YfEPqhFTfQXRn9dPsNG9Z/d2Rjj3m8vsbNIKBOn3idZm5jpSzQ1xQxg9ZuesfFEJQzvS1gHMQ7GaVuErE8HMTmh9wQvBbxMbTkgT5XogO7sEe7AdBoDSLRWBZvgEVD1t3CPMx5QbtKgqKwOpXoSXYvQSUuVrtWAa6RXqZ1jL1WW/SlH9c+8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kcFT6gJz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1345; helo=mail-dy1-x1345.google.com; envelope-from=3jyjhagckdfoajg86jk8gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kcFT6gJz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1345; helo=mail-dy1-x1345.google.com; envelope-from=3jyjhagckdfoajg86jk8gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1345.google.com (mail-dy1-x1345.google.com [IPv6:2607:f8b0:4864:20::1345])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDlmV42Mfz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:39:38 +1100 (AEDT)
Received: by mail-dy1-x1345.google.com with SMTP id 5a478bee46e88-359b81ad4e8so403113eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140776; x=1793745576; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36a0/HoL8yXBAoRB1lx62HZinWx8I5wnTQwOiZ4VBGs=;
        b=kcFT6gJzfD8JN4mk8q5LeEHtIYMnz75Mw802ZUfU/1shv7bZs7XE+q8Zyj5+TlfyMv
         gVfWSe7yGfC6+7X+3jbfI9K9JPqxSJlrlu5pPG20JL7zX/8FJ33/79XpR93hmgKL0kFl
         mNwSYtjHj3WBGQ59KS/8u+WHdTROu0zwPI4Yqm83vN16AwYWX+FMt/xUIfNuV96qfq3j
         KtI1kCDmu4mG0Y7IY1pJfCyb4qZYGj8wjy4V7MA3U+nIwc9mXGIIJ+rKhKE/wPWcRGbl
         LFW5XmrEpMpn4DXDyJHUy9Dq0FW0Rw9HGRgK0+i1ArFiqKQTVpYJhr8icfmEH46y7Una
         3NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140776; x=1793745576;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=36a0/HoL8yXBAoRB1lx62HZinWx8I5wnTQwOiZ4VBGs=;
        b=1H+/W9f6zpaq3jGYBFF920WIL/eQgyDUhTjgquSX4e9HAmszfsKsHaGdSB2twvDUlF
         yOSKYMy5PvT7LBU928X2WxF9BaAttn3CLKIgulAoaL1MXd3HOxtPzf4pFdJyMPsXU2et
         RbE0baWFtE9nWX/vLDViUeZ0oixCPKf0lrlSIU5m1rmYyqfupYZEo8j4K41hwZFmPvpw
         Wg7Y2uSM1MzxYEdTLvV4MGu77j0z6IRnJCgJvBbmsGlJ5t8wBQvqbTalj+AOWbUXea3b
         oMXNOTFnvhQYiCD0uEZQEpsDcoAQfiTVfOIB3BlVnQhP9Kemen/9v7IJRF1wqr6I8tlL
         0NLg==
X-Forwarded-Encrypted: i=1; AKwUvBySWOhdphaDN9oGsLgs98Nuh9sjX7o0kfWNHn2clX1Xvv6j20nEejixCYpQClxF0rqV37WG/st1X6mFNZ0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJm8Y9cO6OJsFGN0l3jdFJMnz5E3AXlw1MLJ98pCbshGyy7BRsP
	5G4bGZx4aZ/DcKAFXH9yhvGKehEPfTTFTFwVU//eAbw0IbKw7mlaSBKD0CkwvXUQTL147yusMxQ
	E6JBwcKgHoA==
X-Received: from dycna22.prod.google.com ([2002:a05:7300:ea96:b0:369:de3f:acf9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d101:b0:369:5583:bf4c
 with SMTP id 5a478bee46e88-36a200c8c63mr1046676eec.28.1793140775931; Tue, 27
 Oct 2026 15:39:35 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:44 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
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
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-10-irogers@google.com>
Subject: [PATCH v2 9/9] kobject: Require explicit initialization of struct kobj_type::release
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
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Len Brown <lenb@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Nelson Escobar <neescoba@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Linus Walleij <linusw@kernel.org>, Sebastian Reichel <sre@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Huisong Li <lihuisong@huawei.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jingbo Xu <jefflexu@163.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <hongbohbli@tencent.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Heming Zhao <heming.zhao@suse.com>, Johan Hovold <johan@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Documentation/core-api/kobject.rst states:

  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the code
  is flawed. Note that the kernel will warn you if you forget to provide
  a release() method. Do not try to get rid of this warning by providing
  an \"empty\" release function."

Annotate struct kobj_type::release with __must_init
so the compiler diagnoses any struct kobj_type initializer that omits
.release.

For the remaining legacy struct kobj_type definitions where the kobject
is static, per-CPU, permanent firmware structures, or embedded inside a
devm- or parent-managed structure rather than freed by kobject_put(),
explicitly initialize .release = NULL with a comment documenting why no
release callback is provided.

Where the existing teardown is not safe with CONFIG_DEBUG_KOBJECT_RELEASE,
because the kobject's memory can be freed or cleared while the delayed
kobject cleanup is still pending (ioat, kunpeng_hccs and omapfb display),
the comment says so. Fixing those is left to follow-up patches; this
change does not alter their behavior.

Link: https://lpc.events/event/20/contributions/2392/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/arm64/kernel/cpuinfo.c                   |  5 +++++
 drivers/acpi/sysfs.c                          |  2 ++
 drivers/dma/ioat/sysfs.c                      |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       | 10 +++++++++
 drivers/infiniband/hw/hfi1/sysfs.c            |  5 +++++
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |  2 ++
 drivers/parisc/pdc_stable.c                   |  5 +++++
 drivers/power/supply/ab8500_fg.c              |  5 +++++
 drivers/s390/char/sclp_mem.c                  |  2 ++
 drivers/soc/hisilicon/kunpeng_hccs.c          | 21 +++++++++++++++++++
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  7 +++++++
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  5 +++++
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  5 +++++
 fs/erofs/sysfs.c                              | 10 +++++++++
 fs/f2fs/sysfs.c                               | 15 +++++++++++++
 fs/ocfs2/cluster/masklog.c                    |  5 +++++
 include/linux/kobject.h                       |  2 +-
 18 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 94e6cd211d70..7a4ac8dd0b86 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -295,6 +295,11 @@ const struct seq_operations cpuinfo_op = {
 
 
 static const struct kobj_type cpuregs_kobj_type = {
+	/*
+	 * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
+	 * cpuid_cpu_offline() only calls kobject_del().
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a99373547126..1948b80e8a4a 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -973,6 +973,8 @@ static struct attribute *hotplug_profile_attrs[] = {
 ATTRIBUTE_GROUPS(hotplug_profile);
 
 static const struct kobj_type acpi_hotplug_profile_ktype = {
+	/* Pre-existing: hotplug->kobj is embedded in static struct acpi_scan_hotplug objects. */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = hotplug_profile_groups,
 };
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index e796ddb5383f..5ba44876eb96 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -167,6 +167,13 @@ static const struct attribute *const ioat_attrs[] = {
 ATTRIBUTE_GROUPS(ioat);
 
 const struct kobj_type ioat_ktype = {
+	/*
+	 * Pre-existing: ioatdma_chan is freed by release_ioatdma(), not
+	 * by kobject_put(). With CONFIG_DEBUG_KOBJECT_RELEASE the delayed
+	 * kobject cleanup queued by ioat_kobject_del() may run after
+	 * that kfree(), a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &ioat_sysfs_ops,
 	.default_groups = ioat_groups,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 17888cf54447..c2cccd924b03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -885,6 +885,11 @@ static const struct attribute_group ualink_xcp_info_group = {
 };
 
 static const struct kobj_type ualink_xcp_info_ktype = {
+	/*
+	 * Pre-existing: xcp->ualink.kobj is embedded in struct amdgpu_xcp_mgr
+	 * rather than freed individually by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index ab14079d1c42..0847134a1391 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_ops = {
 };
 
 static const struct kobj_type xcp_cfg_res_sysfs_ktype = {
+	/*
+	 * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
+	 * rather than freed individually by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &xcp_cfg_res_sysfs_ops,
 	.default_groups = xcp_cfg_res_sysfs_groups,
 };
@@ -1061,6 +1066,11 @@ static const struct attribute_group amdgpu_xcp_attrs_group = {
 };
 
 static const struct kobj_type xcp_sysfs_ktype = {
+	/*
+	 * Pre-existing: xcp is embedded in struct amdgpu_xcp_mgr
+	 * rather than freed individually by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 372cfd13dc61..5a1aca06b542 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -608,6 +608,11 @@ static const struct sysfs_ops sde_sysfs_ops = {
 };
 
 static struct kobj_type sde_ktype = {
+	/*
+	 * Pre-existing: sdma_engine is embedded in dd->per_sdma array
+	 * rather than freed by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &sde_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index fdb63a8fb997..df0e48070c2e 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -245,6 +245,8 @@ static struct attribute *usnic_ib_qpn_default_attrs[] = {
 ATTRIBUTE_GROUPS(usnic_ib_qpn_default);
 
 static struct kobj_type usnic_ib_qpn_type = {
+	/* Pre-existing: usnic_ib_qp_grp is embedded in RDMA core-managed struct usnic_ib_qp_grp. */
+	.release = NULL,
 	.sysfs_ops = &usnic_ib_qpn_sysfs_ops,
 	.default_groups = usnic_ib_qpn_default_groups,
 };
diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index 6b567a74fc2c..2f530e8c6757 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -484,6 +484,11 @@ ATTRIBUTE_GROUPS(paths_subsys);
 
 /* Specific kobject type for our PDC paths */
 static const struct kobj_type ktype_pdcspath = {
+	/*
+	 * Pre-existing: pdcspath_entry instances are static; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &pdcspath_attr_ops,
 	.default_groups = paths_subsys_groups,
 };
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index e6b5efdf5dc9..d62411e4f535 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2531,6 +2531,11 @@ static struct attribute *ab8500_fg_attrs[] = {
 ATTRIBUTE_GROUPS(ab8500_fg);
 
 static const struct kobj_type ab8500_fg_ktype = {
+	/*
+	 * Pre-existing: fg_kobject is embedded in devm-allocated struct
+	 * ab8500_fg; ab8500_fg_sysfs_exit() only calls kobject_del().
+	 */
+	.release = NULL,
 	.sysfs_ops = &ab8500_fg_sysfs_ops,
 	.default_groups = ab8500_fg_groups,
 };
diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 6df1926d4c62..2fb7271dce36 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -305,6 +305,8 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
 }
 
 static const struct kobj_type ktype = {
+	/* Pre-existing: permanent firmware kobjects, never freed */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 0cc2953d59a5..da7a64c95058 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1038,6 +1038,13 @@ static struct attribute *hccs_port_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_port_default);
 
 static const struct kobj_type hccs_port_type = {
+	/*
+	 * Pre-existing: hccs_port_info is allocated via devm_kzalloc()
+	 * rather than freed by kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after devm frees it on unbind, a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_port_default_groups,
 };
@@ -1110,6 +1117,13 @@ static struct attribute *hccs_die_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_die_default);
 
 static const struct kobj_type hccs_die_type = {
+	/*
+	 * Pre-existing: hccs_die_info is allocated via devm_kzalloc()
+	 * rather than freed by kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after devm frees it on unbind, a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_die_default_groups,
 };
@@ -1213,6 +1227,13 @@ static struct attribute *hccs_chip_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_chip_default);
 
 static const struct kobj_type hccs_chip_type = {
+	/*
+	 * Pre-existing: hccs_chip_info is allocated via devm_kzalloc()
+	 * rather than freed by kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after devm frees it on unbind, a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_chip_default_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index ae937854403b..452920a4e2a9 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -304,6 +304,13 @@ static const struct sysfs_ops display_sysfs_ops = {
 };
 
 static struct kobj_type display_ktype = {
+	/*
+	 * Pre-existing: dssdev->kobj is embedded in struct omap_dss_device
+	 * and zeroed in display_uninit_sysfs() right after kobject_put().
+	 * With CONFIG_DEBUG_KOBJECT_RELEASE that memset() clobbers the
+	 * pending delayed kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &display_sysfs_ops,
 	.default_groups = display_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index 1b644be5fe2e..40ec750f4315 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -496,6 +496,11 @@ static const struct sysfs_ops manager_sysfs_ops = {
 };
 
 static struct kobj_type manager_ktype = {
+	/*
+	 * Pre-existing: mgr->kobj is embedded in static managers[] and
+	 * zeroed in dss_manager_kobj_uninit().
+	 */
+	.release = NULL,
 	.sysfs_ops = &manager_sysfs_ops,
 	.default_groups = manager_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
index 1da4fb1c77b4..4d333031b18d 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
@@ -429,6 +429,11 @@ static const struct sysfs_ops overlay_sysfs_ops = {
 };
 
 static struct kobj_type overlay_ktype = {
+	/*
+	 * Pre-existing: ovl->kobj is embedded in static overlays[];
+	 * dss_overlay_kobj_uninit() drops the kobject ref.
+	 */
+	.release = NULL,
 	.sysfs_ops = &overlay_sysfs_ops,
 	.default_groups = overlay_sysfs_groups,
 };
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dfcec9376cd5..2ea6773cd98f 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -238,6 +238,11 @@ static const struct kobj_type erofs_sb_ktype = {
 static const struct kobj_type erofs_ktype = {
 	.default_groups = erofs_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/*
+	 * Pre-existing: erofs_root is a static struct kset; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kset erofs_root = {
@@ -247,6 +252,11 @@ static struct kset erofs_root = {
 static const struct kobj_type erofs_feat_ktype = {
 	.default_groups = erofs_feat_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/*
+	 * Pre-existing: erofs_feat is a static struct kobject; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kobject erofs_feat = {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 430356e500af..6e15695cb75f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1683,6 +1683,11 @@ static const struct kobj_type f2fs_sb_ktype = {
 
 static const struct kobj_type f2fs_ktype = {
 	.sysfs_ops	= &f2fs_attr_ops,
+	/*
+	 * Pre-existing: f2fs_kset is a static struct kset; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kset f2fs_kset = {
@@ -1697,6 +1702,11 @@ static const struct sysfs_ops f2fs_feat_attr_ops = {
 static const struct kobj_type f2fs_feat_ktype = {
 	.default_groups = f2fs_feat_groups,
 	.sysfs_ops	= &f2fs_feat_attr_ops,
+	/*
+	 * Pre-existing: f2fs_feat is a static struct kobject; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_feat = {
@@ -1711,6 +1721,11 @@ static const struct sysfs_ops f2fs_tune_attr_ops = {
 static const struct kobj_type f2fs_tune_ktype = {
 	.default_groups = f2fs_tune_groups,
 	.sysfs_ops	= &f2fs_tune_attr_ops,
+	/*
+	 * Pre-existing: f2fs_tune is a static struct kobject; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_tune = {
diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 563881ddbf00..ff8a1cf51e72 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -147,6 +147,11 @@ static const struct sysfs_ops mlog_attr_ops = {
 static struct kobj_type mlog_ktype = {
 	.default_groups = mlog_default_groups,
 	.sysfs_ops      = &mlog_attr_ops,
+	/*
+	 * Pre-existing: mlog_kset is a static struct kset; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release        = NULL,
 };
 
 static struct kset mlog_kset = {
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 55e37a5d405e..8a1332030884 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -114,7 +114,7 @@ void kobject_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 
 struct kobj_type {
-	void (*release)(struct kobject *kobj);
+	void (*release)(struct kobject *kobj) __must_init;
 	const struct sysfs_ops *sysfs_ops;
 	const struct attribute_group **default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
-- 
2.56.0.313.g2479322e68-goog


