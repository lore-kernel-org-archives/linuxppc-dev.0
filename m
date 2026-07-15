Return-Path: <linuxppc-dev+bounces-24289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DD3C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:07:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfQ2cD2z3c7d;
	Wed, 15 Jul 2026 10:05:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073949;
	cv=none; b=cv+byihW2mZsiKO5pK4dVUI/LilDjYBbsFWhLwxbz9H/bG8H2pXx6MxHGpTE/1tH/QgiFUeNWrLVqhDn/2t6VpvO7gmrAS/VuhFR7ibBukFKWhRZKuJqkYVA16L2C5Vf/g7R0O40ydMzDZE6ZFzpDSlwclQ6skWxYAgTftFZ/h2C37Njj9vqpBFRn0l7IS6wL9nUOFCNjmxR9KD+/82Xw5SDxxJpqj2+GJG+16dl3ROX8JyQGLeye74SzNGVbRbOAu+qOifMhkKlig76w0UTc4CepTERB3U/G9aOfBdNRB0NV/2561bF2RXxeOzE9urF98leopOqDPoRJlZLuWQbag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073949; c=relaxed/relaxed;
	bh=k7wS5NSRoXjGzDk9NchtsQuUMk6gxPBQtgSJKeJ9nKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AApFwft8gl5kLZKtXxQgzTV9EJGhhguNwzPvv1K6Xd8Tx74Aflwf82K7I4hkDd0ivVrBqgK6m37Ju4WIUfjjqqUmKiNIl2rG51mk5kZLf8UIsF+4xoCdijqKaRqUyf9VdMpyMKsjkhESRhyRAE0Bf+/7xRt6kmTIYWGM7F1WfSiLUXZemqRVLaC9PHXh3VWFa2rga4bb9OH20hPW4oUYSUWVjSLDoEiAdbT4k4lMiWSSflCUH2ie0zqxZ5T44EhhNqc2Q1lEiNvAJMxVVKMlYFO0CZmTKqJskhbQCSSYNHI2wlj6aagIWrq5OgOcyCPceZBhiAlTI3q9Rp4+lc4uvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f8SbXH/F; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f8SbXH/F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfG5NY6z3bgK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=k7wS5NSRoXjGzDk9NchtsQuUMk6gxPBQtgSJKeJ9nKw=; b=f8SbXH/F+bjtIOd9IIfmqsgr78
	7HFeqK6vJ0Q8jldWeTHf2ywM0egej8z/jjjiklk/O+eHE6fCOcHUwrypv+OAXLBWtswq2lhskICLx
	qgkbTtPcMoIsfK7zDQWTI2owvKawLOOMA7ZaBe6Pq1mTvBMXq68r45Dq+Jw63HZeuGswFA4Ksx8k+
	OG+CB+GCXNQrnUc6nu7bLbx99mUUL5S25Wbgj3SGp8So5fjjGp863MPCObK1rHVu8KDPTit2K6BDv
	yvwPXnY9mv/jawAyMBJqqQg+r8ooq6M1auntD48SxcF5UROOd99UZDM1NED4m9y/JJzburV5xEFkq
	P1YSEFsQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn82-0000000DTcu-2AKD;
	Wed, 15 Jul 2026 00:05:34 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	patches@opensource.cirrus.com,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 11/14 v2] ASoC: soc-acpi: fix all kernel-doc warnings
Date: Tue, 14 Jul 2026 17:05:22 -0700
Message-ID: <20260715000525.739874-12-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715000525.739874-1-rdunlap@infradead.org>
References: <20260715000525.739874-1-rdunlap@infradead.org>
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

Add missing "struct" keyword to kernel-doc for structs.
Describe @mach_params in struct snd_soc_acpi_mach.
Don't document callback parameters with '@' as though they are kernel-doc.

These changes avoid all kernel-doc warnings in this header file.

Examples:
Warning: ../include/sound/soc-acpi.h:77 cannot understand function prototype: 'struct snd_soc_acpi_mach_params'
Warning: ../include/sound/soc-acpi.h:101 cannot understand function prototype: 'struct snd_soc_acpi_endpoint'
Warning: ../include/sound/soc-acpi.h:115 cannot understand function prototype: 'struct snd_soc_acpi_adr_device'
Warning: ../include/sound/soc-acpi.h:132 cannot understand function prototype: 'struct snd_soc_acpi_link_adr'
Warning: ../include/sound/soc-acpi.h:209 cannot understand function prototype: 'struct snd_soc_acpi_mach'

