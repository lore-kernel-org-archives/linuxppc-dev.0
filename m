Return-Path: <linuxppc-dev+bounces-25986-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AA8C5DF85
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 18:00:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQDrM5hMtz2y8c;
	Thu, 20 Aug 2026 04:00:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787162435;
	cv=none; b=UdhZArN6i+Gr5HE65p82ZBpus4oM6Eeg/M1KjMuJ6l+uBgEKUUgnK+9AOR6wlmnpmR2MquZC/bUVB2KKW8ayO+VCCFatMuin78+5P3C4BdO7sUGhXaEi4IoJNc1/y/pW4pfSxGZUenDvfdIt8e+ZPHrxIixpDf/8VxDfYpctMWcy6hn+OCspb29BbD1CVGgRZ8xM94iQnbPsNPsRkatw6gAIcGEGGyLLW9gUiOx1TiRaDGc3r7epqapV+PixyEcYLtYp3D6zyld3OF500l1sWoIze/CG6nxzkes9PSXPCYZ+l6OrY3YStzQtFysZf7nNfjDShtHpkCKOdXHvuACheg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787162435; c=relaxed/relaxed;
	bh=f809616TQAuNQx2Y+lfg7z6H5ml1AQoZbwPFqWnmjto=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=NxnBSvvRPJCPz96zIh7Ky4zOkQ0IYmi7OWEpINef3gAB54Qt3Fkm0k53JLYL7H54UoexspjkV0iLhmu8ZaA9TXgLvX8CEBfnHR0/fe44xKwcQMV/J/xRTY4E/o+KkTmhh1U/NOGZC9hXdwqsq1JzLQawUSpIFZXqzFhnk/L6pGHjVbg1efF6h+aLuRSBTJRtIywxnyICCOJmq9pa2yLPQSmQW62vdyrb3FWRN6a0oV9tGwG66fkpzDTmO5eKI0qEtL+UTPz8bIXuFkHBJyCnxwkyEy1Bs30uu6v8Rga5V9YuBANEni2TCM2h1n/mkIXW22cmwk80jT9x2WOmr2NhcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JJ1vIzkD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JJ1vIzkD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQDrL3qcXz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 04:00:33 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1sS42684873;
	Wed, 19 Aug 2026 18:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=f809616TQAuNQx2Y+lfg7z6H5ml1
	AQoZbwPFqWnmjto=; b=JJ1vIzkDtDQfAmCfQRJEAzBJsxb1vS27aon2xKDYsAIG
	64kkColHsUVDboVCYlV87ztPZpw4SjywsP8OSYK6+V243lD+TOuuasMI+2bs9Z/c
	D/b+CP6J9S8RfNJ7oJQcGp2nReJZ4ppg0lraSfrbP66uiLCMUnMbLxI92qkAG/1+
	o02lnqhHSwKSn0ZnBSE1YqAAhgzXR5GfCUA7hZkw9v4zFAlaeIabamGbj7ITn7x0
	ei4MtQucwr7CFP3v0ddpVa0KjGPOop6cTlBCRI8/Uc7q8AvZo4mMwTftDb0WEH0O
	kCvBEsLp3HDYy9sbQSK9bJY5CFw3nqtcMTIaMtP8Tw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu259x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 18:00:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHun0d012958;
	Wed, 19 Aug 2026 18:00:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xha6c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 18:00:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JHxxMI42992064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 17:59:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2162A2004B;
	Wed, 19 Aug 2026 17:59:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6F3820040;
	Wed, 19 Aug 2026 17:59:56 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 17:59:56 +0000 (GMT)
Subject: [PATCH] powerpc: pci-ioda: Fix the stale irq chip reference
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: tpearson@raptorengineering.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, namcao@linutronix.de, tglx@kernel.org,
        yury.norov@gmail.com, tiwai@suse.de, sbhat@linux.ibm.com,
        wangruikang@iscas.ac.cn, linux-kernel@vger.kernel.org
