Return-Path: <linuxppc-dev+bounces-23010-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52515CDE00E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 09:13:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmqj16gQPz2yVv;
	Fri, 26 Jun 2026 19:13:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782465205;
	cv=none; b=Uro41pN30Z4NZJV9HNSXIzp4UstsFwYyo0WnujsSAu0zyI3SlGZ9vT63t2+0Quc7Sgmw9pkTwvo5yeW3KfLuRCE+orh0/UDVNETlqYnQp1ZXAIdggLyo3raLc+imyUTiwBnoO5Lx2a2eQx5j/MknPn2H4dsudb6++pGRY7oCPVK5VcqfvTxfTMEQk7zsnUCw/x+r/cyZHhDAcO9+TdizBGhfmxDApI/0RvpbtnG/yRthSTOo/mkpRDhGGS58yaGVAhoftuugC0PG77r9bMC006UFR8IhOYoTIuL+87kPGedUt21yVdJIwjASlfXrCVPgN0VFcQJNLqaklKhWsHk2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782465205; c=relaxed/relaxed;
	bh=v6gDTn5FgvBoj/xb3W1jwiO4tyzvEh2+Yekrgngyuzc=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=hNLODWClI2I/pvcQ/Xp81aQsMmbEqJ+nrkZEiBIkf3Qbe19KcvY8DBlDlBgUWmceaNeJAUyXAebrN+YVZNQX7hktoYR46BwgB4c+aeBPY/h9ajyCr4w+d0pD6p7gC2JoNU85JhnK52w43JA5cFBEsKcSYK0nmmbQdemjjUAqN7R0lepljwdvZmFM4DmyD8VTE1MJPUKRqlqNMCLBuMpAmeR4iyUq1TOKT0yOdzDyWFTC98oWfHEgUsm6hscJxli4SgLNA5Rg8UbwWnMW1DSxmDB6ISrYvKA1bMXuNjndVvRdJxcTFJqgoK35BTtwUvj+CLsZS9uuDwalGZK9CGDYsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HBZ8kOeC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HBZ8kOeC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmqj061K4z2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 19:13:24 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6mQuE2322718;
	Fri, 26 Jun 2026 09:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=v6gDTn5FgvBoj/xb3W1jwiO4tyzv
	Eh2+Yekrgngyuzc=; b=HBZ8kOeCCWBDDBmXGZr4Ddo305kLY+idGnddzETmqZsU
	cDs+ItEgcLc3dqI5akrrpI5r5aN6X6/CL1dcKNiTKOYDaBmr8KU4oXfAvX9IMqYQ
	jUKEQ4kVnc1mVy9+SKpHi7mBIRaadvihoZKj8enRmUaJWJ7ZXEt9TNtIDNUzSfwX
	gQnIKFwQoJToNHntYcTZX6HsXYGkcIPvQExHbBdDSr3m1qiyryjc6ZRSfOsw0A0X
	hK89fOzN54Svb2cG3H+H8vbX3021WVXLh9roD2oJTuKlKysmGaesnuzzSoKagrRH
	oSJLL5nNbHeu/4HhpBij6oW+MfLZJUobZt9AEmTkBw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3xayd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 09:13:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q94jNI007133;
	Fri, 26 Jun 2026 09:13:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgj5fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 09:13:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65Q9D41a43057412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 09:13:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 919BE2004B;
	Fri, 26 Jun 2026 09:13:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1798B20040;
	Fri, 26 Jun 2026 09:13:03 +0000 (GMT)
