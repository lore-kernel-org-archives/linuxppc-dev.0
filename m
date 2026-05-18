Return-Path: <linuxppc-dev+bounces-21027-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808DECD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:09:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJm7H18D3z2xRw;
	Mon, 18 May 2026 15:09:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779080955;
	cv=none; b=EWnJ+MN7/4rNhDBIfRO0iksLM4ILZwO4SWCULRuo+rsD8HLYxOuogpVQDKCIhpM566vOzWeBwq+di6imN+kKbajRWzyX9BBQB2PMLt5OI1bvV0KgeAj/WhRHlzi0ZNzFk4ggFTWSk7P1kohRFkgGNk122KoFxUdW/UMIOTzAwn467pVK8URxPhY1GqczgHgtFnt/0hUqZeskIwywa0s/0u2BA5CT9HldPPmAtTOGGXbUYUTnWooa7fapGnjdk7kfg1uHm9Fu8+enAhorshRZpjnpS11pK2Fq7si7rTpfmsh3zmvm09Zvq6Z3S0daVX8pnnCvXULVds2Qlj3Z84NraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779080955; c=relaxed/relaxed;
	bh=Sd8dOuJfWsMTSbzmKhuDPVs7Mnw/R8SLDpSOTbaZxuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMmGbwmAh6AHIS4uW5kbjBFvQtFq3fwjUwwzEPOln+iW0ZtG/MA+0GhNvO4gPeSiVmtab7cbCWbY3TwxLwjh/UaES7ID9snA10oPd2uIAXzxRvrQNCL3qgwDZGGd3OHDHGWsnXwUFFM0CKtm9f0ddiHQaEhqJXHklb3OB52z01YjMmsET5Ovf47KYFhLCWnN3hVUjqUfnzqYf6f3/psVTBZ9ahyM4OMTxs4L091w/K/fLw3FcbluYfsuN4+D+izHKwp9Nr+IBa+1lMyS8E9Cg3784BhZv9O2IkC+TKzAJXIc4FoOLsSm2HeIGsHeMwHrAdN8UGM4GT1q7kyJvD67GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YYWo0WDa; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YYWo0WDa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJm7G2BP7z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:09:14 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H8j4ig620482;
	Mon, 18 May 2026 05:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Sd8dOuJfWsMTSbzmKhuDPVs7Mnw/R8SLDpSOTbaZx
	uM=; b=YYWo0WDaTxzW3Ta6kQc2TmUshwje4wS0jMXy+Bw/njJh9nzlC7lQ10Xqo
	5nEi7CGvgsMWcjg1qAL/SXOZo8n1N+0D3CvZe6j+K+68k2y/FbvnEL9ysRnViBtK
	cIN5ys0KfSEWDJPP4pJ2K+Pa5VQP9Nv+zyW/TZhsZAXIMuoDeGcUKewqYz9qtegv
	kUtphU23Ylpxyfa+iql+VwNmddmVTKPx18FHWSprkoxngQklzhRaQXCmSOTK+lIY
	Wefd8CmuoWMfYxzXhEtT0xGya+WMdRAimiX9WVkBI0Ygwn/5ZqXBQ22p28c+dLDw
	0b7a8ROe1F7w6pY73nH1Q0JLFuPgw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h885umk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:09:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I595e4020178;
	Mon, 18 May 2026 05:09:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vmc4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:09:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I5921d46137600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:09:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00B0F2004B;
	Mon, 18 May 2026 05:09:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD19820049;
	Mon, 18 May 2026 05:08:56 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.124.214.53])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:08:56 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 0/3] powerpc: fix preempt_count imbalances in perf and kexec paths
Date: Mon, 18 May 2026 10:38:52 +0530
Message-ID: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-ORIG-GUID: BKRp9xprexdhaYIaI9sIJV6w_gdlKsBr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA0NiBTYWx0ZWRfX9DY1nPBL0CBr
 We5C0hjK71u9A1sU/E6AMYz6e0Izifk6EC2s6+527g+RQZPQ3ZnnfOinn9OyTkmVoYI/5PpkEPw
 FSFJEFRx4SRlKwWjh7MnvLizT2ztSlpeY9SPBG7EUJvve1fKElON3UNZ/WVtLkXTsDwmYEQwXK9
 I0hT7ga3wKNjRklJF21/oDY6WO/G2e+eVe0NQREJuApcuqoKTzoswQDbiNCZaXHn1sKAk/JfIY/
 j7GPgYQzvjYduAyE2WCCjvKfpMjByq0C3UGI87uPAyhJ0sEnJQ5cos89Nme1q2FoCACGUqMGXNj
 3dBDxEHeZ9SRVkjUyEGVku+KhaDDRWzNXjuQm9QW64P0eKfxVhc9ZOEvPE5/pGO2B3FacR+GDEQ
 LmxCgny1argGUQVkOBBPOLDW/5eQiFHubPZEnZAgnlSxqqy85zRu4GCs4pVlZ1Qg4u48kYfwi+/
 Os2+0bNUcructJeJn/w==
X-Proofpoint-GUID: 39FXVvMyiDiZO3dnkaexYoHMuQ_w10ei
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0a9ef2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=i9BbGgCnHC-T_McXfeMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180046

Hi all,

This patch series fixes some minor preempt_count bookkeeping issues in
arch/powerpc/ found during a preemption leak audit prompted by the
lazy/full preemption model changes. These are get_cpu/put_cpu and
get_cpu_var/put_cpu_var pairing errors that leave preempt_count
incorrectly elevated or underflowed.

Please let me know your comments.

Thanks,
Aboorva

Aboorva Devarajan (3):
  powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
  powerpc/powernv: fix preempt count leak in
    pnv_kexec_wait_secondaries_down
  powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus

 arch/powerpc/kexec/core_64.c           | 15 ++++++++-------
 arch/powerpc/perf/core-fsl-emb.c       |  3 ++-
 arch/powerpc/platforms/powernv/setup.c |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.54.0


