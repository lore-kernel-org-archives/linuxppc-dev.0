Return-Path: <linuxppc-dev+bounces-24757-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE85C531CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 02:30:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5sQf5p8Lz2yh4;
	Fri, 24 Jul 2026 12:30:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.67.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784860202;
	cv=none; b=I8HzzQFaO4oxLOFghiGUsQRYDWvy1q7iiMxYFRWmQ/Nx+/66k4UfMlGYLQPgiHD/VSKwXeXkpI9FxLi7bIZDQF9SpW+i+HDQK9PPloEcfCU5qujdQOLVNMbRMgCx+zcktGKER5qENkEVE+PycLWeEm5ozFOmF7wYgP9ROcP2DFxZrpaBh5bxFEdUdB/iEPY1rzSJf7bW9HhzFhziVvCOwd7pVsnF2kV2g/2+n56808ZcnL1CYNnLIFKnN/06/hiNebA+UIdBl3LpmRviZUme69ymydbyVLY+Uk0rV5GDpt4fqVNn9/Vqtl4cZFhWFFmMwVFnVIgAiiwUMgqlzXmquA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784860202; c=relaxed/relaxed;
	bh=COw6l4tZGKI2EtZCsRNwhO9S4qZRY68UndjXev8R1FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HRaZKCTWSnemspoUyU+rvrth92FONVe8kRzL74nDv+tCWqWrlCxlZY3CDKp6zII3pFn7f++vY38kPnxjTjv7Ihq7+UgMfQ57+0UH9C2fBTUKPoNeshhRvNoLm0AgMuWMLeztOM8Qsu5fIK1kW4a8p/uF1rO4YQBd2Rflr+uXQK4t8l06qpVASpXVJqGXgiI1pKVejgxf+lu/HcuNv1z/AjVanBBV62DKsGJfRLyzh8DLqolLfiGYw7bWe4k0Na1kzXawG8ZITE5Pv2ArSeH2QwHRCnVvjjVU5+WlBrQ2Le9Xy8tSycPZxL55eJ/ceidYPsdpZBxg1BBSP0eDvDmqMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=a8ZgaGCX; dkim-atps=neutral; spf=pass (client-ip=114.132.67.179; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=a8ZgaGCX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=114.132.67.179; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5sQd04xTz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:29:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784860143;
	bh=COw6l4tZGKI2EtZCsRNwhO9S4qZRY68UndjXev8R1FQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=a8ZgaGCX7IP5ahgjzhrcLvGxA79o86aLmAaixDvnoatm0iH/CuHlIahNxBq7/llHi
	 p5l/nAesT3f/p3Pxei/j2qxdXQ+6eS3qwAi6Sn84gZn1tHNwHbqUK2aY7qpPgr9n3h
	 KSgV/tcfu9fPTyhIygu0udE1a21kpVGJhe6Q0pF4=
X-QQ-mid: zesmtpip4t1784860135t56239e5a
X-QQ-Originating-IP: uxNb/JIeTaYaqS/plW1kaXfiKOf+TwmtfXaiPsha900=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 10:28:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5628155496822218120
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	bharat@chelsio.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	akpm@linux-foundation.org,
	gouhao@uniontech.com,
	namcao@linutronix.de,
	ynorov@nvidia.com,
	sshegde@linux.ibm.com,
	nilay@linux.ibm.com,
	clg@kaod.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-mm@kvack.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH v2 0/6] remove dead NULL checks after GFP_NOFAIL allocations and fix xive use-after-free
