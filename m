Return-Path: <linuxppc-dev+bounces-16924-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C54EE9A03B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Feb 2026 05:01:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fG49c18W8z2yr6;
	Wed, 18 Feb 2026 16:01:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771390900;
	cv=none; b=FVtdf8PhHzld3n2+MlCawbCGDw5D98cnyhmLnbaU5WCB9dnE1K3A0oxV5ngxea8kADQItu+s1r53nXdzElhKLHlkFA4TfCKioQxVX8VcAdJuWfotcgfmCWwpWBQYAvlJODC+nEVCAanzx48E8JuiqBA56m/VQ9V0fXNbedC40eIIdm0wSRq7SjGENN8W28YYYs+6Z9G3gQw02L2TkASw05FSE30oFXf8RjsrAuaIb0JE1tdtEZubncS7AiDwgonlfd59uxOexqYRu7+zpTGijRvmK0PE5ZqYtqGLj+3tIlCFPwREa3po+8NEj9BhuhGmgV613jG5FSldeTbm/gl+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771390900; c=relaxed/relaxed;
	bh=KoGPm2YGCnw14TQ8KbDHdfc6ezcQHovGfZU6k2xQ2CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwjUhHI1hGVF4/XDQxca+vUn27U2dd4zGP8K/sRUyhtbf6qsXJWXeP5IgckZ620Ml85kj+QGljDLlzCaPASC4VkkNmEfymlyThKN6KlaS2Hsakl0DPeQhxPVcMddLKrTFNoomi4nf3MUGn7GcagP+hTls/j9uNDsjI0EFoYmhZeRBAzgVMFu4aGIBDe3Mp4/bPiJHSOa84GDRwe6RXK6Cqr6KIkdFql3zA6GDP1oOeJkc2vn4n24P1IUNlMwRbDHbJw2HkBRRVsFxwjfIeB/p7xhSEWadOZctV6j3TC+pDDvInegOSroFx7HmyKdvI0CVpiPz8JVegmiaOUmVTGSmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NO+ZCEu5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NO+ZCEu5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fG49b28xvz2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2026 16:01:38 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HIFCIP3493025;
	Wed, 18 Feb 2026 05:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KoGPm2YGCnw14TQ8KbDHdfc6ezcQHovGfZU6k2xQ2
	CM=; b=NO+ZCEu5FZY9nSxh39J6bYVD3efHUmarr7FNkDSpgw1rtnVRnjAPrQsH8
	oeXPLR3hPa1+0RZcxW7yOcB3Ara0pM1XaL9+zBcYUDth7mdKctm1f80OcJJ4tLA0
	RjXf35rNgBFNdMWCiEa0Eq95mMkAUQ6Q0QX/MvCWs8Whurj117KfYPcExaSt/KLr
	rUI8p779/8fiyh8oQt+7wQmPmrXYbBR92KuGR19Tg7zPC6GAqP6I+nxqmY5oMUxw
	3+lDZQ4vh0C7NBDxnrYVVieTzCZGmvJ3gTVJQZHur+FYGDVvc3pu6gWs8iMdRhAo
	HidMColwARxuP+eAFAvU1p22h/Nbg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6ryqmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 05:01:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61I20eWl012024;
	Wed, 18 Feb 2026 05:01:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb26xhs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 05:01:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61I51Pba16318788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 05:01:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D51BD20040;
	Wed, 18 Feb 2026 05:01:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4EE620043;
	Wed, 18 Feb 2026 05:01:23 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 05:01:23 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH] powerpc/crash: adjust the elfcorehdr size
Date: Wed, 18 Feb 2026 10:31:05 +0530
Message-ID: <20260218050105.391285-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=699547ab cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=WeRnJec9B1Tj4If4SVEA:9
X-Proofpoint-GUID: Fo-OJitUbXtP7U4brmdcV4yQGx7INoIe
X-Proofpoint-ORIG-GUID: 3gYY5axxllJMllGg5V3r9TCEkdUq49aX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDAzOCBTYWx0ZWRfX52w+i1GIuauE
 KFGajBg81Rp6RpKKvopTCdGh48yXRbvQzl2V3c4yFb53/t9M7yOd5bOxOwNJAorCdTPCqwgPT/H
 XQYhQy56DFYBULKKrjQp23jMzg2Y1v9tYn4TIjFZxFp7MRKwRlMXwfHpM2B0h2qMKHUADOC8hGC
 RRi6Mt/WRCrySybe8uBUwzISjW3nGFDbXo+r2Ls/Ap49Uf2NCkiUEfFSWs9e9g2zAAL5GqxtD0j
 iqLjfx78ql/MV/Q+xDYoTDc67D+QDivHJf0/u/LArPgj5lHn2ni+W6XAa8u0sLwqX1p4vCjmpk1
 sgn4JzqygHI8OrmyKeGVx9Zd4HL3xS6ph38Zl+N23AjZsOQwuehrXsjFPt4ZPlp8icdhACucgqQ
 Aqw0VDoyGtVCHl3Xsflu/HUlPwXAM58maPsqa8C7Jh6CHsuWQQ8lN31SjKyF40Rhk6uKjn4sKNB
 4l8EqtKlVanpVrY1XAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180038

With crash hotplug support enabled, additional memory is allocated to
the elfcorehdr kexec segment to accommodate resources added during
memory hotplug events. However, the kdump FDT is not updated with the
same size, which can result in elfcorehdr corruption in the kdump
kernel.

Update elf_headers_sz (the kimage member representing the size of the
elfcorehdr kexec segment) to reflect the total memory allocated for the
elfcorehdr segment instead of the elfcorehdr buffer size at the time of
kdump load. This allows of_kexec_alloc_and_setup_fdt() to reserve the
full elfcorehdr memory in the kdump FDT and prevents elfcorehdr
corruption.

Fixes: 849599b702ef8 ("powerpc/crash: add crash memory hotplug support")
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/file_load_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index e7ef8b2a2554..ed76326f4b57 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -460,7 +460,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	}
 
 	image->elf_load_addr = kbuf->mem;
-	image->elf_headers_sz = headers_sz;
+	image->elf_headers_sz = kbuf->memsz;
 	image->elf_headers = headers;
 out:
 	kfree(cmem);
-- 
2.52.0


