Return-Path: <pegasos@frokaschwei.de>
Received: from frokaschwei.de (frokaschwei.de [213.203.244.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CDCF689F5
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 23:58:48 +1100 (EST)
From: Wolfram Joost <pegasos@frokaschwei.de>
To: linuxppc-dev@ozlabs.org
Date: Thu, 12 Jan 2006 13:29:11 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XukxDvfUaCFiVxy"
Message-Id: <200601121329.11693@mail.frokaschwei.de>
Subject: mv643xx_eth.c: Multicast and IPv6 support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_XukxDvfUaCFiVxy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

currently, the driver mv643xx_eth.c doesn't support receiving of multicast and 
sending of IPv6 packets.
I found a piece of code in the u-boot bootloader which supports multicast 
receiving and did some cut and paste. Now receiving multicast packets works 
for me.
To be able to send IPv6 packets I had to remove the NETIF_F_HW_CSUM flag. 
Hardware checksumming for IPv4 should continue to work because of the 
NETIF_F_IP_CSUM flag.

I attach a diff against 2.6.15.

Does anyone know how to get documentation for the marvell mv643xx-family?

Regards
 Wolfram

--Boundary-00=_XukxDvfUaCFiVxy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mv643xx_eth.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mv643xx_eth.c.diff"

diff -Naurp linux-2.6.15/drivers/net/mv643xx_eth.c linux-2.6.15.patched/drivers/net/mv643xx_eth.c
--- linux-2.6.15/drivers/net/mv643xx_eth.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.patched/drivers/net/mv643xx_eth.c	2006-01-11 19:57:42.000000000 +0100
@@ -89,6 +89,7 @@ static int mv643xx_poll(struct net_devic
 static void ethernet_phy_set(unsigned int eth_port_num, int phy_addr);
 static int ethernet_phy_detect(unsigned int eth_port_num);
 static struct ethtool_ops mv643xx_ethtool_ops;
+static u8 mv643xx_eth_calc_mc_hash(u8 *addr);
 
 static char mv643xx_driver_name[] = "mv643xx_eth";
 static char mv643xx_driver_version[] = "1.0";
@@ -250,9 +251,115 @@ static void mv643xx_eth_update_mac_addre
 }
 
 /*
+ * mv643xx_eth_calc_mc_hash
+ *
+ * calculate multicast hash
+ *
+ * Input : pointer to mac address
+ * Output : hash value
+ */
+static u8 mv643xx_eth_calc_mc_hash(u8 *p_addr)
+{
+	unsigned mac_h;
+	unsigned mac_l;
+	u8 crc_result = 0;
+	unsigned mac_array[48];
+	unsigned crc[8];
+	unsigned i;
+
+	/* Calculate CRC-8 out of the given address */
+	mac_h = (p_addr[0] << 8) | (p_addr[1]);
+	mac_l = (p_addr[2] << 24) | (p_addr[3] << 16) |
+		(p_addr[4] << 8) | (p_addr[5] << 0);
+
+	for (i = 0; i < 32; i++)
+		mac_array[i] = (mac_l >> i) & 0x1;
+	for (i = 32; i < 48; i++)
+		mac_array[i] = (mac_h >> (i - 32)) & 0x1;
+
+
+	crc[0] = mac_array[45] ^ mac_array[43] ^ mac_array[40] ^
+		mac_array[39] ^ mac_array[35] ^ mac_array[34] ^
+		mac_array[31] ^ mac_array[30] ^ mac_array[28] ^
+		mac_array[23] ^ mac_array[21] ^ mac_array[19] ^
+		mac_array[18] ^ mac_array[16] ^ mac_array[14] ^
+		mac_array[12] ^ mac_array[8] ^ mac_array[7] ^
+		mac_array[6] ^ mac_array[0];
+
+	crc[1] = mac_array[46] ^ mac_array[45] ^ mac_array[44] ^
+		mac_array[43] ^ mac_array[41] ^ mac_array[39] ^
+		mac_array[36] ^ mac_array[34] ^ mac_array[32] ^
+		mac_array[30] ^ mac_array[29] ^ mac_array[28] ^
+		mac_array[24] ^ mac_array[23] ^ mac_array[22] ^
+		mac_array[21] ^ mac_array[20] ^ mac_array[18] ^
+		mac_array[17] ^ mac_array[16] ^ mac_array[15] ^
+		mac_array[14] ^ mac_array[13] ^ mac_array[12] ^
+		mac_array[9] ^ mac_array[6] ^ mac_array[1] ^
+		mac_array[0];
+
+	crc[2] = mac_array[47] ^ mac_array[46] ^ mac_array[44] ^
+		mac_array[43] ^ mac_array[42] ^ mac_array[39] ^
+		mac_array[37] ^ mac_array[34] ^ mac_array[33] ^
+		mac_array[29] ^ mac_array[28] ^ mac_array[25] ^
+		mac_array[24] ^ mac_array[22] ^ mac_array[17] ^
+		mac_array[15] ^ mac_array[13] ^ mac_array[12] ^
+		mac_array[10] ^ mac_array[8] ^ mac_array[6] ^
+		mac_array[2] ^ mac_array[1] ^ mac_array[0];
+
+	crc[3] = mac_array[47] ^ mac_array[45] ^ mac_array[44] ^
+		mac_array[43] ^ mac_array[40] ^ mac_array[38] ^
+		mac_array[35] ^ mac_array[34] ^ mac_array[30] ^
+		mac_array[29] ^ mac_array[26] ^ mac_array[25] ^
+		mac_array[23] ^ mac_array[18] ^ mac_array[16] ^
+		mac_array[14] ^ mac_array[13] ^ mac_array[11] ^
+		mac_array[9] ^ mac_array[7] ^ mac_array[3] ^
+		mac_array[2] ^ mac_array[1];
+
+	crc[4] = mac_array[46] ^ mac_array[45] ^ mac_array[44] ^
+		mac_array[41] ^ mac_array[39] ^ mac_array[36] ^
+		mac_array[35] ^ mac_array[31] ^ mac_array[30] ^
+		mac_array[27] ^ mac_array[26] ^ mac_array[24] ^
+		mac_array[19] ^ mac_array[17] ^ mac_array[15] ^
+		mac_array[14] ^ mac_array[12] ^ mac_array[10] ^
+		mac_array[8] ^ mac_array[4] ^ mac_array[3] ^
+		mac_array[2];
+
+	crc[5] = mac_array[47] ^ mac_array[46] ^ mac_array[45] ^
+		mac_array[42] ^ mac_array[40] ^ mac_array[37] ^
+		mac_array[36] ^ mac_array[32] ^ mac_array[31] ^
+		mac_array[28] ^ mac_array[27] ^ mac_array[25] ^
+		mac_array[20] ^ mac_array[18] ^ mac_array[16] ^
+		mac_array[15] ^ mac_array[13] ^ mac_array[11] ^
+		mac_array[9] ^ mac_array[5] ^ mac_array[4] ^
+		mac_array[3];
+
+	crc[6] = mac_array[47] ^ mac_array[46] ^ mac_array[43] ^
+		mac_array[41] ^ mac_array[38] ^ mac_array[37] ^
+		mac_array[33] ^ mac_array[32] ^ mac_array[29] ^
+		mac_array[28] ^ mac_array[26] ^ mac_array[21] ^
+		mac_array[19] ^ mac_array[17] ^ mac_array[16] ^
+		mac_array[14] ^ mac_array[12] ^ mac_array[10] ^
+		mac_array[6] ^ mac_array[5] ^ mac_array[4];
+
+	crc[7] = mac_array[47] ^ mac_array[44] ^ mac_array[42] ^
+		mac_array[39] ^ mac_array[38] ^ mac_array[34] ^
+		mac_array[33] ^ mac_array[30] ^ mac_array[29] ^
+		mac_array[27] ^ mac_array[22] ^ mac_array[20] ^
+		mac_array[18] ^ mac_array[17] ^ mac_array[15] ^
+		mac_array[13] ^ mac_array[11] ^ mac_array[7] ^
+		mac_array[6] ^ mac_array[5];
+
+	for (i = 0; i < 8; i++)
+		crc_result = crc_result | (crc[i] << i);
+
+	return crc_result;
+}
+
+/*
  * mv643xx_eth_set_rx_mode
  *
  * Change from promiscuos to regular rx mode
+ * maintain multicast tables
  *
  * Input :	pointer to ethernet interface network device structure
  * Output :	N/A
@@ -260,13 +367,64 @@ static void mv643xx_eth_update_mac_addre
 static void mv643xx_eth_set_rx_mode(struct net_device *dev)
 {
 	struct mv643xx_private *mp = netdev_priv(dev);
+	struct dev_mc_list *mc_list = dev->mc_list;
+	u32 multicast_table[64];
+	unsigned table_index;
+	unsigned reg_index;
 
+	/* promiscuous mode */
 	if (dev->flags & IFF_PROMISC)
 		mp->port_config |= (u32) MV643XX_ETH_UNICAST_PROMISCUOUS_MODE;
 	else
 		mp->port_config &= ~(u32) MV643XX_ETH_UNICAST_PROMISCUOUS_MODE;
 
 	mv_write(MV643XX_ETH_PORT_CONFIG_REG(mp->port_num), mp->port_config);
+
+	/* multicast */
+	if (dev->flags & IFF_ALLMULTI) {
+		for (table_index = 0; table_index <= 0xFC; table_index += 4) {
+			printk(KERN_INFO "IFF_ALLMULTI!\n");
+			mv_write((MV643XX_ETH_DA_FILTER_SPECIAL_MULTICAST_TABLE_BASE(mp->port_num) +
+				  table_index), 0x01010101);
+			mv_write((MV643XX_ETH_DA_FILTER_OTHER_MULTICAST_TABLE_BASE(mp->port_num) +
+				  table_index), 0x01010101);
+		}
+	} else {
+		/* special multicast table */
+		memset(multicast_table,0,sizeof(multicast_table));
+		for (mc_list = dev->mc_list; mc_list; mc_list = mc_list->next) {
+			if ( (mc_list->dmi_addr[0] == 0x01) &&
+				 (mc_list->dmi_addr[1] == 0x00) &&
+				 (mc_list->dmi_addr[2] == 0x5E) &&
+				 (mc_list->dmi_addr[3] == 0x00) &&
+				 (mc_list->dmi_addr[4] == 0x00) ) {
+
+				table_index = mc_list->dmi_addr[5] / 4;
+				reg_index = 8 * ( mc_list->dmi_addr[5] & 0x03 );
+				multicast_table[table_index] |= 0x01 << reg_index;
+			}
+		}
+		for (table_index = 0; table_index <=0xFC; table_index +=4)
+				mv_write((MV643XX_ETH_DA_FILTER_SPECIAL_MULTICAST_TABLE_BASE(mp->port_num) +
+						  table_index), multicast_table[table_index / 4]);
+		/* other multicast table */
+		memset(multicast_table,0,sizeof(multicast_table));
+		for (mc_list = dev->mc_list; mc_list; mc_list = mc_list->next) {
+			if ( (mc_list->dmi_addr[0] != 0x01) ||
+				 (mc_list->dmi_addr[1] != 0x00) ||
+				 (mc_list->dmi_addr[2] != 0x5E) ||
+				 (mc_list->dmi_addr[3] != 0x00) ||
+				 (mc_list->dmi_addr[4] != 0x00) ) {
+
+				table_index = mv643xx_eth_calc_mc_hash(mc_list->dmi_addr);
+				reg_index = 8 * (table_index & 0x03);
+				multicast_table[table_index / 4] |= 0x01 << reg_index;
+			}
+		}
+		for (table_index = 0; table_index <=0xFC; table_index +=4)
+				mv_write((MV643XX_ETH_DA_FILTER_OTHER_MULTICAST_TABLE_BASE(mp->port_num) +
+						  table_index), multicast_table[table_index / 4]);
+	}
 }
 
 /*
@@ -1150,7 +1308,6 @@ linear:
 					   5 << ETH_TX_IHL_SHIFT;
 			pkt_info.l4i_chk = 0;
 		} else {
-
 			pkt_info.cmd_sts = ETH_TX_ENABLE_INTERRUPT |
 					   ETH_TX_FIRST_DESC |
 					   ETH_TX_LAST_DESC |
@@ -1158,14 +1315,16 @@ linear:
 					   ETH_GEN_IP_V_4_CHECKSUM |
 					   skb->nh.iph->ihl << ETH_TX_IHL_SHIFT;
 			/* CPU already calculated pseudo header checksum. */
-			if (skb->nh.iph->protocol == IPPROTO_UDP) {
+			if ( (skb->protocol == ETH_P_IP) &&
+				 (skb->nh.iph->protocol == IPPROTO_UDP) ) {
 				pkt_info.cmd_sts |= ETH_UDP_FRAME;
 				pkt_info.l4i_chk = skb->h.uh->check;
-			} else if (skb->nh.iph->protocol == IPPROTO_TCP)
+			} else if ( (skb->protocol == ETH_P_IP) &&
+				 (skb->nh.iph->protocol == IPPROTO_TCP) )
 				pkt_info.l4i_chk = skb->h.th->check;
 			else {
 				printk(KERN_ERR
-					"%s: chksum proto != TCP or UDP\n",
+					"%s: chksum proto != IPv4 TCP or UDP\n",
 					dev->name);
 				spin_unlock_irqrestore(&mp->lock, flags);
 				return 1;
@@ -1221,14 +1380,19 @@ linear:
 					   ETH_GEN_IP_V_4_CHECKSUM |
 					   skb->nh.iph->ihl << ETH_TX_IHL_SHIFT;
 			/* CPU already calculated pseudo header checksum. */
-			if (skb->nh.iph->protocol == IPPROTO_UDP) {
+
+
+
+			if ( (skb->protocol == ETH_P_IP) &&
+				 (skb->nh.iph->protocol == IPPROTO_UDP) ) {
 				pkt_info.cmd_sts |= ETH_UDP_FRAME;
 				pkt_info.l4i_chk = skb->h.uh->check;
-			} else if (skb->nh.iph->protocol == IPPROTO_TCP)
+			} else if ( (skb->protocol == ETH_P_IP) &&
+				 (skb->nh.iph->protocol == IPPROTO_TCP) ) 
 				pkt_info.l4i_chk = skb->h.th->check;
 			else {
 				printk(KERN_ERR
-					"%s: chksum proto != TCP or UDP\n",
+					"%s: chksum proto != IPv4 TCP or UDP\n",
 					dev->name);
 				spin_unlock_irqrestore(&mp->lock, flags);
 				return 1;
@@ -1441,7 +1605,7 @@ static int mv643xx_eth_probe(struct plat
 	 * Zero copy can only work if we use Discovery II memory. Else, we will
 	 * have to map the buffers to ISA memory which is only 16 MB
 	 */
-	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_HW_CSUM;
+	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM;
 #endif
 #endif

--Boundary-00=_XukxDvfUaCFiVxy--
