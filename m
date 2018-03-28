Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BJbH4w6YzF2J1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 06:58:19 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id m13so3353312wrj.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 12:58:19 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/19] powerpc/kvm: Prefer fault_in_pages_readable function
Date: Wed, 28 Mar 2018 21:58:11 +0200
Message-Id: <20180328195811.27758-1-malat@debian.org>
In-Reply-To: <20180322202007.23088-5-malat@debian.org>
References: <20180322202007.23088-5-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Directly use fault_in_pages_readable instead of manual __get_user code. Fix
warning treated as error with W=1:

  arch/powerpc/kernel/kvm.c:675:6: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: use fault_in_pages_readable instead
 arch/powerpc/kernel/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 9ad37f827a97..124c51030b75 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -25,6 +25,7 @@
 #include <linux/kvm_para.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/pagemap.h>
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -672,14 +673,13 @@ static void kvm_use_magic_page(void)
 {
 	u32 *p;
 	u32 *start, *end;
-	u32 tmp;
 	u32 features;
 
 	/* Tell the host to map the magic page to -4096 on all CPUs */
 	on_each_cpu(kvm_map_magic_page, &features, 1);
 
 	/* Quick self-test to see if the mapping works */
-	if (__get_user(tmp, (u32*)KVM_MAGIC_PAGE)) {
+	if (!fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(u32))) {
 		kvm_patching_worked = false;
 		return;
 	}
-- 
2.11.0
