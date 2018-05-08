Return-Path: <clg@kaod.org>
Received: from 3.mo69.mail-out.ovh.net (3.mo69.mail-out.ovh.net
 [188.165.52.203])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gCGc0Lz1zF1p4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 18:25:11 +1000 (AEST)
Received: from player737.ha.ovh.net (unknown [10.109.122.11])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 3AA3E140E6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 09:05:51 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 4/4] powerpc/xive: prepare all hcalls to support long busy
 delays
Date: Tue,  8 May 2018 09:05:17 +0200
Message-Id: <20180508070517.947-5-clg@kaod.org>
In-Reply-To: <20180508070517.947-1-clg@kaod.org>
References: <20180508070517.947-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is not the case for the moment, but future releases of pHyp might
need to introduce some synchronisation routines under the hood which
would make the XIVE hcalls longer to complete.

As this was done for H_INT_RESET, let's wrap the other hcalls in a
loop catching the H_LONG_BUSY_* codes.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/spapr.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 31dc73cacd45..730284f838c8 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -164,7 +164,10 @@ static long plpar_int_get_source_info(unsigned long flags,
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 	long rc;
 
-	rc = plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
+	do {
+		rc = plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
+	} while (plpar_busy_delay(rc));
+
 	if (rc) {
 		pr_err("H_INT_GET_SOURCE_INFO lisn=%ld failed %ld\n", lisn, rc);
 		return rc;
@@ -194,8 +197,11 @@ static long plpar_int_set_source_config(unsigned long flags,
 		flags, lisn, target, prio, sw_irq);
 
 
-	rc = plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
-				target, prio, sw_irq);
+	do {
+		rc = plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
+					target, prio, sw_irq);
+	} while (plpar_busy_delay(rc));
+
 	if (rc) {
 		pr_err("H_INT_SET_SOURCE_CONFIG lisn=%ld target=%lx prio=%lx failed %ld\n",
 		       lisn, target, prio, rc);
@@ -214,7 +220,11 @@ static long plpar_int_get_queue_info(unsigned long flags,
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 	long rc;
 
-	rc = plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target, priority);
+	do {
+		rc = plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target,
+				 priority);
+	} while (plpar_busy_delay(rc));
+
 	if (rc) {
 		pr_err("H_INT_GET_QUEUE_INFO cpu=%ld prio=%ld failed %ld\n",
 		       target, priority, rc);
@@ -241,8 +251,11 @@ static long plpar_int_set_queue_config(unsigned long flags,
 	pr_devel("H_INT_SET_QUEUE_CONFIG flags=%lx target=%lx priority=%lx qpage=%lx qsize=%lx\n",
 		flags,  target, priority, qpage, qsize);
 
-	rc = plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
-				priority, qpage, qsize);
+	do {
+		rc = plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
+					priority, qpage, qsize);
+	} while (plpar_busy_delay(rc));
+
 	if (rc) {
 		pr_err("H_INT_SET_QUEUE_CONFIG cpu=%ld prio=%ld qpage=%lx returned %ld\n",
 		       target, priority, qpage, rc);
@@ -256,7 +269,10 @@ static long plpar_int_sync(unsigned long flags, unsigned long lisn)
 {
 	long rc;
 
-	rc = plpar_hcall_norets(H_INT_SYNC, flags, lisn);
+	do {
+		rc = plpar_hcall_norets(H_INT_SYNC, flags, lisn);
+	} while (plpar_busy_delay(rc));
+
 	if (rc) {
 		pr_err("H_INT_SYNC lisn=%ld returned %ld\n", lisn, rc);
 		return  rc;
@@ -277,7 +293,11 @@ static long plpar_int_esb(unsigned long flags,
 	pr_devel("H_INT_ESB flags=%lx lisn=%lx offset=%lx in=%lx\n",
 		flags,  lisn, offset, in_data);
 
-	rc = plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset, in_data);
+	do {
+		rc = plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset,
+				 in_data);
+	} while (plpar_busy_delay(rc));
+
 	if (rc) {
 		pr_err("H_INT_ESB lisn=%ld offset=%ld returned %ld\n",
 		       lisn, offset, rc);
-- 
2.13.6
