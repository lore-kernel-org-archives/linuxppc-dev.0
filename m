Return-Path: <libo.chen@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA4E42C017B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 13:37:01 +1000 (EST)
Message-ID: <520AFB3F.2090006@huawei.com>
Date: Wed, 14 Aug 2013 11:36:31 +0800
From: Libo Chen <clbchenlibo.chen@huawei.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: [PATCH RESEND 0/8] use platform_{get,set}_drvdata()
References: <5208E20A.4010306@huawei.com>
In-Reply-To: <5208E20A.4010306@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Greg KH <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 jg1.han@samsung.com, LKML <linux-kernel@vger.kernel.org>,
 Li Zefan <lizefan@huawei.com>, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We can use the wrapper functions platform_{get,set}_drvdata() instead of
dev_{get,set}_drvdata() with &pdev->dev, it is convenient for user.

Also, unnecessary dev_set_drvdata() is removed, because the driver core
clears the driver data to NULL after device_release or on probe failure.

changelog:
	this version add modify record about dev_set_drvdata().

Libo Chen (8):
  net: fsl_pq_mdio: use platform_{get,set}_drvdata()
  net: ucc_geth: use platform_{get,set}_drvdata()
  net: fec_mpc52xx_phy: use platform_{get,set}_drvdata()
  net: fs_enet: remove unnecessary dev_set_drvdata()
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
