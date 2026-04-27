Return-Path: <linuxppc-dev+bounces-20139-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887FCFF885D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 03:02:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3pJT0lGKz2yRn;
	Mon, 27 Apr 2026 13:02:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777258937;
	cv=none; b=mNBTHnLPubQ8FTtlDr1B/ILmbaYHEBU1lP/BiK22SwiywZvX/oDv0TqhONkCDONae2wXMDs7TIb0XSQNzOLbCnaK0Ls5L+Y1rbwl4tg9onNI87MQP14j96QkjllQLDzbREC3yL39sLVPGSeXU+oZCdxUQ4xz+TNS31Ylp0Szrq8rTyjJypLfCGCq9ntoCYQBAL+h24qB6dBnwH4nhc9Y/ueQachsvwdvTMBfzxPF6+c9EJ2qpENUkSpcS5gzOOKEK4eoxu5OwZqEOU4/VW9tlkZKCiwsjXSN1RiaenCZBEsadB8eDAINTpIj9mZQVsiES7zhtICKO8Bb4R0H0GmwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777258937; c=relaxed/relaxed;
	bh=DMn+gZXWmXLH4JqMvtV0lEi5AqUJF7G4JjlGl3OPnks=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=HZqT8GwgjPDdn6+7lnArzlLZb4XiqIxpa43ZlVoJ4d6QhKOeNKco2V+Iz66vQGPagW59eOR23Dy9a3d2PToatzrUNFnPVsmrpVx4I09B0IRUAWSo8eyEB9veXzFrju98QXkjR1PX4/fMnIAbaZ48vvq7NfRHSHw5lGvkwwNW2neUi/WNT4SHe2duEvtjEqWPuPi2p6KlUiPSWc6DAr/YCbD5kQuQD2vrefdAt30O0b+e0+tkO/PEoY820eN3FZ8+TzSBVpnXAWCEPLct+Sgo6ybVTVkKRtXKSSsm5QTpk7qjYwavKCyDpAcr5LTthgaEOvwBzhFiYDfuf/G13YBKgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hJfHYcv4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hJfHYcv4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3pJS2Vkpz2yGX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 13:02:15 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QMTsXt2902222;
	Mon, 27 Apr 2026 03:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=DMn+gZXWmXLH4JqMvtV0lEi5AqUJ
	F7G4JjlGl3OPnks=; b=hJfHYcv4xguSqNFrpjv1zlRwcyHfBbgO1VKQlLJtGs8A
	z0S7VyxVssDVjNikrBe/ATSAuLjv9hJRcRoBWYjrwLa4Shaq+MAjUWI/4+FAZL+5
	TaeNHpYmJNgSqCG50lHlVZW2sRq8fQ11EqLGeMwob8Lov4OsfbIIn1IEHMwVfK9Y
	D9n9eBTbt8E/7kooQPgxsnWYJ7lU4Yb/N9rKrFi6mYVXF3eL/RMwX8829sTuyUeC
	tu1RexKJtVeNtgunF8MONa5QM703bywVCuzFEY4SFtme0epq5DzxItitDXFJQpyj
	x7C5fvtktEsJb169EngbLZljqWOHtfD3DXTVr778EA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9qxct6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 03:01:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R2rsnx024493;
	Mon, 27 Apr 2026 03:01:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq3jrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 03:01:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R31tTU28901648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 03:01:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CA292004B;
	Mon, 27 Apr 2026 03:01:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17DE32004D;
	Mon, 27 Apr 2026 03:01:54 +0000 (GMT)
Received: from [10.88.0.2] (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 03:01:53 +0000 (GMT)
Subject: [PATCH] powerpc/eeh: Fix recursive locking on devices without EEH
 sensitive driver
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        sbhat@linux.ibm.com, linux-kernel@vger.kernel.org
Date: Mon, 27 Apr 2026 03:00:53 +0000
Message-ID: <177725885065.13410.12259326756082237538.stgit@linux.ibm.com>
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
X-Proofpoint-GUID: NP-4EskW2pb4RhFnZ4rgQLPJIWXVtrX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAyNyBTYWx0ZWRfX3oLdDjD/E6Sr
 mdgqXDC+PVR64dpAAU3doIa2Fgvtwty7jgZBar8tI1/0/oNi/sKPzYEavMurqP2c4gvr5tA9nWW
 oyWLnXObQuN+0vd+Vk6My33lWU8Nf0BYTacUokLljJQItWVbiL/6ukWuTRlctAvHC6aNa7nxYx/
 MuUTjHN04vB9pJtTovkbi1bG/SYq+fOf5+NqkJZOGK+4Ke5VpSHhW4oLnQsCB3dl3zYvjojIm9R
 4rYEfavI/KB6vzNhNARTg50iIWszqhlcZ9v3smg+57TzuKdogU2V1vJAnMu87Pc6LfxCE5W1fNI
 ljzGSJuK7F385cA3Q2iwfK9xDTdoLPLokzV3+ThDKh28ts9JTE52kv+Lu2aH1GVzYtVrlVD0bZ1
 3vRvZZN6VVf08MgN2UFKWKvXfxPFaW8VMwYoydvK839PYHV3ouxTfdMR0l+9M9hp/JYabNO9/SO
 eCL8Y2jATiTOUf3JhJQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69eed1a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=79fxzGWUOgRnezMXib8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iVBTbM44bw_s-KDOIymOhC6VUeUZ7MO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270027

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
 



