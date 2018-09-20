Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GGkt5mBRzF3Km
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 22:49:10 +1000 (AEST)
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dmitry.tarnyagin@lockless.no>,
 <wg@grandegger.com>, <mkl@pengutronix.de>, <michal.simek@xilinx.com>,
 <hsweeten@visionengravers.com>, <madalin.bucur@nxp.com>,
 <pantelis.antoniou@gmail.com>, <claudiu.manoil@nxp.com>,
 <leoyang.li@nxp.com>, <linux@armlinux.org.uk>, <sammy@sammy.net>,
 <ralf@linux-mips.org>, <nico@fluxnic.net>, <steve.glendinning@shawell.net>,
 <f.fainelli@gmail.com>, <grygorii.strashko@ti.com>, <w-kwok2@ti.com>,
 <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>, <jreuter@yaina.de>,
 <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu2@citrix.com>,
 <paul.durrant@citrix.com>, <arvid.brodin@alten.se>, <pshelar@ovn.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-can@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
 <linux-omap@vger.kernel.org>, <linux-hams@vger.kernel.org>,
 <devel@linuxdriverproject.org>, <linux-usb@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <dev@openvswitch.org>, YueHaibing
 <yuehaibing@huawei.com>
Subject: [PATCH net-next 22/22] net: hsr: fix return type of ndo_start_xmit
 function
Date: Thu, 20 Sep 2018 20:33:06 +0800
Message-ID: <20180920123306.14772-23-yuehaibing@huawei.com>
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/hsr/hsr_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index b8cd43c..a067150 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -233,7 +233,7 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
 }
 
 
-static int hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct hsr_priv *hsr = netdev_priv(dev);
 	struct hsr_port *master;
-- 
1.8.3.1
