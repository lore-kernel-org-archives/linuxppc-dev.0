Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 014B8DF14A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:34:28 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIYPpd015981
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:34:25 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIYOeK061108
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:34:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIYN2e029819
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:34:24 -0600
Date: Wed, 23 Jul 2008 13:34:23 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 12/16 v4] ibmveth: Automatically enable larger rx buffer
	pools for larger mtu
Message-ID: <20080723183423.GO12905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080723181932.GC12905@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Santiago Leon <santil@us.ibm.com>

Activates larger rx buffer pools when the MTU is changed to a larger
value.  This patch de-activates the large rx buffer pools when the MTU
changes to a smaller value.

Signed-off-by: Santiago Leon <santil@us.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
We would like to take this patch through linuxppc-dev with the full
change set for this feature.  We are copying netdev for review and ack.

---
 drivers/net/ibmveth.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

Index: b/drivers/net/ibmveth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/net/ibmveth.c
+++ b/drivers/net/ibmveth.c
@@ -1054,7 +1054,6 @@ static int ibmveth_change_mtu(struct net
 {
 	struct ibmveth_adapter *adapter =3D dev->priv;
 	int new_mtu_oh =3D new_mtu + IBMVETH_BUFF_OH;
-	int reinit =3D 0;
 	int i, rc;
=20
 	if (new_mtu < IBMVETH_MAX_MTU)
@@ -1067,15 +1066,21 @@ static int ibmveth_change_mtu(struct net
 	if (i =3D=3D IbmVethNumBufferPools)
 		return -EINVAL;
=20
+	/* Deactivate all the buffer pools so that the next loop can activate
+	   only the buffer pools necessary to hold the new MTU */
+	for (i =3D 0; i < IbmVethNumBufferPools; i++)
+		if (adapter->rx_buff_pool[i].active) {
+			ibmveth_free_buffer_pool(adapter,
+						 &adapter->rx_buff_pool[i]);
+			adapter->rx_buff_pool[i].active =3D 0;
+		}
+
 	/* Look for an active buffer pool that can hold the new MTU */
 	for(i =3D 0; i<IbmVethNumBufferPools; i++) {
-		if (!adapter->rx_buff_pool[i].active) {
-			adapter->rx_buff_pool[i].active =3D 1;
-			reinit =3D 1;
-		}
+		adapter->rx_buff_pool[i].active =3D 1;
=20
 		if (new_mtu_oh < adapter->rx_buff_pool[i].buff_size) {
-			if (reinit && netif_running(adapter->netdev)) {
+			if (netif_running(adapter->netdev)) {
 				adapter->pool_config =3D 1;
 				ibmveth_close(adapter->netdev);
 				adapter->pool_config =3D 0;
@@ -1402,14 +1407,15 @@ const char * buf, size_t count)
 				return -EPERM;
 			}
=20
-			pool->active =3D 0;
 			if (netif_running(netdev)) {
 				adapter->pool_config =3D 1;
 				ibmveth_close(netdev);
+				pool->active =3D 0;
 				adapter->pool_config =3D 0;
 				if ((rc =3D ibmveth_open(netdev)))
 					return rc;
 			}
+			pool->active =3D 0;
 		}
 	} else if (attr =3D=3D &veth_num_attr) {
 		if (value <=3D 0 || value > IBMVETH_MAX_POOL_COUNT)
