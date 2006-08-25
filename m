Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id A45D067C34
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 17:48:03 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7P7m2jA016111
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 00:48:02 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7P7lxMA013813
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 02:48:01 -0500 (CDT)
Subject: Re: [PATCH] powerpc: Support for "weird" MPICs and fixup mpc7448_hpc2
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1156479390.8433.293.camel@localhost.localdomain>
References: <1156479390.8433.293.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1156492062.7107.26.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 25 Aug 2006 15:47:42 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-25 at 12:16, Benjamin Herrenschmidt wrote:
> This patch is a slightly cleaned up version of Zang Roy's support for
> the TSI108 MPIC variant. It also fixes up MPC7448_hpc2 to use the new
> version of the type macros and changes the way MPIC is selected in
> Kconfig to better match what is done for other system devices.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Zang Roy, please verify that it still works for you. I've tested it on
> an Apple G5 with and without CONFIG_MPIC_WEIRD .
> 

It works OK on my mpc7448hpc2 board. 
There is a sequence for the patch applying.

(1) patch for IRQ update for mpc7448hpc2:
http://ozlabs.org/pipermail/linuxppc-dev/2006-August/025559.html

(2) the weird mpic patch repost by your mail.
(3) the following minor patch to build mpic.o for CONFIG_MPIC_WEIRD

Signed-off-by: Roy Zang     <tie-fei.zang@freescale.com> 
---

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index cebfae2..8ae887b 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -3,6 +3,7 @@ EXTRA_CFLAGS			+= -mno-minimal-toc
 endif
 
 obj-$(CONFIG_MPIC)		+= mpic.o
+obj-$(CONFIG_MPIC_WEIRD)	+= mpic.o
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_BOOKE)		+= dcr.o
