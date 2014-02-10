Return-Path: <shuah.kh@samsung.com>
Received: from qmta13.emeryville.ca.mail.comcast.net
 (qmta13.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:44:76:96:27:243])
 by ozlabs.org (Postfix) with ESMTP id C660B2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 03:21:02 +1100 (EST)
From: Shuah Khan <shuah.kh@samsung.com>
To: rjw@rjwysocki.net
Subject: [RFT][PATCH 00/12] change drivers power management to use dev_pm_ops 
Date: Mon, 10 Feb 2014 09:12:23 -0700
Message-Id: <cover.1392040064.git.shuah.kh@samsung.com>
Cc: Shuah Khan <shuah.kh@samsung.com>, heiko.carstens@de.ibm.com,
 chris@printf.net, shuahkhan@gmail.com, dwalker@fifo99.com,
 ingo.tuchscherer@de.ibm.com, sonic.zhang@analog.com,
 linux-s390@vger.kernel.org, linux@arm.linux.org.uk, davidb@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pcmcia@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net,
 mirq-linux@rere.qmqm.pl, ian@mnementh.co.uk, manuel.lauss@gmail.com,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 schwidefsky@de.ibm.com, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change drivers to register pm ops using dev_pm_ops instead of legacy pm_ops.
.pm hooks call existing legacy suspend and resume interfaces by passing in
the right pm state. Bus drivers suspend and resume routines call .pm driver
hooks if found.

Shuah Khan (12):
  arm: change locomo platform and bus power management to use
    dev_pm_ops
  arm: change sa1111 platform and bus power management to use
    dev_pm_ops
  arm: change scoop platform power management to use dev_pm_ops
  drivers/macintosh/adb: change platform power managemnet to use
    dev_pm_ops
  mmc: change au1xmmc platform power management to use dev_pm_ops
  mmc: change bfin_sdh platform power management to use dev_pm_ops
  isa: change isa bus power managemnet to use dev_pm_ops
  mmc: change cb710-mmc platform power management to use dev_pm_ops
  mmc: change msm_sdcc platform power management to use dev_pm_ops
  mmc: change tmio_mmc platform power management to use dev_pm_ops
  drivers/pcmcia: change ds driver power management to use dev_pm_ops
  drivers/s390/crypto: change ap_bus driver power management to use
    dev_pm_ops

 arch/arm/common/locomo.c     |   93 +++++++++++++++++++++++++++++++++++-------
 arch/arm/common/sa1111.c     |   88 +++++++++++++++++++++++++++++++--------
 arch/arm/common/scoop.c      |   44 ++++++++++++++++----
 drivers/base/isa.c           |   30 ++++++++++++--
 drivers/macintosh/adb.c      |   41 ++++++++++++++++---
 drivers/mmc/host/au1xmmc.c   |   43 +++++++++++++++----
 drivers/mmc/host/bfin_sdh.c  |   40 +++++++++++++++---
 drivers/mmc/host/cb710-mmc.c |   37 +++++++++++++++--
 drivers/mmc/host/msm_sdcc.c  |   42 +++++++++++++++----
 drivers/mmc/host/tmio_mmc.c  |   42 +++++++++++++++----
 drivers/pcmcia/ds.c          |   36 +++++++++++++---
 drivers/s390/crypto/ap_bus.c |   30 ++++++++++++--
 12 files changed, 481 insertions(+), 85 deletions(-)

-- 
1.7.10.4
