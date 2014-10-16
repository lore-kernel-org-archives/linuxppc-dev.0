Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FB271A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 22:19:54 +1100 (AEDT)
Received: by mail-pd0-f171.google.com with SMTP id ft15so3085095pdb.30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 04:19:52 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
Date: Thu, 16 Oct 2014 19:18:39 +0800
Message-Id: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
 Mike Turquette <mturquette@linaro.org>,
 Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This tries to fix a kernel panic introduced by commit da788acb2838
("clk: ppc-corenet: Fix Section mismatch warning").

Kevin Hao (2):
  powerpc: move ppc_init() to common place
  clk: ppc-corenet: don't use platform_driver to init the clock device

 arch/powerpc/include/asm/machdep.h            |  2 +-
 arch/powerpc/kernel/setup-common.c            | 15 ++++++++++
 arch/powerpc/kernel/setup_32.c                | 15 ----------
 arch/powerpc/platforms/85xx/corenet_generic.c |  7 +++++
 drivers/clk/clk-ppc-corenet.c                 | 43 ++++-----------------------
 5 files changed, 29 insertions(+), 53 deletions(-)

-- 
1.9.3