Received: from [10.88.0.2] (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 09:13:02 +0000 (GMT)
Subject: [PATCH v2] powerpc/rtas_pci: No hotplug on permanently removed device
 on pSeries
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: harshpb@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, sbhat@linux.ibm.com, linux-kernel@vger.kernel.org
Date: Fri, 26 Jun 2026 09:13:03 +0000
Message-ID: <178246517230.1267.12206176311111155505.stgit@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3e42a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=X10Nmy_CeZXe0l56EggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX+txLtLQFW2aB
 YFEFiDBldMPvgya5lbBWUYErgMbS0ITejN0NNm1m+6mXadPWdJ1CfnjilFIX7oU5dFQG5pPiiAk
 KcxvPr9Gd/h3NdspGcxthWPqf1qH0Ys=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX9etoxmGGvbTL
 y4bGjO8bHBXGM33esx72Y8clfixb07CfykgF+Mbwc+WxSTOD4IXL5IHygf/6maC85E5ypKO5sfv
 gvsnODOns4qbrLF5Rv//Q+IlMB2yDJCZQKmiYEWSNvo3TBzZUnqFOFeZnoTMvypZaGMCeBGvf6l
 VeCXYvoKdiFOHmfO2UyRnQVfBRkIlO16yM1mRjmwisVYi93imdBjv1P7Asj0XxpXNiPj3uBiFZ/
 GMLPUGc9ijshZX9pp5jbbdL67RG1QOhtzOTXN1H/SWP+wxvcCzEnu78vdndSMy/cfnFcCdblAHU
 OQ2sIb6shaeSUpo+11FS8jI0GSvaKwdVUyjiIJ0jjIRgAmie3VAITEluu9DnfHpO/1LASe/a7Jn
 xzUJC4K5nlWqQGFhA3CHrHb58F5WpInKvwN//UVyc83+jpvua4gWd2KKx339rUhPlZWoJ47xane
 9/5OGhXqPJYKARFM9fA==
X-Proofpoint-ORIG-GUID: KT1GE4JRALs8mm1aQua1QrvEX9FO_55F
X-Proofpoint-GUID: Uzd7feYOgz6Gx7CP0rmOngIUkSOtQYjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260070

The eeh_driver disables and offlines the PE permanently when it
exceeds the freeze count beyond eeh_max_freeze within the last hour.
The PE is only offline, so the device tree entries, eeh device
references are all intact till the real unplug of the device from
the guest/host takes place.

On pSeries, with a new hotplug of any PCI device, the drmgr initiates
a system-wide PCI rescan, which finds devices offlined by the eeh_driver
and there will be attempts to bring them online. This leads to
recurring EEHs either at the config read time itself or a bit
later depending on the type of the problem.

For PowerNV, the commit d2b0f6f77ee5 ("powerpc/eeh: No hotplug on
permanently removed dev") introduced the EEH_DEV_REMOVED flag to
prevent such inadvertent rescans on hierarchical toplogies relavent in
Baremetal setups. For pSeries, such topologies don't really make sense
as the devices are either part of the same PE OR exposed as independent
devices on multiple virtual PHBs. However, the inadvertent rescans are
still a possibility with either hotplug of a new device or otherwise
with manual system-wide pci bus rescan attempts.

So the patch checks for EEH_DEV_REMOVED before allowing config space
access just like PowerNV, making the PCI core omit the PE, and thus
preventing subsequent EEH recurances. The patch is tested on PowerVM
and KVM machines with single and multi-function devices, and on the
devices behind a switch. The unplug of the affected devices post EEH
removal is also working fine as expected.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
References: d2b0f6f77ee5 ("powerpc/eeh: No hotplug on permanently removed dev")
---
 arch/powerpc/kernel/rtas_pci.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index fccf96e897f6..206c825225c2 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -54,6 +54,10 @@ int rtas_pci_dn_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 	if (!config_access_valid(pdn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 #ifdef CONFIG_EEH
+	if (pdn->edev &&
+	    (pdn->edev->mode & EEH_DEV_REMOVED))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (pdn->edev && pdn->edev->pe &&
 	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
 		return PCIBIOS_SET_FAILED;
@@ -105,6 +109,10 @@ int rtas_pci_dn_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 	if (!config_access_valid(pdn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 #ifdef CONFIG_EEH
+	if (pdn->edev &&
+	    (pdn->edev->mode & EEH_DEV_REMOVED))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (pdn->edev && pdn->edev->pe &&
 	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
 		return PCIBIOS_SET_FAILED;



