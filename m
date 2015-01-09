Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAA291A0F86
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jan 2015 04:22:25 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [RFC 00/11] i2c: add generic quirk infrastructure
Date: Fri,  9 Jan 2015 18:21:30 +0100
Message-Id: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Cc: linux-mips@linux-mips.org, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently, a number of submitted I2C master drivers could not fully handle all
I2C type transfers due to limited HW. So, they had to bail out with some errno
although the user supplied a valid I2C transfer. In order to centralize such
quirks, a central structure describing the quirks is introduced. The next patch
lets the core do the checks based on the information about the quirks. Then
existing drivers with quirks are converted.

This already has the advantage of avoiding code duplication and having
consistent error handling. Later, once the structure is tested and stable, we
can pass it over to the users, so they can actually check what the current HW
is capable of and react accordingly.

These patches are RFC and only build-tested so far. Yet, I wanted to show what
I am up to. I will do some testing on HW once I finished my task of fixing the
slave interface, hopefully after next week.

I'd really love to see this go into v3.20, but this will need assistance. I
really need testers, at least for the recent hardware. Other comments/reviews
are also appreciated.

Patches are based on v3.19-rc3 and the branch is here

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks

Thanks,

   Wolfram


Wolfram Sang (11):
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

 drivers/i2c/busses/i2c-at91.c       | 32 ++++++++--------------
 drivers/i2c/busses/i2c-axxia.c      | 11 ++++----
 drivers/i2c/busses/i2c-cpm.c        | 20 +++++++-------
 drivers/i2c/busses/i2c-dln2.c       | 12 ++++-----
 drivers/i2c/busses/i2c-opal.c       | 22 +++++++--------
 drivers/i2c/busses/i2c-pmcmsp.c     | 42 +++++++++++------------------
 drivers/i2c/busses/i2c-powermac.c   | 10 +++----
 drivers/i2c/busses/i2c-qup.c        | 21 +++++++--------
 drivers/i2c/busses/i2c-viperboard.c | 10 ++++---
 drivers/i2c/i2c-core.c              | 53 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h                 | 35 ++++++++++++++++++++++++
 11 files changed, 167 insertions(+), 101 deletions(-)

-- 
2.1.3