Date: Wed, 19 Aug 2026 17:58:22 +0000
Message-ID: <178716225364.1437.6201568081502251835.stgit@linux.ibm.com>
User-Agent: StGit/1.5
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a85ef24 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VflPewI5Ea8Cah3RUCMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: s0qOrReJKZnGl_UxHmfPrv4waLFuKjsE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfXxq1RlGObHGdy
 DRqmtFsMBqHGCWekTtwHfAAX7PQDIrqdYt+8X12FT7XDiiUe1XfARIYNihmIdQjzrtjVBFXvBih
 G2QGKd2hL4lFB8KKoy45jnldf8nyxPbkLFxE4blMx06syM/cFDnV9wN+5hUTPRWSyMT5qEbab8h
 xt9vWtg8uL6DbrQWKS2H/NX5oAmr7yWBNx+CTHghJnm4MObKjsALjq/MY1RSDZICTewvB8H4sS7
 BkjUIhriTrLSWsR4sFHr1s4/fhxWa+IsMBwnbieWviPtqcGvxJRUblHzDC5ZmojfFhqv/XGqjV3
 FwVgAXwug067SBpvHm3IpBzH3RGA4YqTkc8L5xL78/XOpetSRyu+sfcg9ypJ1csfR6HvlOH/vQq
 RrR2LG9whlbxHEEwT6z79lu99+RW46ueEdn1VBa1O6Siqj10gqqgdwuOntqbXUxUFyKxxKsPDrL
 PgHgTPa0wOibkz5QGnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX/Bz0sPodjXpL
 0NZBN8NVWHC9bZWlBm4oubhC5RyUgOLKJihA6SKgZIQTgjWXYVUGjSTbvKYviEHg0UZL9c8WRz3
 ewQXB6XSYN0DnKM0FkjdrXpBCgjlhLQ=
X-Proofpoint-ORIG-GUID: Hyb5E4LI1vtDLV3N2_ysSN83HiRHcjFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190136

The commit f0ac60e6e311 ("powerpc/powernv/pci: Switch to use
msi_create_parent_irq_domain()") removed the legacy MSI irq chip
pnv_pci_msi_irq_chip but left behind the static definition of it and
its reference in is_pnv_opal_msi().

The KVM IRQ bypass for vfio devices is broken because the
comparision in is_pnv_opal_msi() fails on the comparision with
stale unused variable showing the below errors in dmesg.

 kvmppc_set_passthru_irq_hv: Could not assign IRQ map for (X,Y)
 kvmppc_set_passthru_irq (irq X, gsi Y) fails: -2
 vfio-pci A:B:C.D irq bypass producer (eventfd Z) registration fails: -2

The patch removes the stale variable definition and fixes the
is_pnv_opal_msi() by comparing against the chip name prefix.

Fixes: f0ac60e6e311 ("powerpc/powernv/pci: Switch to use msi_create_parent_irq_domain()")
Cc: stable@kernel.org
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 32ecbc46e74b..728a5610d167 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1623,15 +1623,13 @@ int64_t pnv_opal_pci_msi_eoi(struct irq_data *d)
 	return opal_pci_msi_eoi(phb->opal_id, d->parent_data->hwirq);
 }
 
-static struct irq_chip pnv_pci_msi_irq_chip;
-
 /*
  * Returns true iff chip is something that we could call
  * pnv_opal_pci_msi_eoi for.
  */
 bool is_pnv_opal_msi(struct irq_chip *chip)
 {
-	return chip == &pnv_pci_msi_irq_chip;
+	return chip && chip->name && str_has_prefix(chip->name, "PNV-");
 }
 EXPORT_SYMBOL_GPL(is_pnv_opal_msi);
 
@@ -1728,7 +1726,7 @@ static const struct msi_parent_ops pnv_msi_parent_ops = {
 	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI,
-	.prefix			= "PNV-",
+	.prefix			= "PNV-", /* Note: is_pnv_opal_msi() uses this */
 	.init_dev_msi_info	= pnv_init_dev_msi_info,
 };
 



