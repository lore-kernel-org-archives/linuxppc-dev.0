Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A0BCDDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:53:22 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7MErHpE163028
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 14:53:17 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7MErH5k2322460
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 16:53:17 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7MErHK7015107
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 16:53:17 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 1/4] ehea: fix interface to DLPAR tools
Date: Wed, 22 Aug 2007 16:20:58 +0200
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708221620.59078.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Userspace DLPAR tool expects decimal numbers to be written to
and read from sysfs entries.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>


---
 drivers/net/ehea/ehea_main.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 9756211..22d000f 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2490,7 +2490,7 @@ static ssize_t ehea_show_port_id(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct ehea_port *port = container_of(dev, struct ehea_port, ofdev.dev);
-	return sprintf(buf, "0x%X", port->logical_port_id);
+	return sprintf(buf, "%d", port->logical_port_id);
 }
 
 static DEVICE_ATTR(log_port_id, S_IRUSR | S_IRGRP | S_IROTH, ehea_show_port_id,
@@ -2781,7 +2781,7 @@ static ssize_t ehea_probe_port(struct device *dev,
 
 	u32 logical_port_id;
 
-	sscanf(buf, "%X", &logical_port_id);
+	sscanf(buf, "%d", &logical_port_id);
 
 	port = ehea_get_port(adapter, logical_port_id);
 
@@ -2834,7 +2834,7 @@ static ssize_t ehea_remove_port(struct device *dev,
 	int i;
 	u32 logical_port_id;
 
-	sscanf(buf, "%X", &logical_port_id);
+	sscanf(buf, "%d", &logical_port_id);
 
 	port = ehea_get_port(adapter, logical_port_id);
 
-- 
1.5.2
