Message-ID: <3C15BB05.7070702@elsoft.ch>
Date: Tue, 11 Dec 2001 08:51:33 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Felix Radensky <felix@allot.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405_enet problems
References: <3C14B86D.726DBDE6@allot.com>
Content-Type: multipart/mixed;
 boundary="------------030307080501080301020007"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------030307080501080301020007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It looks like the MII controller is not setting the error flag for the
first access (reading of PHYIR1 in find_phy(ppc405_phy.c)

Perhaps my work-around (see attached file) will help you too.


Felix Radensky wrote:

 > Hi,
 >
 > I'm trying to run the latest linuxppc_2_4_devel kernel on
 > our custom 405GP based board. I get kernel panic when an
 > attempt is made to probe for ethernet controller phy:
 >
 > Kernel panic: eth0: PHY id 0xfbc85c20 is not supported!
 >
 > The phy is National Semiconductor DP83846AVHG.
 > It works fine with Monta Vista HHL 2.0 kernel.
 >
 > What you think could be the problem ?
 >
 > TIA.
 >
 > Felix.
 >


Dave

--------------030307080501080301020007
Content-Type: text/plain;
 name="net_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net_patch.txt"

--- 1.5/drivers/net/ppc405_phy.c	Thu Oct 25 00:44:15 2001
+++ edited/ppc405_phy.c	Mon Dec  3 16:51:05 2001
@@ -707,14 +707,17 @@
 {
 	struct fec_enet_private *fep;
 	int i;
-	uint phy_reg;
+	uint phy_reg, phy_reg2;
 	uint phytype;

 	fep = dev->priv;

 	for ( i = 0; i < MAX_NUM_PHYS; i++)
-		if (!(fec_enet_mdio_read(i, mk_mii_read(MII_REG_PHYIR1),
-						&phy_reg)))
+		if (!((fec_enet_mdio_read(i, mk_mii_read(MII_REG_PHYIR1),
+						&phy_reg)) ||
+		      (fec_enet_mdio_read(i, mk_mii_read(MII_REG_PHYIR2),
+		                                &phy_reg2))))
+
 			break;

 	fep->phy_addr = i;

--------------030307080501080301020007--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
