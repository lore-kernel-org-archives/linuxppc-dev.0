Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSmZ33NDpzDrq3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:31 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85Nh0TX144407
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:45:29 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 259dmh0a7w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 19:45:28 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 6 Sep 2016 09:45:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A2DD43578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:24 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85NjOse5177748
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:24 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85NjOfi026197
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:24 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: wei.guo.simon@gmail.com, mikey@neuling.org
Subject: [PATCH v4 01/20] selftests/powerpc: Compile selftests against headers
 without AT_HWCAP2
Date: Tue,  6 Sep 2016 09:44:29 +1000
In-Reply-To: <20160905234448.5866-1-cyrilbur@gmail.com>
References: <20160905234448.5866-1-cyrilbur@gmail.com>
Message-Id: <20160905234448.5866-2-cyrilbur@gmail.com>
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
2.9.3
