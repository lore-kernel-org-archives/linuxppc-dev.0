Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F8961A027F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Oct 2014 17:12:39 +1100 (AEDT)
Received: by mail-pa0-f53.google.com with SMTP id kq14so3141530pab.26
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 23:12:37 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
Date: Sun, 19 Oct 2014 14:11:36 +0800
Message-Id: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
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

I have done a boot test on p2014rdb and t4240qds boards. I don't have an access
to mpc512x board, so only build test for that.

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
