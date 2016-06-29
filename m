Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfg8y27rFzDqvK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 21:16:18 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TBEEtK029277
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 07:16:15 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sm3wa22f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 07:16:15 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 21:16:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 717BE2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 21:16:10 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TBGAcu17039374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 21:16:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TBG9WI030173
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 21:16:10 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, mpe@ellerman.id.au, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
 David.Laight@ACULAB.COM
Subject: [PATCH v2 1/4] perf: Utility function to fetch arch
Date: Wed, 29 Jun 2016 16:45:55 +0530
In-Reply-To: <1467198958-9195-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1467198958-9195-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1467198958-9195-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add Utility function to fetch arch using evsel. (evsel->env->arch)

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v2:
  - No changes

 tools/perf/util/evsel.c | 7 +++++++
 tools/perf/util/evsel.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1d8f2bb..0fea724 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2422,3 +2422,10 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			 err, strerror_r(err, sbuf, sizeof(sbuf)),
 			 perf_evsel__name(evsel));
 }
+
+char *perf_evsel__env_arch(struct perf_evsel *evsel)
+{
+	if (evsel && evsel->evlist && evsel->evlist->env)
+		return evsel->evlist->env->arch;
+	return NULL;
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 828ddd1..86fed7a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -435,4 +435,6 @@ typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *);
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv);
 
+char *perf_evsel__env_arch(struct perf_evsel *evsel);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.5.5
