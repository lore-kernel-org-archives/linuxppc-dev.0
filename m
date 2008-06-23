Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8AF25DDF28
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 06:21:57 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5NKLs4J031512
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 16:21:54 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5NKLsMU120818
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 16:21:54 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5NKLr3G030410
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 16:21:54 -0400
Date: Mon, 23 Jun 2008 15:21:51 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Brian King <brking@linux.vnet.ibm.com>,
	Nathan Fontenot <nfont@austin.ibm.com>,
	David Darrington <ddarring@linux.vnet.ibm.com>
Subject: Re: [PATCH 16/19][v2] ibmveth: Automatically enable larger rx
	buffer pools for larger mtu
Message-ID: <20080623202150.GC31014@linux.vnet.ibm.com>
References: <20080612215312.GF30916@linux.vnet.ibm.com>
	<20080612222249.GX30916@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612222249.GX30916@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Santiago Leon <santil@us.ibm.com>

Fixed patch formatting.

Activates larger rx buffer pools when the MTU is changed to a larger
value.  This patch de-activates the large rx buffer pools when the MTU
changes to a smaller value.

Signed-off-by: Santiago Leon <santil@us.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

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
