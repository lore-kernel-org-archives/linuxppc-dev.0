Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PNv6Z02zDr8Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:19 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNSaEw116512
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:18 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rtx3mf84-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:17 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7AC8E2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:12 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNTCt727918420
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNTCKg023259
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:12 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 12/20] selftests/powerpc: Add TM tcheck helpers in C
Date: Fri, 12 Aug 2016 09:28:11 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-13-cyrilbur@gmail.com>
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
2.9.2
