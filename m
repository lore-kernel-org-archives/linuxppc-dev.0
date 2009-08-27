Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EB655B7CA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 03:35:52 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 675AADDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 03:35:52 +1000 (EST)
Date: Thu, 27 Aug 2009 21:35:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 2/5] powerpc/qe: Implement qe_alive_during_sleep() helper
	function
Message-ID: <20090827173550.GB1580@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In some CPUs (i.e. MPC8569) QE shuts down completely during sleep,
drivers may want to know that to reinitialize registers and buffer
descriptors.

This patch implements qe_alive_during_sleep() helper function, so far
it just checks if MPC8569-compatible power management controller is
present, which is a sign that QE turns off during sleep.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/qe.h   |    1 +
 arch/powerpc/sysdev/qe_lib/qe.c |   13 +++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index e8232bb..20c0b07 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -163,6 +163,7 @@ int qe_get_snum(void);
 void qe_put_snum(u8 snum);
 unsigned int qe_get_num_of_risc(void);
 unsigned int qe_get_num_of_snums(void);
+int qe_alive_during_sleep(void);
 
 /* we actually use cpm_muram implementation, define this for convenience */
 #define qe_muram_init cpm_muram_init
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index f485d5a..a765f9c 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -65,6 +65,19 @@ static unsigned int qe_num_of_snum;
 
 static phys_addr_t qebase = -1;
 
+int qe_alive_during_sleep(void)
+{
+	static int ret = -1;
+
+	if (ret != -1)
+		return ret;
+
+	ret = !of_find_compatible_node(NULL, NULL, "fsl,mpc8569-pmc");
+
+	return ret;
+}
+EXPORT_SYMBOL(qe_alive_during_sleep);
+
 phys_addr_t get_qe_base(void)
 {
 	struct device_node *qe;
-- 
1.6.3.3
