Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id E04B667A6B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 17:57:22 +1100 (EST)
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	j2G6wWPv029614
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2005 23:58:32 -0700 (MST)
Received: from [192.168.1.109] (IL01D100043.pci.local [10.214.72.26] (may be
	forged))
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id j2G6x7Pn004708
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 00:59:08 -0600 (CST)
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <4e44f753c3a197eff3b584f24a239f06@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 16 Mar 2005 00:57:24 -0600
Subject: building ppc_htab?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is there any reason not to make the following change so we build 
ppc_htab only on PPC STD MMU?  This would also require fixing up 
fs/proc/proc_misc.c.

--- 1.52/arch/ppc/kernel/Makefile       2005-03-13 17:29:44 -06:00
+++ edited/Makefile     2005-03-16 00:44:17 -06:00
@@ -2,7 +2,7 @@
  # Makefile for the linux kernel.
  #

-extra-$(CONFIG_PPC_STD_MMU)    := head.o
+extra-$(CONFIG_PPC_STD_MMU)    := head.o ppc_htab.o
  extra-$(CONFIG_40x)            := head_4xx.o
  extra-$(CONFIG_44x)            := head_44x.o
  extra-$(CONFIG_E500)           := head_e500.o
@@ -14,7 +14,7 @@
  obj-y                          := entry.o traps.o irq.o idle.o time.o 
misc.o \
                                         process.o signal.o ptrace.o 
align.o \
                                         semaphore.o syscalls.o setup.o \
-                                       cputable.o ppc_htab.o perfmon.o
+                                       cputable.o perfmon.o
  obj-$(CONFIG_6xx)              += l2cr.o cpu_setup_6xx.o
  obj-$(CONFIG_SOFTWARE_SUSPEND) += swsusp.o
  obj-$(CONFIG_POWER4)           += cpu_setup_power4.o

- kumar
