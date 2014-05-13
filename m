Return-Path: <cody@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 28944140083
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 13:10:22 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Mon, 12 May 2014 21:10:19 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BB8891FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:10:15 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4D39OVL63439006
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 05:09:24 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4D3AFjL031267
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:10:15 -0600
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>,
 Li Zhong <zhong@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Bolle <pebolle@tiscali.nl>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/pseries: relocate "config DTL" so KConfig nests
 properly
Date: Mon, 12 May 2014 20:09:55 -0700
Message-Id: <1399950599-24826-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 2cb8b77..e00dd4d 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -33,6 +33,16 @@ config PPC_SPLPAR
 	  processors, that is, which share physical processors between
 	  two or more partitions.
 
+config DTL
+	bool "Dispatch Trace Log"
+	depends on PPC_SPLPAR && DEBUG_FS
+	help
+	  SPLPAR machines can log hypervisor preempt & dispatch events to a
+	  kernel buffer. Saying Y here will enable logging these events,
+	  which are accessible through a debugfs file.
+
+	  Say N if you are unsure.
+
 config PSERIES_MSI
        bool
        depends on PCI_MSI && PPC_PSERIES && EEH
@@ -122,13 +132,3 @@ config HV_PERF_CTRS
 	  systems. 24x7 is available on Power 8 systems.
 
           If unsure, select Y.
-
-config DTL
-	bool "Dispatch Trace Log"
-	depends on PPC_SPLPAR && DEBUG_FS
-	help
-	  SPLPAR machines can log hypervisor preempt & dispatch events to a
-	  kernel buffer. Saying Y here will enable logging these events,
-	  which are accessible through a debugfs file.
-
-	  Say N if you are unsure.
-- 
1.9.3
