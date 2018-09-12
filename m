Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4292Sj4PWlzF37c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 10:18:45 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
 <linux-kernel@vger.kernel.org>
Message-Id: <cover.1536709753.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/7] Miscellaneous Macintosh fixes and clean up
Date: Tue, 11 Sep 2018 20:18:43 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series has some minor fixes and cleanups under drivers/macintosh,
including a patch to rework recent printk changes in adb-hid.c.
There's also a re-based RTC code de-duplication patch.


Finn Thain (7):
  macintosh: Use common code to access RTC
  macintosh/adb: Rework printk output again
  macintosh/via-macii: Synchronous bus reset
  macintosh/via-macii: Remove BUG_ON assertions
  macintosh/via-macii: Simplify locking
  macintosh/via-macii, macintosh/adb-iop: Modernize printk calls
  macintosh/via-macii, macintosh/adb-iop: Clean up whitespace

 arch/m68k/mac/misc.c                   |  75 +------
 arch/powerpc/platforms/powermac/time.c | 126 ++----------
 drivers/macintosh/adb-iop.c            |  50 +++--
 drivers/macintosh/adb.c                |   8 +-
 drivers/macintosh/adbhid.c             |  53 ++---
 drivers/macintosh/via-cuda.c           |  35 ++++
 drivers/macintosh/via-macii.c          | 352 ++++++++++++++++-----------------
 drivers/macintosh/via-pmu.c            |  33 ++++
 include/linux/cuda.h                   |   4 +
 include/linux/pmu.h                    |   4 +
 10 files changed, 328 insertions(+), 412 deletions(-)

-- 
2.16.4
