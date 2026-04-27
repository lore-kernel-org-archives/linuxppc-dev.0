Return-Path: <linuxppc-dev+bounces-20138-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8CCFF8850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 02:56:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3pB06pW1z2yGX;
	Mon, 27 Apr 2026 12:56:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777258600;
	cv=none; b=HN4PEM9Opr61x2iSzCisaHxyVUJoJFbQ0gHYwdjkb8uZAuSS0IkN+SjYjy5oVNFMlKDNX88IsdHeQGcBFqP07NLmvDhjZl61C0v7kQ13LLVT3bx3E1WnV9Afwzh+UM9hb7hO5H/7Ih8Td27T47v+yZkl2wflDDvkjrFM5grnkqP7Ffq7uBgVxG9bYehT+cvSBzGnVNQh1l6/S97gyLwTqYCjrHVXrmNOhZfH2pk3GywtD/+djvW/nIhdCOz6RCMgIGCIUvzyQDSV+zSkZ/Vaf0K7W77wAyFwLj/8AD68iuQqzZcZu74EMaYF9a/Y5KohcyHyfwl48XoWLlzYWNEPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777258600; c=relaxed/relaxed;
	bh=Xn3mi7KMW1FBVI7pmioeUuys/KMDT/Xo+UTG2dOypMg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=OWK6Sy2UNLpQk+pdQCS6EVR8V3aUjSiVnHHCIRo3m732NBOULZVJDTBMYT1wOACOFbE2ggahH0+/eiFuTfcgK/UYc7f06WZkn7OEBFxG2yIYwY1huVw62SBeMtqoQO29biwBh3+i7riu11TFo1znwHhQ248DM6R1a0a/DpQXKjWd7ONGIjAeVguMeehYjskhfQXPsoSc2p2nupFHVw/ewj4j9Qrs/ts60E2vCrJX+wXgTU0YFi0xOIWHC+8OqBI6TwdMG/aQ9HHqlyAis7FJzMG0rD046HQmxJ8xZwZ4dfYE77H/kUgwmJnhmDUXWe+5nuyNoPEwRZ5PGGIwA/+4/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QMrKXOvK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QMrKXOvK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3p9z2CLDz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 12:56:38 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QHNhMG2683203;
	Mon, 27 Apr 2026 02:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Xn3mi7KMW1FBVI7pmioeUuys/KMD
	T/Xo+UTG2dOypMg=; b=QMrKXOvKbjbxePz8hJGZeyYFc5q5sqW/Owo62wPN8Y+Q
	gr6j4GY3E/TrqROubP3pJeCfeK9Ckcq23t3J2P9qgg2tPswT6iA0I8tGUR19JZGr
	g0dHNZorexuZXRaddezDsNm3va5cOPcW4S7mM7T5HfXnGtBWe7o6iLOPMRTAPIf2
	/s58gRFB6YmkxKtqxuKpXpp2bksAhzbcYTeY3koNPR9o2a+tvd6Bn959BILfQ4B5
	H3i1O41nyp4pXvoxNLNj1YzpzD4CBkgAAkKvSvGniCvBfF8NvYdIw5jRnyKesPO9
	Prxy8UPAnWx7viC75dF16Q0MAeParie+GBZ81kg2GA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jdxn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 02:56:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R2ruPb012501;
	Mon, 27 Apr 2026 02:56:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g38ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 02:56:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R2uLop58458610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 02:56:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73FF720043;
	Mon, 27 Apr 2026 02:56:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F46620040;
	Mon, 27 Apr 2026 02:56:20 +0000 (GMT)
Received: from [10.88.0.2] (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 02:56:19 +0000 (GMT)
Subject: [PATCH] powerpc/rtas_pci: No hotplug on permanently removed device on
 pSeries
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        sbhat@linux.ibm.com, linux-kernel@vger.kernel.org
Date: Mon, 27 Apr 2026 02:55:19 +0000
Message-ID: <177725851139.12391.5948009745181492600.stgit@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAyNyBTYWx0ZWRfXyIFkyYmGzffv
 m1b7b2scQTPrV87PyBF2PDjSw9bVTEM8QnrLn+Dl0fjp2zN3NPgS+NpZRSCi9w0E89syvIIaQ7L
 X280cwNIvnipYoCuoCtV9neKYr/XB1wgIH2t0u7WwDa1deON7XH+9C5ZXfSudRrDXXrT1i/6QZi
 pZgjq1a0LDJbPpxWTglulNW4oNV94dLU8Eh7PZ8J2EQvL7dHbOS7tLm5sp1zTbtCfWCjly9w8pl
 jEd6GZk78zy9PA/MdlKPzWJogkKchwgCMZsRXGMjvEOWuvYadQWb15nkWfBgb3M7ACBmVAR9VJz
 FQlAmC3l07yVQe0weHFEs+G/j5NoO9trxzOIEHSHyj2dFJ0mBAiC7+GLZJkzzTNcDp4tWN0oeCa
 IjQlxy7v1h6CK0D3pDQEQbvul6vj4YMIRUu3PeKXF0MyeXbYlldRKDUkLq7+UA2aNmeUcqMD3un
 OObwBLiSgX1MMjWG12A==
X-Proofpoint-GUID: xGXgjvPLjukpyCrpLpClClWhO-pHmymm
X-Proofpoint-ORIG-GUID: JUSzJo9XncJ4jXLFa5pNDCqV4fRNxr82
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69eed05a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=hXN3hDdva7rXtmnWi-wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270027

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
 arch/powerpc/kernel/rtas_pci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index fccf96e897f6..ce24b18712ca 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -57,6 +57,9 @@ int rtas_pci_dn_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 	if (pdn->edev && pdn->edev->pe &&
 	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
 		return PCIBIOS_SET_FAILED;
+
+	if (pdn->edev && pdn->edev->mode & EEH_DEV_REMOVED)
+		return PCIBIOS_SET_FAILED;
 #endif
 
 	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
@@ -108,6 +111,9 @@ int rtas_pci_dn_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 	if (pdn->edev && pdn->edev->pe &&
 	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
 		return PCIBIOS_SET_FAILED;
+
+	if (pdn->edev && pdn->edev->mode & EEH_DEV_REMOVED)
+		return PCIBIOS_SET_FAILED;
 #endif
 
 	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);



