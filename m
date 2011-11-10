Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: add hvcall.h include to book3s_hv.c
Date: Thu, 10 Nov 2011 17:39:49 +1100
Message-ID: <8263.1320907189@neuling.org>
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If you build with KVM and UP it fails with the following due to a
missing include.

/arch/powerpc/kvm/book3s_hv.c: In function 'do_h_register_vpa':
arch/powerpc/kvm/book3s_hv.c:156:10: error: 'H_PARAMETER' undeclared (first use in this function)
arch/powerpc/kvm/book3s_hv.c:156:10: note: each undeclared identifier is reported only once for each function it appears in
arch/powerpc/kvm/book3s_hv.c:192:12: error: 'H_RESOURCE' undeclared (first use in this function)
arch/powerpc/kvm/book3s_hv.c:222:9: error: 'H_SUCCESS' undeclared (first use in this function)
arch/powerpc/kvm/book3s_hv.c: In function 'kvmppc_pseries_do_hcall':
arch/powerpc/kvm/book3s_hv.c:228:30: error: 'H_SUCCESS' undeclared (first use in this function)
arch/powerpc/kvm/book3s_hv.c:232:7: error: 'H_CEDE' undeclared (first use in this function)
arch/powerpc/kvm/book3s_hv.c:234:7: error: 'H_PROD' undeclared (first use in this function)
arch/powerpc/kvm/book3s_hv.c:238:10: error: 'H_PARAMETER' undeclared (first use in this function)
arch/powerpc/kvm/book3s_hv.c:250:7: error: 'H_CONFER' undeclared (first use in this function)
arch/powerpc/kvm/book3s_hv.c:252:7: error: 'H_REGISTER_VPA' undeclared (first use in this function)
make[2]: *** [arch/powerpc/kvm/book3s_hv.o] Error 1

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@kernel.org (3.1 only)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0cdbc07..0cb137a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -44,6 +44,7 @@
 #include <asm/processor.h>
 #include <asm/cputhreads.h>
 #include <asm/page.h>
+#include <asm/hvcall.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
