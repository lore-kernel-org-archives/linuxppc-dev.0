Return-Path: <linuxppc-dev+bounces-22159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5AFCD8C8C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2026 14:03:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYH272Rk8z2xlV;
	Mon, 08 Jun 2026 00:03:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780840991;
	cv=none; b=d8rHX2eqRtK3YLTJ83bxyBd7WzdDc1Rh4z7xAcqEjpsFxTxzK7Y4Of8xAVKDxDWnOLb2ej/tetmfV6pQiRB8ubin8/5DpLsySvr31NGnMSRW64fGHBZvpV85qCbXjWxYHBMbD7OvVY/l1l+rRq3tcsLy5Kj6hIpGUlXQQzekhXZX0pYsUTmSwnHUkYwSiuQCitLSQZvO9I9U6W3gxLvmhHcMrF253b11sc4K1Hy6fZZ6txeBmW59GtDe9E7UV/ChFHx9PNDP+jloVpd9zu4AemFw4k7qzGWQy4B/PRa/XpJlfOUcnL6tunPCBq/yAEkqqNAAWzYdv+wxX/aKEN6PJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780840991; c=relaxed/relaxed;
	bh=92/15F0E7K+Gmt+DJNN7hwn2qqMr+y9fsv+d9JcHMSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eb/5i59xrrR+MsdiTlXacOz8hcOs6ONKMk0ovSeM2t3d61dnvUz5CUjbLbX7DZnw/NghX8eA771De52M7SOO5dpajNcqlMlrsOQiO7wTNtgTtfUQEh5XLYJnEsBXl9v9qvM102onavzTXKfvGQ7x4yiRsgGdOsnYMaq0JUe4PIodM7pJIwkuwjWAVvxE/ZioLblWlZZDO5q9AcwFY2ybfD4Vc/0SgLgPAayPK4YX53deUP7S6cQEzylXhDh587chsjq/hLdA5hbrcd2KDwVGcxBb8l3OW1SGxXINobkFd7cNiXpU+sKDxqYQjWCI30NFfrFNOhshyCD9GHsambS9Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rn4Rd2hx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rn4Rd2hx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYH252VT9z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 00:03:08 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657AudN73165130;
	Sun, 7 Jun 2026 14:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=92/15F0E7K+Gmt+DJNN7hwn2qqMr+y9fsv+d9JcHM
	Sw=; b=rn4Rd2hxuCXauF0SKbdEeMiCxkfSjWvsQFs01D11AwystNSSaW4FEACIY
	h+CcI/MjFc1OysbPiK2YLeXv7l5g1sXzu6debB/8yFIKCHEcth/ECZGT7Ox0CumG
	ejsAeWm7TQifUrE6aCxbbUFUU3AHXXOGSd6sNCJ53IO/YmQYxDkPFQMbpFpkmyyo
	ZPk6F8gq+vAVZT9DPsZ/IntwhNnNQkb1pxb8X1zUuQJzPn0vyjjKH5yEAVgjVYeK
	TAaxcs9tfE4qNli9mmXWahs2Ak1/5a+UYdkPM3TiZRjPyG1f7LQUSzLLYZFOCOcF
	BU/fUC2jiTvI8cuowp+9o6179FmJA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhm2h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 14:02:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657Dnapd026868;
	Sun, 7 Jun 2026 14:02:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vssdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 14:02:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657E2rYL57278722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 14:02:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08A9920040;
	Sun,  7 Jun 2026 14:02:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4222220049;
	Sun,  7 Jun 2026 14:02:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.16])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 14:02:48 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com,
        venkat88@linux.ibm.com
Subject: [PATCH V2] tools/perf/sched: Update process names of processes in zombie state for both -s and -S options
Date: Sun,  7 Jun 2026 19:32:45 +0530
Message-Id: <20260607140245.95706-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEzNSBTYWx0ZWRfX3gBK3KsX4JoS
 mfwFHmYiPJsRlr9iPxTvaEjLc8i8Pmp9yNyFLPya3/ACc7tSBFP9K2GtnMQu6YevVsL9nNrV7eb
 TY42Vt22DZOk5LP5XS+Kl9epVESPX1pCiKRqrT1QmFBkdJ+5YEvE/+0AAqAX020nKbwjadEH72U
 4j9XmlGAANk8xJac6ZL0pdgw4ANV+Hi3Z7wvM3SW6Fvg+Ee2QYUXTioSxhRVp4KQ0fIsKarWjLi
 eaJwNpN8y2LK8IqpM7MSY+7VleE4kNtVvuWHKjtw/dOi77mMKcoPkzRMBDqxzr3YY6lDFl96hv/
 On/p0gjhyGdCnRBoedWvzAn3ZStMVkogvZiApf5sZwem82SXDRn/9GVl8IQEQizGVQYec9NC9bI
 ukDfSqtNBMqrViaLjsibEU3LgVjvbRDnGon5Izfq80WaJguOsxkfUYF8TUbNI7nbLZwac+z/Pvg
 6YeA7RNjWY9+Y+gPxWg==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a257a12 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x5QCPqNzQhPJdF4W:21 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fa4VNzToAjw6E99RSBIA:9
X-Proofpoint-ORIG-GUID: LdMLDzD92-V2GmAAqTuh9EgA5zOWuSYO
X-Proofpoint-GUID: T-BxeIh0jjcDaAGtp5M1DMOMxB4iGfxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070135

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

Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog
v1 -> v2:
- Rebased on top of latest perf-tools-next
- Since there is no change in logic, carried Acked-by from
Namhyung Kim and Tested-by from Venkat Rao Bagalkote

 tools/perf/builtin-sched.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b7ccdc6a985d..5d3761a27e67 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2259,12 +2259,6 @@ static void timehist_print_sample(struct perf_sched *sched,
 		printf(" ");
 	}
 
-	if (!thread__comm_set(thread)) {
-		const char *prev_comm = perf_sample__strval(sample, "prev_comm");
-
-		thread__set_comm(thread, prev_comm, sample->time);
-        }
-
 	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
 
 	if (sched->show_prio)
@@ -2965,6 +2959,16 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 			thread__zput(itr->last_thread);
 		}
 
+		/*
+		 * If the process name is not set for the thread, use "prev_comm"
+		 * to set it. Otherwise the sched summary will have just pid information
+		 */
+		if (!thread__comm_set(thread)) {
+			const char *prev_comm = perf_sample__strval(sample, "prev_comm");
+
+			thread__set_comm(thread, prev_comm, sample->time);
+		}
+
 		if (!sched->summary_only)
 			timehist_print_sample(sched, sample, &al, thread, t, state);
 	}
-- 
2.52.0


