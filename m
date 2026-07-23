Return-Path: <linuxppc-dev+bounces-24719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECCEC531C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 09:40:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5R224NQKz2ygG;
	Thu, 23 Jul 2026 19:40:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784799642;
	cv=none; b=WNRa2EDeKYQ460dt/LmORWc9OcuNU/Xf6WP8VZzitY/j0jFCNsj3xRQotSRuspSqesbiX8/Dq788HJdJ3UHFC3cfqFeo9Ui4jaUPAXHeQbPUmVHO4s+eWL+pE9MIPlnG4iSwR4fanEjIPddhNO7zaHBwDodcsNe1t8X47TAbfO0SzHkm43ZUZuQ02+OfWWkmoMuus8Bp+Bud8pl482T5oHdjlUEyeddpu0m6pazISP3vHeAWHbRcxhjMsFVtl6j6RIr7Olcy2nkghe+vlawc0AOUm9HGUKnN284kftw0jluSDmbZdibz/fYFjE4x38KkceBBL651fNVpBSeJkut8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784799642; c=relaxed/relaxed;
	bh=7lkWB8TBMN9eGwcnbbQpgmiei9lQBtl0ikXiLoJmOQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eortku5YJ4xylR3diRsgYGgN0zu7KrOLBgfJuFcWy7qAX6li9FRWTkklqmvbVG4fuWvGFT3hUIMmgazWdYrKZsHmdJDHbalx/IFM3NjoesQlJpkW/URYQhjuNM9QbSreLV26wJDJeQc+cNh3mYU1Opiex8rHf4R6UAD1tLAKUZ/jF6PUZJUTePgEe2tFQNCswPtALq/xq9ugJ3fdAfux9GN0AOp00sHadCsDz19RAJwWo8zYgf7PhacM+17gs0m9Su1PGN9DS91IdbruqChfIvNs1FfRdwysvagDS/JvylWApXGdAYajMdLKIadoIzpHU3d/VUcvwZB0hi1maJkpmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LrQR9Ay6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LrQR9Ay6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5R215N3xz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 19:40:41 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9Bni32580353;
	Thu, 23 Jul 2026 09:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7lkWB8TBMN9eGwcnbbQpgmiei9lQBtl0ikXiLoJmO
	Qo=; b=LrQR9Ay6QMLundIzl+FZmUy3LIVJ/6tqtxOYdsIrFwmYAF7iOw09nux3Q
	gt73BVHApkP8ybM19hJUWbMHOw0yILCaWYlkYQSWT2A9wDThLwSwHsNHQTqOZqYi
	QVh5M8RC9/Tko4XqO+nAO6itJf8dOlXZ0wj+LeCFPffe95O52qNggmvIG0w9Sj+Y
	FZyn62VUUyBCMFMtvYhcrrVXZ70Mu7gV+dzJmqbF9VQRgKNiLGt6jNsCl7YzuYsM
	9L7uS2nOyzIeNxsswmKf1PrxxQBpCYNa+jWg128Vht291XPaLx6HzRYQy0eVjLCw
	UPPHXfw3NyLj50pTca/m81DoGL5Gw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abpvcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:40:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N9YgXG011193;
	Thu, 23 Jul 2026 09:40:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gkb8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:40:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N9eJbJ49414438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 09:40:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9304E200A0;
	Thu, 23 Jul 2026 09:40:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A03432009E;
	Thu, 23 Jul 2026 09:40:12 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.bl1-in.ibm.com (unknown [9.123.15.94])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 09:40:12 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v2 0/2] perf trace-event: Fix security vulnerabilities in trace-event-read.c
Date: Thu, 23 Jul 2026 15:09:58 +0530
Message-ID: <20260723093958.416650-3-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfXwpRReBeWeoaJ
 PYTUNBHUslWhVr4yCVvQZJyNVlUkJbly3yP6oXIUHsxRNissgtQytH5ML47MLCyKQsW55WT2lCn
 /fT5cyWWq4ouCxKMxzjzkixDpPJneQibmUmhGxMYTS3FR7F/WjEfo/jZ3reWOuy+wIkSATWZyxQ
 FYafQFX8UslKjJvhHnzhzbCJkSiQyVkIiBLgnCtB63WLV1C/vDozRQpw3KeMwNXHAjVJ4r7HKKI
 rbNSv7V3gQdkj2GDBEtjxUYvDyTJ7UbFuukj7hbhLzL1ra9HzDOxGJitjRA2XNQ2w/Q6rDCxU0K
 lWGPpKmrws57rVKuuzu0DfbTiFlhkFaKJanthhjGCzeLrsArU/5+le0AqlOYzwnjaLFzKjtAnJM
 BlfkEpPF8Rmxp6xXmuA/2i37iYxOEJfJZ4CeiU7RTgJTUpEENm6UV8i/Ce03OzeRsndtg6TAcf3
 IdHTYSxsJ/9NzMgYHAA==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a61e188 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=xBR__Bw1y1-2kD5fWpIA:9 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: UAXcaDFmLwCt5v9l792Bh0b8xJnb3kKX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfX6iqdAxPakLc6
 B0jPM0D5fIiRH0InRkz1Fi2ycrFuzR8JD0LwxcsKmO/LzjFcEuku7c0yCUJGwQ1FafksqjhUzqZ
 HUCdqOnj3D1gJyUoWDyb1pMcGAy+I7Q=
X-Proofpoint-GUID: ckgNF4-jTBkiAQq8xbSAxOlL9epCk36Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230091

This series fixes two security issues in trace-event-read.c:

1. Stack buffer overflow in read_string() when a string exceeds
   BUFSIZ, due to a missing bounds check.

2. Integer truncation when passing 64-bit sizes into functions using
   'int' parameters, causing uninitialized memory to be dumped and
   parsers to read out of bounds.

Both are pre-existing bugs; this series fixes them.

Changes in v2:
- Added new patch to fix integer truncation in do_read() and skip().
- Organized as patch series to separate the two security fixes.

v1: https://lore.kernel.org/linux-perf-users/20260722113552.191143-3-tshah@linux.ibm.com/

Tanushree Shah (2):
  perf trace-event: Fix buffer overflow in read_string()
  perf trace-event: Fix integer truncation in do_read() and skip()

 tools/perf/util/trace-event-read.c | 33 +++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

-- 
2.47.3