Warning: include/sound/soc-acpi.h:230 struct member 'mach_params' not described in 'snd_soc_acpi_mach'
Warning: include/sound/soc-acpi.h:230 Excess struct member 'card' description in 'snd_soc_acpi_mach'
Warning: include/sound/soc-acpi.h:230 Excess struct member 'mach' description in 'snd_soc_acpi_mach'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: no change

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org

 include/sound/soc-acpi.h |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- linext-2026-0710.orig/include/sound/soc-acpi.h
+++ linext-2026-0710/include/sound/soc-acpi.h
@@ -57,7 +57,7 @@ static inline struct snd_soc_acpi_mach *
 #endif
 
 /**
- * snd_soc_acpi_mach_params: interface for machine driver configuration
+ * struct snd_soc_acpi_mach_params - interface for machine driver configuration
  *
  * @acpi_ipc_irq_index: used for BYT-CR detection
  * @platform: string used for HDAudio codec support
@@ -93,7 +93,7 @@ struct snd_soc_acpi_mach_params {
 };
 
 /**
- * snd_soc_acpi_endpoint - endpoint descriptor
+ * struct snd_soc_acpi_endpoint - endpoint descriptor
  * @num: endpoint number (mandatory, unique per device)
  * @aggregated: 0 (independent) or 1 (logically grouped)
  * @group_position: zero-based order (only when @aggregated is 1)
@@ -107,7 +107,7 @@ struct snd_soc_acpi_endpoint {
 };
 
 /**
- * snd_soc_acpi_adr_device - descriptor for _ADR-enumerated device
+ * struct snd_soc_acpi_adr_device - descriptor for _ADR-enumerated device
  * @adr: 64 bit ACPI _ADR value
  * @num_endpoints: number of endpoints for this device
  * @endpoints: array of endpoints
@@ -121,7 +121,7 @@ struct snd_soc_acpi_adr_device {
 };
 
 /**
- * snd_soc_acpi_link_adr - ACPI-based list of _ADR enumerated devices
+ * struct snd_soc_acpi_link_adr - ACPI-based list of _ADR enumerated devices
  * @mask: one bit set indicates the link this list applies to
  * @num_adr: ARRAY_SIZE of devices
  * @adr_d: array of devices
@@ -167,8 +167,8 @@ struct snd_soc_acpi_link_adr {
 #define SND_SOC_ACPI_TPLG_INTEL_CODEC_NAME BIT(4)
 
 /**
- * snd_soc_acpi_mach: ACPI-based machine descriptor. Most of the fields are
- * related to the hardware, except for the firmware and topology file names.
+ * struct snd_soc_acpi_mach - ACPI-based machine descriptor. Most of the fields
+ * are related to the hardware, except for the firmware and topology file names.
  * A platform supported by legacy and Sound Open Firmware (SOF) would expose
  * all firmware/topology related fields.
  *
@@ -192,6 +192,7 @@ struct snd_soc_acpi_link_adr {
  * the initial selection in the snd_soc_acpi_mach table.
  * @pdata: intended for platform data or machine specific-ops. This structure
  *  is not constant since this field may be updated at run-time
+ * @mach_params: machine driver configuration
  * @sof_tplg_filename: Sound Open Firmware topology file name, if enabled
  * @tplg_quirk_mask: quirks to select different topology files dynamically
  * @get_function_tplg_files: This is an optional callback, if specified then instead of
@@ -199,11 +200,11 @@ struct snd_soc_acpi_link_adr {
  *	files to be loaded.
  *	Return value: The number of the files or negative ERRNO. 0 means that the single topology
  *		      file should be used, no function topology split can be used on the machine.
- *	@card: the pointer of the card
- *	@mach: the pointer of the machine driver
- *	@prefix: the prefix of the topology file name. Typically, it is the path.
- *	@tplg_files: the pointer of the array of the topology file names.
- *	@best_effort: ignore non supported links and try to build the card in best effort
+ *	card: the pointer of the card
+ *	mach: the pointer of the machine driver
+ *	prefix: the prefix of the topology file name. Typically, it is the path.
+ *	tplg_files: the pointer of the array of the topology file names.
+ *	best_effort: ignore non supported links and try to build the card in best effort
  *		      with supported links
  */
 /* Descriptor for SST ASoC machine driver */

