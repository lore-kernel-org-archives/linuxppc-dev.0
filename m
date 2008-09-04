Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 57F9C47A68
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:02:48 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so1954092pyi.27
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 08:02:46 -0700 (PDT)
Date: Thu, 4 Sep 2008 11:02:05 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, netdev@vger.kernel.org
Subject: [PATCH 2/3] ibm_newemac: Introduce mal_has_feature
Message-ID: <20080904150205.GC2479@yoda.jdub.homelinux.org>
References: <cover.1220540078.git.jwboyer@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1220540078.git.jwboyer@linux.vnet.ibm.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are some PowerPC SoCs that do odd things with the MAL handling.  In
order to accommodate them, we need to introduce a feature mechanism that is
similar to the existing emac_has_feature function.

This adds a feature variable to the mal_instance structure, and adds a
mal_has_feature function with some feature definitions.  These are guarded
by Kconfig options that are selected by the affected platforms.

Signed-of-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 drivers/net/ibm_newemac/Kconfig |    8 ++++++++
 drivers/net/ibm_newemac/mal.h   |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/Kconfig b/drivers/net/ibm_newemac/Kconfig
index dfb6547..44e5a0e 100644
--- a/drivers/net/ibm_newemac/Kconfig
+++ b/drivers/net/ibm_newemac/Kconfig
@@ -66,3 +66,11 @@ config IBM_NEW_EMAC_EMAC4
 config IBM_NEW_EMAC_NO_FLOW_CTRL
 	bool
 	default n
+
+config IBM_NEW_EMAC_MAL_CLR_ICINTSTAT
+	bool
+	default n
+
+config IBM_NEW_EMAC_MAL_COMMON_ERR
+	bool
+	default n
diff --git a/drivers/net/ibm_newemac/mal.h b/drivers/net/ibm_newemac/mal.h
index eaa7262..50c5c65 100644
--- a/drivers/net/ibm_newemac/mal.h
+++ b/drivers/net/ibm_newemac/mal.h
@@ -213,6 +213,8 @@ struct mal_instance {
 	struct of_device	*ofdev;
 	int			index;
 	spinlock_t		lock;
+
+	unsigned int features;
 };
 
 static inline u32 get_mal_dcrn(struct mal_instance *mal, int reg)
@@ -225,6 +227,41 @@ static inline void set_mal_dcrn(struct mal_instance *mal, int reg, u32 val)
 	dcr_write(mal->dcr_host, reg, val);
 }
 
+/* Features of various MAL implementations */
+
+/* Dummy feature bit so the enum works properly */
+#define MAL_FTR_DUMMY	0x00000001
+
+/* Set if you have interrupt coalescing and you have to clear the SDR
+ * register for TXEOB and RXEOB interrupts to work
+ */
+#define MAL_FTR_CLEAR_ICINTSTAT	0x00000002
+
+/* Set if your MAL has SERR, TXDE, and RXDE OR'd into a single UIC
+ * interrupt
+ */
+#define MAL_FTR_COMMON_ERR_INT	0x00000004
+
+enum {
+	MAL_FTRS_ALWAYS = 0,
+
+	MAL_FTRS_POSSIBLE =
+#ifdef CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT
+		MAL_FTR_CLEAR_ICINTSTAT |
+#endif
+#ifdef CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR
+		MAL_FTR_COMMON_ERR_INT |
+#endif
+		MAL_FTR_DUMMY,
+};
+
+static inline int mal_has_feature(struct mal_instance *dev,
+		unsigned long feature)
+{
+	return (MAL_FTRS_ALWAYS & feature) ||
+		(MAL_FTRS_POSSIBLE & dev->features & feature);
+}
+
 /* Register MAL devices */
 int mal_init(void);
 void mal_exit(void);
-- 
1.5.5.1
