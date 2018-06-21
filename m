Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B2fL6G7MzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:30:18 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L0Ss3U086365
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:30:15 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jqx24xkgx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:30:14 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 20 Jun 2018 18:30:14 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH v04 7/9] powerpc/rtas: Allow disabling rtas_event_scan
In-Reply-To: <0425b353-54b0-6ccd-fbb6-3d26d9448bb5@linux.vnet.ibm.com>
Date: Wed, 20 Jun 2018 19:30:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <ae7435c7-7d45-0981-1caf-04972c46b930@linux.vnet.ibm.com>
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
index 4f45152..a94e3ff 100644
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
index f915db9..72f3696 100644
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
