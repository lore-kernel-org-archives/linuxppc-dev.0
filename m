Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50DB61A0D75
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 05:38:33 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Jul 2015 15:38:29 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 14DB638C8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 15:38:28 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t67JcRgd37814318
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2015 19:38:27 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t67JcR6D026495
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2015 15:38:27 -0400
Date: Tue, 7 Jul 2015 12:37:25 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: gustavold@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/perf/24x7: Fix lockdep warning
Message-ID: <20150707193725.GA12395@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 370152d9427e57cd9632b00189f71099f8e85544 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 7 Jul 2015 12:21:10 -0400
Subject: [PATCH 1/1] powerpc/perf/24x7: Fix lockdep warning

The sysfs attributes for the 24x7 counters are dynamically allocated.
Initialize the attributes using sysfs_attr_init() to fix following
warning which occurs when CONFIG_DEBUG_LOCK_VMALLOC=y.

[    0.346249] audit: initializing netlink subsys (disabled)
[    0.346284] audit: type=2000 audit(1436295254.340:1): initialized
[    0.346489] BUG: key c0000000efe90198 not in .data!
[    0.346491] DEBUG_LOCKS_WARN_ON(1)
[    0.346502] ------------[ cut here ]------------
[    0.346504] WARNING: at ../kernel/locking/lockdep.c:3002
[    0.346506] Modules linked in:

Reported-by: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index ec2eb20..df95629 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -320,6 +320,8 @@ static struct attribute *device_str_attr_create_(char *name, char *str)
 	if (!attr)
 		return NULL;
 
+	sysfs_attr_init(&attr->attr.attr);
+
 	attr->var = str;
 	attr->attr.attr.name = name;
 	attr->attr.attr.mode = 0444;
-- 
1.8.3.1
