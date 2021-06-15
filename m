Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB41CC48BE8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 01:37:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA6D6141B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 01:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA6D6141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3rXm4Z8vz3bv3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 11:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com;
 envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3rVc2VQSz2yxy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 11:35:33 +1000 (AEST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G3rNg31Shz1BMYl;
 Tue, 15 Jun 2021 09:30:27 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:35:25 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 09:35:24 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <alsa-devel@alsa-project.org>
Subject: [PATCH -next v2 0/9] ASoC: fsl: Use
 devm_platform_get_and_ioremap_resource()
Date: Tue, 15 Jun 2021 09:39:13 +0800
Message-ID: <20210615013922.784296-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
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
Cc: broonie@kernel.org, timur@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

patch #1 ~ #8:
  Use devm_platform_get_and_ioremap_resource()

patch #9
  check return value of platform_get_resource_byname()

v2:
  change error message in patch #9

Yang Yingliang (9):
  ASoC: fsl_asrc: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_aud2htx: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_easrc: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_esai: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_micfil: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_sai: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_spdif: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_ssi: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_xcvr: check return value after calling
    platform_get_resource_byname()

 sound/soc/fsl/fsl_asrc.c    | 3 +--
 sound/soc/fsl/fsl_aud2htx.c | 3 +--
 sound/soc/fsl/fsl_easrc.c   | 3 +--
 sound/soc/fsl/fsl_esai.c    | 3 +--
 sound/soc/fsl/fsl_micfil.c  | 3 +--
 sound/soc/fsl/fsl_sai.c     | 3 +--
 sound/soc/fsl/fsl_spdif.c   | 3 +--
 sound/soc/fsl/fsl_ssi.c     | 3 +--
 sound/soc/fsl/fsl_xcvr.c    | 4 ++++
 9 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.25.1

