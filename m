Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41S3z40xw0zF35d
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 06:18:23 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6DKFvHl063111
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 16:18:22 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k6y4qh7as-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 16:18:21 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 13 Jul 2018 16:18:20 -0400
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v07 7/9] powerpc/rtas: Allow disabling rtas_event_scan
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <458ff569-f611-f506-afa1-138146551dde@linux.vnet.ibm.com>
Date: Fri, 13 Jul 2018 15:18:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a271ac20-e601-72b7-5ef6-ceecdb3b7c34@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/rtas: Provide mechanism by which the rtas_event_scan can
be disabled/re-enabled by other portions of the powerpc code.
Among other things, this simplifies the usage of locking mechanisms
for shared kernel resources.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h |    4 ++++
 arch/powerpc/kernel/rtasd.c     |   14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 4f601c7..4ab605a 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -386,8 +386,12 @@ extern int early_init_dt_scan_rtas(unsigned long node,
 
 #ifdef CONFIG_PPC_RTAS_DAEMON
 extern void rtas_cancel_event_scan(void);
+extern void rtas_event_scan_disable(void);
+extern void rtas_event_scan_enable(void);
 #else
 static inline void rtas_cancel_event_scan(void) { }
+static inline void rtas_event_scan_disable(void) { }
+static inline void rtas_event_scan_enable(void) { }
 #endif
 
 /* Error types logged.  */
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 44d66c33d..af69e44 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -455,11 +455,25 @@ static void do_event_scan(void)
  */
 static unsigned long event_scan_delay = 1*HZ;
 static int first_pass = 1;
+static int res_enable = 1;
+
+void rtas_event_scan_disable(void)
+{
+	res_enable = 0;
+}
+
+void rtas_event_scan_enable(void)
+{
+	res_enable = 1;
+}
 
 static void rtas_event_scan(struct work_struct *w)
 {
 	unsigned int cpu;
 
+	if (!res_enable)
+		return;
+
 	do_event_scan();
 
 	get_online_cpus();
