Return-Path: <linuxppc-dev+bounces-21993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF819CD6E68
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 06:56:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWFhk6rljz2y1Y;
	Thu, 04 Jun 2026 16:56:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780556166;
	cv=none; b=cEas7ctBq+k798HzERgtMJv1X+mWptd0xd/Bq10eNgJul1fbkZfrFMBgqrUYDQvBhDUUZaxIl4BorCwzN11KB4l5wTzPAfcSH8imtMCJ9dAYcWzSku7tHByeld24SsVhvDYcAqEU/Dm9A8cA1F8d2sF7g1I0ZqyEhV+A7G4MSMkP8E4iU+G8QEurYTABcFOCdxXfg7leIlmblUVI6BG7GrTKDv1E74NJ6/SNGz1Iq4M4VPGN4HSJTO/MIVQbtcXExPDCbacT7/x8M8nKTWbSUO4MkebhT+bVTjx1Uo74M9FaATYUG7DM6XMub+IocyAvBF+Aw5/YHsWx6msd7h14nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780556166; c=relaxed/relaxed;
	bh=v7q8lGE5veN+Zy2Yq8Lm666Ruc/DM2nucqA19GrYgQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHAKPuGuK3ShpobGK2wTvhCSvIE5LhttACAyD0zpM2nJ2K7RY0Tf4ph7k7oQn23W/Cz+YN90fTZRqYyvoQuTuccb1bkHNCU4zLm3Oibbdmh26XNAlQsW3ozDhS64GivqGzthAHRWgIbQKb4NRCAKm3GwhkhIpV8VYxIzayrH08hnVYf6tCOgqxQvKi8EdXd7YIeoK2FjJ2U4agRvtKKwlded+pn1+LrQYzRAv2MD9uhMg9H6LeCt58SIHBFsKYFrNEZ439admTxGgEkdiSb+3scIBOEl+1wGWfNVEHj2Tp56ATX+Ah3Zskl9DDyxo7PZv8Xn1FkNpm6Zo31P1fS4cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nAy0wTlP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nAy0wTlP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWFhg0z2tz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 16:56:02 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653LeEhp2223981;
	Thu, 4 Jun 2026 06:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=v7q8lGE5veN+Zy2Yq8Lm666Ruc/DM2nucqA19GrYg
	QU=; b=nAy0wTlPB7epWS3ciKMbEyLbBRU401ZBQOGfjqGXrK7/R30sphV47zZmJ
	DNe5+1mpjrR4x8LQCbEUqIBr6xV+rtlnkSVOeAeZFKmYV3al8TRMFXBk7+iRkCpj
	HEXbkuDTk5X6DnAEAo3lp1ZAsS3mrvAtdcXxDu0wiLhpIToSt2zdsVq2MmxQlcFx
	0E6mXpFORTKmA3gRw4uDDdk3DbpQv48zwUx2aw8sM8uStVeqkMWVVsvtP/0kHByk
	klYAc0uLjhSPFhhE/tyZMBjU6RfQ0zDOxmPd5TCuf0gQjd367ZTuRJYaui0dD7Tm
	8ewJ79Uq8kjloLK5UMh49kclvShfQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4ep7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 06:55:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6546sB70028157;
	Thu, 4 Jun 2026 06:55:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhktxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 06:55:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6546toTf23331152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 06:55:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAB8920043;
	Thu,  4 Jun 2026 06:55:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3A0220040;
	Thu,  4 Jun 2026 06:55:45 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.124.210.20])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 06:55:45 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH] perf data convert json: Fix trace_seq memory leak in process_sample_event()
Date: Thu,  4 Jun 2026 12:25:19 +0530
Message-ID: <20260604065519.112101-1-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2MiBTYWx0ZWRfX/oCjBzRrb5No
 uayxiaNhgf5UYzf71bybru8TfKUwpBdfwU7CntxGEY85AbONISN8Yt9VajNncyA00lzjeIBRVLV
 vzMlswQvL6P0JxhJBQaXp/rT3/TmxAH9Wx6RvAxhvcstmfnrSvEVl64QACR4n8IQK0HQI+R+fjR
 ySvsgS1VCo+VDhbqPWF82oLKvIFFRt4dcLIuVRJ6tfPXLCWcQyAJjqopzsH9Q16YpMgNg1cHmVM
 geSj93lFhs3zKfgelJiIWlyVrUbjKo6M4bYr1a6dzUd4JKvSyKRM1R3WyHWDUYk7N6lHULeQtod
 bNvsGIenbIpTRzdaLcnKzSm/3HErkXseA99cjIfbJKyLGIT9FkBSkd98Ccz02qeBRmRyIeuyX6x
 dyT9pV0GaLDtoaQ4nnbCpAExxvJ7nd+V3/ZHSlcQTQB5zSv3GKNXg85e9jA5S7Xwb/yK1Z7xTrg
 4O/8MGofM6rK3OoLzBQ==
X-Proofpoint-GUID: zt4s_CatP7Ff5t38XY6C0Dc18WjjcIEQ
X-Proofpoint-ORIG-GUID: 3AT3m9-D5EmDiNatLrnIoKrIPfXmyOXF
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a21217d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Nc15H_VyoKEvSVhrjhoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040062

Unlike the in-kernel trace_seq which uses a statically allocated buffer,
the userspace traceevent library's trace_seq uses a dynamically allocated
one. Therefore, every trace_seq_init() call must be paired with a
trace_seq_destroy(), otherwise it produces a memory leak.

In process_sample_event(), a trace_seq is initialized for each field when
formatting tracepoint raw_data, but the matching trace_seq_destroy() is
never called, leaking memory for every field of every sample processed.

Add the missing trace_seq_destroy() after using the trace_seq buffer to
properly free the allocated memory.

Detected with Valgrind on a perf.data file with 2,729 tracepoint samples:
  Before: definitely lost: 55,537,664 bytes in 13,559 blocks
  After:  definitely lost: 0 bytes in 0 blocks

Fixes: 9d895e468429 ("perf data: Add tracepoint fields when converting to JSON")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/data-convert-json.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index d526c91312ed..6dd9349ab10f 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -257,6 +257,7 @@ static int process_sample_event(const struct perf_tool *tool,
 				trace_seq_init(&s);
 				tep_print_field(&s, sample->raw_data, fields[i]);
 				output_json_key_string(out, true, 3, fields[i]->name, s.buffer);
+				trace_seq_destroy(&s);
 
 				i++;
 			}
-- 
2.47.3


