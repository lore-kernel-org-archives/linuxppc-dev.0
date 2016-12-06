Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tY29t1SXqzDvtg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:13:06 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB6D5ciP102568
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 08:13:03 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 275w5hb88b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 08:13:03 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 23:13:01 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CBA303578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:12:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB6DCx835046574
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:12:59 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB6DCwR2000404
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:12:59 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 longman@redhat.com, xinhui.pan@linux.vnet.ibm.com,
 virtualization@lists.linux-foundation.org, boqun.feng@gmail.com
Subject: [PATCH v9 2/6] powerpc: platforms/Kconfig: Add qspinlock build config
Date: Tue,  6 Dec 2016 13:09:23 -0500
In-Reply-To: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1481047767-60255-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pSeries/powerNV will use qspinlock from now on.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index fbdae83..3559bbf 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -20,6 +20,15 @@ source "arch/powerpc/platforms/44x/Kconfig"
 source "arch/powerpc/platforms/40x/Kconfig"
 source "arch/powerpc/platforms/amigaone/Kconfig"
 
+config ARCH_USE_QUEUED_SPINLOCKS
+        depends on PPC_PSERIES || PPC_POWERNV
+        bool "Enable qspinlock"
+        default y
+        help
+	  Enabling this option will let kernel use qspinlock which is a kind of
+	  fairlock.  It has shown a good performance improvement on x86 and also
+	  ppc especially in high contention cases.
+
 config KVM_GUEST
 	bool "KVM Guest support"
 	default n
-- 
2.4.11
