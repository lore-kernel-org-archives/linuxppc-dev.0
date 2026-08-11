Return-Path: <linuxppc-dev+bounces-25746-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23043C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 14:04:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKCz04WNJz304r;
	Wed, 12 Aug 2026 00:03:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786457036;
	cv=none; b=HxjlsCHcrlKssKcGNbKl1ib0iDPWn4zMEQF1BF3qBUfNFc8XErcFIG82IoopIXmZJ27VEpsb88a69idWk2iZ4/Z5RotG2X/o5roCVb5QYXI4w6K3TsQ3+Hj+ebZxsuU2nKzccz3Vy0QvtbHjUdJA2JPscdJ4hrNy/wjm1Hpd9AlDFsI0mhM9yWLxl8gyWHMlz3Eq4HPeNwXxeBTUlckfUTuKPt9+lk2/SYMn6oqf3jGOweK4kk/EcEBfpzsRbTX2SN0ZdSSO2/H76PVZ6CaSZer614flNT3KlUjjkadDJPvw/mksTkwM9TkzoOlrLq0pv0Jmvrv7yQ6g/qNmHpoN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786457036; c=relaxed/relaxed;
	bh=dKAHFXuRiLyTFft9Sxrzg1DrtOzev+TQHXYWHsfwFkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq5/FmYfzZf6gFwCNIrAslhPyVQFMPFMv6jT1QBOYc7K8vUsfZRGF9kzFSKKwRDwIyVNsUekJuMhfIOb1b4LxseI2YJKVbpBKIKB7P9nQGwCODYhMGpkoP/glnh+2vYOdLo5dw41PtnTcbMm6EQ82xDr2wbo/aKKAYue39fGGvwmoyyCOsKGCoBV9+dx3A30nlq7t17s4KrLCl0UCBXRjKNQSQM6ihLi8g+gj7TLGI7M+/iqjG/FDtSvkbQC8CKovmIQsD26qQxsntRLizqHTnL06mQNmLTrZiJnfrVNwIIn8beBuC0jjdB7bO1efGg/wMotPWgfoi4Ac1VBYr94bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rKBHPFAg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rKBHPFAg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKCz00Qblz2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 00:03:55 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWct5492485;
	Tue, 11 Aug 2026 14:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dKAHFXuRiLyTFft9S
	xrzg1DrtOzev+TQHXYWHsfwFkw=; b=rKBHPFAgz+E5rgmuXJO7q9WMQa8Y/3NIo
	Bg/MM0iDRHiUctH6L42X8JgKfmQUyz/1jl33d1SVvLfHLSTe2SMXU5GIhZN/wKXy
	GsIWNLMvgHT83bqOGv9SWaM4FxcvDZpgaBEKtqOehNzt39js86I+IAROaMS99Hup
	CULsI+3us876Q1T9iPXsXRMcSaFL3joDbruxwlIRymmKcg+eFVfFwtuEwCH8tSQZ
	lHcU0pkM8bvPclYkhIJebekMANBbHqMNj7Pjz7+5kqHy1BGu+/QSIFb0e/7F7r17
	oYPkzca9L38gmxZ4ZPL0rwbhxJs2KjJCCQzYovgpSB7NSw0fWoSkQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9d839-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDuG8g029804;
	Tue, 11 Aug 2026 14:03:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy0yv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BE3hWF40305104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:03:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 253A52004B;
	Tue, 11 Aug 2026 14:03:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F07A220040;
	Tue, 11 Aug 2026 14:03:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.6])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 14:03:40 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] powerpc/perf: Update prev_count of event to get accurate values
Date: Tue, 11 Aug 2026 19:33:09 +0530
Message-ID: <20260811140313.15397-4-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260811140313.15397-1-gautam@linux.ibm.com>
References: <20260811140313.15397-1-gautam@linux.ibm.com>
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
X-Proofpoint-GUID: u4Na4jzxmqRsBFgKisVgJDNiZERexDqA
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b2bc4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=2AWsWaKDJcEKxLcdIakA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX5VXTNq0FaKf8
 Qysatjkipqj+OzTqOUeaHVRPTakkrv9q1p693Ntr8EIoaZ2Cyndj4mMwXbausru4ksnUcAYWkaY
 yxCiiUAlie/++h+VxfZ8hmXWdaFZzCqsFXB87TjVPpr5JCN5pkvA3pXkIOWUK7M+9mmLdIZtgqw
 9YxANRKgNZC65QHFwJnXawGu0IFvgxhuH/d2EZUHNM5DCUMD9QhEeoz2Bicgd1PePMZ1g44ycHK
 zzSKbKxCr68TZCRwmKw7Fi5HlZEPbVjUr1Q09MbdOgCeeHEjh+rVKq/zbQq9FoX/Rd0zqrGdyuQ
 xj/XnKbrDlecmjYerkTiqCoNEpAqSeGdWp8JtbzOXrj1aI6yd34+aa1wNrYwAzhwh1Hpb+VEoh0
 fKHIio2PXGJ3geINzIxgoBXz05YeWnpVcRinUbOZv5zZmaZTB4n+yEVOO26E+gb3sR1nKjsoX6K
 Pr6Ktr5Vj48836BSecg==
X-Proofpoint-ORIG-GUID: pIdlkqF6E0zehb9GQMbNwchtfqSQ5FfX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfXw3ycQyk6lPb0
 smC+YbrhzeemXW+C0Ww5dmPd981VMHLC3HKID6iGE5lFcWMtN99hg+Nedkfu//8nCRQKNPoMVBh
 /1RFk5tDkh7XOquPjhqSFlyBt++z1zA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110117

When vpa_pmu_read() is called twice while a process is running on a cpu,
the "event->hw.prev_count" variable returns a stale value on the 2nd
read which results in a larger value getting added to event->count.

Fix this by updating the event->hw.prev_count every time vpa_pmu_read()
is called.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/perf/vpa-pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
index 334ef7719db9..f5cfa4d5e369 100644
--- a/arch/powerpc/perf/vpa-pmu.c
+++ b/arch/powerpc/perf/vpa-pmu.c
@@ -145,6 +145,7 @@ static void vpa_pmu_read(struct perf_event *event)
 	final_data = new_data - prev_data;
 
 	local64_add(final_data, &event->count);
+	local64_set(&event->hw.prev_count, new_data);
 }
 
 static void vpa_pmu_del(struct perf_event *event, int flags)
-- 
2.54.0


