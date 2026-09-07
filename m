Return-Path: <linuxppc-dev+bounces-26645-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F42C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 05:52:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdbmy4TTgz2yvj;
	Mon, 07 Sep 2026 15:52:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788760322;
	cv=none; b=lbOcTUYYScqn0ADI3M0NDLBQvzNAalWG/dllsMFtRxpMy+RomrvjMcIwDdrZa49QIj/t18T4J0Ri0wOLyzFGWchvkEZ3X87aEyKbBepLuKvzMmiQDRskFcLPijml4f8jFcd8l/jUkNE1t7sEGkyxjal/dBcSRDvFZTmh5wWrOnwBGEc/YcnyEm4zDTMU2Q8OsUcCmiHsxGwA1uA6dAQQ8t45PFvQ9CgIwKLqd+uXmFlaryjoIO5A+VQsh+VaAfdyQ41s3tRjHjQx74UWItmoakEuVpl6A2wB37a+BKtcwtGWerjJWNWaHoEb2v8vRwejtnEQXeIXigf8XUwJtwYYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788760322; c=relaxed/relaxed;
	bh=OE+94+rxnr6JyHzVf41++W806Ur3QbjQQuslFQknClE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C+o94o51cfbBIDU1kvNrThr1YW3zhsk/Od1LtoH9szigmLlRtSclW2eZhVr5ITSy9yaDAVbF2Yx/6klRdLmBJPAMQVKpkBuiw5TqSqif67J8qymakkz0SS1HVGxOU6tIZT0rdAQ2TPQb3tORYJzmluGDkcZAf2bH4PQwkEY5CnIM/0S03fba+qyOctbtSRnYc4XsHoDlCJgE1NsVQeeFtUsaWuZ43D4YIX27RcakBNMfTWmYrzdOrFqkODU+nv7IYysm8jQgX+EZ2EBmJlCcnoham63BY1l6nhCgvI/F+IiHw/2zFWoFpxL+fME4Ae5H0QwS09129De+bMuikVY+Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=A6HY3cV7; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=A6HY3cV7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 400 seconds by postgrey-1.37 at boromir; Mon, 07 Sep 2026 15:52:00 AEST
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdbmw2ktXz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 15:52:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1788759912;
	bh=74OyWk+S1XapnZa91tZh7QGJ8Z65Zq0I4MGM9fNJNk4=;
	h=From:Subject:Date:To:Cc:From;
	b=A6HY3cV701dgp4nehXyHi0uuEnDYEsK/ruMG+iGzYoQjZUV/M7TXnif6yPqj1WCHf
	 u6SwqmxYz6xiFp1/Wb0+Xphev6GzjL+dE1p6VSs5jEWoFF42oV7/2jf4QHzK47dG/q
	 rSXkrDVQq0zPLslfyMEAaaLBw5epZDE/IPsbgxso=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] driver core: Constify the signature of
 device_show/store_*()
Date: Mon, 07 Sep 2026 07:45:00 +0200
Message-Id: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw7CIBBFf6Vh7RjAitGV/2GapoVBcEENQ7FN0
 3+3j7h2eZKbc+7ECKNHYrdiYhGzJ9+FBeShYNo14YngzcJMcqn4RUigkSyB7gIlaFKKYDDXOKR
 6h9YqdbXGmhLZ4nhHtH7Y/I9qZ+rbF+q0SteF85S6OG4Hslh3v1b5p5UFcFCt1Lw8nY2S4v5BT
 0Ta9e4YMLFqnucvwCtUS+EAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788759912; l=2248;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=74OyWk+S1XapnZa91tZh7QGJ8Z65Zq0I4MGM9fNJNk4=;
 b=XvYmhK8g23TtkqqxN7yFFdmL3QKRYan/Vq1gOpl1Rbpx5vGwB2eFDVQ3yILkyDbE08ZBxinF5
 wad1OfZF2tjA5gvkgXhlADqWAri64DSYcu+XOo2XcNPH3zmUHKsUZII
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Prepare for the constification of 'struct dev_ext_attribute' instances
by changing the signature of the standard callback functions.
The first two patches prepare some drivers to handle both the const and
non-const callback variants.

Intended for the driver-core tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase on v7.3-rc1.
- Cover a few more drivers in drivers/perf/.
- Link to v1: https://patch.msgid.link/20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net

---
Thomas Weißschuh (3):
      x86/mce: Use __DEVICE_ATTR() macro to initialize dev_ext_attribute
      drivers: perf: Use __DEVICE_ATTR() macro to initialize dev_ext_attribute
      driver core: Constify the signature of device_show/store_*()

 arch/powerpc/perf/hv-24x7.c                 |  2 +-
 arch/x86/kernel/cpu/mce/core.c              |  6 +++---
 drivers/base/core.c                         | 30 ++++++++++++++---------------
 drivers/perf/alibaba_uncore_drw_pmu.c       |  2 +-
 drivers/perf/arm-cci.c                      |  2 +-
 drivers/perf/arm-ccn.c                      |  2 +-
 drivers/perf/arm_cspmu/arm_cspmu.h          |  2 +-
 drivers/perf/arm_dsu_pmu.c                  |  2 +-
 drivers/perf/arm_spe_pmu.c                  |  6 +++---
 drivers/perf/cxl_pmu.c                      | 10 +++++-----
 drivers/perf/fsl_imx8_ddr_perf.c            |  2 +-
 drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |  6 +++---
 drivers/perf/hisilicon/hns3_pmu.c           |  6 +++---
 drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 12 ++++++------
 drivers/perf/qcom_l3_pmu.c                  |  8 ++++----
 drivers/perf/starfive_starlink_pmu.c        |  2 +-
 drivers/perf/xgene_pmu.c                    |  2 +-
 include/linux/device.h                      | 14 +++++++-------
 21 files changed, 61 insertions(+), 61 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260712-sysfs-const-attr-dev_ext_attr-dbf669fdfd4e

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>


