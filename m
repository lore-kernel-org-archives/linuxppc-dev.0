Return-Path: <vincent.yang.fujitsu@gmail.com>
Received: from mail-pb0-x22b.google.com (mail-pb0-x22b.google.com
 [IPv6:2607:f8b0:400e:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C47F1A0006
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 19:35:38 +1000 (EST)
Received: by mail-pb0-f43.google.com with SMTP id um1so2684476pbc.16
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 02:35:34 -0700 (PDT)
From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
To: chris@printf.net,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH 0/7] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Fri, 20 Jun 2014 17:35:21 +0800
Message-Id: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Cc: andy.green@linaro.org, anton@enomsg.org, linuxppc-dev@lists.ozlabs.org,
 Vincent.Yang@tw.fujitsu.com, patches@linaro.org
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

Thanks a lot!


Best regards,
Vincent Yang


Vincent Yang (7):
  mmc: sdhci: add quirk for broken 3.0V support
  mmc: sdhci: add quirk for voltage switch callback
  mmc: sdhci: add quirk for tuning work around
  mmc: sdhci: add quirk for single block transactions
  mmc: sdhci: host: add new f_sdh30
  mmc: core: hold SD Clock before CMD11 during Signal Voltage Switch
    Procedure
  mmc: core: add manual resume capability

 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  25 ++
 drivers/mmc/core/core.c                            |   8 +-
 drivers/mmc/core/sd.c                              |   4 +
 drivers/mmc/host/Kconfig                           |   7 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci.c                           |  18 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 429 +++++++++++++++++++++
 drivers/mmc/host/sdhci_f_sdh30.h                   |  40 ++
 include/linux/mmc/host.h                           |  14 +
 include/linux/mmc/sdhci.h                          |   8 +
 11 files changed, 550 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h

-- 
1.9.0
