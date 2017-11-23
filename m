Return-Path: <srs0=nyc3=cv=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjH2P51vDzDrM4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 22:21:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yjH2P3nZyz8t88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 22:21:17 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yjH2P0BK0z9sPm
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 22:21:16 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vANBJmhP038795
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 06:21:15 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eduwbprxb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 06:21:14 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 23 Nov 2017 11:21:12 -0000
Subject: [RESEND PATCH] powernv: Avoid calling trace tlbie in kexec path.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 16:51:07 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151143595801.30911.1522075666229150195.stgit@jupiter.in.ibm.com>
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

Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
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
 
