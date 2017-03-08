Return-Path: <srs0=msm2=2r=linux.vnet.ibm.com=bharata@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdWyz0VrMzDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 22:49:31 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vdWyy74G7z8sX0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 22:49:30 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vdWyy2JRhz9sCZ
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Mar 2017 22:49:30 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v28Bn16A039531
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Mar 2017 06:49:27 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292ec88232-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Mar 2017 06:49:27 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Wed, 8 Mar 2017 17:19:24 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v28BmCRV15532114
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Mar 2017 17:18:12 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v28BnKjv012597
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Mar 2017 17:19:21 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: nfont@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [FIX PATCH] powerpc/pseries: Fix reference count leak during CPU
 unplug
Date: Wed,  8 Mar 2017 17:19:15 +0530
Message-Id: <1488973755-30269-1-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following warning is seen when a CPU is hot unplugged on a PowerKVM
guest:

refcount_t: underflow; use-after-free.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 53 at lib/refcount.c:128 refcount_sub_and_test+0xd8/0xf0
Modules linked in:
CPU: 0 PID: 53 Comm: kworker/u510:1 Not tainted 4.11.0-rc1 #3
Workqueue: pseries hotplug workque pseries_hp_work_fn
task: c0000000fb475000 task.stack: c0000000fb81c000
NIP: c0000000006f0808 LR: c0000000006f0804 CTR: c0000000007b98c0
REGS: c0000000fb81f710 TRAP: 0700   Not tainted  (4.11.0-rc1)
MSR: 800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
  CR: 48002222  XER: 20000000
CFAR: c000000000c438e0 SOFTE: 1
GPR00: c0000000006f0804 c0000000fb81f990 c000000001573b00 0000000000000026
GPR04: 0000000000000000 000000000000016c 667265652e0d0a73 652d61667465722d
GPR08: 0000000000000007 0000000000000007 0000000000000001 0000000000000006
GPR12: 0000000000002200 c00000000ff40000 c00000000010c578 c0000001f11b9f40
GPR16: c0000001fe0312a8 c0000001fe031078 c0000001fe031020 0000000000000001
GPR20: 0000000000000000 0000000000000000 c000000001454808 fffffffffffffef7
GPR24: 0000000000000000 c0000001f1677648 0000000000000000 0000000000000000
GPR28: 0000000010000008 c000000000e4d3d8 0000000000000000 c0000001eaae07d8
NIP [c0000000006f0808] refcount_sub_and_test+0xd8/0xf0
LR [c0000000006f0804] refcount_sub_and_test+0xd4/0xf0
Call Trace:
[c0000000fb81f990] [c0000000006f0804] refcount_sub_and_test+0xd4/0xf0 (unreliable)
[c0000000fb81f9f0] [c0000000006d04b4] kobject_put+0x44/0x2a0
[c0000000fb81fa70] [c0000000009d5284] of_node_put+0x34/0x50
[c0000000fb81faa0] [c0000000000aceb8] dlpar_cpu_remove_by_index+0x108/0x130
[c0000000fb81fb30] [c0000000000ae128] dlpar_cpu+0x78/0x550
[c0000000fb81fbe0] [c0000000000a7b40] handle_dlpar_errorlog+0xc0/0x160
[c0000000fb81fc50] [c0000000000a7c74] pseries_hp_work_fn+0x94/0xa0
[c0000000fb81fc80] [c000000000102cec] process_one_work+0x23c/0x540
[c0000000fb81fd20] [c00000000010309c] worker_thread+0xac/0x620
[c0000000fb81fdc0] [c00000000010c6c4] kthread+0x154/0x1a0
[c0000000fb81fe30] [c00000000000bbe0] ret_from_kernel_thread+0x5c/0x7c

Fix this by ensuring that of_node_put() is called only from the
error path in dlpar_cpu_remove_by_index(). In the normal path,
of_node_put() happens as part of dlpar_detach_node().

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 7bc0e91..b5eff35 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -619,7 +619,8 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
 	}
 
 	rc = dlpar_cpu_remove(dn, drc_index);
-	of_node_put(dn);
+	if (rc)
+		of_node_put(dn);
 	return rc;
 }
 
-- 
2.7.4
