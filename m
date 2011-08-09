Return-Path: <mylinux@udp143655uds.ap.freescale.net>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23960B6F82
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2011 12:16:36 +1000 (EST)
From: Liu Gang <b34182@freescale.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] rio: Use discovered bit to test if enumeration is complete
Date: Tue, 9 Aug 2011 10:17:06 +0800
Message-ID: <1312856226-3695-1-git-send-email-b34182@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r58472@freescale.com, Liu Gang <b34182@freescale.com>, r61911@freescale.com,
	linuxppc-dev@ozlabs.org, Liu Gang <Gang.Liu@freescale.com>,
	akpm@linux-foundation.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The discovered bit in PGCCSR register indicates if the device has
been discovered by system host. In Rapidio system, some agent devices
can also be master devices. They can issue requests into the system.

Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
---
 drivers/rapidio/rio-scan.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index ee89358..2dac1f0 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -924,7 +924,7 @@ static int __devinit rio_enum_peer(struct rio_net *net, struct rio_mport *port,
  * rio_enum_complete- Tests if enumeration of a network is complete
  * @port: Master port to send transaction
  *
- * Tests the Component Tag CSR for non-zero value (enumeration
+ * Tests the PGCCSR discovered bit for non-zero value (enumeration
  * complete flag). Return %1 if enumeration is complete or %0 if
  * enumeration is incomplete.
  */
@@ -934,7 +934,7 @@ static int rio_enum_complete(struct rio_mport *port)
 
 	rio_local_read_config_32(port, port->phys_efptr + RIO_PORT_GEN_CTL_CSR,
 				 &regval);
-	return (regval & RIO_PORT_GEN_MASTER) ? 1 : 0;
+	return (regval & RIO_PORT_GEN_DISCOVERED) ? 1 : 0;
 }
 
 /**
-- 
1.7.3.1
