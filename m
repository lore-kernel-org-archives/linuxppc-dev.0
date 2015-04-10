Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1756D1A031F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 15:28:35 +1000 (AEST)
Message-ID: <1428643714.30592.4.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pasemi: Only the build the pasemi MSI code for
 PASEMI=y
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 10 Apr 2015 15:28:34 +1000
In-Reply-To: <20150410142414.0ea55c4b@canb.auug.org.au>
References: <1428630726-12905-1-git-send-email-mpe@ellerman.id.au>
 <20150410142414.0ea55c4b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johannsson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-10 at 14:24 +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Fri, 10 Apr 2015 11:52:06 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> >  arch/powerpc/platforms/pasemi/Makefile |   1 +
> >  arch/powerpc/platforms/pasemi/msi.c    | 165 ++++++++++++++++++++++++++++++++
> >  arch/powerpc/sysdev/Makefile           |   2 +-
> >  arch/powerpc/sysdev/mpic.h             |  10 +-
> >  arch/powerpc/sysdev/mpic_pasemi_msi.c  | 167 ---------------------------------
> >  5 files changed, 172 insertions(+), 173 deletions(-)
> >  create mode 100644 arch/powerpc/platforms/pasemi/msi.c
> >  delete mode 100644 arch/powerpc/sysdev/mpic_pasemi_msi.c
> 
> What does this look like if you do "git diff --stat -M" and "git diff -M"?
> 
> This is very useful in cases where files are moved so that people can
> see what changed when the file moved.

Like this?

$ git diff --stat -M HEAD^
 arch/powerpc/platforms/pasemi/Makefile                            |  1 +
 arch/powerpc/{sysdev/mpic_pasemi_msi.c => platforms/pasemi/msi.c} |  4 +---
 arch/powerpc/sysdev/Makefile                                      |  2 +-
 arch/powerpc/sysdev/mpic.h                                        | 10 +++++-----
 4 files changed, 8 insertions(+), 9 deletions(-)


diff --git a/arch/powerpc/platforms/pasemi/Makefile b/arch/powerpc/platforms/pasemi/Makefile
index 8e8d4cae5ebe..60b4e0fd9808 100644
--- a/arch/powerpc/platforms/pasemi/Makefile
+++ b/arch/powerpc/platforms/pasemi/Makefile
@@ -1,2 +1,3 @@
 obj-y  += setup.o pci.o time.o idle.o powersave.o iommu.o dma_lib.o misc.o
 obj-$(CONFIG_PPC_PASEMI_MDIO)  += gpio_mdio.o
+obj-$(CONFIG_PCI_MSI)          += msi.o
diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/platforms/pasemi/msi.c
similarity index 99%
rename from arch/powerpc/sysdev/mpic_pasemi_msi.c
rename to arch/powerpc/platforms/pasemi/msi.c
index a3f660eed6de..0b3706604543 100644
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ b/arch/powerpc/platforms/pasemi/msi.c
@@ -13,8 +13,6 @@
  *
  */
 
-#undef DEBUG
-
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <asm/mpic.h>
@@ -23,7 +21,7 @@
 #include <asm/ppc-pci.h>
 #include <asm/msi_bitmap.h>
 
-#include "mpic.h"
+#include <sysdev/mpic.h>
 
 /* Allocate 16 interrupts per device, to give an alignment of 16,
  * since that's the size of the grouping w.r.t. affinity. If someone
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f7cb2a1b01fa..5b492a6438ff 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -2,7 +2,7 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)                := $(NO_MINIMAL_TOC)
 
-mpic-msi-obj-$(CONFIG_PCI_MSI) += mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
+mpic-msi-obj-$(CONFIG_PCI_MSI) += mpic_msi.o mpic_u3msi.o
 obj-$(CONFIG_MPIC)             += mpic.o $(mpic-msi-obj-y)
 obj-$(CONFIG_MPIC_TIMER)        += mpic_timer.o
 obj-$(CONFIG_FSL_MPIC_TIMER_WAKEUP)    += fsl_mpic_timer_wakeup.o
diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
index 24bf07a63924..32971a41853b 100644
--- a/arch/powerpc/sysdev/mpic.h
+++ b/arch/powerpc/sysdev/mpic.h
@@ -15,7 +15,6 @@
 extern void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq);
 extern int mpic_msi_init_allocator(struct mpic *mpic);
 extern int mpic_u3msi_init(struct mpic *mpic);
-extern int mpic_pasemi_msi_init(struct mpic *mpic);
 #else
 static inline void mpic_msi_reserve_hwirq(struct mpic *mpic,
                                          irq_hw_number_t hwirq)
@@ -27,11 +26,12 @@ static inline int mpic_u3msi_init(struct mpic *mpic)
 {
        return -1;
 }
+#endif
 
-static inline int mpic_pasemi_msi_init(struct mpic *mpic)
-{
-       return -1;
-}
+#if defined(CONFIG_PCI_MSI) && defined(CONFIG_PPC_PASEMI)
+int mpic_pasemi_msi_init(struct mpic *mpic);
+#else
+static inline int mpic_pasemi_msi_init(struct mpic *mpic) { return -1; }
 #endif
 
 extern int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type);


cheers
