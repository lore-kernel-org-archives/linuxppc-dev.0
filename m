Return-Path: <linuxppc-dev+bounces-27166-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993E8C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:10:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhgxs4xyRz2y2Q;
	Sat, 12 Sep 2026 16:10:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789193425;
	cv=none; b=QizkrCVwt776YJSZ2yHEnaydXYaNV7D762TiC6wNLWvouuHGoq9aSfiXmROR0E4j8Qilfik0iXSETS2yJytibaJja/v2BtFK3RQlPcbSuNW4TCs/GYlGCrtrTlgbpgmbFedEHhrEAiC5PIs9MR6E3PbQhCXomsycuX/+nZYZZaxPzyMoI02u/HEIbCOuuD/yie7/eljnwXlU0nBisaWMb6igP/pQMP/Y/r+YQU8PiRj6/qywDWnedu+9Z6LX2I69cBP4qmkbamLQ4HqW2HmfaaCfvlSquRUeb1ig/Ucsh752IpvmWb3VuPSy0ACEL6kmINtQWgTSVUipUnxZl4QCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789193425; c=relaxed/relaxed;
	bh=ziKGmp+RFUsicvsMPTlaSxO33SZAFbOcB4DvM6PmbSI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LSnSvrCfJPA274Cd4F007SCph/x+UYLIbYQVi74N0jxfeHWTiojfR7MjVwsfPsKMUsEP+Xr2SFcSKnrLS7KrVMccm/UsfAvQ8pzJH7/r1iSfPGfr8JLK9yT9BGXTnsLn/PcWSWNu5jPv7+BINLjgT/FxMMWypS9DYZiaqWvncUaXWdfu8oxTwTp6lTGcz4rirInFRhS7oIypM2OZv3dvmVAzmlKdoXJ/A2/hasHDsdbAEtH7nM0ZqJ4mWSCAz2LMvvjnVKDC9ojPjcnlNz+qQ6NJgAjkh36q53kE+K2Dnau3EVcGvTNK/7cSm6uhZ7Qc1dzBb1likDVrn3q5IrzF+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gpTNoZ8A; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gpTNoZ8A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhgxr5gwLz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 16:10:24 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C4WFMs2610556;
	Sat, 12 Sep 2026 06:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ziKGmp+RFUsicvsMPTlaSxO33SZA
	FbOcB4DvM6PmbSI=; b=gpTNoZ8AiT5NBuGZPbKYfirLtn+Tz83eLnQjYbfn8cL2
	b1J4pT1e+sqNds7FQqDqDUu/Vhzkk+NmDhmgSQKGseQNkCszNhJRrA6AXDmSM19R
	4jKZtrYpHDQbi7Q5gt89bXkiwGPm0IZyUZC1090hlMYoBjHM5+a2l/bn6YgTmhg2
	5sxhkKVP1QEd8eFkxoU/HuZ0+6pzxgQ8d8F1o0HWMEPm+cM+qkpW5QnyIft5Yrr/
	gJ9fnjW9X2nEI8kVEvK/rI2xx1MKyXOob5oehwppXH1wiYTErMRgBAqYCugaREWd
	1oPSpDC5HSTutAThcoDi44rlmnjqbtm8P4uxNFBGKg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5dgm6y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 06:09:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68C4Z1D92798777;
	Sat, 12 Sep 2026 06:09:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq3271p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 06:09:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68C69l0G8717044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Sep 2026 06:09:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C27858059;
	Sat, 12 Sep 2026 06:09:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E201058058;
	Sat, 12 Sep 2026 06:09:40 +0000 (GMT)
Received: from [9.43.99.206] (unknown [9.43.99.206])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Sep 2026 06:09:40 +0000 (GMT)
Message-ID: <96c01d5a-3000-4921-9775-025f9c4c2908@linux.ibm.com>
Date: Sat, 12 Sep 2026 11:40:34 +0530
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
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aboorvad@linux.ibm.com, atrajeev@linux.ibm.com, chentao@kylinos.cn,
        christophe.leroy@csgroup.eu, leixiang@kylinos.cn,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        michail.tatas@gmail.com, mpe@ellerman.id.au, naveen@kernel.org,
        npiggin@gmail.com, sourabhjain@linux.ibm.com,
        thibault.ferrante@canonical.com, yanlonglong@kylinos.cn
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.3-3 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDA4NCBTYWx0ZWRfXzW3spdA9BY0W
 dyLedNY1iNYGeKvH19Or7s0Hkcguw8taTetNFCjlLD2d8mm2nRVbBGdtwiV/b3OzigyS75ov+IX
 7Lhkb4FqqS+Wwkgk1RwTugbdjRsIgjB6d8zaTdrzp6eATmeqLPfM36L6s0mvD4+J8t/MA4+FVjP
 O2KoiOdhPYZh86fBbwgIwuoqQCbZYduYsnZdOqlq7X4mbvNy5qr/eRnhQHh/A13GdyUFkrQp33b
 KobgQ6nPgkto4ek8zU7UtpO8xGs1jzpnZji9wNz04y+pBMs5swQX+nDy2yf06/pxJGWf2FWFswH
 nq5YL7Xs6ssVVmY4ZTYrXJTAHHwfyejh6dyBakXjgzPw3J7myb/dNaCKeItbFQQBPBxGOvNVJqe
 Zr3RQze9Gp5lHu7ESQ4+Yb8vXFRioM9QDCZQ+GI0sHFtllOUcMhzPUlFF2KpeMSpGV1O/kuyXfp
 pwQvg3IL3Ndm8rYnQ+A==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa4ecae cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=7XlsL3zjmXWDbTe4z3YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NM9Dz2-3_I1bwV-RzUFxvFYZ8W7zlk_L
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDA4NCBTYWx0ZWRfX6OIrsDPsi2IR
 WyfteM055/C+ucdnf6DQQqE13G/CI2RJ2OrLyCGZckiRW1XtBsBWEQ8DWKaF55PM4Ob1FF5F/O+
 XyiMpdcBQiSSKNhpNA/Cri/6q+buopU=
