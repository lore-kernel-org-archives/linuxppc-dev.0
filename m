Return-Path: <linuxppc-dev+bounces-22152-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403FFCD8C8C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2026 15:18:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXhlM5BPcz3bqD;
	Sun, 07 Jun 2026 01:18:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780759103;
	cv=none; b=ILzJH4oDoHXX99r2mv+kUgWW+vAcPaK+I2uDjU81GCG5LU5etn+cGZlCMyb40za/RYQcpINoT24YPQGS/0mZqwLgHzQ7SKlX7hZRFANcFU8h6NHS+fBYQcUSY7WRmZ0XgkBhyVxF843GkiUBhpBtWlq8yJqi7VfPoOC1O8I2CNMMHFw37FwSzvPco/24SyppnznNBIC3MGhyvwd/TbbduLbzYwB4mELx2cakDcnu1KOOO8Q5T+jGwYSenGCkpy7cUO9OrccyMCS8kdMdhm66RUyhO6ToaJQWjpFwAGARFWczHfDKZ9jUdltYdxFLhmI2QTJWFbctNXmDbm6bdvXTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780759103; c=relaxed/relaxed;
	bh=3ArlLswGmfQemCZGM37g2kUcXqZDo2XdqvnR9GVoxQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgLMWtTuzN1Q63qzDHa8RJ5oGilTMawSAg8PVYLnNHJf8zgyUCyCR94RuwswKOMMSLBDag+a3sbpVFo0fiaH1XWFbL7zD2tRrAkl1epBGROaZ5ODRRGjyTB8tX3e4E4xx1UAyBu+rLB5/5enn77VGamshSOeD9XHmnSv2+mxMl7hzDPhynQ1aGeDc3cjc3hWtmwPFiHY8XVT77km76zK9UbqcT663/AIRLpgPjlLghKX60gNAUqjIKRrFt7TZAmcfA+MHvR5fqojuPPFJpmoUSb8827O64Jxig5E2ktvGIwwKESALOrM3he0pBYnSsK35bisIE/dtOQ1N3VWQKri2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fHpnslB3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fHpnslB3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXhlL6RlXz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jun 2026 01:18:22 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BtZlS476871;
	Sat, 6 Jun 2026 15:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3ArlLswGmfQemCZGM
	37g2kUcXqZDo2XdqvnR9GVoxQY=; b=fHpnslB3P/Gb564DUJXpHhh8wzBz03Gu/
	KLNiYlwdR8QSL5bmGSQe+KwzYGuvqz17tyjlh8Jt/7ufWkuwRzgKlGepvTkzzd+v
	MVWM9rkPAwe2pF1CPfhRZhahZoIWQXDebhQU+ARJX0Nh8gsXWLyX7Nv0tjp+BAjw
	vCvp471KsoDLEw9+zu/aI4mwGLjfgqRnxr03LPpUU/3rtZopUeIOGFWxp73r3tVe
	BtxA70pakFSyHPLnQuioYS5ab1Y5uuXIM1pBGp5nEjPzKLtmNWlBUX7PyZ8A+syO
	RJQ+N+6Rebf9Axe6MveIzI2pYL3UEGFJjzhZ8WbvtysOH/y2ttCPQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhhkue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 15:18:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656F54sk012524;
	Sat, 6 Jun 2026 15:18:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kp48u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 15:18:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 656FI8dQ49218012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Jun 2026 15:18:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5543520043;
	Sat,  6 Jun 2026 15:18:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5593320040;
	Sat,  6 Jun 2026 15:18:03 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.124.211.229])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Jun 2026 15:18:03 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com,
        adityag@linux.ibm.com, venkat88@linux.ibm.com,
        sourabhjain@linux.ibm.com, avnish@linux.ibm.com, sayalip@linux.ibm.com
Subject: [RFC PATCH 1/1] powerpc/fadump: move crash memory reservation to middle of RAM
Date: Sat,  6 Jun 2026 20:47:39 +0530
Message-ID: <20260606151739.1720246-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260606151739.1720246-1-sourabhjain@linux.ibm.com>
References: <20260606151739.1720246-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE1NCBTYWx0ZWRfXyt5F4+8TVJa0
 4tsscnHZy+gE2Zl2xCRrSwusYLZfUtO6eyyJJ/cCaIthMoJgaA2KPkaIpAJbtt8R+CiCWmK1mQH
 GOlgCDGuogQDDvcHYOyvnWSlNn1dMBsEBYMSlT6oXSHCettMISU0TlATZYhYcNl/oinnEmJbNgi
 jHme8AsjDDzHtLinQBOUjouSzrT5YXiHLelR1BXHqm0ZtPCi/Cnfs6tqqTNr2J0FowK0qD1pSzA
 PbIc1VW38M5XJ+13McDlmje1/pXgbLvpKuQ7iY4lUTMMqX2y4YyVE1z3dmuwStZ+brXtabr/qI1
 rGmR6RTC+Jiml9gVTzysDodAup0J5hN2R6zjhTeGt1b+CAToFhZZqj+eRlq1xxKVsStg9rjb5d5
 BErxLr7Y4aOL3QI4RzzOmQN+KURmtPTtAlNrzhqMBeeMLy2jZtLKhsWbD1OLm3BxoTucfyzsYIp
 GLiSQqBhcdL/ty1lhkg==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a243a35 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=-mTSyfWIt07sbQz3qQAA:9
X-Proofpoint-ORIG-GUID: x9r-Re_jZ07cJNhNttXP5V_tkNuEzEqb
X-Proofpoint-GUID: OtK9_b7vAfLsu3QImBUOrG8MXFUq_uT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060154

Currently, the fadump crash memory reservation base is derived from
the crashkernel reservation size. For example, with crashkernel=768M,
the crash memory area is preferably placed at 768M physical address.
If a suitable reservation area is not available due to memory holes or
reserved ranges, the base address is adjusted accordingly.

When a kernel crashes with fadump enabled, the system performs a reboot
and the next kernel boots with special device tree properties added by
firmware to indicate an active dump. During this reboot flow, GRUB is
invoked again before the capture kernel boots.

To preserve the crashed kernel memory, GRUB operation must stay below
the fadump crash memory reservation area. Currently this works because
fadump requires a minimum crashkernel reservation of 768M, which ensures
that the fadump memory reservation base address is at least 768M.

However, if GRUB increases its memory access range in future, it may
overwrite the preserved crash memory before the capture kernel boots,
resulting in dump corruption.

Avoid this dependency by moving the fadump crash memory reservation
base to the middle of system RAM instead of deriving it from the
crashkernel reservation size.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 501d43bf18f3..1b4a330b7de0 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -586,7 +586,11 @@ int __init fadump_reserve_mem(void)
 	else
 		mem_boundary = memblock_end_of_DRAM();
 
-	base = fw_dump.boot_mem_top;
+	if (fw_dump.dump_active)
+		base = fw_dump.boot_mem_top;
+	else
+		base = mem_boundary / 2;
+
 	size = get_fadump_area_size();
 	fw_dump.reserve_dump_area_size = size;
 	if (fw_dump.dump_active) {
-- 
2.52.0


