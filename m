Return-Path: <paulus@ozlabs.org>
Date: Tue, 5 Feb 2013 15:11:44 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH 4/4] KVM: PPC: Book3S PR: Fix compilation on 32-bit machines
Message-ID: <20130205041144.GE20303@drongo>
References: <20130205040902.GA20303@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130205040902.GA20303@drongo>
Cc: kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a413f474a0 ("powerpc: Disable relocation on exceptions whenever
PR KVM is active") added calls to pSeries_disable_reloc_on_exc() and
pSeries_enable_reloc_on_exc() to book3s_pr.c, and added declarations
of those functions to <asm/hvcall.h>, but didn't add an include of
<asm/hvcall.h> to book3s_pr.c.  64-bit kernels seem to get hvcall.h
included via some other path, but 32-bit kernels fail to compile with:

arch/powerpc/kvm/book3s_pr.c: In function ‘kvmppc_core_init_vm’:
arch/powerpc/kvm/book3s_pr.c:1300:4: error: implicit declaration of function ‘pSeries_disable_reloc_on_exc’ [-Werror=implicit-function-declaration]
arch/powerpc/kvm/book3s_pr.c: In function ‘kvmppc_core_destroy_vm’:
arch/powerpc/kvm/book3s_pr.c:1316:4: error: implicit declaration of function ‘pSeries_enable_reloc_on_exc’ [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors
make[2]: *** [arch/powerpc/kvm/book3s_pr.o] Error 1
make[1]: *** [arch/powerpc/kvm] Error 2
make: *** [sub-make] Error 2

This fixes it by adding an include of hvcall.h.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_pr.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 67e4708..6702442 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -35,6 +35,7 @@
 #include <asm/mmu_context.h>
 #include <asm/switch_to.h>
 #include <asm/firmware.h>
+#include <asm/hvcall.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
-- 
1.7.10.4
