Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Vy212168zF24D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 08:00:40 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3OLxW60142648
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 18:00:37 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hj7kfeh2e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 18:00:37 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 24 Apr 2018 16:00:36 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/numa: Handle unitialized timer reset
Date: Tue, 24 Apr 2018 17:00:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <c6639718-a8a5-7595-aa96-4a0395092adc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the code in 'numa.c' may be reused when updating kernel
state after an LPAR migration event.  One such common function
is 'reset_topology_timer' which was being invoked by the
'.notifier_call' function within the NUMA module by
'of_property_notify'.  If this occurs after a previous call to
'stop_topology_update' or on a system without VPHN enabled, the
code runs into an unitialized timer structure and crashes.  This
patch adds a safety check along this path toward the problem code.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 57a5029..8802e7d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1457,7 +1457,8 @@ static void topology_timer_fn(struct timer_list *unused)
 
 static void reset_topology_timer(void)
 {
-	mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);
+	if (vphn_enabled)
+		mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);
 }
 
 #ifdef CONFIG_SMP
