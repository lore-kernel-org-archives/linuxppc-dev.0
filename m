Return-Path: <libo.chen@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AA742C0144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 23:31:31 +1000 (EST)
Message-ID: <5208E20A.4010306@huawei.com>
Date: Mon, 12 Aug 2013 21:24:26 +0800
From: Libo Chen <clbchenlibo.chen@huawei.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: use platform_{get,set}_drvdata()
Content-Type: text/plain; charset="ISO-8859-1"
Cc: mugunthanvnm@ti.com, Bill Pemberton <wfp5p@virginia.edu>,
 Greg KH <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 bigeasy@linutronix.de, jg1.han@samsung.com,
 LKML <linux-kernel@vger.kernel.org>, michal.simek@xilinx.com,
 prabhakar.csengg@gmail.com, Li Zefan <lizefan@huawei.com>,
 vbordug@ru.mvista.com, renner@efe-gmbh.de, linuxppc-dev@lists.ozlabs.org,
 timur@freescale.com, b-liu@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.


Libo Chen (8):
  net: fsl_pq_mdio: use platform_{get,set}_drvdata()
  net: ucc_geth: use platform_{get,set}_drvdata()
  net: fec_mpc52xx_phy: use platform_{get,set}_drvdata()
  net: fs_enet: use platform_{get,set}_drvdata()
  net: sunbmac: use platform_{get,set}_drvdata()
  net: sunhme: use platform_{get,set}_drvdata()
  net: xilinx_emaclite: use platform_{get,set}_drvdata()
  net: davinci_mdio: use platform_{get,set}_drvdata()

 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c   |    4 +---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c  |    1 -
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |    3 +--
 drivers/net/ethernet/freescale/ucc_geth.c          |    4 +---
 drivers/net/ethernet/sun/sunbmac.c                 |    3 +--
 drivers/net/ethernet/sun/sunhme.c                  |    8 +++-----
 drivers/net/ethernet/ti/davinci_mdio.c             |    4 +---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |    4 +---
 8 files changed, 9 insertions(+), 22 deletions(-)
