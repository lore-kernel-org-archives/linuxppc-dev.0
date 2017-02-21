Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS6l45dSBzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 15:21:36 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS6l428Bgz9s1h
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 15:21:36 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L4J56s068423
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 23:21:34 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r12070bt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 23:21:34 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 09:51:31 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 95321125805F
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:51:35 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L4KPoQ10485920
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:50:25 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L4LSxt001385
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:51:28 +0530
Subject: [PATCH 1/2] Introduce add_taint variant that does not print warning.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 21 Feb 2017 09:51:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148765088309.20315.15300624012053746538.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Some interrupt handler's may not be happy to call printk and would lead to
unexpected behavior or kernel panic. e.g. machine_check_early() from MCE
handler on OPAL based system. Introduce add_taint variant that does not call
printk.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 include/linux/kernel.h |    1 +
 kernel/panic.c         |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index cb09238..799943e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -480,6 +480,7 @@ enum lockdep_ok {
 	LOCKDEP_NOW_UNRELIABLE
 };
 extern void add_taint(unsigned flag, enum lockdep_ok);
+extern void add_taint_no_warn(unsigned flag, enum lockdep_ok);
 extern int test_taint(unsigned flag);
 extern unsigned long get_taint(void);
 extern int root_mountflags;
diff --git a/kernel/panic.c b/kernel/panic.c
index 08aa88d..d344ea3 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -392,6 +392,12 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
 }
 EXPORT_SYMBOL(add_taint);
 
+void add_taint_no_warn(unsigned flag, enum lockdep_ok lockdep_ok)
+{
+	set_bit(flag, &tainted_mask);
+}
+EXPORT_SYMBOL(add_taint_no_warn);
+
 static void spin_msec(int msecs)
 {
 	int i;
