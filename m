Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7F181B7B84
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 07:43:56 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 7D56CDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 07:43:55 +1000 (EST)
Date: Wed, 16 Sep 2009 01:43:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/7] powerpc/qe: QE also shuts down on MPC8568
Message-ID: <20090915214354.GB24821@oksana.dev.rtsoft.ru>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It appears that QE shuts down on all MPC85xx CPUs (i.e. MPC8568 and
MPC8569) and thus needs reset upon resume.

So modify qe_alive_during_sleep() to account that.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/qe.h   |   23 ++++++++++++++++++++++-
 arch/powerpc/sysdev/qe_lib/qe.c |   13 -------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index fe507ff..0947b36 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -163,7 +163,28 @@ int qe_get_snum(void);
 void qe_put_snum(u8 snum);
 unsigned int qe_get_num_of_risc(void);
 unsigned int qe_get_num_of_snums(void);
-int qe_alive_during_sleep(void);
+
+static inline int qe_alive_during_sleep(void)
+{
+	/*
+	 * MPC8568E reference manual says:
+	 *
+	 * "...power down sequence waits for all I/O interfaces to become idle.
+	 *  In some applications this may happen eventually without actively
+	 *  shutting down interfaces, but most likely, software will have to
+	 *  take steps to shut down the eTSEC, QUICC Engine Block, and PCI
+	 *  interfaces before issuing the command (either the write to the core
+	 *  MSR[WE] as described above or writing to POWMGTCSR) to put the
+	 *  device into sleep state."
+	 *
+	 * MPC8569E reference manual has a similar paragraph.
+	 */
+#ifdef CONFIG_PPC_85xx
+	return 0;
+#else
+	return 1;
+#endif
+}
 
 /* we actually use cpm_muram implementation, define this for convenience */
 #define qe_muram_init cpm_muram_init
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 1ed1a9f..4eaf2a9 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -65,19 +65,6 @@ static unsigned int qe_num_of_snum;
 
 static phys_addr_t qebase = -1;
 
-int qe_alive_during_sleep(void)
-{
-	static int ret = -1;
-
-	if (ret != -1)
-		return ret;
-
-	ret = !of_find_compatible_node(NULL, NULL, "fsl,mpc8569-pmc");
-
-	return ret;
-}
-EXPORT_SYMBOL(qe_alive_during_sleep);
-
 phys_addr_t get_qe_base(void)
 {
 	struct device_node *qe;
-- 
1.6.3.3
