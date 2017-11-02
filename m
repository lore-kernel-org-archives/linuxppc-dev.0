Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySG0d64xhzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 17:49:37 +1100 (AEDT)
Date: Thu, 2 Nov 2017 17:49:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: linux-next: build failure after merge of the powerpc tree
Message-ID: <20171102174936.7cc061cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc64
allnoconfig) failed like this:

arch/powerpc/kernel/irq.o: In function `.replay_system_reset':
irq.c:(.text+0x10): undefined reference to `.ppc_save_regs'

Caused by commit

  78adf6c214f0 ("powerpc/64s: Implement system reset idle wakeup reason")

I have applied the following fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 2 Nov 2017 17:45:18 +1100
Subject: [PATCH] powerpc/64s: ppc_save_regs is now needed for all 64s builds

Fixes: 78adf6c214f0 ("powerpc/64s: Implement system reset idle wakeup reason")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 91960f83039c..34b6e729f38c 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -128,7 +128,7 @@ obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 obj-$(CONFIG_PPC32)		+= $(obj32-y)
 
-ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC_CORE),)
+ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC_CORE)(CONFIG_PPC_BOOK3S),)
 obj-y				+= ppc_save_regs.o
 endif
 
-- 
2.14.1

-- 
Cheers,
Stephen Rothwell
