Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 14 Feb 2007 16:08:05 +1100
Subject: [PATCH] Fix cut and paste breakage in
	arch/powerpc/platforms/pseries/pseries.h
Message-Id: <20070214050809.9EDE3DDE08@ozlabs.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My "cleanup" patch (dce623e0827e8d0ad60ce7f385c3394bf1b0bae0) had a cut
and paste error for the !CONFIG_KEXEC case. Fifty lashes for me.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/pseries.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/pseries.h
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/pseries.h
+++ powerpc/arch/powerpc/platforms/pseries/pseries.h
@@ -29,8 +29,8 @@ static inline smp_init_pseries_xics(void
 extern void setup_kexec_cpu_down_xics(void);
 extern void setup_kexec_cpu_down_mpic(void);
 #else
-static inline setup_kexec_cpu_down_xics(void) { };
-static inline setup_kexec_cpu_down_mpic(void) { };
+static inline void setup_kexec_cpu_down_xics(void) { }
+static inline void setup_kexec_cpu_down_mpic(void) { }
 #endif
 
 #endif /* _PSERIES_PSERIES_H */
