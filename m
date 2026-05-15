Return-Path: <linuxppc-dev+bounces-20975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED779CD4F25
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 14:27:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH8fp3t7Yz2xnZ;
	Sat, 16 May 2026 00:27:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778854982;
	cv=none; b=ZNa1etwknBOPMqXyH1Mo238sXb7h5UAs+Ow58rFIrrAYXNk5gF877oj3hxYAlXyEJaVa+yh7uEToxwyhZACw3aJZIGs/y50S7v3ixklCMLfZcjS7TEwGebeStWOgyuGid7Wivbrf+6ka8mZdPpDg0YdjebNFpiJOl7frL733hJy2jUspLv9zT3p/xC7HGD4KJrVRbEXWZ+peL2NeRlSmikGrzDOgbT7I62/AtdOBSnafQZHKlwsKjY9IZ5LfFOx9TcEDZdcrMwlT4/6uV8dKsO2zhcbQmDJT2phP3k/kHk77TRp/TQDZCaIfaFuefs9Gs9LLEfs3nshHt41Ld9n3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778854982; c=relaxed/relaxed;
	bh=P8kcyQqXjPJl/wA2iNvOTp3xe+f0bXif7P+1RpYbGxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GxnNOSFSI/j1wvGFa4ZdnuDnb6NkzMcuaMEBU7EbUe9proGCAm5D7smT/qa531OxjLO6jUQZOtfcRUDNfEqLliVb4DZHuDgxQvID+A3MDqIgl81YZNYTsLhJmCD5Wkn6uBlZPdaGtyumIajvAgkp7uRE9DjDAExv988yt4xKcRi4UGDsbRSDEnIIEFhu0DqAd2V/sHaQGgD08b8mRrn9UWeQ1gChZVkVnm4GPWK2+Vqr8gJtXD31lCsXl1KZ5yM1XAhUahMxRqYfZd6tETbB+NKvxdbV/2aJP/JT5dW2XoRxDbKtk5rlLNsuHxnKcbeYRr1luZ3UE6AiG28oEVqbBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bRyihCop; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbayer@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bRyihCop;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbayer@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH8Yf2vGrz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 00:23:02 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBY8BR3953235;
	Fri, 15 May 2026 14:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P8kcyQ
	qXjPJl/wA2iNvOTp3xe+f0bXif7P+1RpYbGxs=; b=bRyihCopm4HbUs3qahWe3e
	lfJYr3QO0rv4sAtIn0VzH1vDfDfyXbiKXTDLrqnZ9KhEJ5+wlVdYoKgAZ0tH9cpA
	DYY/qen8cmtFxdI+O4TiX7GbHw6QwBACXtB5VHkGZArq3OC1ZuC4/sVkD+Wkqwyz
	W8srPe8/l/OeOOS7Gc1y8Satyi/gHETCpI6e+2o1w+//NWON6n/SnJOMt99utcpZ
	wWzSJqeh2Oh2fDDleJ+ISEw5BLP7CkIHLVIGFrl12sBHzJPon1ETHG8XYYn5nG/7
	aBVHw+slhi0aCv0nzAuRL1MSaxjsDFUqpYNbQgb22urh+71uyVXq0J+fFF9xxV4w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8ybkfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FE9ECB022649;
	Fri, 15 May 2026 14:22:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcuvay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FEMTTB53412222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 14:22:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 844BD20040;
	Fri, 15 May 2026 14:22:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E7420043;
	Fri, 15 May 2026 14:22:28 +0000 (GMT)
Received: from [192.168.178.55] (unknown [9.87.148.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 14:22:28 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 15 May 2026 16:22:07 +0200
Subject: [PATCH 5/5] PCI: Make pci_root_buses private to PCI core
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
Message-Id: <20260515-priv_root_buses-v1-5-f8e393c57390@linux.ibm.com>
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
X-Proofpoint-GUID: 2_E4E5fQqGK_gdgWkz3XVFqX2Y64d0U-
X-Authority-Analysis: v=2.4 cv=Os5/DS/t c=1 sm=1 tr=0 ts=6a072c2a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=28hvmymbyGcFHlkD5P8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gbZhqh0AjV2r8Vc2qnzG8viGM-BWhP2c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE0MyBTYWx0ZWRfX8z4Tzbj1mY3i
 OEcTYAqVviT097HtrxKeQs5QgPSSPoxwMDRWUARFq9HWbqoZOmAO3g/f2FiP4CHxWVz+kvd9yyI
 fdlfRR+Ij9IyF52PMHC3ST7BN9J7msYmDV+CBuCut9r4jshOtyh52Q4gMy5Cxh2QBay1MC6JWny
 SMVEgbAiFwzafkGzqPBBkIcToihe3YzCW0yAcq2hevlIfDOeWt7qHJZcsZbvVvZ0JEZQBqBeQTm
 MxWdTKx3rMRXOWoBQSz6I7xJY4nOrvnLx7i9Ojl9IGga3ItD9V2gGjkAoJczV6Kq0tOIyQFH99u
 Ge+o32YtYT7Wgp1zKUvHYBZu3P3hI41t6EFW1lDD4JWY+4i8xdvvyzf6z0bXRtD4blf/Whzr0Sk
 ogX/QCjpchV5L71bBnKKutAPOnuPlng/sh5Y6E9GCCRy6dxMggiXe5ocOFOQ1vbopuFIIloL/Zq
 WuNcajT4UphwmTXDVcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150143

After all users of pci_root_buses external to PCI core have been
converted to using pci_find_next_bus(), move its declaration to the
PCI core code and stop exporting the symbol.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.h   | 3 +++
 drivers/pci/probe.c | 2 --
 include/linux/pci.h | 4 ----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..1f36d400c9e0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -366,6 +366,9 @@ static inline void pci_create_legacy_files(struct pci_bus *bus) { }
 static inline void pci_remove_legacy_files(struct pci_bus *bus) { }
 #endif
 
+/* List of all known PCI buses */
+extern struct list_head pci_root_buses;
+
 /* Lock for read/write access to pci device and bus lists */
 extern struct rw_semaphore pci_bus_sem;
 extern struct mutex pci_slot_mutex;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..2e97ab125ead 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -33,9 +33,7 @@ static struct resource busn_resource = {
 	.flags	= IORESOURCE_BUS,
 };
 
-/* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
-EXPORT_SYMBOL(pci_root_buses);
 
 static LIST_HEAD(pci_domain_busn_res_list);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..1c4610848b5c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1192,10 +1192,6 @@ extern enum pcie_bus_config_types pcie_bus_config;
 
 extern const struct bus_type pci_bus_type;
 
-/* Do NOT directly access these two variables, unless you are arch-specific PCI
- * code, or PCI core code. */
-extern struct list_head pci_root_buses;	/* List of all known PCI buses */
-
 void pcibios_resource_survey_bus(struct pci_bus *bus);
 void pcibios_bus_add_device(struct pci_dev *pdev);
 void pcibios_add_bus(struct pci_bus *bus);

-- 
2.54.0