Date: Fri, 24 Jul 2026 10:28:45 +0800
Message-Id: <20260724022851.466017-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: NkIlkbzvNbmq+cKfi/KPSk/jPEwqsDvwwTO3JJ+qAg96W5gFrIaKDGbx
	UYTorCu2QUbbK7cIiWDTtQncxhHka/MC/c+9AnQacYzJmjMZtLVW1eP1FPI85Fj0RVpLq5M
	/Q+u2+rfxxz40qagDsmTrJ7bCsHsWLrdCiDL+d5h5pK2tFg37b6E1mxE+kernL+T/GCNNcM
	1NCAfhy5911m9MYxLOxfwJoomOWZaM91tdoDZaeuxTyOncV9j+3YJ+Qtwrgl98jdO1dvZMG
	GXYtGkoFFyEMx1TKZgGhpB/iOW8hZnpyAqRwrVAjd04PslJ/MT0Ds21UfID6VPpTs3V0SmL
	JyM/vNQ5GxP4I/RdE42eE2xVFzWDGEbpu/LiFFPOtedf3afDH/IUQRuCoqveeF0Aji/nDoR
	8rGCXmEBVWZIu4xwcVe0b5kIB2oXg8nGktm0kNuCxwVXo/BbQO4fJVuMb9aXI6aLFan0K1r
	4oj3ptF7Ho3GwXpKK0L8fyWE6muZmGAzBqq+1iJr0i0X2nwCiFrKz80XKDLyzqkOpfjyRBL
	hoV5Rcqpy0rJbJR4icjgaXO1703lrDrIl7MYma/8fLCebiAUm7zw9gVxWouEN7i64iJnApg
	mXqv4/sE2jxNoqQf9dzNdjMGJhWo69LYIUrxPzkRPDGJpff5Ps6BYRGaRMD7/Sbxjy+oi+L
	ZtBlAEI6e/Of7RSpbeqwjHDybXtk30/E8pW+SINymM0ZYuV27cTovnA5S39BuU6Q4EDNJVf
	TCZwI+/m4YYGNddZcQUDz5MaL8ZAmw6fdJ0m2TY0aHORzsNGUOhzExlpm4P8EadRKmkwZNf
	hlGNTugYmlN7E7c/gUiyojiUM2EhYr1uy5lrXiYyFXvoYgJh60YGdOhucJOFW4HE7OVXBc4
	8xDr2JnUEZVX3XdDe9VCItL9w2qY3omUkZPnn5t85FZZjEBiAnn4M1UUQLiCjviRgSGa5xl
	9dy/zjgOTtjasXcPO/ePWfH8poJbIQIrlegXLaSjhZudBiW7nxE3x7FfcIX74kbgvhm1QZZ
	qY0yrOI+tP1KrsPfVStHzmX71BQuOrZDc7OvNNcw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Changes in v2:
- Remove the now-unused out_free_domain error label in the xive
  patch after deleting the unreachable NULL check goto.
- Fix a use-after-free of xive_ipis: when xive_init_ipis() fails,
  the error path frees xive_ipis but xive_smp_probe() ignores the
  error and proceeds to dereference it in xive_setup_cpu_ipi().
  Propagate the error return through xive_smp_probe() and check
  it in both pnv_smp_probe() and pSeries_smp_probe().

This is a code cleanup series that removes unreachable
NULL checks (and associated error handling) that follow allocations
using __GFP_NOFAIL, which guarantees non-NULL return.

Gou Hao (6):
  powerpc/xive: remove dead NULL check after GFP_NOFAIL allocation
  powerpc/xive: add error return value to xive_smp_probe()
  powerpc/xive: fix use-after-free of xive_ipis
  drm: remove dead WARN_ON NULL check after GFP_NOFAIL allocation
  lib/test_hmm: remove dead NULL checks after GFP_NOFAIL allocations
  RDMA/cxgb4: remove dead NULL checks after GFP_NOFAIL allocations

 arch/powerpc/include/asm/xive.h      |  4 ++--
 arch/powerpc/platforms/powernv/smp.c |  8 +++++---
 arch/powerpc/platforms/pseries/smp.c |  8 +++++---
 arch/powerpc/sysdev/xive/common.c    | 15 +++++++++------
 drivers/gpu/drm/drm_modeset_lock.c   |  4 ----
 drivers/infiniband/hw/cxgb4/mem.c    | 10 ++--------
 lib/test_hmm.c                       |  6 ------
 7 files changed, 23 insertions(+), 32 deletions(-)

-- 
2.20.1


