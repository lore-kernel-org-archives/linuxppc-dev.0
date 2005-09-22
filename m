Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D07E9682FA
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2005 05:51:43 +1000 (EST)
Date: Thu, 22 Sep 2005 14:51:34 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <Pine.LNX.4.61.0509221450190.30738@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: make sure we have an L3 before touch its control
 register
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Can you take a look at this.  I think its pretty straight forward and if 
your ok with it please forward on to linus.

- kumar

--

Some variants of 745x may not actually have the L3CR register.  Since
we mark which variants of 745x have L3CRs in the cputable we can
use that information to ensure that the mfspr L3CR will not cause
an exception in the processors that don't have the register.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit f706b6046f1fee29bdf3081dd783f7e482012165
tree 6d42ee61458ec94ac7d4567e3f0383dd1e47a537
parent d8ac10639b6a1ed900efbee38c18baaca31e64dc
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 22 Sep 2005 14:47:52 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 22 Sep 2005 14:47:52 -0500

 arch/ppc/kernel/cpu_setup_6xx.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/cpu_setup_6xx.S b/arch/ppc/kernel/cpu_setup_6xx.S
--- a/arch/ppc/kernel/cpu_setup_6xx.S
+++ b/arch/ppc/kernel/cpu_setup_6xx.S
@@ -212,9 +212,11 @@ setup_745x_specifics:
 	 * the firmware. If any, we disable NAP capability as
 	 * it's known to be bogus on rev 2.1 and earlier
 	 */
+BEGIN_FTR_SECTION
 	mfspr	r11,SPRN_L3CR
 	andis.	r11,r11,L3CR_L3E@h
 	beq	1f
+END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
 	lwz	r6,CPU_SPEC_FEATURES(r5)
 	andi.	r0,r6,CPU_FTR_L3_DISABLE_NAP
 	beq	1f
