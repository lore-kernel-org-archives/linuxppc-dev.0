Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 92C57DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 14:52:09 +1000 (EST)
Received: from pd3mr1so.prod.shaw.ca
	(pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPD005VXESC39G0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:50:36 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPD00EEOESC7G20@pd3mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 03 Oct 2007 22:50:36 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPD000EAESBDS20@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 03 Oct 2007 22:50:35 -0600 (MDT)
Date: Wed, 03 Oct 2007 22:50:42 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Don't build arch/powerpc/sysdev/dcr.c for ARCH=ppc kernels
To: paulus@samba.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Message-id: <20071004044911.30154.23109.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

dcr.c is an arch/powerpc only thing.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Ben/Paulus,

As far as I can tell this is correct.  Having sysdev/dcr.c in the arch/ppc
build spits out warnings.  Grep doesn't show anything in arch/ppc that
is using it.

Cheers,
g.

 arch/powerpc/sysdev/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 592c17e..7f88d4e 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -6,7 +6,6 @@ mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
 
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
-obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
 obj-$(CONFIG_PPC_PMI)		+= pmi.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
@@ -31,6 +30,7 @@ endif
 
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
+obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o commproc.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
