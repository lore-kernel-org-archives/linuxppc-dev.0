Return-Path: <linuxppc-dev+bounces-20120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67630FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 09:39:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3M9k0WKrz2yFl;
	Sun, 26 Apr 2026 19:39:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777196393;
	cv=none; b=LebCdNhimGqY1ARtYCyOu60pH4YGfDpZ2DErpno6Ci7VMVFbjvEJ0BV5tfARIsaVFF4V54qjBguPooYDnow6d/t43TMUdLMdARGtWgXfhR9HO+CC0C2g7yEU6LnZ0k4/Uzlps+N5QHk7fRwG14TI34ECV1IutQzmLCqC3ZaOgT3EB1rkcM/vsu0dmzDL/6S4OYVBMrgenAJvFiSdB6lOOiIMeDxrpcKqkFC8Niru/9Z9ySa3fFYYmZdwukDkpjJiv7vJii4E/r3MUyQ/AYadJl0g2AWXr2vepg6RO2U4jo1CRULrpmS18blVYrMqRvu1zW7t231KvWW+lbml2SHc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777196393; c=relaxed/relaxed;
	bh=Rzji9qKGrPdQU8n/vuCu/SOzBClb11q0e3ag7y2Rt6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OPN2tue2uVD0Q+sXBQLZbURu5Op1Q4r39E9egscPPIuwbnUtOiZb0GYZYWXUj+DIFZfLgjF365jbVZz5RT4uy1xsDv57FPrGSIJelQOgBKEaGpWAQBYG8632nT91SJQwYuiz3iZoOWCJSp8uXNfcuGWViu1N0n7bo206OGQv3VXjjE7EeFsXKfhvHrSk5545zxG4QOe877OVBka9HkEFEuyO1u9X+J7sQZavCPklskMlbPXsZcW7zOyCHT/Sm8k/SWdMfC+HUAvRB9So1xz09IToTdn+RQL6urq4AVY/H/FdtF1c1Mv0YdrTS5LEDFz9dGsObNmJILA+UsPQqQ7wVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cTmad9Aa; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cTmad9Aa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3M9h6vzfz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 19:39:52 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63Q4A79U1150119;
	Sun, 26 Apr 2026 09:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Rzji9qKGrPdQU8n/vuCu/SOzBClb11q0e3ag7y2Rt
	6I=; b=cTmad9Aaa7IMs3MVuHomJCNXcJ316XXbhjwdtepMyJ/dSN7QKm3ByGw4p
	7ALzdNDQPaxhjK50J68fog1W72G6mmWXp8gE0P3qOJmch3lBPBCLAAhLcswK7nM7
	8S8Xml2D1VLCp4f/n5pOnIoGHMeMOPf8smBuFbg8seM5vQLzHj7CmUbMdPxoNqAY
	IkMM4sV3TjxiJM//TBvJ+ZNusK994HrJhB/GGsPBoI+aP8eLA+9/TlKXk6TWDBwM
	lFd/Y/LB5Lf4aytmVDnofq62RNa+FmCBM/4e+rkZfhxlTM1h/af8+yASRSOkAZqC
	11aMZs7dL2ldSYqXRL3qZ6N2iyZiQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jbw0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 09:39:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63Q9O5jg029691;
	Sun, 26 Apr 2026 09:39:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avh4n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 09:39:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63Q9ddmw51315160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Apr 2026 09:39:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA6952004D;
	Sun, 26 Apr 2026 09:39:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8018820040;
	Sun, 26 Apr 2026 09:39:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.109])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 26 Apr 2026 09:39:34 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH] tools/perf/sched: Update process names of processes in zombie state for both -s and -S options
