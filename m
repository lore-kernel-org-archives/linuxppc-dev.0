Return-Path: <linuxppc-dev+bounces-19420-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037B1FB5192
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 05:44:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqZs87300z2ygf;
	Tue, 07 Apr 2026 15:44:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775540684;
	cv=none; b=WywqK6bC04FFisLA5a+2K3oNlP51bbWDCtHRMvKjVK4JbFjnT0ieKbxfOkUfqVev9kcfOwdyEw/T7VfVbnb/ndgEY31vE35QUu4rf9GMhoEH3KUXdJL6uZCnkD7mpfSL7bxnaX9/mT2jwBplpmrSm6nESqe22yXViVqtOL02xpTyV7ArEilIQe0znNxfgt4o6W2d+wvNKYIGrEer0Kj8bm8VnXiM2OWCcq4Tj8JIspPxPynjUVLuhwNOVM1dIWQf9jyBwWnJIBa6MqyNGX6NUAxzatFoNm7nw6/lPYEBWY/rwVxuo+Tb1UyhqC3Tzj0abD/IroOyoPx8SIiOH1Lzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775540684; c=relaxed/relaxed;
	bh=aCmEefWRvKXGBjsOIh3qoKPtf9uo0VFwU5pugD6TZ+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqqKH6rztt+zWYAh/JncuGBdZ8l4+8XgLYTt2WjmauyZzDWhem+uIiMn8JHN+Cm0sURcFtrwazwDIKQnAIIFAb9zG9kkVYHmMitb0pHAW68Q1O1JeLf29+O4RLmINsGlEpqca3qEL2qqbpoCGLvhlQPXRwAeGfewGM3RwfS+cHvJkVQOeXQpu5VV4PeU3AGijCYo8oJXQHMactOuOLaMKSpVB8Dsbbn+uB98a0+RhiYIPZ6fQPOR4+j9o3H6otzuDEjlUz2FG5nbwSItWLLhdHu1YLuZ+knRv83hFNR90u+oX/sAlxL6WBPuuMfHthpnLa23FR8f6lJaxhNl3l3N1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KXeaoMrd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KXeaoMrd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqZs75Qqqz2ydq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 15:44:42 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LlnLe2314952;
	Tue, 7 Apr 2026 05:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aCmEefWRvKXGBjsOIh3qoKPtf9uo0VFwU5pugD6TZ
	+c=; b=KXeaoMrd2m1XCrDbmBRrgiOjWX7KhRipMqvh1aMFzYqTftCQBTn2Ed6Xn
	ZLF6a4zXPGwaunJMZoqD0jsJHiIgODBHwZq01jtMkTLToMjxHMjIVHVdEXxvhHZD
	aDiuEpcxnTWoalxH82EEE839EBDerf7ZiGGkvlkIq2kDzYcK4uXcG/ZV/bM5+aLX
	CipWi9IDeu7WBjoGCQpPs4KC65apo+WNXdJ8jzPtxSDqhSvuOzINY+tJ10Sj5WK9
	gv5/m785wuHGO6hl3PQy4txgExK8levtzre85bC8tCzNhvgCLEjIFllLu9d4ph/Z
	youZl9NV+EW1EFVTfZc+31tGD8pug==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fs9dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 05:44:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6373UB6C026646;
	Tue, 7 Apr 2026 05:44:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7s731-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 05:44:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6375iM3M52298096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 05:44:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE16820043;
	Tue,  7 Apr 2026 05:44:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BD9220040;
	Tue,  7 Apr 2026 05:44:19 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 05:44:19 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, kees@kernel.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ritesh.list@gmail.com, rppt@kernel.org,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Shirisha G <shirisha@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH] ppc/fadump: invoke kmsg_dump in fadump panic path
Date: Tue,  7 Apr 2026 11:13:41 +0530
Message-ID: <20260407054341.308710-1-shivangu@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d499bc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=-8xlvo7cLD9n2LxdQYwA:9
X-Proofpoint-ORIG-GUID: bLPW3yWZt0f-L80K2F-6HtkyB23tqNN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OCBTYWx0ZWRfXw3xRALYazEZ1
 q+zgy6fy/V+hULYR+Vtq+JiDJbH1uqElt/fLKtMQwO7le5Ri0xi88f18s1+vu4ec35xZUbHOxs9
 Iq+t3PMXpCkxxr0ozFx8I2LgCS/gbh4XEQ+z6KaErXHSfM4/db6qJJF0rVvTz7ke9mV4NEmXWvZ
 k2SFT16M9/NmbljOxdiG/PeO5HNQ/qcVT+rWhof03G3IMIoSIkDkdGQVyxYeoXWWGHGmG/uXSb/
 WYib1oCxPG5NFPySFy/fFO+EL/1ATuCoW7QVCdPlTfmMrJmQD5gaIyTbO4gUtGuD+jpoTwG/ob8
 o/dOiCwXXKMPysJ+2jMcSmlKqZuCLlAzccVGNNRzYyH0AAkCq0H8cVvoNT+UPWwuqNhsLFe66Ef
 +qbDqpUm0U4YmvKVCYIlwybQPDV7d79e11RQ3Nd75X1Xk77LvFtvGgWSbMd8ZWNIl53FmeAGKkI
 vv5C+5fcS3WwJvwBK2Q==
X-Proofpoint-GUID: RtH_LuYadJylsEq2r28vwalDKR3upyRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070048

fadump is registered in panic_notifier_list and gets triggered
before kmsg_dump_desc() in the panic path. As a result,
kmsg_dumpers (e.g. pstore) are not executed.

Invoke kmsg_dump_desc() from the fadump handler to ensure
kmsg_dumpers are called during panic.

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reported-by: Shirisha G <shirisha@linux.ibm.com>
Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 arch/powerpc/kernel/setup-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index b1761909c23f..c329b071643d 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -68,6 +68,7 @@
 #include <asm/kasan.h>
 #include <asm/mce.h>
 #include <asm/systemcfg.h>
+#include <linux/kmsg_dump.h>
 
 #include "setup.h"
 
@@ -748,6 +749,8 @@ static int ppc_panic_fadump_handler(struct notifier_block *this,
 	 * If firmware-assisted dump has been registered then trigger
 	 * its callback and let the firmware handles everything else.
 	 */
+	kmsg_dump_desc(KMSG_DUMP_PANIC, (char *)ptr);
+
 	crash_fadump(NULL, ptr);
 
 	return NOTIFY_DONE;
-- 
2.53.0


