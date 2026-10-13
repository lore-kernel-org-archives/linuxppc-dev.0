Return-Path: <linuxppc-dev+bounces-29448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2008CC6B12
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:41:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48S94RWyz3c9Z;
	Wed, 14 Oct 2026 09:40:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931241;
	cv=none; b=YjFMVP017rknWyWJn8NKb9uDdxKyF8INyz4hDOSaLJBCVqCsnXlEpjh99CcldhIhwMfv5XcVJwiGSZkFZQtxPENhpClHHQ8IqSUWAGUAVrRtUGXxanMUPCSjqq4eziYIZwOlKCbB0M9zOUzbAc/aylszb+X+d8U6WJL3ysJYwPWYl5WkU+uqq2uFSgzazNAszOMDScOLuaJyt09hGqacrfQRM47+XsT7xKYhLZBhVcBvBnKppiVFpQPIsG6TtFexaLx1RKonGiGOv80DBedUu4wHubSQky+lF+qSxlkU1/ULwnHR8dAbfST6ndM8EKGXadjh2YbK33+1NNnnMFOwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931241; c=relaxed/relaxed;
	bh=KZW0TlkuVx1/ay444vuidlpbLOf1N6NgoBIEapd0snM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dMFTadumm41ExT9h2Z1kieWlpb+r/mTlFZQAm5EyJ4oyrge29deYAdF2Wevyoy695bRbR4ATrkMpXWQt7J/caf5w9REVFEyuWINnUl+vo8oMs/WSbf+0QB44HuVLDfY5i9SARtRNgisdJnFbUjsKR+M9E5H4p2gBbvVCK2hx67C2Sh99qtXwEIRKCcrFmPFatmeNYcW1LvA73ODZfSUmVWTvNvUGLOwLCTCc6ZpRShdYClB/s5GksSAdEMZslZAQlQ36aPUMYjcEKdpgiVG25i93O2leCQxak/VA91gECZo1hqm5p0ZpKnon+ZAnUOAVHq8MacU9bWCXTIWZJ/TKSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=seHQ6FNz; dkim-atps=neutral; spf=pass (client-ip=74.125.82.199; helo=mail-dy1-f199.google.com; envelope-from=3zbpoagckdgqktqigtuiqqing.eqonkpwzrre-fgxnkuvu.qbncdu.qti@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=seHQ6FNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=74.125.82.199; helo=mail-dy1-f199.google.com; envelope-from=3zbpoagckdgqktqigtuiqqing.eqonkpwzrre-fgxnkuvu.qbncdu.qti@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48S8301Fz3c8H
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:40 +1100 (AEDT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c5aef2a74so1455364eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931238; x=1792536038; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZW0TlkuVx1/ay444vuidlpbLOf1N6NgoBIEapd0snM=;
        b=seHQ6FNzz8i5Y1/Ylm+TcW21yorESuqI5xtd5yf/HsZqRD8fBanYAgCY04qjK26Xio
         wYsa4j3SpaNd7BwudCLg8U0zTDDeBWzzTCIi/QkAr2RHDnDpS9KsLnamYFtpH0v06n9H
         GQCqoHm51nj3wywW9ZF8AXSAIFAefobBbeqprgjJIvof65W8jDFF/RyL0Nio6KNVZnfW
         BBIZjqv6DhLjD3K3ocTZxoaMkhn3AQk+i5YxPgugJoie5rsU7SMItIs02GZ0FaOTJ5eN
         GAdOFRU/SrJ088voJzLSFKG8f8Jd6lclGHKy6sKmFtGS5aO6R/0SJmuumY5E+69+BmjF
         HHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931238; x=1792536038;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZW0TlkuVx1/ay444vuidlpbLOf1N6NgoBIEapd0snM=;
        b=qUgFklDM293WsmCxtfCoojYzQNli1iOtwf1Xp/2S8tYGGkE50l99tCKTy9DUXd/UqI
         OCYs4wMYK+yHQAnhXmXcG9HTyflcGntU1IWyrC8gDILVtk4kc8pkm2LHR2HgmC9yyXsX
         c8HDZoAFmY807oNiP2Jv2zn5OkLPH1V7hcvuiP0aZ8TNy95cGPqQ8u+hVqdA1AbRAJyq
         OM1CHX6JV+ws60EQTMkW+oEAt7cPXsLF61GXgdnSHU7LS8Ps3Y3rrRU8fvKuQkSuYLPK
         dYupjGAe5Dy+KylR6qVUPKaTi6agvG0Mrg9H6DkyrTTZE2b/jcBBDDcwjzZxPhHB0+zq
         i/NA==
X-Forwarded-Encrypted: i=1; AKwUvBwyEGaJdh34NlIEKmE4G4BVA8Q0pYIqt76E2gaR8JP9yguowOYe0fyA2qHBA7xdaRg//oFTuKnFI56p8ns=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ4iRM+XgDbgzVv5j4zvDWIcICnZNtlvZAgAYasIUT6HLo4ZCPM
	UAVHwJwynQxFX4SDCFYydK8CzMrsv5zPDR9zFwZrvCEnVsVith6FjI3eSl64h7lf2udmx6ft2KR
	ZnBNJaYDOzg==
X-Received: from dly17-n1.prod.google.com ([2002:a05:701b:2051:10b0:168:6cd7:1061])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b0d4:b0:141:4a06:ad6f
 with SMTP id a92af1059eb24-16a5dfd5d8cmr22211984c88.8.1791931237569; Tue, 13
 Oct 2026 15:40:37 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:46 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
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
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-12-irogers@google.com>
Subject: [PATCH 11/11] kobject: Require explicit initialization of struct kobj_type::release
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Documentation/core-api/kobject.rst states:

  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the code is
  flawed. Note that the kernel will warn you if you forget to provide a
  release() method. Do not try to get rid of this warning by providing an
  "empty" release function."

Annotate struct kobj_type::release with __require_explicit_initialization
so the compiler diagnoses any struct kobj_type initializer that omits
.release.

For the remaining legacy struct kobj_type definitions where the kobject
is static, per-CPU, or embedded inside a devm- or parent-managed
structure rather than freed by kobject_put(), explicitly initialize
.release = NULL with a comment documenting why no release callback is
provided.

Link: https://lpc.events/event/20/contributions/2392/
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/arm64/kernel/cpuinfo.c                          | 2 ++
 drivers/acpi/sysfs.c                                 | 2 ++
 drivers/dma/ioat/sysfs.c                             | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c              | 4 ++++
 drivers/infiniband/hw/hfi1/sysfs.c                   | 2 ++
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c         | 2 ++
 drivers/parisc/pdc_stable.c                          | 2 ++
 drivers/power/supply/ab8500_fg.c                     | 2 ++
 drivers/soc/hisilicon/kunpeng_hccs.c                 | 6 ++++++
 drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c | 2 ++
 drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c | 2 ++
 drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c | 2 ++
 fs/erofs/sysfs.c                                     | 4 ++++
 fs/f2fs/sysfs.c                                      | 6 ++++++
 fs/ocfs2/cluster/masklog.c                           | 2 ++
 include/linux/kobject.h                              | 2 +-
 16 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 45c63f3d75c5..ab78efdb13f5 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -309,6 +309,8 @@ const struct seq_operations cpuinfo_op = {
 
 
 static const struct kobj_type cpuregs_kobj_type = {
+	/* info->kobj is embedded in per-CPU cpu_data; cpuid_cpu_offline() only calls kobject_del(). */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index dd4a99f09efe..7534d3f305ba 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -972,6 +972,8 @@ static struct attribute *hotplug_profile_attrs[] = {
 ATTRIBUTE_GROUPS(hotplug_profile);
 
 static const struct kobj_type acpi_hotplug_profile_ktype = {
+	/* hotplug->kobj is embedded in static struct acpi_scan_hotplug objects. */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = hotplug_profile_groups,
 };
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index e796ddb5383f..7fdd0ca36b98 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -167,6 +167,8 @@ static const struct attribute *const ioat_attrs[] = {
 ATTRIBUTE_GROUPS(ioat);
 
 const struct kobj_type ioat_ktype = {
+	/* ioatdma_chan is allocated via devm_kzalloc() rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &ioat_sysfs_ops,
 	.default_groups = ioat_groups,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index b15af318784b..0477468f12ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -789,6 +789,8 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_ops = {
 };
 
 static const struct kobj_type xcp_cfg_res_sysfs_ktype = {
+	/* xcp_res is embedded in struct amdgpu_xcp_cfg rather than freed individually by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &xcp_cfg_res_sysfs_ops,
 	.default_groups = xcp_cfg_res_sysfs_groups,
 };
@@ -1053,6 +1055,8 @@ static const struct attribute_group amdgpu_xcp_attrs_group = {
 };
 
 static const struct kobj_type xcp_sysfs_ktype = {
+	/* xcp is embedded in struct amdgpu_xcp_mgr rather than freed individually by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 372cfd13dc61..33b26650069d 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -608,6 +608,8 @@ static const struct sysfs_ops sde_sysfs_ops = {
 };
 
 static struct kobj_type sde_ktype = {
+	/* sdma_engine is embedded in the dd->per_sdma array rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &sde_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index fdb63a8fb997..234d8d9532aa 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -245,6 +245,8 @@ static struct attribute *usnic_ib_qpn_default_attrs[] = {
 ATTRIBUTE_GROUPS(usnic_ib_qpn_default);
 
 static struct kobj_type usnic_ib_qpn_type = {
+	/* usnic_ib_qp_grp is embedded in RDMA core-managed struct usnic_ib_qp_grp. */
+	.release = NULL,
 	.sysfs_ops = &usnic_ib_qpn_sysfs_ops,
 	.default_groups = usnic_ib_qpn_default_groups,
 };
diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index 16f4496bca95..6d972c965c1e 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -484,6 +484,8 @@ ATTRIBUTE_GROUPS(paths_subsys);
 
 /* Specific kobject type for our PDC paths */
 static const struct kobj_type ktype_pdcspath = {
+	/* pdcspath_entry instances are static; lifetime is not controlled by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &pdcspath_attr_ops,
 	.default_groups = paths_subsys_groups,
 };
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index e6b5efdf5dc9..206ee2e392fb 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2531,6 +2531,8 @@ static struct attribute *ab8500_fg_attrs[] = {
 ATTRIBUTE_GROUPS(ab8500_fg);
 
 static const struct kobj_type ab8500_fg_ktype = {
+	/* fg_kobject is embedded in devm-allocated struct ab8500_fg; ab8500_fg_sysfs_exit() only calls kobject_del(). */
+	.release = NULL,
 	.sysfs_ops = &ab8500_fg_sysfs_ops,
 	.default_groups = ab8500_fg_groups,
 };
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 0cc2953d59a5..5d083d2b72ca 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1038,6 +1038,8 @@ static struct attribute *hccs_port_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_port_default);
 
 static const struct kobj_type hccs_port_type = {
+	/* hccs_port_info is allocated via devm_kcalloc() rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_port_default_groups,
 };
@@ -1110,6 +1112,8 @@ static struct attribute *hccs_die_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_die_default);
 
 static const struct kobj_type hccs_die_type = {
+	/* hccs_die_info is allocated via devm_kcalloc() rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_die_default_groups,
 };
@@ -1213,6 +1217,8 @@ static struct attribute *hccs_chip_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_chip_default);
 
 static const struct kobj_type hccs_chip_type = {
+	/* hccs_chip_info is allocated via devm_kcalloc() rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_chip_default_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index ae937854403b..3d787245f5b5 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -304,6 +304,8 @@ static const struct sysfs_ops display_sysfs_ops = {
 };
 
 static struct kobj_type display_ktype = {
+	/* dssdev->kobj is embedded in struct omap_dss_device and zeroed in display_uninit_sysfs(). */
+	.release = NULL,
 	.sysfs_ops = &display_sysfs_ops,
 	.default_groups = display_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index 1b644be5fe2e..cf816e83e903 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -496,6 +496,8 @@ static const struct sysfs_ops manager_sysfs_ops = {
 };
 
 static struct kobj_type manager_ktype = {
+	/* mgr->kobj is embedded in static managers[] and zeroed in dss_manager_kobj_uninit(). */
+	.release = NULL,
 	.sysfs_ops = &manager_sysfs_ops,
 	.default_groups = manager_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
index 1da4fb1c77b4..9aa16b3dee5e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
@@ -429,6 +429,8 @@ static const struct sysfs_ops overlay_sysfs_ops = {
 };
 
 static struct kobj_type overlay_ktype = {
+	/* ovl->kobj is embedded in static overlays[]; dss_overlay_kobj_uninit() only calls kobject_del(). */
+	.release = NULL,
 	.sysfs_ops = &overlay_sysfs_ops,
 	.default_groups = overlay_sysfs_groups,
 };
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dfcec9376cd5..588d541e1713 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -238,6 +238,8 @@ static const struct kobj_type erofs_sb_ktype = {
 static const struct kobj_type erofs_ktype = {
 	.default_groups = erofs_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/* erofs_root is a static struct kset; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kset erofs_root = {
@@ -247,6 +249,8 @@ static struct kset erofs_root = {
 static const struct kobj_type erofs_feat_ktype = {
 	.default_groups = erofs_feat_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/* erofs_feat is a static struct kobject; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kobject erofs_feat = {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 811e350a1430..a66cef927c62 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1653,6 +1653,8 @@ static const struct kobj_type f2fs_sb_ktype = {
 
 static const struct kobj_type f2fs_ktype = {
 	.sysfs_ops	= &f2fs_attr_ops,
+	/* f2fs_kset is a static struct kset; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kset f2fs_kset = {
@@ -1667,6 +1669,8 @@ static const struct sysfs_ops f2fs_feat_attr_ops = {
 static const struct kobj_type f2fs_feat_ktype = {
 	.default_groups = f2fs_feat_groups,
 	.sysfs_ops	= &f2fs_feat_attr_ops,
+	/* f2fs_feat is a static struct kobject; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_feat = {
@@ -1681,6 +1685,8 @@ static const struct sysfs_ops f2fs_tune_attr_ops = {
 static const struct kobj_type f2fs_tune_ktype = {
 	.default_groups = f2fs_tune_groups,
 	.sysfs_ops	= &f2fs_tune_attr_ops,
+	/* f2fs_tune is a static struct kobject; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_tune = {
diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 563881ddbf00..e476fa7ffea6 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -147,6 +147,8 @@ static const struct sysfs_ops mlog_attr_ops = {
 static struct kobj_type mlog_ktype = {
 	.default_groups = mlog_default_groups,
 	.sysfs_ops      = &mlog_attr_ops,
+	/* mlog_kset is a static struct kset; lifetime is not controlled by kobject_put(). */
+	.release        = NULL,
 };
 
 static struct kset mlog_kset = {
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 55e37a5d405e..e65331717e03 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -114,7 +114,7 @@ void kobject_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 
 struct kobj_type {
-	void (*release)(struct kobject *kobj);
+	void (*release)(struct kobject *kobj) __require_explicit_initialization;
 	const struct sysfs_ops *sysfs_ops;
 	const struct attribute_group **default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
-- 
2.56.0.385.gd3acb90ef8-goog


