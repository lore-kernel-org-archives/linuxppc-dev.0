Return-Path: <SRS0=owsf=57=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D99C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 12:44:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8D9206A2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 12:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8D9206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492MWG0ZbgzDqsR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 22:44:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=vivo.com (client-ip=59.111.176.18; helo=m17618.mail.qiye.163.com;
 envelope-from=wenhu.wang@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=vivo.com
Received: from m17618.mail.qiye.163.com (m17618.mail.qiye.163.com
 [59.111.176.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492MHT5HsSzDqN8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2020 22:34:27 +1000 (AEST)
Received: from ubuntu.localdomain (unknown [58.251.74.226])
 by m17618.mail.qiye.163.com (Hmail) with ESMTPA id A5EC54E23DF;
 Wed, 15 Apr 2020 20:34:16 +0800 (CST)
From: Wang Wenhu <wenhu.wang@vivo.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, oss@buserror.net,
 christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] drivers: uio: new driver uio_fsl_85xx_cache_sram
Date: Wed, 15 Apr 2020 05:33:41 -0700
Message-Id: <20200415123346.116212-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVPTklLS0tKT0pKT0hDWVdZKFlBSE
 83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjI6KSo*CTgzQwgDA0I5IzQc
 MzMKCQxVSlVKTkNNQk5PS05CS0tMVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
 Q1VJTkpVTE9VSUlNWVdZCAFZQUlKSk43Bg++
X-HM-Tid: 0a717dd534d09376kuwsa5ec54e23df
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
Cc: kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series add a new uio driver for freescale 85xx platforms to
access the Cache-Sram form user level. This is extremely helpful
for the user-space applications that require high performance memory
accesses.

It fixes the compile errors and warning of the hardware level drivers
and implements the uio driver in uio_fsl_85xx_cache_sram.c.

Wang Wenhu (5):
  powerpc: 85xx: make FSL_85XX_CACHE_SRAM configurable
  powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
  powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
  powerpc: sysdev: fix compile error for fsl_85xx_l2ctlr
  drivers: uio: new driver for fsl_85xx_cache_sram

 arch/powerpc/platforms/85xx/Kconfig       |   2 +-
 arch/powerpc/platforms/Kconfig.cputype    |   5 +-
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c |   3 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   1 +
 drivers/uio/Kconfig                       |   8 +
 drivers/uio/Makefile                      |   1 +
 drivers/uio/uio_fsl_85xx_cache_sram.c     | 195 ++++++++++++++++++++++
 7 files changed, 211 insertions(+), 4 deletions(-)
 create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c

-- 
2.17.1

