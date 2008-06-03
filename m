Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 24A8DDDEC6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 08:31:58 +1000 (EST)
Date: Tue, 3 Jun 2008 17:31:28 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2/2] ehea: remove dependency on MEMORY_HOTPLUG
Message-ID: <20080603223128.GD7475@localdomain>
References: <200805071443.20192.hannes.hering@linux.vnet.ibm.com>
	<20080528164405.GA4836@localdomain>
	<200806031007.40162.hannes.hering@linux.vnet.ibm.com>
	<20080603204908.GB7475@localdomain>
	<1212527335.23656.2.camel@badari-desktop>
	<4845B382.20205@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4845B382.20205@garzik.org>
Cc: tklein@de.ibm.com, themann@de.ibm.com,
	Hannes Hering <hannes.hering@linux.vnet.ibm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Badari Pulavarty <pbadari@us.ibm.com>,
	ossthema@de.ibm.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that walk_memory_resource() is available regardless of
MEMORY_HOTPLUG's setting, this dependency is not needed.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 drivers/net/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index dd0ec9e..f4182cf 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2426,7 +2426,7 @@ config CHELSIO_T3
 
 config EHEA
 	tristate "eHEA Ethernet support"
-	depends on IBMEBUS && INET && SPARSEMEM && MEMORY_HOTPLUG
+	depends on IBMEBUS && INET && SPARSEMEM
 	select INET_LRO
 	---help---
 	  This driver supports the IBM pSeries eHEA ethernet adapter.
-- 
1.5.5
