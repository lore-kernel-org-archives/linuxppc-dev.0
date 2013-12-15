Return-Path: <cengelma@gmx.at>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 024942C009F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 05:51:49 +1100 (EST)
Received: from spike ([81.217.122.98]) by mail.gmx.com (mrgmx003) with ESMTPSA
 (Nemesis) id 0MPm54-1VxCHD41wY-0051qr for
 <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2013 19:38:58 +0100
Date: Sun, 15 Dec 2013 19:38:56 +0100
From: Christian Engelmayer <cengelma@gmx.at>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/sysdev: Fix a mpic section mismatch for MPC85xx
Message-ID: <20131215193856.1637accd@spike>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Moved arch/powerpc/sysdev/mpic.c : smp_mpic_probe() out of the __init section.
It is referenced by arch/powerpc/platforms/85xx/smp.c : smp_85xx_setup_cpu().

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
 arch/powerpc/sysdev/mpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 0e166ed..72c1e65 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1924,7 +1924,7 @@ void smp_mpic_message_pass(int cpu, int msg)
 		       msg * MPIC_INFO(CPU_IPI_DISPATCH_STRIDE), physmask);
 }
 
-int __init smp_mpic_probe(void)
+int smp_mpic_probe(void)
 {
 	int nr_cpus;
 
-- 
1.8.3.2
