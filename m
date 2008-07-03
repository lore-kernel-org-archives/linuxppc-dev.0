Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 0F1B3DDE20
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 11:02:57 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so629166wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 18:02:56 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 0/5] SPI OF bindings and mpc5200-spi driver
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Date: Wed, 02 Jul 2008 19:02:52 -0600
Message-ID: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
Cc: david-b@pacbell.net, fabrizio.garetto@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think I've addressed all the comments I've received.  This series
adds OpenFirmware device tree bindings for SPI devices.  SPI master
drivers which make use of of_spi.c can retrieve the set of spi
devices from the device tree and automatically create them.

This series depends on previously posted patch:
"spi: Change modalias from a pointer to a character array"

 Documentation/powerpc/booting-without-of.txt |   60 +++
 drivers/of/Kconfig                           |    6 +
 drivers/of/Makefile                          |    1 +
 drivers/of/of_spi.c                          |   88 ++++
 drivers/spi/Kconfig                          |    8 +
 drivers/spi/Makefile                         |    1 +
 drivers/spi/mpc52xx_spi.c                    |  595 ++++++++++++++++++++++++++
 drivers/spi/spi.c                            |  141 +++++--
 include/linux/of_spi.h                       |   18 +
 include/linux/spi/mpc52xx_spi.h              |   10 +
 include/linux/spi/spi.h                      |   12 +-
 11 files changed, 895 insertions(+), 45 deletions(-)

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
