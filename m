Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 418C4DEB93
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 04:24:26 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 37D5D8810
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 22:24:38 +0400 (SAMT)
Date: Tue, 11 Mar 2008 20:24:24 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] [POWERPC] qe_lib: export qe_get_brg_clk()
Message-ID: <20080311172424.GE7727@localhost.localdomain>
References: <20080311172106.GA4766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080311172106.GA4766@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

qe_get_brg_clk() will be used by the fsl_gtm routines.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |    5 +++--
 include/asm-powerpc/qe.h        |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index b444b1d..2061c46 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -156,7 +156,7 @@ EXPORT_SYMBOL(qe_issue_cmd);
  */
 static unsigned int brg_clk = 0;
 
-unsigned int get_brg_clk(void)
+unsigned int qe_get_brg_clk(void)
 {
 	struct device_node *qe;
 	unsigned int size;
@@ -180,6 +180,7 @@ unsigned int get_brg_clk(void)
 
 	return brg_clk;
 }
+EXPORT_SYMBOL(qe_get_brg_clk);
 
 /* Program the BRG to the given sampling rate and multiplier
  *
@@ -197,7 +198,7 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier)
 	if ((brg < QE_BRG1) || (brg > QE_BRG16))
 		return -EINVAL;
 
-	divisor = get_brg_clk() / (rate * multiplier);
+	divisor = qe_get_brg_clk() / (rate * multiplier);
 
 	if (divisor > QE_BRGC_DIVISOR_MAX + 1) {
 		div16 = QE_BRGC_DIV16;
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 398534c..c3be6e2 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -85,6 +85,7 @@ extern int par_io_data_set(u8 port, u8 pin, u8 val);
 /* QE internal API */
 int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input);
 enum qe_clock qe_clock_source(const char *source);
+unsigned int qe_get_brg_clk(void);
 int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier);
 int qe_get_snum(void);
 void qe_put_snum(u8 snum);
-- 
1.5.2.2
