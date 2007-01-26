Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A9971DE34C
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 07:55:07 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0QKt49C022974
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 15:55:04 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0QKt4Xb455216
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:55:04 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0QKt4e0025988
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:55:04 -0700
Date: Fri, 26 Jan 2007 14:55:03 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] pSeries: EEH improperly enabled for some Power4 systems
Message-ID: <20070126205503.GA11220@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,

The attached patch seems like a late-arriving candidate for 2.6.20
I've had it floating around for a few weeks, and should have  sent it
earler.

--linas

It appears that EEH is improperly enabled for some Power4 systems.
On these systems, the ibm,set-eeh-option returns a value of success
even when EEH is not supported on the given node. Thus, an explicit
check for support is required.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com> 

----
 arch/powerpc/platforms/pseries/eeh.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.20-rc4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-01-11 14:15:02.000000000 -0600
+++ linux-2.6.20-rc4/arch/powerpc/platforms/pseries/eeh.c	2007-01-11 15:14:39.000000000 -0600
@@ -748,6 +748,7 @@ struct eeh_early_enable_info {
 /* Enable eeh for the given device node. */
 static void *early_enable_eeh(struct device_node *dn, void *data)
 {
+	unsigned int rets[3];
 	struct eeh_early_enable_info *info = data;
 	int ret;
 	const char *status = get_property(dn, "status", NULL);
@@ -804,16 +805,14 @@ static void *early_enable_eeh(struct dev
 		                regs[0], info->buid_hi, info->buid_lo,
 		                EEH_ENABLE);
 
+		enable = 0;
 		if (ret == 0) {
-			eeh_subsystem_enabled = 1;
-			pdn->eeh_mode |= EEH_MODE_SUPPORTED;
 			pdn->eeh_config_addr = regs[0];
 
 			/* If the newer, better, ibm,get-config-addr-info is supported, 
 			 * then use that instead. */
 			pdn->eeh_pe_config_addr = 0;
 			if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) {
-				unsigned int rets[2];
 				ret = rtas_call (ibm_get_config_addr_info, 4, 2, rets, 
 					pdn->eeh_config_addr, 
 					info->buid_hi, info->buid_lo,
@@ -821,6 +820,20 @@ static void *early_enable_eeh(struct dev
 				if (ret == 0)
 					pdn->eeh_pe_config_addr = rets[0];
 			}
+
+			/* Some older systems (Power4) allow the
+			 * ibm,set-eeh-option call to succeed even on nodes
+			 * where EEH is not supported. Verify support
+			 * explicitly. */
+			ret = read_slot_reset_state(pdn, rets);
+			if ((ret == 0) && (rets[1] == 1))
+				enable = 1;
+		}
+
+		if (enable) {
+			eeh_subsystem_enabled = 1;
+			pdn->eeh_mode |= EEH_MODE_SUPPORTED;
+
 #ifdef DEBUG
 			printk(KERN_DEBUG "EEH: %s: eeh enabled, config=%x pe_config=%x\n",
 			       dn->full_name, pdn->eeh_config_addr, pdn->eeh_pe_config_addr);
