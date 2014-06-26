Return-Path: <vincent.yang.fujitsu@gmail.com>
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 667381A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:23:42 +1000 (EST)
Received: by mail-pb0-f45.google.com with SMTP id rr13so2713872pbb.18
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 23:23:39 -0700 (PDT)
From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
To: chris@printf.net,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH v2 0/6] mmc: sdhci: adding support for a new Fujitsu sdhci
 IP
Date: Thu, 26 Jun 2014 14:23:26 +0800
Message-Id: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Cc: devicetree@vger.kernel.org, andy.green@linaro.org, patches@linaro.org,
 anton@enomsg.org, Vincent.Yang@tw.fujitsu.com, jaswinder.singh@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
We are adding support for a new Fujitsu sdhci IP.

These patches are against v3.16-rc1 mainline since nothing in
mmc-next at this moment.

These patches are tested on 3.16-rc1 integration tree.

We welcome any comment and advice about how to make any
improvements or better align them with upstream.

Changes from v1:
- Add sufficient description in DT binding ducument
- Remove one patch "mmc: sdhci: add quirk for broken 3.0V support" and use
  voltage-ranges = <> in the device tree instead

Thanks a lot!

Best regards,
Vincent Yang


Vincent Yang (6):
  mmc: sdhci: add quirk for voltage switch callback
  mmc: sdhci: add quirk for tuning work around
  mmc: sdhci: add quirk for single block transactions
  mmc: sdhci: host: add new f_sdh30
  mmc: core: hold SD Clock before CMD11 during Signal Voltage Switch
    Procedure
  mmc: core: add manual resume capability

 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  35 ++
 drivers/mmc/core/core.c                            |   8 +-
 drivers/mmc/core/sd.c                              |   4 +
 drivers/mmc/host/Kconfig                           |   7 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci.c                           |  15 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 435 +++++++++++++++++++++
 drivers/mmc/host/sdhci_f_sdh30.h                   |  40 ++
 include/linux/mmc/host.h                           |  14 +
 include/linux/mmc/sdhci.h                          |   6 +
 11 files changed, 561 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h

-- 
1.9.0
