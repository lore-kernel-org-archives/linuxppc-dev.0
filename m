Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F241606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OKEmlj5n
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9MSK5Yb8z2y7W;
	Thu, 22 Oct 2026 21:13:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792664033;
	cv=none; b=WggyK9xNG65Cvbptz9AholFKyE6BHuCBWiVwS1U3u0DBvy4o6CXvhq7Jm4Vtp9WuMNN+oIPAAf3ZU3ophjWUk6Nuc/6w9doEdJp5AHzuj2BXZyL13OezQRe53kfyxvBPbONCNutCD0+RlqBB4KYbz2WXSWlf/QjTkI3rml1M1PuyuyXFcgHVOh9pGKqCkjuDNbmLHCVztzxMpAPhUMVo/25ym4bJOuzcQVukbAdHAQ7iarmm2+m5AccEr0AZwdhSL/EfWfDicEy4TM+yRDpckF3gKLBUZ0Ml4t+06pbgXnAcg+7Ii8PCjyrQmr53hbvv4UB6EzizTxAgnK3zhm+I/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792664033; c=relaxed/relaxed;
	bh=Yc3Lk1SMDUy5lRE1e9UFOoEJ3aUlGfsMjGNgwYeic5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=forGGZIiAzSO7dKb765gjpU+YGBwo74Pm0OqnP7u8eONKkzHPCLpxM4hxCaeCZdyGnQeohqnJdGO4rKEAjIOZCLAc5Nr1fRpK0C0W0W+iolFIhpHjLbS6j7gy16HtxVEF7GIVtlRne6OB9IID1KH7K/ABR3X8VKGYWlkazM55MuW76/Z2NWpkEf7lOJv72ockqLugx1SwnYIet9nE3sDGyV4mXUKmW0LA6uKIHGnqHeR1dhQhZXBB9LAojKOwrMfKch4h1l50yoNfBb+pNZh266AHPMZA54QOlavVtdTpj6ZQsVxW6ReXQJiuzMFytYVmRYJkeBzDxN35UPlPm01Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OKEmlj5n; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OKEmlj5n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9MSJ4lPCz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 21:13:52 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M7EOip3457375;
	Thu, 22 Oct 2026 10:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Yc3Lk1SMDUy5lRE1e9UFOoEJ3aUlGfsMjGNgwYeic
	5Q=; b=OKEmlj5nptwXzVbGaN3+N0LSpFJERpwDmRRXMG4JxUYyS+FutEvhwaUyf
	gSLyGFzVRWV5mxyYXMN5GobKX+ZQuHakI9rRZavhAazw/aueLZwzqQ7f4+/tmTT7
	GbSiF8oePxFP6yMcG7p/x0ZRTb8B8w+tcv0jhObUNFu4fH0Pl2SWs1Spb/Kc6p60
	ZqpVJhcW48qXyKelt62txqDVCARFeERkT3V6XojsNgAVVIjDxe5p98tZz7uOWCju
	27RFLV6Fqtw8qZv+ENdpKJJ7KQvIZpFd6kyOKv1enqmUUch9o1yH0N7MdF7t8GR0
	ZlN0RSoUwVWa7B6SIzhI4V/atpQhw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a60d0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 10:13:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA4sBg337793;
	Thu, 22 Oct 2026 10:13:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he6gqhppk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 10:13:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MADi2M39321952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 10:13:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AB3C2004F;
	Thu, 22 Oct 2026 10:13:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C0D12004E;
	Thu, 22 Oct 2026 10:13:43 +0000 (GMT)
Received: from jupiter.bl1-in.ibm.com (unknown [9.123.6.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 10:13:43 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Update EEH maintainer details
Date: Thu, 22 Oct 2026 15:43:42 +0530
Message-ID: <20261022101342.2962384-1-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOCBTYWx0ZWRfX01xUOc4yusG9
 58BVi38jJMs6cqtZsGd24xUJ3pXAePDbiurhkB+3nmdWdaCv0j5KBdraZPzTUTIagWZU+OLNE/D
 UMuWuxf/MGGMWnNKPVtsZhUNBBrzGClJEpJaQKZfXQsrvT+TagTO+7AX6MYRqz3b5j993L+nnNV
 s/vKhyvuMFfyT1upAIRV1ruHENRcn3E1Zv4NaoJB9/0ASkI1TKjzGxqydMVhdRe/goEaX8k0BzQ
 YZZvHxeQJ4O0LFtFHKXFlHHXjUurena2Dv/6PHqiVtot3QSP7A99ki2IVkDANTlxsSFH2lHva6m
 z59ocTJ1zxJy65nXFAYJGy0YijUgJzPTmRvu4mgVj8R99DAh7M1UJ+oFyR1QFY3fIn/C+U+K5Ky
 WRAS+82smKgRwwYOIcpDoRsLnbuM8b4ktSs5NoMmpD6EFoyxY6gZsnGWbZ4QDANpTSXQQtENFhv
 iAsQn3bsYoAMvfH+NhQ==
X-Proofpoint-ORIG-GUID: lMyKY-k35uyVJ9UW91JMsKH9GmciRAdo
X-Proofpoint-GUID: lMyKY-k35uyVJ9UW91JMsKH9GmciRAdo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOCBTYWx0ZWRfX0EDo88Ly3Pmo
 ekutgiUXRYdi1av7fBudiAScLxFdpRkB3rWRFcSIWgLtFurPdUY8nhVILrnYLdI2OyTZy/32JPH
 fUGkuhLrzLW/PKhAhzRehExtvTU6Nz0=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad9e1dd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8
 a=l8-7-_HzwCMQ2enNK-oA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220038
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I no longer have the bandwidth to maintain EEH. Sourabh Jain has
graciously agreed to take over as the new maintainer.

- Add Sourabh Jain as EEH maintainer
- Remove myself from the EEH maintainer role

Thank you Sourabh for stepping up and ensuring continued support for
EEH.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9fe9c2a39b..e7bc0bb7353d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21092,7 +21092,7 @@ F:	drivers/pci/endpoint/
 F:	tools/testing/selftests/pci_endpoint/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
-M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
+M:	Sourabh Jain <sourabhjain@linux.ibm.com>
 R:	Oliver O'Halloran <oohall@gmail.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
-- 
2.56.0


