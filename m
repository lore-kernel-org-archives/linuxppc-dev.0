Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f14.google.com (mail-gx0-f14.google.com
	[209.85.217.14]) by ozlabs.org (Postfix) with ESMTP id 76808DE69D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 06:00:49 +1100 (EST)
Received: by gxk7 with SMTP id 7so624329gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 12:00:48 -0700 (PDT)
Date: Fri, 10 Oct 2008 14:53:21 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] Remove old workaround for arch/ppc vs. arch/powerpc from
	Makefile
Message-ID: <20081010185321.GA16769@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is an old workaround in the sysdev/Makefile for dealing
with arch/ppc vs. arch/powerpc compiles.  This is no longer
needed as arch/ppc is dead.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 55618ba..a44709a 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -38,15 +38,12 @@ ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)              += ppc4xx_pci.o
 endif
 
-# Temporary hack until we have migrated to asm-powerpc
-ifeq ($(ARCH),powerpc)
 obj-$(CONFIG_CPM)              += cpm_common.o
 obj-$(CONFIG_CPM2)             += cpm2.o cpm2_pic.o
 obj-$(CONFIG_QUICC_ENGINE)     += cpm_common.o
 obj-$(CONFIG_PPC_DCR)          += dcr.o
 obj-$(CONFIG_8xx)              += mpc8xx_pic.o cpm1.o
 obj-$(CONFIG_UCODE_PATCH)      += micropatch.o
-endif
 
 ifeq ($(CONFIG_SUSPEND),y)
 obj-$(CONFIG_6xx)              += 6xx-suspend.o
