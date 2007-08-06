Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1569BDDE09
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 21:55:50 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l76Bthhr424144
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 11:55:43 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l76BthFI2785474
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 12:55:43 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l76BtQuE002146
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 12:55:26 +0100
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [RESEND][PATCH 2/3] ehea: Simplify resource usage check
Date: Mon, 6 Aug 2007 13:55:14 +0200
MIME-Version: 1.0
Message-Id: <200708061355.15180.osstklei@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use shorter method to determine whether adapter has configured ports

Signed-off-by: Thomas Klein <tklein@de.ibm.com>

---
 drivers/net/ehea/ehea_main.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index d43ab0f..36ca322 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2165,24 +2165,18 @@ static int ehea_clean_all_portres(struct ehea_port *port)
 	return ret;
 }
 
-static void ehea_remove_adapter_mr (struct ehea_adapter *adapter)
+static void ehea_remove_adapter_mr(struct ehea_adapter *adapter)
 {
-	int i;
-
-	for (i=0; i < EHEA_MAX_PORTS; i++)
-		if (adapter->port[i])
-			return;
+	if (adapter->active_ports)
+		return;
 
 	ehea_rem_mr(&adapter->mr);
 }
 
-static int ehea_add_adapter_mr (struct ehea_adapter *adapter)
+static int ehea_add_adapter_mr(struct ehea_adapter *adapter)
 {
-	int i;
-
-	for (i=0; i < EHEA_MAX_PORTS; i++)
-		if (adapter->port[i])
-			return 0;
+	if (adapter->active_ports)
+		return 0;
 
 	return ehea_reg_kernel_mr(adapter, &adapter->mr);
 }
-- 
1.5.2
