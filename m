Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A2DA1A09DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 19:56:02 +1100 (AEDT)
Received: by mail-pa0-f43.google.com with SMTP id kx10so15415785pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Dec 2014 00:55:59 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/3] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
Date: Wed,  3 Dec 2014 16:53:50 +0800
Message-Id: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have done a boot test on p5040ds and mpc5121eads board.

v3:
  - Rebase on next.
  - CC stable for patch 1.
  - Add Scott and Michael's ack.

v2:
 - Revert the commit da788acb2838 first.
 - Invoke of_clk_init() from a common place.

v1
This tries to fix a kernel panic introduced by commit da788acb2838
("clk: ppc-corenet: Fix Section mismatch warning").


Kevin Hao (3):
  Revert "clk: ppc-corenet: Fix Section mismatch warning"
  powerpc: call of_clk_init() from time_init()
  clk: ppc-corenet: fix section mismatch warning

 arch/powerpc/kernel/time.c                    |  5 ++++
 arch/powerpc/platforms/512x/clock-commonclk.c | 11 ++++---
 drivers/clk/clk-ppc-corenet.c                 | 43 ++++-----------------------
 3 files changed, 16 insertions(+), 43 deletions(-)

-- 
1.9.3
