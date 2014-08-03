Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04B261A01C4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Aug 2014 17:53:18 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Sun, 3 Aug 2014 13:23:14 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A89711258017
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Aug 2014 13:23:11 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s737tEB46095158
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Aug 2014 13:25:14 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s737r9Xc019109
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Aug 2014 13:23:09 +0530
Subject: [PATCH] powerpc/cpuidle: Fix parsing of idle state flags from
 device-tree
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Date: Sun, 03 Aug 2014 13:23:08 +0530
Message-ID: <20140803075119.10152.52685.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Flags from device-tree need to be parsed with accessors for
interpreting correct value in little-endian.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 74f5788..a64be57 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -160,10 +160,10 @@ static int powernv_cpuidle_driver_init(void)
 static int powernv_add_idle_states(void)
 {
 	struct device_node *power_mgt;
-	struct property *prop;
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states;
-	u32 *flags;
+	const __be32 *idle_state_flags;
+	u32 len_flags, flags;
 	int i;
 
 	/* Currently we have snooze statically defined */
@@ -174,18 +174,18 @@ static int powernv_add_idle_states(void)
 		return nr_idle_states;
 	}
 
-	prop = of_find_property(power_mgt, "ibm,cpu-idle-state-flags", NULL);
-	if (!prop) {
+	idle_state_flags = of_get_property(power_mgt, "ibm,cpu-idle-state-flags", &len_flags);
+	if (!idle_state_flags) {
 		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
 		return nr_idle_states;
 	}
 
-	dt_idle_states = prop->length / sizeof(u32);
-	flags = (u32 *) prop->value;
+	dt_idle_states = len_flags / sizeof(u32);
 
 	for (i = 0; i < dt_idle_states; i++) {
 
-		if (flags[i] & IDLE_USE_INST_NAP) {
+		flags = be32_to_cpu(idle_state_flags[i]);
+		if (flags & IDLE_USE_INST_NAP) {
 			/* Add NAP state */
 			strcpy(powernv_states[nr_idle_states].name, "Nap");
 			strcpy(powernv_states[nr_idle_states].desc, "Nap");
@@ -196,7 +196,7 @@ static int powernv_add_idle_states(void)
 			nr_idle_states++;
 		}
 
-		if (flags[i] & IDLE_USE_INST_SLEEP) {
+		if (flags & IDLE_USE_INST_SLEEP) {
 			/* Add FASTSLEEP state */
 			strcpy(powernv_states[nr_idle_states].name, "FastSleep");
 			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
