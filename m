Return-Path: <linuxppc-dev+bounces-24257-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B74C44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 16:58:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h058r45qvz2yXj;
	Wed, 15 Jul 2026 02:58:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784048284;
	cv=none; b=KnZcr+WcR14P72GSV+mXoXTjkpss3v077SioK/kZa62apd1CqSL4y83N46aHdUklh6ccE3HvV1KFHh3clJuQxLJTtNPr4OUzKsI40psaxHO4y4gnbSnxOfJnQsfMTD1v4r46W/Rjht9CaYtP0KgFfg1JvJyprFZ3HsU7wzzFuoGsIcKbCu5P2IdqXdUF4axeDc2BlXOum8G30QqOU7/CwxRVbE1NQjkMdBJMN7nvt52aGr3sAlWv3uOCZPn1g6mWiPBR5Dg4eRquEINFOwt3AXXIV5DmZ9W4ECS3k+OHt+BvOIiSrM/NbHVezvgvzdcVOELBUkf8aB6YdFZPml9M1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784048284; c=relaxed/relaxed;
	bh=X8B92NSgcTkdtLIgkn5KYMnVlI4ZOR0kx94kw92peH4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DXV4vPnDQhncXNUVfdGOZCShdY+iaV4HdUcnBPnP5Dt2Z09Oz2nd9BhGIIBRbfQR3PQo1NIdFjfHSH9BbA48Mu89zyGc5vtEtr14WOXIEIFE/JmNSOKNM+kacg/LkYGbiMs8DoBWDV4TnHLWlnOp/oSo6di3H1NTnpV5iIxkNUYHV9IvBkZ+8yP2N8OhlBgXAYIx34UUhNo55Fbta//3eIK7VVCutjA1IKlw8xJtZBpBxMR0UXKm9Yf+Fn2w+rxG/0DebpLfS9SGOiEtTx7SNEjH6w0wlAm7W4YACdVnOpTONRY49Y7CvyCI98ErJ5Ef7O3IVb0go5+LjwXH9GASPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=fve7O5Vd; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=fve7O5Vd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h058m6X2Xz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 02:58:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784047914;
	bh=P8axtzlc26y5kWyEb7PWfrNrtHlna+IHi2EA6Xja4RU=;
	h=From:Subject:Date:To:Cc:From;
	b=fve7O5Vdo0KIs1MfkqxpEQn3B8brETbVkR2GMWxcSRtjnyMrrllrNZSFcVUyAKGfJ
	 +0MemZuGN2XsszgcG33WTOnzCWVhGwc0tsW7lp4iTH9ZjJH6ylUCl6axlnl64eOBgG
	 QHUVxyn/CcyexZdNguLoj0JIfv89MVc7IhxCP7b0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] driver core: Constify the signature of
 device_show/store_*()
Date: Tue, 14 Jul 2026 18:51:47 +0200
Message-Id: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMAwA0F+RnA1oGR3brwwRbRPNDnU0mTjEf
 183j+/ydlDKQgr3aodMq6gsqaCtKwjzkCZCicXgGueba+tQP8qKYUlqOJhljLT2tFl/YmTvbxw
 5XgjK8crEsv3/R3da3+OTgv1SOI4v7Q3lOoEAAAA=
X-Change-ID: 20260712-sysfs-const-attr-dev_ext_attr-dbf669fdfd4e
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, 
 Yushan Wang <wangyushan12@huawei.com>, Jijie Shao <shaojijie@huawei.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784047913; l=1711;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=P8axtzlc26y5kWyEb7PWfrNrtHlna+IHi2EA6Xja4RU=;
 b=ygssrvOv1vOPr3lElItnO1Z5cofbIvqxZSp7zutH11/4nI7eNOB7qK2ICFH8O4iBEF8Ffq26R
 SSBn+MlIBpABIIOgUqelEMPj402hGe/Kyp7J89f+xIgEOUpE3i2ZbqC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Prepare for the constification of 'struct dev_ext_attribute' by changing
the signature of the standard callback functions.

Intended for the driver-core tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      x86/mce: Use __DEVICE_ATTR() macro to initialize dev_ext_attribute
      drivers: perf: Use __DEVICE_ATTR() macro to initialize dev_ext_attribute
      driver core: Constify the signature of device_show/store_*()

 arch/powerpc/perf/hv-24x7.c                 |  2 +-
 arch/x86/kernel/cpu/mce/core.c              |  6 +++---
 drivers/base/core.c                         | 30 ++++++++++++++---------------
 drivers/perf/arm-cci.c                      |  2 +-
 drivers/perf/arm-ccn.c                      |  2 +-
 drivers/perf/arm_cspmu/arm_cspmu.h          |  2 +-
 drivers/perf/arm_dsu_pmu.c                  |  2 +-
 drivers/perf/cxl_pmu.c                      | 10 +++++-----
 drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |  6 +++---
 drivers/perf/hisilicon/hns3_pmu.c           |  6 +++---
 drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 12 ++++++------
 drivers/perf/qcom_l3_pmu.c                  |  8 ++++----
 drivers/perf/xgene_pmu.c                    |  2 +-
 include/linux/device.h                      | 14 +++++++-------
 17 files changed, 55 insertions(+), 55 deletions(-)
---
base-commit: 1160c2208fab4eaf4a32d738f83474c32c3a6944
change-id: 20260712-sysfs-const-attr-dev_ext_attr-dbf669fdfd4e

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>


