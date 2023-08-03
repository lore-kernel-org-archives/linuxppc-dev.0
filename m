Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E67C00528
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:10:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RGmND0Mgcz3c3x
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Aug 2023 21:10:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RGmMg5pp9z3bNq
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2023 21:09:51 +1000 (AEST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGlqN4DzSztRq5;
	Thu,  3 Aug 2023 18:45:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 18:48:42 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<qiang.zhao@nxp.com>, <leoyang.li@nxp.com>, <michal.simek@amd.com>,
	<robh@kernel.org>
Subject: [PATCH -next 0/2] soc: Do not check for 0 return after calling platform_get_irq()
Date: Thu, 3 Aug 2023 18:48:05 +0800
Message-ID: <20230803104807.814005-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
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
Cc: ruanjinjie@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since commit ce753ad1549c ("platform: finally disallow IRQ0 in
platform_get_irq() and its ilk"), there is no possible for
platform_get_irq() to return 0.

And the return value of platform_get_irq() is
more sensible to show the error reason.

Ruan Jinjie (2):
  soc: fsl: qe: Do not check for 0 return after calling
    platform_get_irq()
  soc: xilinx: Do not check for 0 return after calling
    platform_get_irq()

 drivers/soc/fsl/qe/qe_ic.c        | 4 ++--
 drivers/soc/xilinx/zynqmp_power.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1

