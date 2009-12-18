Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15]) by ozlabs.org (Postfix) with ESMTP id 4A1221007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Dec 2009 06:20:45 +1100 (EST)
Message-ID: <4B2BD5C4.6050001@am.sony.com>
Date: Fri, 18 Dec 2009 11:19:32 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3] ps3_gelic_wireless: Fix build failure due to missing
	WEXT_PRIV
References: <1261115574.2173.18.camel@pasglop>
In-Reply-To: <1261115574.2173.18.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The option to support the old style PSK interface in the PS3
GELIC wireless drivers requires CONFIG_WEXT_PRIV to be set

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
v2: Added 'depends on WLAN'.
v3: Moved 'depends on WLAN' to GELIC_WIRELESS.

Please send to Linus asap (or I can put it in powerpc.git) as it's
breaking one of my test build configs :-)

---
 drivers/net/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2346,6 +2346,7 @@ config GELIC_NET
 
 config GELIC_WIRELESS
 	bool "PS3 Wireless support"
+	depends on WLAN
 	depends on GELIC_NET
 	select WIRELESS_EXT
 	help
@@ -2358,6 +2359,7 @@ config GELIC_WIRELESS
 config GELIC_WIRELESS_OLD_PSK_INTERFACE
        bool "PS3 Wireless private PSK interface (OBSOLETE)"
        depends on GELIC_WIRELESS
+       select WEXT_PRIV
        help
           This option retains the obsolete private interface to pass
           the PSK from user space programs to the driver.  The PSK
