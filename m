Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PPC5wyTzDrGB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:35 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNScGV092646
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:34 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9vfyus-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:34 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3CA7F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNTTs232178426
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNTSWl028724
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:29 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 01/20] selftests/powerpc: Compile selftests against headers
 without AT_HWCAP2
Date: Fri, 12 Aug 2016 09:28:00 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-2-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It might be nice to compile selftests against older kernels and
headers but which may not have HWCAP2.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/utils.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index fbd33e5..ecd11b5 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -32,10 +32,17 @@ static inline bool have_hwcap(unsigned long ftr)
 	return ((unsigned long)get_auxv_entry(AT_HWCAP) & ftr) == ftr;
 }
 
+#ifdef AT_HWCAP2
 static inline bool have_hwcap2(unsigned long ftr2)
 {
 	return ((unsigned long)get_auxv_entry(AT_HWCAP2) & ftr2) == ftr2;
 }
+#else
+static inline bool have_hwcap2(unsigned long ftr2)
+{
+	return false;
+}
+#endif
 
 /* Yes, this is evil */
 #define FAIL_IF(x)						\
-- 
2.9.2
