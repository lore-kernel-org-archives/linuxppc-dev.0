Return-Path: <linuxppc-dev+bounces-24261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DC1C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 17:16:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h05ZJ2YBGz2yY0;
	Wed, 15 Jul 2026 03:16:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784049400;
	cv=none; b=l/gCCGs3SUyUCe/sxtpVh+k7+fieoF50cYGJzHLuImBPWRmpKpnA/O5zFEjvcjE804CWqviRDIGm2bJ2vaBj/7MDQ8gBdX7temudIjfUiiyVVkeLwRLpTK0cPr6ALAvRNtkXO7xm6Wb2/gMmem12G6PkmCi2X1re78ErMn+tfQBi+5IQZNO+XhQlPbNoHf0KR734SFiKPKKFPn/Qndchhgm5BJf/ktT7c8a5xpoNLAqDAvhINEe2qd6007dQHnrvWvK4+p405Fq5abt45/H7jydU0xSY57oqUHpOBNx46AetyMf/exsPD9v6MZ9mLQwxFQctDIr45Hl6OMHdR0K87w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784049400; c=relaxed/relaxed;
	bh=BN1bapyXWsF6ooooo4YnizJnLIrFYRxFw2nU7p3eh0A=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=WSEsloPxURyq6iZTG8mkp+FHxATvHdE6SbNcN5F/PbFNCWKeL+jsd7o0hopZky+Uf3f5xtXnmhd2zEGam4ann1eyfi1lQtoeufQV14Ou50Jvyl1zB20CONrzRfQJavyo4R5h9Lt9ZKdFjlKTT+ZYGwQDT1raqBg57Wgc+2qgMUuGTGJRLg2XEJA/l88RNgzwbXz5TFc6pE3MDlF7l3KmhGbePACImlLbUbamBfVSUDPlpPcFRdNWy2X/ci6SwB4ihlRq9AafyoNI7h7ighVjeHXXSjB2XxuYtaIHTs3sFyneyHA0uEPKY93dEBRTlIJmSI5h524G08yAxjO0Jx0hYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ii+/nUWb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ii+/nUWb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h05ZH35qmz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 03:16:39 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EGC0C61805977;
	Tue, 14 Jul 2026 17:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=BN1bapyXWsF6ooooo4YnizJnLIrF
	YRxFw2nU7p3eh0A=; b=ii+/nUWb9Q78nZCO72ka+2kf7mXNE87JLvz0jlxPyr4L
	iuct4OTdTMUENykKaQWo1p/FPyLaKGWINTsv/w1GGY1gsDUs+biZIL3TGdk9zBlR
	KmrgKxgqYiNpPGv5XtNuG20mMFi7uL0/bsbVSw8U9v7/YcuQLcyzLgUwpchjBGIh
	vYiS/LtMKHFgRtItnqgpJdTbbpy9MxJrhM+2pOOtba3coGjPjLOg9qowGU9jggyT
	3oPymlQWde/Uf+Bmz2kARHy/IG60efm7EuTYIGfdu89M5TY/iRVdJTGYpE8qXl4b
	LKzpAtdk2EMTxkREc2rE3zZHBNqGnIKU09baKtQufQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxfd87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 17:16:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EH4eEi015494;
	Tue, 14 Jul 2026 17:16:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw40qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 17:16:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EHGOLb36241870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 17:16:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 782A120043;
	Tue, 14 Jul 2026 17:16:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF6F320040;
	Tue, 14 Jul 2026 17:16:22 +0000 (GMT)
Received: from [10.88.0.2] (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 17:16:22 +0000 (GMT)
Subject: [PATCH v2] powerpc/eeh: Fix recursive locking on devices without EEH
 sensitive driver
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: harshpb@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, sbhat@linux.ibm.com, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 17:16:23 +0000
Message-ID: <178404937381.913.2759874335293830160.stgit@linux.ibm.com>
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
X-Proofpoint-GUID: TDIa28Vk4m81zZoZx4XEAhGKGcUKIP3n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfXyprxumugrdGq
 oSg8YyApru96mYnCGl6Cw8p59S9DyBinx5KOvA+o2J6I6P7D4hU47xS/oKdzLq/dnYojPNxPO/n
 L9z+BPMpV+BxJp0gpj+ATQgoSY/zCFM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX8SK5LvFU8xVY
 sLAn8sn1j9Jcp9K8tiZvix07VLUo8nAv0kWm9IBoZf0NLN5HKSuEdbzfzyu7KbsH7LPWVi/JEcB
 jTIs3AFbL5ypjiT8EApOBKW2REgi/jbK3z/3Xtbl7NcMH0RRgEsHneOw0k2xtUTJgdCSxJAs0Fu
 EhvO2DYRVx44b1Uu1rYSvgSgm/n6roLN3yEfSYhI9DAXPgQr9C38AvE1cCDHg3OdbrPjtLH7d3m
 6Mor5rbVA5O4x4gN2wCX0w4R6pIiqHwqGDwG/lYre81YwCKMGLJX1NN6F4T/C5pox4DM7aeDivh
 V/kTYvddvSBpL5vlwnlbTd4wGXnYvjUBCkgeHmwIWM8u+ZaDcqVUQ8AefApuCNl5XbmhwICHzK7
 YRK5QpUoKVIRZJkYbgr5SjrKg75cTR6sdzUtENEhFG4ZiHV8hI5NsTHomJ4fT9WcH6R+pBdEXIr
 kna2MBcM+u3DBgz0E5A==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a566eee cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=79fxzGWUOgRnezMXib8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fk5hHiHahhE5hXDzOFz65T4H0FavEStU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140178

The commit 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug
safe") refactored the EEH code such that the pci_rescan_remove_lock is
held at the beginning of eeh_handle_normal_event() and the
eeh_reset_device() is called with that lock being held. Looks like the
commit missed to remove the existing lock/unlock inside eeh_rmv_device()
which is no longer necessary. This is causing the eehd to hang on the
lock which it actually holds when that code path is taken.

[<0>] 0xc00000011c78f870
[<0>] __switch_to+0xfc/0x1a0
[<0>] pci_lock_rescan_remove+0x30/0x44
[<0>] eeh_rmv_device+0x290/0x2e0
[<0>] eeh_pe_dev_traverse+0x80/0x130
[<0>] eeh_reset_device+0xcc/0x23c
[<0>] eeh_handle_normal_event+0x830/0xa80
[<0>] eeh_event_handler+0xf8/0x190
[<0>] kthread+0x194/0x1b0
[<0>] start_kernel_thread+0x14/0x18

The issue is seen for cases where the errors are detected on the PHB
directly AND|OR for devices where the driver error_detected() returns
PCI_ERS_RESULT_NEED_RESET, and driver being not EEH sensitive(i.e no
error handlers like slot_reset(), resume() etc defined).

Fixes: 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug safe")
Cc: stable <stable@kernel.org>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 028f69158532..d64cce17a4e0 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -533,9 +533,7 @@ static void eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 		if (rmv_data)
 			list_add(&edev->rmv_entry, &rmv_data->removed_vf_list);
 	} else {
-		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(dev);
-		pci_unlock_rescan_remove();
 	}
 }
 



