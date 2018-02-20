Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCr3pCRzDrHV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:04 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0JUeS001785
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:01 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g84k90nsy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:01 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:00 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 02/12] selftests/powerpc: Fix tm.h helpers
Date: Tue, 20 Feb 2018 11:22:31 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-3-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Turns out the tcheck() helpers were subtly wrong

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index df4204247d45..e187a0d3160c 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -57,11 +57,11 @@ static inline bool failure_is_nesting(void)
 	return (__builtin_get_texasru() & 0x400000);
 }
 
-static inline int tcheck(void)
+static inline uint8_t tcheck(void)
 {
-	long cr;
-	asm volatile ("tcheck 0" : "=r"(cr) : : "cr0");
-	return (cr >> 28) & 4;
+	unsigned long cr;
+	asm volatile ("tcheck 0; mfcr %0;" : "=r"(cr) : : "cr0");
+	return (cr >> 28) & 0xF;
 }
 
 static inline bool tcheck_doomed(void)
@@ -81,7 +81,7 @@ static inline bool tcheck_suspended(void)
 
 static inline bool tcheck_transactional(void)
 {
-	return tcheck() & 6;
+	return (tcheck_active()) || (tcheck_suspended());
 }
 
 #endif /* _SELFTESTS_POWERPC_TM_TM_H */
-- 
2.16.2
