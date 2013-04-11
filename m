Return-Path: <sebastian.hesselbarth@gmail.com>
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 0/2] net: mv643xx_eth: use managed clk and allocation
Date: Thu, 11 Apr 2013 11:29:32 +0200
Message-Id: <1365672574-31123-1-git-send-email-sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Florian Fainelli <florian@openwrt.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With introduction of common clock framework and the ability to provide
gated clocks, mv643xx_eth required calls to get and enable these clock
gates on some platforms. Back then, common clock framework api wasn't
safe for architectures without support for common clocks. This has
changed now and there are also managed (devm_) counterparts for clock
related functions.

The second patch in this series, also converts kzalloc to devm_kzalloc
where applicable.

Both patches have been sent to the corresponding mailing lists as
individual patches before. To get the order required to apply them right,
this patch set combines both patches into one set.

Sebastian Hesselbarth (2):
  net: mv643xx_eth: add shared clk and cleanup existing clk handling
  net: mv643xx_eth: use managed devm_kzalloc

 Documentation/devicetree/bindings/marvell.txt |    3 ++
 drivers/net/ethernet/marvell/mv643xx_eth.c    |   44 +++++++++----------------
 2 files changed, 18 insertions(+), 29 deletions(-)

---
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
-- 
1.7.10.4
