Return-Path: <linuxppc-dev+bounces-24176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BF8C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:46:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvW2wk1z3c5h;
	Tue, 14 Jul 2026 11:45:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993510;
	cv=none; b=bgBGH8/tNnVBBtm5SBhEhzD0sBeS8pnjqMEbiD1kpQD0j9WlsWCMfeJ6o3ApwFSZQhKljc7HsJSzqNEeR95cByUYUKTtAK5HU4ovNRMYiNbRCop1QwUbLoz3FCjK5cBOrlaqNjBfL7UvLRiXsQ9Qx6QGe4lxj/54tDgI69QPqOpK/N3cDHJR+aaoX5Gn6XqyWTWf239yk89jvSb2AGdWoAcgLSqdVA/kZGyw3iCUpWojdAFT/6mGIVOdyyNGiiCGanuPZhuTYh1JTslanVAoMI3W9nvHkvLf8Ka82STewC5V0BMoH18G78wnUprlBopkkmwImIMEH1uon/IvdXYN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993510; c=relaxed/relaxed;
	bh=zS7NmjIateHYP4i/gAc15WR9uDUXiL/jlbaVU67XbRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNJTTLM+tqWvw2/RcsETygdUTj0YEfE/yxgfWtyAI4enMJw2vle8XMzOgtNMs25mzjiRQrjqHJn+0IQPNeSVjRwWHBaqnehKFBB3Ppt4jQnk4DTthskMb4yNOfrP02iYVJKITV06erpcFhIL3sBUMtaqh69Q8MHoTTcKsJHVqCUqT6HkGLdOU8FpZsMDKl1K6Gvi6nW4R6OcDCvMv2kEfG94ZniPu3YOSJcSuMvIK9MR6/pXGVH3AhVcMQRtoRUQexfThHySA58UrhZmSgawzbjrBTIVwZifUvKZhsqb7evcx8u9OvwOWJYSxLv0nQVr+4w02U/zJt2v0IbMhSujzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uW1sq82g; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uW1sq82g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvL1Qhcz30F9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:45:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zS7NmjIateHYP4i/gAc15WR9uDUXiL/jlbaVU67XbRA=; b=uW1sq82gP92lKcxJgem8/gbpo3
	vriL0KJqLww1OU9fwjWMTUBXoaU1fBPoJsyAr3YCk0FzlxjIViZeVnkV9T37ckSe1C89U7q2YlyF2
	QkoOC3FvLXibecLU6Mxb6tvZ/tmb+ClXQC+HAnBCGl85Xp956dMBKqeMfvD3ZhCL2vKhFzazOMRTM
	S6PsGvW13pkjom3if0qyxpPEwaYDhMUkYs1d7wYi2t7YDL8RzauhskYsDptkjmZylKLdaa6IsmTht
	hiKB5UX1/+V3s0Dc4gu76WhoJX51o/vH+tRhcAv85EbXhj5qrDRJ5a+InMJdi8KTq9TF9SxG4P//V
	WEUl2wiA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCc-0000000AgsR-0kF8;
	Tue, 14 Jul 2026 01:44:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
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
	linux-arm-msm@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 12/14] ASoC: Intel: Skylake: convert SKL_TKNS to kernel-doc format
Date: Mon, 13 Jul 2026 18:44:43 -0700
Message-ID: <20260714014445.569992-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714014445.569992-1-rdunlap@infradead.org>
References: <20260714014445.569992-1-rdunlap@infradead.org>
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

Convert enum SKL_TKNS to kernel-doc format:
- use '@' instead of '%' for enum items
- add missing enum values
- correct a few enum names in the comments
- remove the comment for %SKL_TKN_U16_PIN_INST_ID since it is undefined
- fix a few typos

Warning: include/uapi/sound/snd_sst_tokens.h:11 Cannot find identifier on line:
 * %SKL_TKN_UUID:               Module UUID
Warning: ../include/uapi/sound/snd_sst_tokens.h:12 Cannot find identifier on line: *
Warning: ../include/uapi/sound/snd_sst_tokens.h:13 Cannot find identifier on line:
 * %SKL_TKN_U8_BLOCK_TYPE:      Type of the private data block.Can be:
Warning: include/uapi/sound/snd_sst_tokens.h:14 This comment starts with '/**', but isn't a kernel-doc comment.
 *                              tuples, bytes, short and words

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>

 include/uapi/sound/snd_sst_tokens.h |  165 +++++++++++++-------------
 1 file changed, 87 insertions(+), 78 deletions(-)

