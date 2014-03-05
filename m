Return-Path: <qiang.zhao@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BDD62C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 18:25:55 +1100 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>,
 <galak@kernel.crashing.org>
Subject: [PATCh v2 1/2] QE: split function mpc85xx_qe_init() into two
 functions.
Date: Wed, 5 Mar 2014 15:21:31 +0800
Message-ID: <1394004092-4622-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, R63061@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

New QE doesn't have par_io, it doesn't need to init par_io
for new QE.
Split function mpc85xx_qe_init() into mpc85xx_qe_init()
and mpc85xx_qe_par_io_init().
Call mpc85xx_qe_init() for both new and old while
mpc85xx_qe_par_io_init() after mpc85xx_qe_init() for old.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
Changes for v2:
	-no

 arch/powerpc/platforms/85xx/common.c      | 6 ++++++
 arch/powerpc/platforms/85xx/mpc85xx.h     | 2 ++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c | 1 +
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 1 +
 arch/powerpc/platforms/85xx/twr_p102x.c   | 1 +
 5 files changed, 11 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 3b085c7..b564b5e 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -107,6 +107,12 @@ void __init mpc85xx_qe_init(void)
 	qe_reset();
 	of_node_put(np);
 
+}
+
+void __init mpc85xx_qe_par_io_init(void)
+{
+	struct device_node *np;
+
 	np = of_find_node_by_name(NULL, "par_io");
 	if (np) {
 		struct device_node *ucc;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index fc51dd4..39056f6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -10,8 +10,10 @@ static inline void __init mpc85xx_cpm2_pic_init(void) {}
 
 #ifdef CONFIG_QUICC_ENGINE
 extern void mpc85xx_qe_init(void);
+extern void mpc85xx_qe_par_io_init(void);
 #else
 static inline void __init mpc85xx_qe_init(void) {}
+static inline void __init mpc85xx_qe_par_io_init(void) {}
 #endif
 
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 34f3c5e..3c190b4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -239,6 +239,7 @@ static void __init mpc85xx_mds_qe_init(void)
 	struct device_node *np;
 
 	mpc85xx_qe_init();
+	mpc85xx_qe_par_io_init();
 	mpc85xx_mds_reset_ucc_phys();
 
 	if (machine_is(p1021_mds)) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index e15bdd1..f9668ed 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -99,6 +99,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 #ifdef CONFIG_QUICC_ENGINE
 	mpc85xx_qe_init();
+	mpc85xx_qe_par_io_init();
 #if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
 	if (machine_is(p1025_rdb)) {
 
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index c25ff10..1eadb6d 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -77,6 +77,7 @@ static void __init twr_p1025_setup_arch(void)
 
 #ifdef CONFIG_QUICC_ENGINE
 	mpc85xx_qe_init();
+	mpc85xx_qe_par_io_init();
 
 #if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
 	if (machine_is(twr_p1025)) {
-- 
1.8.5
