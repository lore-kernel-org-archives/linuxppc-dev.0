Return-Path: <linuxppc-dev+bounces-16497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC47DE65296
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Feb 2026 16:54:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f3wnT6m59z2yDk;
	Mon, 02 Feb 2026 03:54:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769964845;
	cv=none; b=YHSzW0RdKqhRSSqFqTrHHEaR6eV70WU5sIp8GNqfcIdV38tYGoBdqxgsYo/aXUu622NvLEbOfU55b/2+m52sb5ze0txiHNM9x/pJkigW/iig5Vb8TcE4QDEr4LaGuPoH87PybsYAkOylkJm0944Atvq2VLWz++nIENdzU3U8T+yinINTeZmqu2Oo1TjdAtUpruwqzqJPU6bHwzSvaHPYZq50uU8PE2zhPR0KDtsBknTXNPqFWlHrReuNAVWa9J7qGJzBBzvzMdukJGlBmo5mbIS84RcDp3QgZei893fm0wYr7OEdH8ahFQqDQL01zOtpkCbPBvw+yy5tn+je2BeVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769964845; c=relaxed/relaxed;
	bh=2tMSgbI0jMcpFL6WYU4eGr8ihKd31sPH32yhsqf/z2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCCesdUFT9+ttWjtZPh/jSUn+LJqUdVqs28qEXbNRTQ1iexTPLJEfq5+D7ulWFRK5gM0RzekJ/BrqVO0WQqmO4g/gGIy8C5ZRBbYfLuhD4YAvcYomp4vom8EZlNvJnOYNVUmilSWfDLFSEDnITP6HFsItSCOu4NshfuIzGoA2e33D1vLJ5oRC6Bn8O6iiKHp5LaQIrstVSH0KKqMzb94IfqvDtJw0QhG8X7IZ+ojN/KTKijTRUZ89UfS37m92yn+gmO+IM6Pwd6AQ4KygJSC7h8AdqGQus38ckwds2vHD3H39RlcC/5d1kgKbMWK6H5q4wlD2i76O5xwSTkcsc2tzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I0Fjh3M3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I0Fjh3M3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f3wnS6BNPz2xqL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Feb 2026 03:54:03 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6116lV6O017410;
	Sun, 1 Feb 2026 16:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2tMSgbI0jMcpFL6WYU4eGr8ihKd31sPH32yhsqf/z
	2k=; b=I0Fjh3M3xyXyjrzJUNU/VP7zYDfqpF1X6zK1DkAPSXhSaYFetIANSLHv7
	3Lse0ObX7eRsBGG4IqlHIVX5ymRg3KDtfKAyl37m/lJsBzQH95awbznoSZ+W4O3L
	ww5ZSoO5aGxv0xUA+Km8O9weE7kpMQnqVnk9X7o1DQZcEAw7MsNsnILSPGeHMuDt
	fZJylQSKyVJ2GvwXuNMhzIM/XDeuWdgKB7WM5AvaYHyQ7z0UThUA9CgubPpfwQz3
	qXjWrVsoJNkV1joMCsid/pxUXvGAKz+t3Wxp1sN+b+qQ+c/wEnOwbfFlRTD9x5C4
	Q5aW/JHEQJga8TZNJOthU3er1eZWA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c198651cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 16:53:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 611Grqx1010216;
	Sun, 1 Feb 2026 16:53:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c198651ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 16:53:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 611Gb5oc005959;
	Sun, 1 Feb 2026 16:53:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9j1ts0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 16:53:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 611GrlkE51708262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 1 Feb 2026 16:53:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A05B42004B;
	Sun,  1 Feb 2026 16:53:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 576F620043;
	Sun,  1 Feb 2026 16:53:45 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.20.75])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  1 Feb 2026 16:53:45 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, zohar@linux.ibm.com,
        rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
        ssrish@linux.ibm.com
Subject: [PATCH] powerpc/pseries: plpks: export plpks_wrapping_is_supported
Date: Sun,  1 Feb 2026 22:23:44 +0530
Message-ID: <20260201165344.950870-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDE0NiBTYWx0ZWRfXyJX+Ay5SgAgI
 yCClGqeYUxt0nEKc84uxN+dYX9eSQIyXvB2zkAT1ExLRTjObiV7ZZb5XIid8GLbDuI6OGUTnLej
 YA1gDo2Q7Osvz/5eKeMEmD5zKUCa3E4RQxNUP90PW4x4Jv+0qOOMlduIqoY7DMmez+HISHH7IDF
 tI4l/KEQOlaNWE5iVGe6AXXIIL1CVatk+9DmASm02N/Fn++whk+bn7UYmd10Y3vkhhCIKZ2YmPR
 x//gQQ9akZpUtcv9rqe7zel2YgohaT3DtqHMgR5Ma37JRvC+iFfq2FfgqxkNSe/Vb8C8O3CyZtV
 9zf4kHyDywMRqWlwjxZy6NGMAmTWGU7Kd/0OzBrVb+YhWErBG6AOT8Thsxs9jHP7Atr3tyOwX3x
 e5QfqF8/2PSvqTt4zw8brktJCKLE0L9GvW2kHMxaC7JeA+ve2PCem1zVKTsCelr/EpTwJ54KCKk
 1mxuVe0VGtFZwmxVPAQ==
X-Proofpoint-GUID: sbxXnh39Pidq5PaRryjFnBmY0NkI-bWK
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=697f8520 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QyXUC8HyAAAA:8 a=h_aGgwYpWhQZvvvh6yEA:9
X-Proofpoint-ORIG-GUID: CKhOrYsh8MC42vvcLJRghKUViMOVQGPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_06,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602010146

Building trusted-keys as a module fails modpost with:

ERROR: modpost: "plpks_wrapping_is_supported" [security/keys/trusted-keys/
trusted.ko] undefined!

Export plpks_wrapping_is_supported() so trusted-keys links cleanly

This patch is intended to be applied on top of the earlier "Extend "trusted
" keys to support a new trust source named the PowerVM Key Wrapping Module
(PKWM)" series (v5).
Link: https://lore.kernel.org/all/20260127145228.48320-1-ssrish@linux.ibm.com/

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602010724.1g9hbLKv-lkp@intel.com/
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 038ecf8f6d6b..23e4e2a922fc 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -896,6 +896,7 @@ bool plpks_wrapping_is_supported(void)
 {
 	return wrapsupport;
 }
+EXPORT_SYMBOL_GPL(plpks_wrapping_is_supported);
 
 /**
  * plpks_gen_wrapping_key() - Generate a new random key with the 'wrapping key'
-- 
2.47.3


