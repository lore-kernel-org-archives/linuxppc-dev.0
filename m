Message-ID: <6B546A602AD2D211BFF00008C7A4288905843FC6@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: FEC driver multicast patch
Date: Fri, 1 Feb 2002 11:09:51 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan, Hi all,

Remember the discussion we had on the multicast support in the FEC-driver?
There is some code but is uses SCC1 for the CRC-calculation, the code is
commented out and does not compile...
It took me some time because I had some other things to finish first, but I
have now some code that seems to work. Here is a patch:

--- arch/ppc/8xx_io/fec.c	Wed May 23 21:46:02 2001
+++ arch/ppc/8xx_io/fec.c	Mon Jan 28 15:28:34 2002
@@ -23,6 +23,9 @@
  * Make use of MII for PHY control configurable.
  * Some fixes.
  * Copyright (c) 2000 Wolfgang Denk, DENX Software Engineering.
+ *
+ * Added code for Multicast support, Frederic Goddeeris, Paul Geerinckx
+ * Copyright (c) 2002 Siemens Atea
  */

 /* List of PHYs we wish to support.
@@ -31,6 +34,14 @@
 #define	CONFIG_FEC_LXT971
 #define	CONFIG_FEC_QS6612

+/* multicast support
+*/
+#define DEBUG_MULTICAST
+/* CRC polynomium used by the FEC for the multicast group filtering
+*/
+#define FEC_CRC_POLY	0x04c11db7
+
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -723,6 +734,13 @@
 				 (unsigned char *)__va(bdp->cbd_bufaddr),
 				 pkt_len-4, 0);
 		skb->protocol=eth_type_trans(skb,dev);
+		#ifdef DEBUG_MULTICAST
+			if (bdp->cbd_sc & BD_ENET_RX_MC) {
+				printk("%s: Received Multicast packet DA:
%2x:%2x:%2x:%2x:%2x:%2x\n",
+					dev->name,
+					(int)data[0], (int)data[1],
(int)data[2], (int)data[3], (int)data[4], (int)data[5]);
+			}
+		#endif
 		netif_rx(skb);
 	}
   rx_processing_done:
@@ -1457,6 +1476,33 @@
 	return &fep->stats;
 }

+
+/* Returns the CRC needed when filling in the hash table for multicast
group filtering
+ * pAddr must point to a MAC address (6 bytes)
+ */
+
+static u32 fec_mulicast_calc_crc(char *pAddr)
+{
+	u8	byte;
+	int	byte_count;
+	int	bit_count;
+	u32	crc = 0xffffffff;
+	u8	msb;
+
+	for (byte_count=0; byte_count<6; byte_count++) {
+        	byte = pAddr[byte_count];
+		for (bit_count=0; bit_count<8; bit_count++) {
+            		msb = crc >> 31;
+            		crc <<= 1;
+            		if (msb ^ (byte & 0x1)) {
+                		crc ^= FEC_CRC_POLY;
+   	    		}
+            		byte >>= 1;
+		}
+        }
+	return (crc);
+}
+
 /* Set or clear the multicast filter for this adaptor.
  * Skeleton taken from sunlance driver.
  * The CPM Ethernet implementation allows Multicast as well as individual
@@ -1491,6 +1537,56 @@
 			ep->fec_hash_table_high = 0xffffffff;
 			ep->fec_hash_table_low = 0xffffffff;
 		}
+		else {
+			struct dev_mc_list *pmc = dev->mc_list;
+
+			/* Clear Hash-Table
+			*/
+			ep->fec_hash_table_high = 0;
+			ep->fec_hash_table_low = 0;
+
+			/* Now populate the hash table
+			*/
+			#ifdef DEBUG_MULTICAST
+				if (pmc) {
+					printk("%s: Recalculating
hash-table:\n", dev->name);
+					printk(" MAC Address         high
low\n");
+				}
+			#endif
+
+			while (pmc) {
+				u32	crc;
+				int	temp;
+				u32	csrVal;
+				int	hash_index;
+
+				crc = fec_mulicast_calc_crc(pmc->dmi_addr);
+				temp = (crc & 0x3f) >> 1;
+				hash_index = ((temp & 0x1) << 4) | ((temp &
0x2) << 2) | ((temp & 0x4)) | ((temp & 0x8) >> 2) | ((temp & 0x10) >> 4);
+				csrVal = (1 << hash_index);
+				if (crc & 1) {
+					ep->fec_hash_table_high	|= csrVal;
+				}
+				else {
+					ep->fec_hash_table_low	|= csrVal;
+				}
+				#ifdef DEBUG_MULTICAST
+					printk("
%02x:%02x:%02x:%02x:%02x:%02x   %08x %08x\n",
+						(int)pmc->dmi_addr[0],
+						(int)pmc->dmi_addr[1],
+						(int)pmc->dmi_addr[2],
+						(int)pmc->dmi_addr[3],
+						(int)pmc->dmi_addr[4],
+						(int)pmc->dmi_addr[5],
+						ep->fec_hash_table_high,
+						ep->fec_hash_table_low);
+				#endif
+				pmc = pmc->next;
+			}
+
+
+		}
+
 #if 0
 		else {
 			/* Clear filter and add the addresses in the list.

--- arch/ppc/8xx_io/commproc.h	Wed May 23 21:46:02 2001
+++ arch/ppc/8xx_io/commproc.h	Fri Jan 11 16:30:19 2002
@@ -668,6 +668,8 @@
 #define BD_ENET_RX_CR		((ushort)0x0004)
 #define BD_ENET_RX_OV		((ushort)0x0002)
 #define BD_ENET_RX_CL		((ushort)0x0001)
+#define BD_ENET_RX_BC		((ushort)0x0080)	/* DA is Broadcast
*/
+#define BD_ENET_RX_MC		((ushort)0x0040)	/* DA is Multicast
*/
 #define BD_ENET_RX_STATS	((ushort)0x013f)	/* All status bits
*/

 /* Buffer descriptor control/status used by Ethernet transmit.




Regards,
Frederic


-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: zaterdag 22 december 2001 19:20
To: Frederic Goddeeris
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC driver / multicast / Hash Table



Frederic Goddeeris wrote:


> I know it looks strange to let an SCC do the work but to me it looks like
> the MPC860T documentation about the FEC suggests such an approach:

Worse than strange, it is complexity we don't need to add to the system.
I understand the suggestion, but we are not computing new multicast filters
at a rate that requires such hardware support.  It takes less cycles to just
run the CRC in software (and there are plenty of examples to utilize) than
to complicate the drivers and suffer the overhead of such an implentation.

There isn't likely to be an "off-line" Ethernet controller available, so you
need the software alternative in this case.  Just write it and use all of
the
time.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
