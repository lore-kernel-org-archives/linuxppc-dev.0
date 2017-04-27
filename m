Return-Path: <ankit@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDFGh6TlszDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 21:34:36 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3RBXhXV050123
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 07:34:22 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a3aqwnpn6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 07:34:21 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ankit@linux.vnet.ibm.com>;
 Thu, 27 Apr 2017 21:34:18 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3RBY9r632112736
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 21:34:17 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3RBXfOZ017746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 21:33:43 +1000
From: Ankit Kumar <ankit@linux.vnet.ibm.com>
To: keescook@chromium.org, anton@enomsg.org, ccross@android.com,
 tony.luck@intel.com, xinhui.pan@linux.vnet.ibm.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, dja@axtens.net, geliangtang@163.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mahesh@linux.vnet.ibm.com, Ankit Kumar <ankit@linux.vnet.ibm.com>
Subject: [PATCH] Enabled pstore write for powerpc
Date: Thu, 27 Apr 2017 17:03:13 +0530
Message-Id: <1493292794-13166-1-git-send-email-ankit@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After commit c950fd6f201a kernel registers pstore write based on flag set.
Pstore write for powerpc is broken as flags(PSTORE_FLAGS_DMESG) is not set for
powerpc architecture. On panic, kernel doesn't write message to
/fs/pstore/dmesg*(Entry doesn't gets created at all).

This patch enables pstore write for powerpc architecture by setting
PSTORE_FLAGS_DMESG flag.

Fixes:c950fd6f201a pstore: Split pstore fragile flags
Signed-off-by: Ankit Kumar <ankit@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/nvram_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index d5e2b83..021db31 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -561,6 +561,7 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 static struct pstore_info nvram_pstore_info = {
 	.owner = THIS_MODULE,
 	.name = "nvram",
+	.flags = PSTORE_FLAGS_DMESG,
 	.open = nvram_pstore_open,
 	.read = nvram_pstore_read,
 	.write = nvram_pstore_write,
-- 
2.7.4
