Return-Path: <linuxppc-dev+bounces-18899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EF010BA430
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 06:31:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhrQV6QNQz3bgw;
	Fri, 27 Mar 2026 17:31:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774593106;
	cv=none; b=I38fPbH0st5ecptiTIoj/vXCotP32aaJDmbjhKME1CiL6eCsUZSStqJAZgFD/3tERU6U74a8usRUYcopYOuX3eTogqfAZteNVsPeEBSYYvn8WmJ4dke97wa0FPw39C4ogVnQAeB9ZUgy7kCwsm+4JQRVSIY+exLOqaMHkWJi78dG5S4zrEJpEUeGQZE4ib76b+BHtS/TRN5jbZQ+wEqbFJRyYFHQqHR15zrXCdwjzYk3bWVO+V+bxPWW/Pj8ZHTeVY6dXSSRO6s969jTzArFQqxj98Kg81vTb3z2Ru9lRaibDfHw5J3R9Dqpp1nkee9DQjB1+PqqNJ9ctMakzkzA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774593106; c=relaxed/relaxed;
	bh=Yq35+eY8ts+l+sLLEfl3dRavvWM5IuFVdVXwWzzT2d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URMgIZ+pn9YP9EBuIE+GLO6ofh5Cs0Mn1px6NaZSlMvsyQbsVwQT9utm0vw0kjFuiy7dAyVSY4xW8eK96x046Noo4m3/yUbcrXI3ZKkywJWyWofQCTqlEToY4O3mz/ULNGnmoqc9LZboiQtaq7Rul6cSF+CcQWucmPYGj8DUzRqKZezGa0JxxHBF9+DR65DCtjJevT+mCWMjhbenCSyrkp7+zXyFXtBlNCV0ab3ygtRANOaBEGJ9WzR8J/1COWGYuRlVGEcPxv0euU4ETz3O11dRu4TEv4bW6OKaLPUZJgGpSzt15RZJV1yhG7cWqerEToohOcG7XLYMeVa0DocpdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kVech+3C; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kVech+3C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhrQT53tkz309P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 17:31:45 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R2dvLS4083839;
	Fri, 27 Mar 2026 06:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Yq35+eY8ts+l+sLLEfl3dRavvWM5IuFVdVXwWzzT2
	d8=; b=kVech+3CMpOcVimw3+OTm17eUBepWTRfAYNUws9MYQAcMWab/eGvQlpHj
	yz1d+/0Xm3ZrdUw9KKTd/nZ808OqUiF/4SmEthbRbdDEWgJRjnKIFqUsz1i8ss4/
	iPU9Odlvy8fsNKf7cGZNFxt8Qd3PzZPSQvGCPcE3EqIdjTClMw9b83tK/Olo65KE
	67lArOqeuVCSEgCn5RaCs2iuumRrQuY2PxjP6MFyHZlefctw6LdCz0anlKEblX5P
	YwgDbQXoPX7aeCQEcN3dvMHs83LosJUONhsgLnuo4GutsK1PVIOG/XwQ318/vWBa
	rNWP+ev6MVfZEy478L26vLtKvlj9A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0fmf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 06:31:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R1jVmr004380;
	Fri, 27 Mar 2026 06:31:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2e2h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 06:31:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R6VYMF44630480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 06:31:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08FD20043;
	Fri, 27 Mar 2026 06:31:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 037152004B;
	Fri, 27 Mar 2026 06:31:33 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.223.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 06:31:32 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, chleroy@kernel.org
Subject: [PATCH 0/2] powerpc: A few misc cpumask refactors
Date: Fri, 27 Mar 2026 12:01:27 +0530
Message-ID: <20260327063129.127302-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA0NSBTYWx0ZWRfX7Mg+KSxmMr0p
 +I9Vid0W/3sjtkRZZQ2BdKyUN8vULYTVnS8ncgIOM/4FUuk/9gTvS5y9JtQyV5AFGnO52v2vkqT
 6qB2U9vZd9PpukE774YdwBkc345atzoOiiFyKoAA9sCh23BAvmz0Zf7Y4McMRAOet5T9snAOlfr
 mPh+mwzh+k1uHLQbs8L52NvlCUi17h5X5KBdPZfjZTEPySB+Xi+lQr0mZV+6/mXGaz6tradN6ew
 GTJAOVivpIGZb/+Wb+lFCFYzrCtsCNkFJQIWsd5i0pMiSwvrm7M9sig0MbxdF81y6n8X+PUtMPB
 HZYyR3hRoYDIEWP9OODjKwAvlVyAPRcVYILhOQauaONp60O4Fxp4i9CFTfmRI9pJdujyqr80v3h
 8w6drtesPiEPs8ZmkUb5CEW2mzunw6dNFLO8lkUkkuJfTcCQbdezoXjGlVFiJbb0u0g9MnBZq9U
 njyVPMSeX1+WQNvpB1g==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c6244b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=dqFMsSFrXTCGJFEeyBoA:9
X-Proofpoint-ORIG-GUID: STrPFMPpmXOdORy7-k-bxhLeHEKPY6dV
X-Proofpoint-GUID: k4l9_jSHFr7pEbOvtK7JAtyijcreubCA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270045

While going through the code, spotted these cpumask miscellaneous
changes. These are pure code refactors, they dont affect functionality
or performance. They just use the updated cpumask api and remove some
checks which are not necessary now.

Major one being:
cpu = cpumask_next(cpu, mask)
if (cpu >= nr_cpu_ids)
    cpu = cpumask_first(mask)
Above block can be replaced by cpu = cpumask_next_wrap(cpu, mask)


Note that exact same blocks are still present in:
arch/x86/kernel/tsc_sync.c
drivers/char/random.c
drivers/net/wireguard/queueing.h
drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
drivers/net/ethernet/sfc/siena/efx_channels.c
drivers/net/ethernet/sfc/efx_channels.c
kernel/rcu/rcutorture.c

Yury, Rasmus,
Do you think it makes sense to send for the above files too?

Shrikanth Hegde (2):
  powerpc: Use cpumask_next_wrap instead
  powerpc: Few misc cpumask code refactors

 arch/powerpc/kernel/irq.c             |  5 +----
 arch/powerpc/kernel/setup-common.c    |  7 ++-----
 arch/powerpc/mm/book3s64/hash_utils.c |  4 +---
 arch/powerpc/sysdev/xive/common.c     | 12 ++++--------
 4 files changed, 8 insertions(+), 20 deletions(-)

-- 
2.47.3


