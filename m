Return-Path: <linuxppc-dev+bounces-25818-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B484C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:46:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLL8n3Q6zz2ygG;
	Thu, 13 Aug 2026 19:46:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786614377;
	cv=none; b=GlJx5h73iufrOgz/EvAK4JHr+o3+/3j/bFMCCopmFKeT+zlL/Mkl/eGcr6lIeKf/COVoJddcAfkjfpYqPruPQcI5zJPR7oEMBedBJkpeKFmqjm1FZ73bcVkzUrFp6/Y3c0eRlV3VgxRajABdOYljOb72ZrOzKdFn8Ep9nJ8xE0o+XQmG3WoCSRcZOSExkRrGrGxSVwN54wvvWU/ITURbR0lnEFgAZEQETEq4+flexIiERArLrM8EgdcsyH9wKz6hoxZNH8MIXIJnTLV/+iB8CTrImo4CEDyaimTQTow234pZyDJRx1RuE9YNtgjg7wYECsIdRVEA2b6yD05qrsHB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786614377; c=relaxed/relaxed;
	bh=xzMVkPaBPArW37WMHbKa1fYCa1MnsYfvPwV0Im3Ynsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2e6X3JCGQGOuzvFwBdFFgLaydRjCyFQbhk15PniQNIJ3Q2mdxLXfETbaQqA99iGsod3q6+EUKhR4ZqSVHMxrOjcIsA23V8i+5YL7lcJ+uu7ZXG6xIqGpG/5XsbPNiSWAY0R0q8nZx53/Va4l8oVYhUYCkECJfEHU005kUia8tKdvp2K84DF9QRtADhZ0hbVb2Xl8nWIi5kJlGUSdxZsawGJJJ/FsYg+hGujn2YFaNW7KrzuXcj54rfqD9yGdb0YYEfMbSmTwKFqSFaCIaFQ0Lt70KQVPOHDEQXSS6mb8go6kVRcgdDh4SEMh1r3jsYvzFCLswgtl4vOSQ3nfoElEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qKbv2nqI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qKbv2nqI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLL8m44qLz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:46:16 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98wp7811167;
	Thu, 13 Aug 2026 09:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xzMVkPaBPArW37WMH
	bKa1fYCa1MnsYfvPwV0Im3Ynsw=; b=qKbv2nqIy64rse51mLJcg467ezh1tosv0
	0v9GU3QGw0290tTiGBOvW+1amWk49xy7AE1WXmY3KEh3KfS4EtwnODxhHF7dXQWO
	01eZV5rSmmNVv3paije5OKGgTX6aNYi6b24PHRrfSVd/+QomhPoZhnOdlGHDCisz
	i0USg9UsWbWaBvlq6Ew5ok45CUcuKglOQIZLZc8yMTG5o8kDy3F6kMnZZlP5qky+
	NxC2Q7v/tdcc+kI4q5tq2Nf1lAuA7vlGyAqh3KjElhTV+dZoD2X/Gb65MWJf16/h
	BS+5qOKo7x+/ZWiJsMG0UmdFtNUf0Xorn+Dav3F185HRYk6sqKzuQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23ymy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:46:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D9fJ29007453;
	Thu, 13 Aug 2026 09:46:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9had6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:46:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D9k1fT51708224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 09:46:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4778C20043;
	Thu, 13 Aug 2026 09:46:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99F4E20040;
	Thu, 13 Aug 2026 09:45:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.17.189])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 09:45:58 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 3/3] powerpc/perf: Update prev_count of event to get accurate values
Date: Thu, 13 Aug 2026 15:15:32 +0530
Message-ID: <20260813094535.10083-4-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813094535.10083-1-gautam@linux.ibm.com>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7d925e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TypYd02-Uuc7vCoQRyAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfXxqgqB3ZG1qdZ
 ErUrA78il1ezEKwjEyKfEnrnEL1onvtAhgHepV/K1iweCChlYGucWDugafzg/MxBncm4BMj5VJb
 SyafdIMrrsUJrULym08yy9hWwoxVsq4ecd4+kFtObOl4zRPrOUNZN9EEkRdhpJSW0cHcsizS+Sl
 8+ZeMey0V/kP2flnO2tHqDTFxTMHWCoFlB8h/9f11gC8CER9ja60e4aWaJJ1KByB41L+gLfA4X0
 yHSys88VqOhEhwqQg9HTQoYJQ35XkhCT30rHPndMtRRWggLaTsLmckwQgePVFG0VsxcssuEXKAx
 0HOHBtare8eV4LrzWcZnKljnlmeyYgyEp+MVFa6qWUByj9/9KJEA7bZ5qk1WveySHQwGHDSTtPw
 H8/Svp0s8mkMWoE4AexWsdUTo9UeQh2IWIzIgcv8YpsKW3zC2rKGq8PnvjtRd+YzH5MluNA0yLz
 Z/5FD8ezJOkiZegRrNw==
X-Proofpoint-ORIG-GUID: fJzjQxyJDKc7CjMXQGkzUAvl8JDkbBIh
X-Proofpoint-GUID: ZVuaM1SgJm079P5i5UolAZq-6w_X2svt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfX8kxVhX0VcfAA
 FcCrcTULJwm9eaWMvOv4674VZaU3Gxl9cIwzkvEg7pMw0w1mF/Asmqk1V9If9V86aKzNPseQaui
 1KzqcJRsSFSfkintLuQf1UP7t1F11vM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130066

When vpa_pmu_read() is called twice while a process is running on a cpu,
the "event->hw.prev_count" variable returns a stale value on the 2nd
read which results in a larger value getting added to event->count.

Fix this by updating the event->hw.prev_count every time vpa_pmu_read()
is called.

Fixes: 176cda0619b6 ("powerpc/perf: Add perf interface to expose vpa counters")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Add stable/fixes tags.

 arch/powerpc/perf/vpa-pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
index e79d98447c74..efc39f71553b 100644
--- a/arch/powerpc/perf/vpa-pmu.c
+++ b/arch/powerpc/perf/vpa-pmu.c
@@ -156,6 +156,7 @@ static void vpa_pmu_read(struct perf_event *event)
 	final_data = new_data - prev_data;
 
 	local64_add(final_data, &event->count);
+	local64_set(&event->hw.prev_count, new_data);
 }
 
 static void vpa_pmu_del(struct perf_event *event, int flags)
-- 
2.54.0


