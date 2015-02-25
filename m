Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C26661A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 03:02:33 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
Date: Wed, 25 Feb 2015 17:01:51 +0100
Message-Id: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Cc: linux-mips@linux-mips.org, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Here is the second version of the patch series to describe i2c adapter quirks
in a generic way. For the motivation, please read description of patch 1. This
is still RFC because I would like to do some more tests on my own, but I need
to write a tool for that. However, I'd really like to have the driver authors
to have a look already. Actual testing is very much appreciated. Thanks to the
Mediatek guys for rebasing their new driver to this framework. That helps, too!

The branch is also here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks

Thanks,

   Wolfram

Major changes since V1:

* more fine-grained options to describe modes with combined messages.
  This should also cover the Mediatek HW now as well as all other
  permutations I can think of.

* the core code and at91 driver had to be refactored to reflect the
  above change

* added the bcm-iproc driver which came to mainline recently

Wolfram Sang (12):
  i2c: add quirk structure to describe adapter flaws
  i2c: add quirk checks to core
  i2c: at91: make use of the new infrastructure for quirks
  i2c: opal: make use of the new infrastructure for quirks
  i2c: qup: make use of the new infrastructure for quirks
  i2c: cpm: make use of the new infrastructure for quirks
  i2c: axxia: make use of the new infrastructure for quirks
  i2c: dln2: make use of the new infrastructure for quirks
  i2c: powermac: make use of the new infrastructure for quirks
  i2c: viperboard: make use of the new infrastructure for quirks
  i2c: pmcmsp: make use of the new infrastructure for quirks
  i2c: bcm-iproc: make use of the new infrastructure for quirks

 drivers/i2c/busses/i2c-at91.c       | 32 +++++++------------
 drivers/i2c/busses/i2c-axxia.c      | 11 ++++---
 drivers/i2c/busses/i2c-bcm-iproc.c  | 15 +++++----
 drivers/i2c/busses/i2c-cpm.c        | 20 ++++++------
 drivers/i2c/busses/i2c-dln2.c       | 12 +++----
 drivers/i2c/busses/i2c-opal.c       | 22 ++++++-------
 drivers/i2c/busses/i2c-pmcmsp.c     | 42 ++++++++++---------------
 drivers/i2c/busses/i2c-powermac.c   | 10 +++---
 drivers/i2c/busses/i2c-qup.c        | 21 ++++++-------
 drivers/i2c/busses/i2c-viperboard.c | 10 +++---
 drivers/i2c/i2c-core.c              | 62 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h                 | 43 +++++++++++++++++++++++++
 12 files changed, 191 insertions(+), 109 deletions(-)

-- 
2.1.4
