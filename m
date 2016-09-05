Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSmZT3tm0zDrpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:53 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85NgxZP002898
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:45:51 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259dh6rm5d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 19:45:51 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 6 Sep 2016 09:45:49 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D28863578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85Njj7U4915612
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85Njjei025074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:45 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: wei.guo.simon@gmail.com, mikey@neuling.org
Subject: [PATCH v4 12/20] selftests/powerpc: Add TM tcheck helpers in C
Date: Tue,  6 Sep 2016 09:44:40 +1000
In-Reply-To: <20160905234448.5866-1-cyrilbur@gmail.com>
References: <20160905234448.5866-1-cyrilbur@gmail.com>
Message-Id: <20160905234448.5866-13-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index 60318ba..2c8da74 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -52,4 +52,31 @@ static inline bool failure_is_nesting(void)
 	return (__builtin_get_texasru() & 0x400000);
 }
 
+static inline int tcheck(void)
+{
+	long cr;
+	asm volatile ("tcheck 0" : "=r"(cr) : : "cr0");
+	return (cr >> 28) & 4;
+}
+
+static inline bool tcheck_doomed(void)
+{
+	return tcheck() & 8;
+}
+
+static inline bool tcheck_active(void)
+{
+	return tcheck() & 4;
+}
+
+static inline bool tcheck_suspended(void)
+{
+	return tcheck() & 2;
+}
+
+static inline bool tcheck_transactional(void)
+{
+	return tcheck() & 6;
+}
+
 #endif /* _SELFTESTS_POWERPC_TM_TM_H */
-- 
2.9.3
