Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A43606A332
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qGKS1ask
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXynC2F7hz2xyj;
	Mon, 23 Nov 2026 18:51:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420287;
	cv=none; b=S9uBPGyyJyY1JR9HooKmGYSteHTzoyn/j5IZGJxsNQbhE1PQOPLXenUFv3LglgRU2Hh02iGn9zXIUS4TyMcDKoh/QkXB6Tzpqns+Gui3rxU1uao3Gy+k7YZ5A8FoFHR0Xu9nvRvwRkLHx5y+e3nQ1vDXrVG5YCCR1zQw9EUeYOLL2xOr1bML6JsDJ9QtF7EaudV7ndSlRb7SJ6yDfgveG2/8SMY+ev5+1mZ+OFqFQRZwQJKCsGxyAHXo2QBJiMXpTGx2+BlqAFw++j105U9H6VqCISM9s1wHPyXsBM+MVUVowOFMiwn3aS7e9IVhQM0u9MkNZRcxYN2+H58P2liOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420287; c=relaxed/relaxed;
	bh=NnmWGe9a+E123Mgyj097ItDVybjMM+ktVdi/Zst0ynI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nS19AEL9L6c149r2+ntj5/w23XTYUESRtAdjljDCQxDXPCy+/zzCtkT6Qqx4YikF5CLRS7VWg74EvTaosnVbquJO0eBDedNLSBRH3T+/CTvZMkz2Rd3rZd0F7UoiaXP0dwvkR61zyZyLQr/zODEFPsX6/GoGjts9VnTY+x+YYjST5ICOHbHuvAoLg1/g0JdvFLNCYPhZiGHdspx4DmTVZkPEHtbJxIrFGZNdxE0SM4fRUdXtDGj2HNz8goYUga0pi9lWtP7DRD3dMSuYfnlIfNDXRVIOfTRtKzE7ehXF/EqaOx9wRqXN2pNynwORAhh2DMcRiDJTck0Q4yPh3qKulQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qGKS1ask; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qGKS1ask;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXynB3MxXz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:51:26 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54b1v981894;
	Mon, 23 Nov 2026 07:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NnmWGe9a+E123Mgyj097ItDVybjMM+ktVdi/Zst0y
	nI=; b=qGKS1askR+/DF9BSqtkSa8nJzCtQfb29NK4ZN+EcV3sStctgJ55JyZWnV
	oHL8Lsid4x0zB3bArx/fgiqhGST3mlXJcmAyD6tOiZhRffexI04V/nXgI5GwjtXv
	+XkUwcNTL3cgWYJK9ujEnGwtrVoycdeb840xrkheTBY/0sIs6u53xUdxLewT/SpI
	QONT1PEKTWlucN6pcKPNLc+y1sApBEZzp1iQFDVbGHLqEt4wFLa2QYvLt6P8/+Y1
	J0PFlgrWKMmz9JvDJ6+PE7UHB746+Bf1p+VnjUfPtVRy3D6s93Zhqb0OR+w5/hdo
	QzZRIZdilwVtijINRK193ZQ0Q9fBA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3238q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54KZ92487377;
	Mon, 23 Nov 2026 07:51:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h5rgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7pAJO28705500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:51:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58C1D58056;
	Mon, 23 Nov 2026 07:51:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC80E5803F;
	Mon, 23 Nov 2026 07:51:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:51:07 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        horms@kernel.org, davemarq@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v2 0/2] ibmveth: two TX and reset fixes
Date: Sun, 22 Nov 2026 23:51:00 -0800
Message-Id: <20261123075102.2962-1-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b03f071 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3XeKXeJX3U8D6EKEFAIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX9J7kNQzwMnBB
 EtSoahheacZYsjuvifjbQ3xZMUSEH/gdhMWaQuU7TeKfHU2HMct4nislDcTtktuRRadB/V4/gWn
 B8CVhKirZj+kNulIawIb+omKjYJp6O4=
X-Proofpoint-ORIG-GUID: wjIrpWgzdPXzkBLwgNyrExVsaxPWTxI4
X-Proofpoint-GUID: OTiLYXGmYa-CDWct8J9vd4aHwFqpStx5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfXxiE+GV+LvtNJ
 mv0ZtR53z8R0jTuwomK2CYqwKnhAPELL7dvV3Vez+FSiZVVQq0WavPPQymXdXP9hjv1G7wusaff
 68vAT/Xdyl9hRXiC0G7S7ViRHbl4dasea92iLfTg8INJsemUHvvLK1VNPswYc0Kg18b9gIIn61d
 +eH1z0Qcjxi2xLfbLDz79uP2o7+CMDebZ56CreF+o3RVhf0fc6NxXTYpo68/96XPPqu8up30BWe
 trqH+1bUjZaJCEd7kZFgLr3jVoTc8AZ+RFnJj154PYvWjd47BLz/FBfV1GOttq3EIFsnSm9xtP4
 I9+CAHOvKxxV7JL5GxzhhPUEvJLfI6ZZhDbr70EUAUMiFdDIXWh2i6rp+rfHK4r7tlGcOc+ngKX
 /b4nQsGolrxwxXk3g3lPY1Qr3G14sbLAwU9gypSmNZn6MD3CezyPTiCS4KEcEYfpU1qKb3SMGxH
 Ng+7TwfgthmBqg5qiLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230030
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two independent bugs in ibmveth that exist on today's kernels.

  1. After ethtool -L shrinks the TX queues, a sender that already
     picked a removed queue (AF_PACKET PACKET_QDISC_BYPASS, pktgen)
     can memcpy into a NULL long-term buffer. Drop that packet, and
     stop TX with netif_tx_disable() so a sender already in xmit is
     done before ethtool -L allocates or frees a buffer.

  2. ibmveth_reset() closes and reopens the device without checking
     whether the admin already set it down, and can bring it back up.
     Skip the reopen if the device is not running.

Both came up during review of the v8 multi-queue series [1]: patch 1
on v8 06/15, patch 2 while splitting that series. Neither was
reproduced; the fixes are based on analysis of the code paths, and
each commit message says so. They carry Fixes: tags, but the
triggers are narrow and the second multi-queue series builds on them,
so please take them through net-next. The first multi-queue series,
posted separately, does not depend on them.

Tested: on a PowerVM LPAR: ethtool -L TX shrink under traffic,
ifdown/up under iperf3, and a queued reset while the admin has set
the device down. v2 on QEMU pseries only: TX shrink and restore under
UDP traffic, MTU change, open/close churn.

Changes in v2:
- 1/2: wake the TX queues under netif_tx_lock_bh(), and map a new
  long-term buffer before publishing its pointer (Sashiko)
- 2/2: say the bug was found during review and was not reproduced

v1: https://lore.kernel.org/netdev/20261119000235.15622-1-mmc@linux.ibm.com/

[1] https://lore.kernel.org/netdev/20261109235556.60604-1-mmc@linux.ibm.com/

