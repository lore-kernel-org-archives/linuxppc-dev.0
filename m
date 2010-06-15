Return-Path: <richardcochran@gmail.com>
Date: Tue, 15 Jun 2010 18:08:06 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH 03/12] phylib: add a driver method for the SIOCSHWTSTAMP ioctl.
Message-ID: <77fe18d640e35dcbfad1e117a4321f935500d5ac.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1276615626.git.richard.cochran@omicron.at>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a phy driver method for configuring hardware time stamping.
Drivers may optionally implement this function.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 drivers/net/phy/phy.c |    5 +++++
 include/linux/phy.h   |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index bd88d81..5130db8 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -361,6 +361,11 @@ int phy_mii_ioctl(struct phy_device *phydev,
 		}
 		break;
 
+	case SIOCSHWTSTAMP:
+		if (phydev->drv->hwtstamp)
+			return phydev->drv->hwtstamp(phydev, ifr);
+		/* fall through */
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index d63736a..a5e9df1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -402,6 +402,9 @@ struct phy_driver {
 	/* Clears up any memory if needed */
 	void (*remove)(struct phy_device *phydev);
 
+	/* Handles SIOCSHWTSTAMP ioctl for hardware time stamping. */
+	int (*hwtstamp)(struct phy_device *phydev, struct ifreq *ifr);
+
 	struct device_driver driver;
 };
 #define to_phy_driver(d) container_of(d, struct phy_driver, driver)
-- 
1.6.3.3
