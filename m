Return-Path: <anton@samba.org>
Date: Sun, 30 Jan 2011 09:35:22 +1100
From: Anton Blanchard <anton@samba.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, jlarrew@linux.vnet.ibm.com
Subject: [PATCH 4/5] powerpc/numa: Disable VPHN on dedicated processor
	partitions
Message-ID: <20110130093522.1fee5a4e@kryten>
In-Reply-To: <20110130092434.42a887ef@kryten>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
	<1295409980.2148.125.camel@pasglop>
	<20110119043757.GA29865@us.ibm.com>
	<20110130092217.70ebb424@kryten> <20110130092434.42a887ef@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


There is no need to start up the timer and monitor topology changes on a
dedicated processor partition, so disable it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/numa.c	2011-01-29 12:58:01.849279835 +1100
+++ linux-2.6/arch/powerpc/mm/numa.c	2011-01-29 12:58:02.489239819 +1100
@@ -1520,7 +1520,8 @@ int start_topology_update(void)
 {
 	int rc = 0;
 
-	if (firmware_has_feature(FW_FEATURE_VPHN)) {
+	if (firmware_has_feature(FW_FEATURE_VPHN) &&
+	    get_lppaca()->shared_proc) {
 		vphn_enabled = 1;
 		setup_cpu_associativity_change_counters();
 		init_timer_deferrable(&topology_timer);
