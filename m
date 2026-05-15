Return-Path: <linuxppc-dev+bounces-20976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4F6CD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 14:27:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH8g62PQ0z2y8p;
	Sat, 16 May 2026 00:27:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778854982;
	cv=none; b=RG+nWxa25VftqzVTlKZlFfLMamjfLXR4ebdAK5JP+Z6kyhxRsRNPy7STccDoQm68NwKQwAeF8dtS+o1aKO19bq1sDwa8o5IXPXkzONl1Nyo3bjO04ZpQhbb+bfAV3hjKneCY8CK+t2GbKHZNDXbXjjTewroKlAd1WS9dmOgFZm7eq6lLlpc6vOVMtqKZW+X/GsHQ3m6eOtqBf1dwdKQUhfywtdiwQZrvwUGMhE86vw3z+tVFQzMkZNFjy2wyhd10wpAMVBPmvk65I1NxfrlJPDTziUF2qibQIzi4ILRxqG+o7vSpOiSejbxG8T2roBKWnBWexR+LMCPexs+2/D5DIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778854982; c=relaxed/relaxed;
	bh=ufGlv0CVGjiDuGZD9L5jSfGD3Qkubf2rfZSAyyegaMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTwpP5Nk84f6fIXxwyt72ou+aIpkVR30MSsc/1yDzVt6r18jTJvv+EU10QxPz/y6Os0hXtdAWafVjWxm3JiNS0dHHnTbur20OQFXwvLkcnnthMZEaZDw6E4UdXjEWRfTKsUuiuJJzugb045XWPBmCCQxFBffzDT3iZbrxSzNtqMdyZkMbI9gZNBqGxwkXxtOx/HMPLg+EY6pmkVP4TDdFmZJF4G8MANT8Xk9Z5rxup4cFOK1WtGY0FPepAeDgUgt7JQpqlkJdPrirgdHD/sgal35CzIhpVhhyYeOtD4jJZqGMO74SjT8x9U8qDxjNCEcOxJC0c6UJrPa9S/StMvXUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JKCe1194; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbayer@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JKCe1194;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbayer@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH8Yd4wpnz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 00:23:01 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBH4RO394204;
	Fri, 15 May 2026 14:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ufGlv0
	CVGjiDuGZD9L5jSfGD3Qkubf2rfZSAyyegaMI=; b=JKCe11946uEaM37tUPyS9y
	+GBxXV5ecwZBQGE0MG4VXlSrNehAMbch2D7dDWZrZycQBS1ldFCCiHMj1JuZ5yPY
	icRai+mkrMt/HT8ndPt5ABv8XmVAI48Co4KO97PEtDj85CHe1Im0jjBL5OXR0gYU
	wJsBhcNMQtI03lEMPQlMavDm4KAEDRjiIn4wHiUvrCb0cGK1nbFZLMTlK+3xgsBs
	ButtUnAXawJ1NqpcQif3FkFW9zK+6xTnKsIg88JNRZLTdEpmYWOwdgQW7egbjttN
	1Kmoe9a4vSz5RNHoqkTR2EzSdFRc6orkdtFnXNLJP5UnVrw+To+I9TlTn0hi7Wrg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8vbkuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FE9Ft3006470;
	Fri, 15 May 2026 14:22:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvckveb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FEMPAo31195568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 14:22:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB78920040;
	Fri, 15 May 2026 14:22:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFEF620043;
	Fri, 15 May 2026 14:22:24 +0000 (GMT)
Received: from [192.168.178.55] (unknown [9.87.148.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 14:22:24 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 15 May 2026 16:22:04 +0200
Subject: [PATCH 2/5] arm/pci: Use official API to iterate over PCI buses
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
Message-Id: <20260515-priv_root_buses-v1-2-f8e393c57390@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: aFzaU5N9Oxsa1AO5roV0iznLLypVfmcE
X-Authority-Analysis: v=2.4 cv=duXrzVg4 c=1 sm=1 tr=0 ts=6a072c27 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=HxxVBxD7FXS1ytRSE9oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Vk9kN3RNJI3bq8vbFbT44kmcusmLN0wu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE0MyBTYWx0ZWRfX7dDcHAfANlOI
 GKwpojpJaG7R1bvch3otKbJzIwMp0BiWYn7rHqHR3N9164Ug1+J362q2Fem5JBuahC6NVudBKnc
 LLC3VjG7QHU2CqVb3hnUmY4HfpmYn/dT+/Ky1s+Yr9BZfEZfWgtdTYF5jLuRUNYt/v7RkiuB0FU
 y4FIqW1KYb5BlSaehRP+Ni/edGqSaZSLIDHFyOZevqI53BWkXgM2pqJEO0K7Bx3w0gHqPC+YMdz
 dqwwGhGSECKYNwXWsBxZ4IN+4iA+nemw20T8fMpQN1I2y7XdzS5d62Fki2F5QytcYa5Dr7bYutI
 3x4suhzacH5WtZfDYgGF16sQaz9Oi1z9DR7g2g4nQNaEiuUe7qsJkKqwjZx+chY1C76yhNxMvWy
 1eKwF+edzqgjeT36CHG5SB8yhBWF4FCjWXuakv5486/oTMfIqCOUWEiMl8gHyfmB+SS4oy+9SBG
 4PohG+EbdVb16N2Spaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150143

Replace iterating over pci_root_buses with the official
pci_find_next_bus() call provided by PCI core. This allows to make
pci_root_buses private to PCI core.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 arch/arm/kernel/bios32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index ac0e890510da..35642c9ba054 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -59,9 +59,9 @@ static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, in
 
 void pcibios_report_status(u_int status_mask, int warn)
 {
-	struct pci_bus *bus;
+	struct pci_bus *bus = NULL;
 
-	list_for_each_entry(bus, &pci_root_buses, node)
+	while ((bus = pci_find_next_bus(bus)) != NULL)
 		pcibios_bus_report_status(bus, status_mask, warn);
 }
 

-- 
2.54.0


