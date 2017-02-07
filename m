Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHw6d2dgTzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 06:55:05 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17JrlrW113208
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 14:55:02 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28fgmt48jb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 14:55:02 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 01:24:59 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 84D663940033
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 01:24:56 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17JsuVM37355614
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 01:24:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v17JssqB021799
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 01:24:55 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: mhiramat@kernel.org, ananth@linux.vnet.ibm.com
Cc: mingo@kernel.org, mpe@ellerman.id.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] kprobes: introduce weak variant of
 kprobe_exceptions_notify
Date: Wed,  8 Feb 2017 01:24:14 +0530
Message-Id: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kprobe_exceptions_notify() is not used on some of the architectures such
as arm[64] and powerpc anymore. Introduce a weak variant for such
architectures.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/kprobes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 43460104f119..60a702a05684 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1705,6 +1705,12 @@ void unregister_kprobes(struct kprobe **kps, int num)
 }
 EXPORT_SYMBOL_GPL(unregister_kprobes);
 
+int __weak __kprobes kprobe_exceptions_notify(struct notifier_block *self,
+					      unsigned long val, void *data)
+{
+	return NOTIFY_DONE;
+}
+
 static struct notifier_block kprobe_exceptions_nb = {
 	.notifier_call = kprobe_exceptions_notify,
 	.priority = 0x7fffffff /* we need to be notified first */
-- 
2.11.0
