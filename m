Return-Path: <linuxppc-dev+bounces-20977-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862F3CD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 14:31:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH8l318Zdz2xnZ;
	Sat, 16 May 2026 00:31:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778854982;
	cv=none; b=XU5VwIkmVe8qOSv1/mdEJtJoIRT9zDjxU/hzL3gcAjKfhxppUq7+oBWTtZVDp2ZwjA0wJ25peTiovDCbGtJz2SRL2v7YU2rUcV2e/NJNM67sbty4CZmqVZhcj05lc9uHx5WQIiw920DWKYi1Z7P5ihlk1WnY8y7lsHRNBhwXiFLfWGFLyMB9Iwiyq7cMUqys//fUlfhI+170sEB+OroAOts9RCdKiQg/mLYsQ1UrS4kEXP9w30gt1fbHu/PIiW4AGz8eyPCR//pBD5Zkpubt58kXccEZkrO3NrVfVwfW49qQFsQgKc9LYMwPlyoxDaoZwXG3OwHrM64v2uAmFp7ywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778854982; c=relaxed/relaxed;
	bh=sSrBZLpLsG21cYV5sFRehKkQIMmaXEBuOlBtNeue/K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1ZrkAqrm9doi4vtyosyfh8MgRoIpDBwX/2FDz3zkbAptzErGWXeFkW7nXOlaLkf4WQ6KEA/NEw9yHvIYSxsDtEEcddIZkVvonjmVikR/0SvYT4Uu0goXZYVO1ETQs2B/zorWhuBpiti35vf+k3xZQx+LHoB7hz6mwVFLbGXMyjDYcxMMyg3m/g694uB37Q5iC6fsqpB4USgVqs+2sG9KdyRghTvkMihHxAzanBGOi5H5pYbDP+WheA3dKMFjYMPgdxdUrt5kLO0YsjijblaIzIDyUoaSs2DMJQHX30fRm+9s6kxclow8vcA6hH83PB25DJhd4MEjy7A5vSPrKQJGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DQyfFv7h; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbayer@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DQyfFv7h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbayer@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH8Yd3LLJz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 00:23:01 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAWWhF3950751;
	Fri, 15 May 2026 14:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sSrBZL
	pLsG21cYV5sFRehKkQIMmaXEBuOlBtNeue/K0=; b=DQyfFv7hqyMqDY11+8o6y2
	Gb8giGVwPZ25I3udbDcpgZX8ubOe6/CS+Oh2WAGQQ4QO4NGF7Z6QH+82qkC2uDxu
	QEA7br6P123CEF/PgSu12dmD/Zf1Gx+EAgApa0HRteFFkN+F79C7Q38mQzm2zv18
	+9sOHLEKAn6yio/1+xTNAbxStGxNvCqx/dHMZJVaUI/e8gLGt8+zIraYFYrBtovd
	/4+Ale/7IfWRAiLfvYAhWOCvWygF65fkaTfDWvRkdo7VkHXJSVCt703YjzKBjBCl
	nSrT+0QpCNKO/uoXYcdMMrP/xevd9XGOIKsK4s+vYhfn9wYA835pr/Fb/LY8I+0A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8ybkfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FE9Dxo026631;
	Fri, 15 May 2026 14:22:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvckvdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FEMS1545089222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 14:22:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 445612004D;
	Fri, 15 May 2026 14:22:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 309FA20043;
	Fri, 15 May 2026 14:22:27 +0000 (GMT)
Received: from [192.168.178.55] (unknown [9.87.148.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 14:22:27 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 15 May 2026 16:22:06 +0200
Subject: [PATCH 4/5] x86/pci: Use official API to iterate over PCI buses
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-priv_root_buses-v1-4-f8e393c57390@linux.ibm.com>
References: <20260515-priv_root_buses-v1-0-f8e393c57390@linux.ibm.com>
In-Reply-To: <20260515-priv_root_buses-v1-0-f8e393c57390@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9Fn6JSOYn5leHLgBxi1ZPSEXCI3IZ1Fr
X-Authority-Analysis: v=2.4 cv=Os5/DS/t c=1 sm=1 tr=0 ts=6a072c2a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=OS3CRczKEtLnDcx_Za4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Hovlul_bhRsIek30WEVnGj5qQFZaeLIw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE0MyBTYWx0ZWRfX8fTqgyx8V9Rj
 7PIPlXLIF2L+55hDHOOLgFHrNMNvc+E9B/YgLccoZ9JbpahswH+v0GcPtNUy1Fj/4YbDFMmjpN5
 dsOAzBtjiTJGzessVoH9tOvhsmvQqkhRJYcrYG4+sPegQbIJZrtixlITfUPJUTFb+b8jrwPmd89
 xzvZcmH0VHM0f9gFbct8PjAQfk/vjPi9eVEyl2gTNvoonUq3wIEvqxS1yQ7vPgwHle4FiApuoLw
 lEOE9WqGAblLXwLwbBGJwjUi63SlvtDBcXrNMK0MnmgPskxcksDNPcdzhHif80L4SQjmEHID0lH
 WVpnEqFSmDr2BJVq1aCE1we6mrvOrz14mU99t6i0yH5u3MS1pGOSD5+2ojbUXsIfqat+2BNPngS
 ZNds6u3CUxixk0LLa9V5IyiZvcIlKW666DsSaV8LZXI+t1aQFLBxNxT/c9fr0dJ8Ch0oqjZU8+s
 T9qrTeS+f9x7LA7dKfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150143

Replace iterating over pci_root_buses with the official
pci_find_next_bus() call provided by PCI core. This allows to make
pci_root_buses private to PCI core.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 arch/x86/pci/i386.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index e2de26b82940..194d0fa3cec8 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -357,10 +357,10 @@ static void pcibios_allocate_rom_resources(struct pci_bus *bus)
 
 static int __init pcibios_assign_resources(void)
 {
-	struct pci_bus *bus;
+	struct pci_bus *bus = NULL;
 
 	if (!(pci_probe & PCI_ASSIGN_ROMS))
-		list_for_each_entry(bus, &pci_root_buses, node)
+		while ((bus = pci_find_next_bus(bus)) != NULL)
 			pcibios_allocate_rom_resources(bus);
 
 	pci_assign_unassigned_resources();
@@ -390,16 +390,18 @@ void pcibios_resource_survey_bus(struct pci_bus *bus)
 
 void __init pcibios_resource_survey(void)
 {
-	struct pci_bus *bus;
+	struct pci_bus *bus = NULL;
 
 	DBG("PCI: Allocating resources\n");
 
-	list_for_each_entry(bus, &pci_root_buses, node)
+	while ((bus = pci_find_next_bus(bus)) != NULL)
 		pcibios_allocate_bus_resources(bus);
 
-	list_for_each_entry(bus, &pci_root_buses, node)
+	bus = NULL; /* start all over */
+	while ((bus = pci_find_next_bus(bus)) != NULL)
 		pcibios_allocate_resources(bus, 0);
-	list_for_each_entry(bus, &pci_root_buses, node)
+	bus = NULL; /* start all over */
+	while ((bus = pci_find_next_bus(bus)) != NULL)
 		pcibios_allocate_resources(bus, 1);
 
 	e820__reserve_resources_late();

-- 
2.54.0


