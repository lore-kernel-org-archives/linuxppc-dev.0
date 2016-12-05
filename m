Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXLTb0TTXzDvyr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 21:24:18 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB5AK33v127869
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 05:24:16 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2753ydetcd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 05:24:16 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 5 Dec 2016 15:54:13 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1BBB61258026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 15:55:18 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB5ANZ6W23003356
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 15:53:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB5AO3XJ028784
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 15:54:10 +0530
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com,
 paulmck@linux.vnet.ibm.com, waiman.long@hpe.com,
 xinhui.pan@linux.vnet.ibm.com,
 virtualization@lists.linux-foundation.org, boqun.feng@gmail.com
Subject: [PATCH v8 5/6] powerpc: pSeries: Add pv-qspinlock build config/make
Date: Mon,  5 Dec 2016 10:19:25 -0500
In-Reply-To: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1480951166-44830-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pSeries run as a guest and might need pv-qspinlock.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/Makefile           | 1 +
 arch/powerpc/platforms/pseries/Kconfig | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1925341..4780415 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_P7_NAP)	+= idle_book3s.o
 procfs-y			:= proc_powerpc.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
+obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= paravirt.o
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
 obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y-y)
 obj-$(CONFIG_PPC_RTAS_DAEMON)	+= rtasd.o
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 8a87d06..0288c78 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -31,6 +31,14 @@ config ARCH_USE_QUEUED_SPINLOCKS
 	  fairlock.  It has shown a good performance improvement on x86 and also ppc
 	  especially in high contention cases.
 
+config PARAVIRT_SPINLOCKS
+       bool "Paravirtialization support for qspinlock"
+       depends on PPC_SPLPAR && QUEUED_SPINLOCKS
+       default y
+       help
+         If kernel need run as a guest then enable this option.
+         Generally it can let kernel have a better performace.
+
 config PPC_SPLPAR
 	depends on PPC_PSERIES
 	bool "Support for shared-processor logical partitions"
-- 
2.4.11
