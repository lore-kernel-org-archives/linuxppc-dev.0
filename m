Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7728BDDED4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 13:21:11 +1000 (EST)
Date: Wed, 16 May 2007 13:21:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] fix non SMP warning
Message-Id: <20070516132109.a9b3b0bb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/pseries/pseries.h:24: warning: return type defaults to 'int'
arch/powerpc/platforms/pseries/pseries.h:25: warning: return type defaults to 'int'
arch/powerpc/platforms/pseries/pseries.h:24: warning: control reaches end of non-void function
arch/powerpc/platforms/pseries/pseries.h:25: warning: control reaches end of non-void function

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/pseries.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 22bc019..2729d55 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -21,8 +21,8 @@ extern int pSeries_machine_check_exception(struct pt_regs *regs);
 extern void smp_init_pseries_mpic(void);
 extern void smp_init_pseries_xics(void);
 #else
-static inline smp_init_pseries_mpic(void) { };
-static inline smp_init_pseries_xics(void) { };
+static inline void smp_init_pseries_mpic(void) { };
+static inline void smp_init_pseries_xics(void) { };
 #endif
 
 #ifdef CONFIG_KEXEC
-- 
1.5.1.4