Date: Sun, 26 Apr 2026 15:09:30 +0530
Message-Id: <20260426093930.47809-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDA5OSBTYWx0ZWRfX/8+LjuHDFXki
 dtU7ns7jpK1cb6Fdv94IFoUfNQcOg9pizjsRxGvYpafg53EHU9oYZh7P3+It2oIKofk7w6Ni3vT
 ls9+KMP5obKOyl4We5AYNUbrWHP39gQm3TK4xAFUbXzWvDrn8jB6Bu2d2HpqS9OsEaE4VEaMj+b
 3bzsamCVHtvUupwB3ApzR/MPPYmSH4Q10SRRe+jCGCV7Unagbc3FqBi8IMwrukIBEs+3INkBnsD
 vkvwNOWBX7CnqehtTFgsj9zDXMyYA6FmkqHNNBCYiBzPVDyu90Dt66FclhSDFdwjMLLrwErq47+
 5t0FbKrNHySDFl/hGHtSc6CshloSUKR7H82YvbDFVWkuXNx6lG55pavOAiPR2TIF6mO5dp+pQ6H
 Brtkv27nkcy1qfZ2xUliLzgQ3O3ICtOPKyWBBcm43s0PmztKwBn6Xh3JCoPqB5VEYmYb2GTF+Hh
 1YZdXp2QAsh+7ATgu7w==
X-Proofpoint-GUID: VA2OYQ8NSMqxzS-t4DUpBhtFlq7NHEgQ
X-Proofpoint-ORIG-GUID: 1qfgpkasp8_3e0-KPL2UHD0bI7UgIUOs
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69eddd60 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x5QCPqNzQhPJdF4W:21 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Fhc_E1mSigePmb3TSNAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604260099

In redhat perftool testsuite, observed fail for this test:
    -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary (output regexp parsing)

This led to analysis of "perf sched timehist" summary options.

  # perf sched record -a -o ./perf.data -- sleep 0.1
   This will record using perf sched record

perf sched timeliest has two options "-s" and "-S"
  # perf sched -i ./perf.data timehist -S
 -S : Captures summary also at the end

  # perf sched -i ./perf.data timehist -s
 -s : Captures only summary

The test saves -s result which has only summary and compares with
summary which comes at the end from -S . Since there is a difference
in these two, test fails.

Checking the behaviour change in -S and -s results, difference is:

                  rcu_sched[16]       2          4        0.013      0.001       0.003       0.006   33.23       0
               migration/11[73]       2          1        0.006      0.006       0.006       0.006    0.00       0
                migration/3[33]       2          1        0.006      0.006       0.006       0.006    0.00       0
 -               :216753[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
 +                 sleep[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
                migration/8[58]       2          1        0.005      0.005       0.005       0.005    0.00       0
            NetworkManager[811]       1          2        0.089      0.028       0.044       0.060   36.06       0
               migration/13[83]       2          1        0.005      0.005       0.005       0.005    0.00       0

Here 216753 is pid for sleep which is a zombie process. This is
happening in latest kernel due to an update in "-S" result.
In -S, the process name appears in the results "sleep[216753]",
where as in the -s, only pid is present in the summary result
":216753[216753]".

After commit 39f473f6d0b2 ("perf sched timehist: decode process names
of processes in zombie state")
for -S option, if process name is using pid, it uses different way to
set it. So that we get the process name and not just Pid.

This change went in only for timehist_print_sample() function.
Add this improvement in generic place so that even -s option (which
captures summary) also will have meaningful information.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/builtin-sched.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..ee1b89a6af50 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2197,11 +2197,6 @@ static void timehist_print_sample(struct perf_sched *sched,
 		printf(" ");
 	}
 
-	if (!thread__comm_set(thread)) {
-                const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
-                thread__set_comm(thread, prev_comm, sample->time);
-        }
-
 	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
 
 	if (sched->show_prio)
@@ -2890,6 +2885,15 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 			itr->last_thread = NULL;
 		}
 
+		/*
+		 * If the process name is not set for the thread, use "prev_comm"
+		 * to set it. Otherwise the sched summary will have just pid information
+		 */
+		if (!thread__comm_set(thread)) {
+			const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
+			thread__set_comm(thread, prev_comm, sample->time);
+		}
+
 		if (!sched->summary_only)
 			timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
 	}
-- 
2.47.3


