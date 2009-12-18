Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 578801007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Dec 2009 05:24:56 +1100 (EST)
Message-ID: <4B2BC8E6.9090007@am.sony.com>
Date: Fri, 18 Dec 2009 10:24:38 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH v2] ps3_gelic_wireless: Fix build failure due to missing
	WEXT_PRIV
References: <1261115574.2173.18.camel@pasglop>
	<20091218085547.fb8bdaf5.randy.dunlap@oracle.com>
In-Reply-To: <20091218085547.fb8bdaf5.randy.dunlap@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Hamish Guthrie <Hamish.Guthrie@sonycom.com>
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

Please send to Linus asap (or I can put it in powerpc.git) as it's
breaking one of my test build configs :-)

Just as a note, I asked Hamish to work to remove this option.
No distros use it anymore, so we don't need it.

-Geoff
---
 drivers/net/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2357,7 +2357,9 @@ config GELIC_WIRELESS
 
 config GELIC_WIRELESS_OLD_PSK_INTERFACE
        bool "PS3 Wireless private PSK interface (OBSOLETE)"
+       depends on WLAN
        depends on GELIC_WIRELESS
+       select WEXT_PRIV
        help
           This option retains the obsolete private interface to pass
           the PSK from user space programs to the driver.  The PSK
