Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B6E2567B83
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2006 16:53:13 +1100 (EST)
Date: Thu, 30 Nov 2006 16:53:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: stop dt_mod.o being rebuilt unnecessarily
Message-Id: <20061130165311.ca9b7da3.sfr@canb.auug.org.au>
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


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platforms/iseries/Makefile
index dee4eb4..13ac301 100644
--- a/arch/powerpc/platforms/iseries/Makefile
+++ b/arch/powerpc/platforms/iseries/Makefile
@@ -1,5 +1,7 @@
 EXTRA_CFLAGS	+= -mno-minimal-toc
 
+extra-y += dt.o
+
 obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o dt_mod.o mf.o lpevents.o \
 	hvcall.o proc.o htab.o iommu.o misc.o irq.o
 obj-$(CONFIG_PCI) += pci.o vpdinfo.o
@@ -7,5 +9,9 @@ obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_VIOPATH) += viopath.o
 obj-$(CONFIG_MODULES) += ksyms.o
 
+quiet_cmd_dt_strings = DT_STR  $@
+      cmd_dt_strings = $(OBJCOPY) --rename-section .rodata.str1.8=.dt_strings \
+				$< $@
+
 $(obj)/dt_mod.o:	$(obj)/dt.o
-	@$(OBJCOPY) --rename-section .rodata.str1.8=.dt_strings $(obj)/dt.o $(obj)/dt_mod.o
+	$(call if_changed,dt_strings)
-- 
1.4.4.1
