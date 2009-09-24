Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id D9186B70B3
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 22:58:47 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	9EDB931ACDE
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 14:49:44 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.202.14])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KQH00M6T7MWGM20@invitel.hu> for
	linuxppc-dev@ozlabs.org; Thu, 24 Sep 2009 14:49:44 +0200 (CEST)
Date: Thu, 24 Sep 2009 14:45:14 +0200
From: Heiko Schocher <hs@denx.de>
Subject: [PATCH, RFC] powerpc, pci: fix MODPOST warning
To: linuxppc-dev@ozlabs.org
Message-id: <4ABB69DA.7030306@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

making a powerpc target with PCI support, shows the
following warning:

  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x10430): Section mismatch in reference from the function pcibios_allocate_bus_resources() to the function .init.text:reparent_resources()
The function pcibios_allocate_bus_resources() references
the function __init reparent_resources().
This is often because pcibios_allocate_bus_resources lacks a __init
annotation or the annotation of reparent_resources is wrong.

This patch fix this warning by removing the __init
annotation before reparent_resources.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
 arch/powerpc/kernel/pci-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e9f4840..48acf63 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1190,7 +1190,7 @@ EXPORT_SYMBOL(pcibios_align_resource);
  * Reparent resource children of pr that conflict with res
  * under res, and make res replace those children.
  */
-static int __init reparent_resources(struct resource *parent,
+static int reparent_resources(struct resource *parent,
 				     struct resource *res)
 {
 	struct resource *p, **pp;
-- 
1.6.0.6

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