X-Proofpoint-GUID: g48dzVaMicoswZFKScOq5qfZtgAmhIAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_02,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120084

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull some more powerpc fixes for 7.3:

The following changes since commit 45a5f7285f835adb3b74c9344c09a7bd2c4fb664:

   MAINTAINERS: powerpc: Add Ritesh and Shrikanth (2026-09-07 12:15:39 
+0530)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.3-3

for you to fetch changes up to 9e5c53d75c560a058abef0e4338c5e3e52cb432a:

   powerpc/pasemi: Add a null pointer check to the pas_setup_mce_regs 
(2026-09-10 13:19:25 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.3 #3

  - powerpc/entry: Fix double accounting of user time on interrupt entry

  - Fix leak in htmdump_init_debugfs

  - KVM: PPC: Book3S HV: Set irqfd->producer only on success

  - powerpc/kexec_file: print configured kernel command line

  - Remove redundant early_init_dt_scan_root() call

  - misc fixes and cleanup

Thanks to: Aboorva Devarajan, Amit Machhiwal, Athira Rajeev, Christophe 
Leroy,
Christophe Leroy (CS GROUP), Kunwu Chan, leixiang, longlong yan, Michail 
Tatas,
Mukesh Kumar Chaurasiya (IBM), Ritesh Harjani (IBM), Shivang Upadhyay, 
Sourabh
Jain, Thibault Ferrante, Vaibhav Jain, Venkat Rao Bagalkote

- ------------------------------------------------------------------
Aboorva Devarajan (1):
       powerpc/entry: Fix double accounting of user time on interrupt entry

Athira Rajeev (1):
       selftests/powerpc/pmu/ebb: fix lost_exception_test hang with 
sched yield change

Kunwu Chan (1):
       powerpc/pasemi: Add a null pointer check to the pas_setup_mce_regs

Michail Tatas (1):
       powerpc/pseries/htmdump: Fix leak in htmdump_init_debugfs

Sourabh Jain (2):
       powerpc/kexec_file: print configured kernel command line
       powerpc/prom: Remove redundant early_init_dt_scan_root() call

Thibault Ferrante (1):
       selftests/powerpc/tm: Fix tcheck() reading uninitialised CR value

leixiang (1):
       KVM: PPC: Book3S HV: Set irqfd->producer only on success

longlong yan (1):
       selftests/powerpc: use MAP_FAILED instead of (void *)-1 in 
tm-signal-context-force-tm


  arch/powerpc/include/asm/entry-common.h  |  2 --
  arch/powerpc/kernel/prom.c |  1 -
  arch/powerpc/kexec/elf_64.c  |  2 ++
  arch/powerpc/kvm/book3s_hv.c |  4 ++--
  arch/powerpc/platforms/pasemi/setup.c  |  2 ++
  arch/powerpc/platforms/pseries/htmdump.c                        | 19 
+++++++++++++++----
  tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c   | 11 
+++++++++--
  tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c |  4 ++--
  tools/testing/selftests/powerpc/tm/tm.h  |  8 ++++++--
  9 files changed, 38 insertions(+), 15 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmqk7GoACgkQpnEsdPSH
ZJRbIg//atmDlXDJC8LJkszixDmqHro670bFgH/bubPKghqCYJNVc3wHKfzki0zq
M3UKtrHwV3al24Ed5w65Nz1PZcp4dvqcpr9axFqKfv62cwemM1Bn0xT5aniH8hyO
Xg+vH8guDYO+tV+eAvtKpR9K2wtsR8cTbGjbvgD4/yI72Ic9VJJb+OtJ+VmlZMaU
w9uqr9qihNl/+tLKL1WCtJ4vm5IePs4tc4jOzPcrijLlAnoKEA3oaD1pPtYNYWHf
WD3Tp1h5URI3YKW3Z22vrp0TKKa39aFqcMR4ynZJw8KmvvvYn1Yf2VmJFyEpNLH+
Wp2UuLaEHp8zvJygS9zzFGXWNLvGd56yW+NcWc4Jjkh8Gq38lilEWnR3BiKEIIif
sSNxA2+gvO9/3wzzEE6H2nQembZOpTOZixo7VDdI6uy4HmRrAz8hOSV7Y000/Nqt
7IH8Lf8zmpt0KK65PIWQ8Mn56IoB7nT6nEjbJCJCGnOefEJDl7jnJlFlrTp3R/t6
HSoErU2gqnVkCUFZ320N4ERrkKy3iWvSzJUXoDu77La1cSOA6aWhAWJMVq/TCpi1
TvVfdbSV2VIRIeswVlF7otPo3pJtkEQ27UNHvZNBWrGZit2VPCHY1m3RbfkdW2TJ
g+N0d4EupA94VIxcyK5dULBqodJ4bp8AwzI9uHLorI8Tjq8Uhsw=
=emPV
-----END PGP SIGNATURE-----

