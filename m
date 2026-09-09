Return-Path: <linuxppc-dev+bounces-26877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABF6C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:19:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrH44nK0z2yln;
	Wed, 09 Sep 2026 16:18:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934736;
	cv=none; b=YjH+7479dCI6q8jSYCOMYZvsxcd0h+6pakCmoFnr9PjBSB1u07d4CWgBtgDBf5Cphe7ADQS1VVcWj4Uj+QknvnYf09LPAzsoQZCOy6sTqtu+dzXKS4Wq56KdMeo4TT9FxEsAXLp+5ov81/37QcTQjBwO+z4QDJhabDqW3/qUI3Qu5hnDS7D+/imOaQ0gbkT3ioLeN3fia+0+5I4bLfE7yEHr7Mo+wCicp9Mb06DP3RGd+6wHFZHfrMLiqRk4Rj84mQcG+dJ0l7l/hu2ux/ICS/lUkTRbW2J8T+o1NdxmKbqkErvtR+y+pYfZyJNtfgPfhuMb/NDM64KOvWGcRvQl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934736; c=relaxed/relaxed;
	bh=KGrUX/EfvG++DiYSXBQxRin3fbRsj7oD86PbHMu9qfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGoSyLosRvNrnn0RUbBfnKhCQsX8iO47sGjhCkn8AneNKz5ReOrBUQTrRILlqr6EtztOLtEDKh3t5RQn2w1VixP8pXthV1xcesnxcQwgTPKMxxaELZJGbB2Vd1NfeUPTT55996Uae2hPteejrq8knGkhFb7lYrP6tJdby7zqSCQ+S9bOHYwGGnO5YKKqB5Uodzv6YLYMg7ofZl3kWW9L8kuUlxEOCMxB7mojTw5GtBSuLYq9KXexQTw6vJFpsnXea8E/54B5BkH8C87WgKD4/DOpe4GHQumg4vNSh1ms6BOK6GUHDnYnAbAF3jl84YuUhmnr/gGDX2hpwR60KOHrfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CNnQuTkh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CNnQuTkh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrH35DSwz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:18:55 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1gU12299337;
	Wed, 9 Sep 2026 06:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KGrUX/
	EfvG++DiYSXBQxRin3fbRsj7oD86PbHMu9qfI=; b=CNnQuTkhfkOLodxfL9W15+
	FkAJZJI02rngMaaaDXcDcA/zmWEk/46H6Y2aQLmzG8vh1SZvcs/KmSlqDBH/mIvk
	RiaseTtjYmjFfyVU0r1ofpA4PO3XZLmGwV9AFJ9vJ8svtO1wYLEm1tenUbvA1Yc2
	mFm655vFvdcakGaK3ONe5TQL+BNESRXqJnIaxvkE0DisL61biCcQ+TsZzb5hAD2A
	/+uw6yCLQE9v5oEFLHaaTVrYRkQfP8bHdNweq/36rtqW+7KrTM7vC+KRxKnaBVcS
	UNTklaq1Pf1aPt9LfDxcDsEiG888BOrbtRGRo4kgrA8bIDv8pjXu7G98FlonDGxw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf3q76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BEx6030561;
	Wed, 9 Sep 2026 06:18:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw8qxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896IYjt51446180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:18:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C2862004B;
	Wed,  9 Sep 2026 06:18:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C58020040;
	Wed,  9 Sep 2026 06:18:30 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:18:29 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: tpearson@raptorengineering.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, namcao@linutronix.de, tglx@kernel.org,
        yury.norov@gmail.com, tiwai@suse.de, wangruikang@iscas.ac.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: pci-ioda: Fix the stale irq chip reference
Date: Wed,  9 Sep 2026 11:48:28 +0530
Message-ID: <178893459268.174069.17928552132814435755.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178716225364.1437.6201568081502251835.stgit@linux.ibm.com>
References: <178716225364.1437.6201568081502251835.stgit@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4BLQBNsqlNIIsnnNY1E6-ufYupYO-m9a
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa0fa3d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=1JNkJZV6CAqgiA_SvoQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX8Jkd90pJMsB5
 fQZsTHdsgBwZkebqy3u4ROq8GYtZCftd21kXa3ZAyvOINTryF7zZADak4czpxUViXDvlXgMRfSz
 /fGoaDX8hjjwReRQwIRqvV56AAzBkNA=
X-Proofpoint-ORIG-GUID: -7tpTnOF4-RFJ1Pi1N_9lDqxj7PtzukJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX6z2JOjPGodyg
 l56JmaruZdfYZYH/jplxkvhBJZfaEEldXq+q0RwPht3XHm0SQ5xlYYQT+VUWHHR7xn9/EH5E5rA
 3UP3GS7jYUgZrlZG6qoMYWNR6UzgmDjo5ABhYTptV6DMG4+WthE81IL7FM2Tzi441OPzGFnPDVY
 3bG/3iTIXNMX/0vbc/RSpdZiGGdGKWGRbJA4/DoZA77fDJAD0EpxvvnuLAlstUArIelevVhOFEe
 vX4kfdgdHuZ+WM2/0ZIv0ZSsUDLmabBycf6BKXFlk0HPO4l8n6eSMjfkcUPMxfzURQzXFGp45t4
 90BLkwjMYEgwGm4+xFFQHBGAMBJWZR+B/lVuhQd6MWriP2E3vX2szx+Tkkl6LCYbsPkNtP/w32I
 5F9Icp6HUt042BYccRWsMMwbeWsWq1pBP3EV/dzI4y2ZIf10eSqqPe4aerI+3xUCotxGg8+cjG6
 ZKgttrircGxWwi85+xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Wed, 19 Aug 2026 17:58:22 +0000, Shivaprasad G Bhat wrote:
> The commit f0ac60e6e311 ("powerpc/powernv/pci: Switch to use
> msi_create_parent_irq_domain()") removed the legacy MSI irq chip
> pnv_pci_msi_irq_chip but left behind the static definition of it and
> its reference in is_pnv_opal_msi().
> 
> The KVM IRQ bypass for vfio devices is broken because the
> comparision in is_pnv_opal_msi() fails on the comparision with
> stale unused variable showing the below errors in dmesg.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: pci-ioda: Fix the stale irq chip reference
      https://git.kernel.org/powerpc/c/d96171d911e3b89ca2957c04264019cf2f96287b

cheers