--- linext-2026-0710.orig/include/uapi/sound/snd_sst_tokens.h
+++ linext-2026-0710/include/uapi/sound/snd_sst_tokens.h
@@ -9,43 +9,47 @@
 #define __SND_SST_TOKENS_H__
 
 /**
- * %SKL_TKN_UUID:               Module UUID
+ * enum SKL_TKNS - SST tokens definitions
  *
- * %SKL_TKN_U8_BLOCK_TYPE:      Type of the private data block.Can be:
+ * @SKL_TKN_UUID:               Module UUID
+ *
+ * @SKL_TKN_U8_BLOCK_TYPE:      Type of the private data block.Can be:
  *                              tuples, bytes, short and words
  *
- * %SKL_TKN_U8_IN_PIN_TYPE:     Input pin type,
+ * @SKL_TKN_U8_NUM_BLOCKS:      FIXME
+ *
+ * @SKL_TKN_U8_IN_PIN_TYPE:     Input pin type,
  *                              homogenous=0, heterogenous=1
  *
- * %SKL_TKN_U8_OUT_PIN_TYPE:    Output pin type,
+ * @SKL_TKN_U8_OUT_PIN_TYPE:    Output pin type,
  *                              homogenous=0, heterogenous=1
- * %SKL_TKN_U8_DYN_IN_PIN:      Configure Input pin dynamically
+ * @SKL_TKN_U8_DYN_IN_PIN:      Configure Input pin dynamically
  *                              if true
  *
- * %SKL_TKN_U8_DYN_OUT_PIN:     Configure Output pin dynamically
+ * @SKL_TKN_U8_DYN_OUT_PIN:     Configure Output pin dynamically
  *                              if true
  *
- * %SKL_TKN_U8_IN_QUEUE_COUNT:  Store the number of Input pins
+ * @SKL_TKN_U8_IN_QUEUE_COUNT:  Store the number of Input pins
  *
- * %SKL_TKN_U8_OUT_QUEUE_COUNT: Store the number of Output pins
+ * @SKL_TKN_U8_OUT_QUEUE_COUNT: Store the number of Output pins
  *
- * %SKL_TKN_U8_TIME_SLOT:       TDM slot number
+ * @SKL_TKN_U8_TIME_SLOT:       TDM slot number
  *
- * %SKL_TKN_U8_CORE_ID:         Stores module affinity value.Can take
+ * @SKL_TKN_U8_CORE_ID:         Stores module affinity value. Can take
  *                              the values:
  *                              SKL_AFFINITY_CORE_0 = 0,
  *                              SKL_AFFINITY_CORE_1,
  *                              SKL_AFFINITY_CORE_MAX
  *
- * %SKL_TKN_U8_MOD_TYPE:        Module type value.
+ * @SKL_TKN_U8_MOD_TYPE:        Module type value.
  *
- * %SKL_TKN_U8_CONN_TYPE:       Module connection type can be a FE,
+ * @SKL_TKN_U8_CONN_TYPE:       Module connection type can be a FE,
  *                              BE or NONE as defined :
  *                              SKL_PIPE_CONN_TYPE_NONE = 0,
  *                              SKL_PIPE_CONN_TYPE_FE = 1 (HOST_DMA)
  *                              SKL_PIPE_CONN_TYPE_BE = 2 (LINK_DMA)
  *
- * %SKL_TKN_U8_DEV_TYPE:        Type of device to which the module is
+ * @SKL_TKN_U8_DEV_TYPE:        Type of device to which the module is
  *                              connected
  *                              Can take the values:
  *                              SKL_DEVICE_BT = 0x0,
@@ -56,43 +60,43 @@
  *                              SKL_DEVICE_HDAHOST = 0x5,
  *                              SKL_DEVICE_NONE
  *
- * %SKL_TKN_U8_HW_CONN_TYPE:    Connection type of the HW to which the
+ * @SKL_TKN_U8_HW_CONN_TYPE:    Connection type of the HW to which the
  *                              module is connected
  *                              SKL_CONN_NONE = 0,
  *                              SKL_CONN_SOURCE = 1,
  *                              SKL_CONN_SINK = 2
  *
- * %SKL_TKN_U16_PIN_INST_ID:    Stores the pin instance id
+ * @SKL_TKN_U16_MOD_INST_ID:    Stores the module instance id
  *
- * %SKL_TKN_U16_MOD_INST_ID:    Stores the mdule instance id
+ * @SKL_TKN_U16_BLOCK_SIZE:     FIXME
  *
- * %SKL_TKN_U32_MAX_MCPS:       Module max mcps value
+ * @SKL_TKN_U32_MAX_MCPS:       Module max mcps value
  *
- * %SKL_TKN_U32_MEM_PAGES:      Module resource pages
+ * @SKL_TKN_U32_MEM_PAGES:      Module resource pages
  *
- * %SKL_TKN_U32_OBS:            Stores Output Buffer size
+ * @SKL_TKN_U32_OBS:            Stores Output Buffer size
  *
- * %SKL_TKN_U32_IBS:            Stores input buffer size
+ * @SKL_TKN_U32_IBS:            Stores input buffer size
  *
- * %SKL_TKN_U32_VBUS_ID:        Module VBUS_ID. PDM=0, SSP0=0,
+ * @SKL_TKN_U32_VBUS_ID:        Module VBUS_ID. PDM=0, SSP0=0,
  *                              SSP1=1,SSP2=2,
  *                              SSP3=3, SSP4=4,
  *                              SSP5=5, SSP6=6,INVALID
  *
- * %SKL_TKN_U32_PARAMS_FIXUP:   Module Params fixup mask
- * %SKL_TKN_U32_CONVERTER:      Module params converter mask
- * %SKL_TKN_U32_PIPE_ID:        Stores the pipe id
+ * @SKL_TKN_U32_PARAMS_FIXUP:   Module Params fixup mask
+ * @SKL_TKN_U32_CONVERTER:      Module params converter mask
+ * @SKL_TKN_U32_PIPE_ID:        Stores the pipe id
  *
- * %SKL_TKN_U32_PIPE_CONN_TYPE: Type of the token to which the pipe is
- *                              connected to. It can be
+ * @SKL_TKN_U32_PIPE_CONN_TYPE: Type of the token to which the pipe is
+ *                              connected. It can be
  *                              SKL_PIPE_CONN_TYPE_NONE = 0,
  *                              SKL_PIPE_CONN_TYPE_FE = 1 (HOST_DMA),
  *                              SKL_PIPE_CONN_TYPE_BE = 2 (LINK_DMA),
  *
- * %SKL_TKN_U32_PIPE_PRIORITY:  Pipe priority value
- * %SKL_TKN_U32_PIPE_MEM_PGS:   Pipe resource pages
+ * @SKL_TKN_U32_PIPE_PRIORITY:  Pipe priority value
+ * @SKL_TKN_U32_PIPE_MEM_PGS:   Pipe resource pages
  *
- * %SKL_TKN_U32_DIR_PIN_COUNT:  Value for the direction to set input/output
+ * @SKL_TKN_U32_DIR_PIN_COUNT:  Value for the direction to set input/output
  *                              formats and the pin count.
  *                              The first 4 bits have the direction
  *                              value and the next 4 have
@@ -104,23 +108,23 @@
  *                              and output made by reading direction
  *                              token.
  *
- * %SKL_TKN_U32_FMT_CH:         Supported channel count
+ * @SKL_TKN_U32_FMT_CH:         Supported channel count
  *
- * %SKL_TKN_U32_FMT_FREQ:       Supported frequency/sample rate
+ * @SKL_TKN_U32_FMT_FREQ:       Supported frequency/sample rate
  *
- * %SKL_TKN_U32_FMT_BIT_DEPTH:  Supported container size
+ * @SKL_TKN_U32_FMT_BIT_DEPTH:  Supported container size
  *
- * %SKL_TKN_U32_FMT_SAMPLE_SIZE:Number of samples in the container
+ * @SKL_TKN_U32_FMT_SAMPLE_SIZE:Number of samples in the container
  *
- * %SKL_TKN_U32_FMT_CH_CONFIG:  Supported channel configurations for the
+ * @SKL_TKN_U32_FMT_CH_CONFIG:  Supported channel configurations for the
  *                              input/output.
  *
- * %SKL_TKN_U32_FMT_INTERLEAVE: Interleaving style which can be per
+ * @SKL_TKN_U32_FMT_INTERLEAVE: Interleaving style which can be per
  *                              channel or per sample. The values can be :
  *                              SKL_INTERLEAVING_PER_CHANNEL = 0,
  *                              SKL_INTERLEAVING_PER_SAMPLE = 1,
  *
- * %SKL_TKN_U32_FMT_SAMPLE_TYPE:
+ * @SKL_TKN_U32_FMT_SAMPLE_TYPE:
  *                              Specifies the sample type. Can take the
  *                              values: SKL_SAMPLE_TYPE_INT_MSB = 0,
  *                              SKL_SAMPLE_TYPE_INT_LSB = 1,
@@ -128,104 +132,109 @@
  *                              SKL_SAMPLE_TYPE_INT_UNSIGNED = 3,
  *                              SKL_SAMPLE_TYPE_FLOAT = 4
  *
- * %SKL_TKN_U32_CH_MAP:         Channel map values
- * %SKL_TKN_U32_MOD_SET_PARAMS: It can take these values:
+ * @SKL_TKN_U32_FMT_CH_MAP:     Channel map values
+ * @SKL_TKN_U32_PIN_MOD_ID:     FIXME
+ * @SKL_TKN_U32_PIN_INST_ID:    FIXME
+ * @SKL_TKN_U32_MOD_SET_PARAMS: It can take these values:
  *                              SKL_PARAM_DEFAULT, SKL_PARAM_INIT,
  *                              SKL_PARAM_SET, SKL_PARAM_BIND
  *
- * %SKL_TKN_U32_MOD_PARAM_ID:   ID of the module params
+ * @SKL_TKN_U32_MOD_PARAM_ID:   ID of the module params
  *
- * %SKL_TKN_U32_CAPS_SET_PARAMS:
+ * @SKL_TKN_U32_CAPS_SET_PARAMS:
  *                              Set params value
  *
- * %SKL_TKN_U32_CAPS_PARAMS_ID: Params ID
+ * @SKL_TKN_U32_CAPS_PARAMS_ID: Params ID
  *
- * %SKL_TKN_U32_CAPS_SIZE:      Caps size
+ * @SKL_TKN_U32_CAPS_SIZE:      Caps size
  *
- * %SKL_TKN_U32_PROC_DOMAIN:    Specify processing domain
+ * @SKL_TKN_U32_PROC_DOMAIN:    Specify processing domain
  *
- * %SKL_TKN_U32_LIB_COUNT:      Specifies the number of libraries
+ * @SKL_TKN_U32_LIB_COUNT:      Specifies the number of libraries
  *
- * %SKL_TKN_STR_LIB_NAME:       Specifies the library name
+ * @SKL_TKN_STR_LIB_NAME:       Specifies the library name
  *
- * %SKL_TKN_U32_PMODE:		Specifies the power mode for pipe
+ * @SKL_TKN_U32_PMODE:		Specifies the power mode for pipe
  *
- * %SKL_TKL_U32_D0I3_CAPS:	Specifies the D0i3 capability for module
+ * @SKL_TKL_U32_D0I3_CAPS:	Specifies the D0i3 capability for module (typo)
+ * @SKL_TKN_U32_D0I3_CAPS:      Specifies the D0i3 capability for module
  *
- * %SKL_TKN_U32_DMA_BUF_SIZE:	DMA buffer size in millisec
+ * @SKL_TKN_U32_DMA_BUF_SIZE:	DMA buffer size in millisec
  *
- * %SKL_TKN_U32_PIPE_DIR:       Specifies pipe direction. Can be
+ * @SKL_TKN_U32_PIPE_DIRECTION: Specifies pipe direction. Can be
  *                              playback/capture.
  *
- * %SKL_TKN_U32_NUM_CONFIGS:    Number of pipe configs
+ * @SKL_TKN_U32_NUM_CONFIGS:    Number of pipe configs
  *
- * %SKL_TKN_U32_PATH_MEM_PGS:   Size of memory (in pages) required for pipeline
+ * @SKL_TKN_U32_PATH_MEM_PGS:   Size of memory (in pages) required for pipeline
  *                              and its data
  *
- * %SKL_TKN_U32_PIPE_CONFIG_ID: Config id for the modules in the pipe
+ * @SKL_TKN_U32_PIPE_CONFIG_ID: Config id for the modules in the pipe
  *                              and PCM params supported by that pipe
  *                              config. This is used as index to fill
  *                              up the pipe config and module config
  *                              structure.
  *
- * %SKL_TKN_U32_CFG_FREQ:
- * %SKL_TKN_U8_CFG_CHAN:
- * %SKL_TKN_U8_CFG_BPS:         PCM params (freq, channels, bits per sample)
+ * @SKL_TKN_U32_CFG_FREQ:       FIXME
+ * @SKL_TKN_U8_CFG_CHAN:        FIXME
+ * @SKL_TKN_U8_CFG_BPS:         PCM params (freq, channels, bits per sample)
  *                              supported for each of the pipe configs.
  *
- * %SKL_TKN_CFG_MOD_RES_ID:     Module's resource index for each of the
+ * @SKL_TKN_CFG_MOD_RES_ID:     Module's resource index for each of the
  *                              pipe config
  *
- * %SKL_TKN_CFG_MOD_FMT_ID:     Module's interface index for each of the
+ * @SKL_TKN_CFG_MOD_FMT_ID:     Module's interface index for each of the
  *                              pipe config
  *
- * %SKL_TKN_U8_NUM_MOD:         Number of modules in the manifest
+ * @SKL_TKN_U8_NUM_MOD:         Number of modules in the manifest
  *
- * %SKL_TKN_MM_U8_MOD_IDX:      Current index of the module in the manifest
+ * @SKL_TKN_MM_U8_MOD_IDX:      Current index of the module in the manifest
  *
- * %SKL_TKN_MM_U8_NUM_RES:      Number of resources for the module
+ * @SKL_TKN_MM_U8_NUM_RES:      Number of resources for the module
  *
- * %SKL_TKN_MM_U8_NUM_INTF:     Number of interfaces for the module
+ * @SKL_TKN_MM_U8_NUM_INTF:     Number of interfaces for the module
  *
- * %SKL_TKN_MM_U32_RES_ID:      Resource index for the resource info to
+ * @SKL_TKN_MM_U32_RES_ID:      Resource index for the resource info to
  *                              be filled into.
  *                              A module can support multiple resource
- *                              configuration and is represnted as a
+ *                              configuration and is represented as a
  *                              resource table. This index is used to
  *                              fill information into appropriate index.
  *
- * %SKL_TKN_MM_U32_CPS:         DSP cycles per second
+ * @SKL_TKN_MM_U32_CPS:         DSP cycles per second
  *
- * %SKL_TKN_MM_U32_DMA_SIZE:    Allocated buffer size for gateway DMA
+ * @SKL_TKN_MM_U32_DMA_SIZE:    Allocated buffer size for gateway DMA
  *
- * %SKL_TKN_MM_U32_CPC:         DSP cycles allocated per frame
+ * @SKL_TKN_MM_U32_CPC:         DSP cycles allocated per frame
  *
- * %SKL_TKN_MM_U32_RES_PIN_ID:  Resource pin index in the module
+ * @SKL_TKN_MM_U32_RES_PIN_ID:  Resource pin index in the module
  *
- * %SKL_TKN_MM_U32_INTF_PIN_ID: Interface index in the module
+ * @SKL_TKN_MM_U32_INTF_PIN_ID: Interface index in the module
  *
- * %SKL_TKN_MM_U32_PIN_BUF:     Buffer size of the module pin
+ * @SKL_TKN_MM_U32_PIN_BUF:     Buffer size of the module pin
  *
- * %SKL_TKN_MM_U32_FMT_ID:      Format index for each of the interface/
+ * @SKL_TKN_MM_U32_FMT_ID:      Format index for each of the interface/
  *                              format information to be filled into.
  *
- * %SKL_TKN_MM_U32_NUM_IN_FMT:  Number of input formats
- * %SKL_TKN_MM_U32_NUM_OUT_FMT: Number of output formats
+ * @SKL_TKN_MM_U32_NUM_IN_FMT:  Number of input formats
+ * @SKL_TKN_MM_U32_NUM_OUT_FMT: Number of output formats
  *
- * %SKL_TKN_U32_ASTATE_IDX:     Table Index for the A-State entry to be filled
+ * @SKL_TKN_U32_ASTATE_IDX:     Table Index for the A-State entry to be filled
  *                              with kcps and clock source
  *
- * %SKL_TKN_U32_ASTATE_COUNT:   Number of valid entries in A-State table
+ * @SKL_TKN_U32_ASTATE_COUNT:   Number of valid entries in A-State table
  *
- * %SKL_TKN_U32_ASTATE_KCPS:    Specifies the core load threshold (in kilo
+ * @SKL_TKN_U32_ASTATE_KCPS:    Specifies the core load threshold (in kilo
  *                              cycles per second) below which DSP is clocked
  *                              from source specified by clock source.
  *
- * %SKL_TKN_U32_ASTATE_CLK_SRC: Clock source for A-State entry
+ * @SKL_TKN_U32_ASTATE_CLK_SRC: Clock source for A-State entry
+ *
+ * @SKL_TKN_U32_FMT_CFG_IDX:    Format config index
  *
- * %SKL_TKN_U32_FMT_CFG_IDX:    Format config index
+ * @SKL_TKN_MAX:                Max value for enum SKL_TKNS
  *
- * module_id and loadable flags dont have tokens as these values will be
+ * module_id and loadable flags don't have tokens as these values will be
  * read from the DSP FW manifest
  *
  * Tokens defined can be used either in the manifest or widget private data.

