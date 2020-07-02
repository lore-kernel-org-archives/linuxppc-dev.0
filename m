Return-Path: <SRS0=FKTu=AN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0F2C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 22:35:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51602075D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 22:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51602075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49yXx222pXzDr5g
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 08:35:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=collabora.com (client-ip=2a00:1098:0:82:1000:25:2eeb:e3e3;
 helo=bhuna.collabora.co.uk; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49yL0X5xryzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2020 00:22:52 +1000 (AEST)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: aferraris)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3CE162A1D11;
 Thu,  2 Jul 2020 15:22:49 +0100 (BST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
To: 
Subject: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Date: Thu,  2 Jul 2020 16:22:31 +0200
Message-Id: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2020 08:28:34 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 kernel@collabora.com, Fabio Estevam <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The current ASRC driver hardcodes the input and output clocks used for
sample rate conversions. In order to allow greater flexibility and to
cover more use cases, it would be preferable to select the clocks using
device-tree properties.

This series also fix register configuration and clock assignment so
conversion can be conducted effectively in both directions with a good
quality.

Arnaud Ferraris (4):
  dt-bindings: sound: fsl,asrc: add properties to select in/out clocks
  ASoC: fsl_asrc: allow using arbitrary input and output clocks
  ASoC: fsl_asrc: always use ratio for conversion
  ASoC: fsl_asrc: swap input and output clocks in capture mode

 Documentation/devicetree/bindings/sound/fsl,asrc.txt |  8 ++++++++
 sound/soc/fsl/fsl_asrc.c                             | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 sound/soc/fsl/fsl_asrc_common.h                      |  3 +++
 3 files changed, 75 insertions(+), 5 deletions(-)


