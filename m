Return-Path: <srs0=hm5l=cu=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhqKR4lQ2zDr8h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 04:32:43 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yhqKQ4p0Vz8vSn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 04:32:42 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yhqKM49SMz9sDB
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 04:32:39 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAMHVugg142004
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2017 12:32:37 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2edcbm41n6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2017 12:32:33 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 22 Nov 2017 17:32:12 -0000
Subject: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 23:02:07 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Rebooting into a new kernel with kexec fails in trace_tlbie() which is
called from native_hpte_clear(). This happens if the running kernel has
CONFIG_LOCKDEP enabled. With lockdep enabled, the tracepoints always
execute few RCU checks regardless of whether tracing is on or off.
We are already in the last phase of kexec sequence in real mode with
HILE_BE set. At this point the RCU check ends up in RCU_LOCKDEP_WARN and
causes kexec to fail.

Fix this by not calling trace_tlbie() from native_hpte_clear().

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/hash_native_64.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 3848af1..640cf56 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -47,7 +47,8 @@
 
 DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
-static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
+static inline unsigned long  ___tlbie(unsigned long vpn, int psize,
+						int apsize, int ssize)
 {
 	unsigned long va;
 	unsigned int penc;
@@ -100,7 +101,15 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 			     : "memory");
 		break;
 	}
-	trace_tlbie(0, 0, va, 0, 0, 0, 0);
+	return va;
+}
+
+static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
+{
+	unsigned long rb;
+
+	rb = ___tlbie(vpn, psize, apsize, ssize);
+	trace_tlbie(0, 0, rb, 0, 0, 0, 0);
 }
 
 static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
@@ -652,7 +661,7 @@ static void native_hpte_clear(void)
 		if (hpte_v & HPTE_V_VALID) {
 			hpte_decode(hptep, slot, &psize, &apsize, &ssize, &vpn);
 			hptep->v = 0;
-			__tlbie(vpn, psize, apsize, ssize);
+			___tlbie(vpn, psize, apsize, ssize);
 		}
 	}
 
