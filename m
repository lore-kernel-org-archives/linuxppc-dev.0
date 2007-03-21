Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D49B6DDF1C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 05:14:41 +1100 (EST)
Message-ID: <460175E3.2090302@ru.mvista.com>
Date: Wed, 21 Mar 2007 21:13:55 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] PPC440EPx/440GRx EMAC support.
References: <46003608.70308@ru.mvista.com> <20070321160438.GA3023@lixom.net>
	<20070321162207.GA2583@gate.ebshome.net>
In-Reply-To: <20070321162207.GA2583@gate.ebshome.net>
Content-Type: multipart/mixed; boundary="------------050308040900060108060004"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050308040900060108060004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eugene Surovegin wrote:
> On Wed, Mar 21, 2007 at 11:04:38AM -0500, Olof Johansson wrote:
>   
>> On Tue, Mar 20, 2007 at 10:29:12PM +0300, Valentine Barshak wrote:
>>     
>>> diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac.h linux/drivers/net/ibm_emac/ibm_emac.h
>>> --- linux.orig/drivers/net/ibm_emac/ibm_emac.h	2007-03-16 18:03:51.000000000 +0300
>>> +++ linux/drivers/net/ibm_emac/ibm_emac.h	2007-03-18 18:53:08.000000000 +0300
>>> @@ -26,7 +26,7 @@
>>>  #if !defined(CONFIG_405GP) && !defined(CONFIG_405GPR) && !defined(CONFIG_405EP) && \
>>>      !defined(CONFIG_440GP) && !defined(CONFIG_440GX) && !defined(CONFIG_440SP) && \
>>>      !defined(CONFIG_440EP) && !defined(CONFIG_NP405H) && !defined(CONFIG_440SPE) && \
>>> -    !defined(CONFIG_440GR)
>>> +    !defined(CONFIG_440GR) && !defined(CONFIG_440EPX) && !defined(CONFIG_440GRX)
>>>       
>> Same here. I know you only added a couple more, but it's reached critical
>> mass (well, it did a while ago).
>>     
>
> No, it's not same here. Please, take a time and look at the full code 
> this particular snippet has nothing to do with Konfig stuff.
>
> One can argue that it can be removed altogether, but I added this ugly 
> check for a reason - people were adding support for new 4xx SoCs 
> blindly in the past without checking that EMAC registers weren't 
> changed slightly.
>
> So, Valentine, keep this particular ugly ifdef as it is.
>
> Also, Valentine, next time CC me with any EMAC changes because I'm not 
> actively reading PPC maillists these days.
>
>   
Please, take a look at the updated 440EPx EMAC patch.
I've added IBM_EMAC_CLK_SEL option which is selected if both 
IBM_EMAC_PHY_RX_CLK_FIX is set and the processor is not 440GX.
The other "ugly" ifdef is left unchanged.
Thanks.

--------------050308040900060108060004
Content-Type: text/plain;
 name="ppc440epx_emac_v1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc440epx_emac_v1.patch"

diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac_core.c linux/drivers/net/ibm_emac/ibm_emac_core.c
--- linux.orig/drivers/net/ibm_emac/ibm_emac_core.c	2007-03-20 19:46:20.000000000 +0300
+++ linux/drivers/net/ibm_emac/ibm_emac_core.c	2007-03-21 20:31:50.000000000 +0300
@@ -85,12 +85,11 @@
  */
 static u32 busy_phy_map;
 
-#if defined(CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) && \
-    (defined(CONFIG_405EP) || defined(CONFIG_440EP) || defined(CONFIG_440GR))
+#if defined(CONFIG_IBM_EMAC_CLK_SEL)
 /* 405EP has "EMAC to PHY Control Register" (CPC0_EPCTL) which can help us
  * with PHY RX clock problem.
- * 440EP/440GR has more sane SDR0_MFR register implementation than 440GX, which
- * also allows controlling each EMAC clock
+ * 440EP/440GR and 440EPx/440GRx have more sane SDR0_MFR register implementation
+ * than 440GX, which also allows controlling each EMAC clock
  */
 static inline void EMAC_RX_CLK_TX(int idx)
 {
diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac.h linux/drivers/net/ibm_emac/ibm_emac.h
--- linux.orig/drivers/net/ibm_emac/ibm_emac.h	2007-03-20 19:46:20.000000000 +0300
+++ linux/drivers/net/ibm_emac/ibm_emac.h	2007-03-20 21:07:59.000000000 +0300
@@ -26,7 +26,7 @@
 #if !defined(CONFIG_405GP) && !defined(CONFIG_405GPR) && !defined(CONFIG_405EP) && \
     !defined(CONFIG_440GP) && !defined(CONFIG_440GX) && !defined(CONFIG_440SP) && \
     !defined(CONFIG_440EP) && !defined(CONFIG_NP405H) && !defined(CONFIG_440SPE) && \
-    !defined(CONFIG_440GR)
+    !defined(CONFIG_440GR) && !defined(CONFIG_440EPX) && !defined(CONFIG_440GRX)
 #error	"Unknown SoC. Please, check chip user manual and make sure EMAC defines are OK"
 #endif
 
@@ -227,9 +227,15 @@
 #define EMAC_STACR_PHYD_SHIFT		16
 #define EMAC_STACR_OC			0x00008000
 #define EMAC_STACR_PHYE			0x00004000
+#if defined(CONFIG_IBM_EMAC4V4)
+#define EMAC_STACR_STAC_MASK		0x00003800
+#define EMAC_STACR_STAC_READ		0x00001000
+#define EMAC_STACR_STAC_WRITE		0x00000800
+#else
 #define EMAC_STACR_STAC_MASK		0x00003000
 #define EMAC_STACR_STAC_READ		0x00001000
 #define EMAC_STACR_STAC_WRITE		0x00002000
+#endif
 #if !defined(CONFIG_IBM_EMAC4)
 #define EMAC_STACR_OPBC_MASK		0x00000C00
 #define EMAC_STACR_OPBC_50		0x00000000
@@ -250,8 +256,11 @@
 /*
  * For the 440SPe, AMCC inexplicably changed the polarity of
  * the "operation complete" bit in the MII control register.
+ *
+ * This change is not associated to 440SPe but to EMAC core version used in
+ * 440SPe, 440EPx, 440GRx.
  */
-#if defined(CONFIG_440SPE)
+#if defined(CONFIG_440SPE) || defined(CONFIG_IBM_EMAC4V4)
 static inline int emac_phy_done(u32 stacr)
 {
 	return !(stacr & EMAC_STACR_OC);
diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac_mal.h linux/drivers/net/ibm_emac/ibm_emac_mal.h
--- linux.orig/drivers/net/ibm_emac/ibm_emac_mal.h	2007-03-20 19:46:20.000000000 +0300
+++ linux/drivers/net/ibm_emac/ibm_emac_mal.h	2007-03-20 21:07:59.000000000 +0300
@@ -35,7 +35,7 @@
     defined(CONFIG_440EP) || defined(CONFIG_440GR) || defined(CONFIG_NP405H)
 #define MAL_VERSION		1
 #elif defined(CONFIG_440GP) || defined(CONFIG_440GX) || defined(CONFIG_440SP) || \
-      defined(CONFIG_440SPE)
+      defined(CONFIG_440SPE) || defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define MAL_VERSION		2
 #else
 #error "Unknown SoC, please check chip manual and choose MAL 'version'"
diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac_phy.c linux/drivers/net/ibm_emac/ibm_emac_phy.c
--- linux.orig/drivers/net/ibm_emac/ibm_emac_phy.c	2007-03-20 19:46:20.000000000 +0300
+++ linux/drivers/net/ibm_emac/ibm_emac_phy.c	2007-03-20 21:07:59.000000000 +0300
@@ -299,8 +299,71 @@
 	.ops		= &cis8201_phy_ops
 };
 
+/* Marvell 88E1111 */
+static int m88e1111_init(struct mii_phy *phy)
+{
+	phy_write(phy, 0x14, 0x0ce3);
+	phy_write(phy, 0x18, 0x4101);
+	phy_write(phy, 0x09, 0x0e00);
+	phy_write(phy, 0x04, 0x01e1);
+	phy_write(phy, 0x00, 0x9140);
+	phy_write(phy, 0x00, 0x1140);
+
+	return  0;
+}
+
+static struct mii_phy_ops m88e1111_phy_ops = {
+	.init		= m88e1111_init,
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link
+};
+
+static struct mii_phy_def m88e1111_phy_def = {
+	.phy_id		= 0x01410CC0,
+	.phy_id_mask	= 0x0ffffff0,
+	.name		= "Marvell 88E1111 Ethernet",
+	.ops		= &m88e1111_phy_ops,
+};
+
+/* ET1011C */
+static int et1011c_init(struct mii_phy *phy)
+{
+	u16 reg_short;
+
+	reg_short = (u16)(phy_read(phy,0x16));
+	reg_short &= ~(0x7);
+	reg_short |= 0x6;	/* RGMII Trace Delay */
+	phy_write(phy, 0x16, reg_short);
+
+	reg_short = (u16)(phy_read(phy, 0x17));
+	reg_short &= ~(0x40);
+	phy_write(phy, 0x17, reg_short);
+
+	phy_write(phy, 0x1c, 0x74f0);
+	return 0;
+}
+
+static struct mii_phy_ops et1011c_phy_ops = {
+	.init		= et1011c_init,
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link
+};
+
+static struct mii_phy_def et1011c_phy_def = {
+	.phy_id		= 0x0282f000,
+	.phy_id_mask	= 0x0fffff00,
+	.name		= "ET1011C Gigabit Ethernet",
+	.ops		= &et1011c_phy_ops
+};
+
 static struct mii_phy_def *mii_phy_table[] = {
 	&cis8201_phy_def,
+	&m88e1111_phy_def,
+	&et1011c_phy_def,
 	&genmii_phy_def,
 	NULL
 };
diff -ruN linux.orig/drivers/net/Kconfig linux/drivers/net/ibm_emac/Kconfig
--- linux.orig/drivers/net/Kconfig	2007-03-20 19:46:18.000000000 +0300
+++ linux/drivers/net/Kconfig	2007-03-21 20:32:07.000000000 +0300
@@ -1226,7 +1226,7 @@
 
 config IBM_EMAC_PHY_RX_CLK_FIX
 	bool "PHY Rx clock workaround"
-	depends on IBM_EMAC && (405EP || 440GX || 440EP || 440GR)
+	depends on IBM_EMAC && (405EP || 440GX || 440EP || 440GR || 440EPX || 440GRX)
 	help
 	  Enable this if EMAC attached to a PHY which doesn't generate
 	  RX clock if there is no link, if this is the case, you will 
@@ -1235,6 +1235,12 @@
 	  
 	  If unsure, say N.
 
+config IBM_EMAC_CLK_SEL
+	bool
+	depends on IBM_EMAC_PHY_RX_CLK_FIX
+	default n if 440GX
+	default y
+
 config IBM_EMAC_DEBUG
 	bool "Debugging"
 	depends on IBM_EMAC

--------------050308040900060108060004--
