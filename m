Return-Path: <linuxppc-dev+bounces-24336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18318C44507
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 05:01:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1d6r4P1mz2yVZ;
	Fri, 17 Jul 2026 15:01:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784264500;
	cv=none; b=TZPLImhhiseOQgAg9L9xzE+q1yfVWTCL22BgYaX3uCn0mSmK9jCpHE9MKJqKZCAp0Ti/JHBK0vVV6+YFQDtDYTddUlZWFlwFQqRMr4XjDYTT2S6ra9NtAf2xbTtK2YchLDh8r6lmxSxn5+L8/3LKm1tiI9qW5OVjKEbpdxyna9uUQ3yvDV8IURl5KkSBPEoRb5PK0HlyfVtRzxRmDvPlKN+aQ9SZiJIAD/FPpfnk7/4GvxNZ20ACEPSaYPpwsAUw038F+/DvIiqroonJf1xVs/MXpWopmpFaXcTMTqIOs/JYaG2Yq/RRcB641GUO23IEQ8vkd7Bzv+7dyLQzN19DCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784264500; c=relaxed/relaxed;
	bh=a9nmP7xHV/gBYAWcRrKoIbTgi5ikv7j0T88HU4xdd5Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QoETl69Pozjn8MumkspdON3X7JPW8uEVMHxAj6PXuFcfI5HJGgqoTs3CHQ2pS8Xd61vKRssZARN7PTXRUAhB3Pflu9lqD4U983+eHAl5snVx5j0V33Wpg/M7X5B438EjF11tp2OJeDBz3dXG9oU2BFoAmkdrSOvkaduqpKnlkPOtxj9URLR+EiDauOzo4qmTXLiaH1VzSnV334z+LPJYdEgTQktbzlH+hgiTIL6s3uuRAA7pdbC6O8JVm9BnHllvLjROss9aJVC1zVuxVT0gWejMpr43WY7LajlXtKKF6PhLq+zCJq7PHTzelJJTxi45jJe+4GYH5KcjpIhFZxWyfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cQTN3+Gc; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cQTN3+Gc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1d6q4KR7z2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 15:01:38 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H3DCbX867984;
	Fri, 17 Jul 2026 05:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=a9nmP7xHV/gBYAWcRrKoIbTgi5ik
	v7j0T88HU4xdd5Y=; b=cQTN3+GcDhVnEfF5YAzg7RyORh/Pox/bk4mdwwXP9KYh
	6BUBtqiiOHxJ+tJjCuy8IHni4xn1qcS+/oGCXj4Pc9cXNeeSnXgQjsg2KTGM64nS
	nkTAT/3CeH3XRqzDq8XtqUm8XmsiI5oNykM4a2HdaF0KS2VNqCMir2/5xU/Xcp3I
	zVOTpZXqxbdTdiZFd94BRQxiM8uBWPy2STXjGZwBDwl25hGb6GXHAxM/wrGjKPxb
	tTPUitTrsepGs0MZxv3Iww/alTdKf4ElHcW8YJ3unCoNXct/zTvN93iHUICnNqUc
	ztTpL1HKbu5lMHhb+5Z+OPVK57vqHUbJVucqpDDwRQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxvps6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 05:01:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H4nhtA018212;
	Fri, 17 Jul 2026 05:01:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhr4js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 05:01:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H51JsW47120730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 05:01:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 477B15805F;
	Fri, 17 Jul 2026 05:01:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 747C258043;
	Fri, 17 Jul 2026 05:01:14 +0000 (GMT)
Received: from [9.123.5.176] (unknown [9.123.5.176])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 05:01:14 +0000 (GMT)
Message-ID: <65137690-360f-424a-b2f2-b62d5f40ee31@linux.ibm.com>
Date: Fri, 17 Jul 2026 10:31:13 +0530
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
Cc: amachhiw@linux.ibm.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
        enelsonmoore@gmail.com, gautam@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        moonafterrain@outlook.com, mpe@ellerman.id.au, naveen@kernel.org,
        npiggin@gmail.com, rosenp@gmail.com, sshegde@linux.ibm.com,
        thorsten.blum@linux.dev
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.2-2 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: TJzh6JKDcCte0otaIhCDb3jG4feIxzGW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA0MyBTYWx0ZWRfX5axkZZfdTou1
 sObE/r7++RVI3UW9/CGeNqKMGVmvsjMy9jvwy/EyEmzQnPE8AShDjqreZ4D4kxxs0vDrgRNUe0s
 7597IEQRcVHs8Z/O1R9L2slkhse3eu8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA0MyBTYWx0ZWRfX6ufKrsXAm+qb
 Z/XSJlpMwQZh27CNNPK6y2KggP/xckvOAbkX59UkOWWdsAg69MWqNJ5J2UEW5V/cpXV62K63qjM
 jUFk6UDLKwtqNBcfrxtkkt31kggJfry0LqNSNUo/fRPstzIIoa1y75vkQ6SHf7ecak5YX5Seq8V
 oi0KhjSMW0e/7KrtbkPZlzTxQ1M1RPCJdEdmF69wUORUxOvw6EUXAgox2gZbA2ElsrVesTgwBSK
 oRdX0Wylf67Xaol8L61eBRSsLVj8Ys04jPnhHbddHDstBL4nC9opEv9ntDp+TftxTESQMGn84IM
 jktmtipxiNrk0gqoDn09Lnx6OGXgrGrFl7xiPQ18NYUDjjf77Q7EejmD/RPcgI7/IzFz82hgf36
 iz3VuWYmP+fe150vjvGBoM01WGAVsT2c6IEByNrquoGl1ivzYmdYPXr/3f25fo/CrqnDnV/G/eV
 JOF4+EMzX1Kx5E5W8CA==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a59b722 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=NEGiq5IG6P-IW5DpamsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: q-LaZzy4D3IxRsN-Uk4Yu9JMMr9sYZIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170043

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull powerpc fixes for 7.2:

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

   Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.2-2

for you to fetch changes up to a2c02aa0c6ca3ec9fab6f1c99912a440c7b8bfdb:

   powerpc: Remove dead non-preemption code (2026-07-15 08:04:13 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.2 #2

  - Enable CONFIG_VPA_PMU to be used with KVM

  - Initialize starttime at boot for native accounting

  - Set CPU_FTR_P11_PVR for Power11 and later processors

  - fix memory leak on krealloc failure in papr_init

  - Misc fixes and cleanups

Thanks to:
Amit Machhiwal, Christophe Leroy (CS GROUP), Ethan Nelson-Moore, Gautam
Menghani, Harsh Prateek Bora, Junrui Luo, Mukesh Kumar Chaurasiya (IBM), 
Ritesh
Harjani (IBM), Rosen Penev, Shrikanth Hegde, Thorsten Blum, Yuhao Jiang

- ------------------------------------------------------------------
Amit Machhiwal (1):
       powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and later 
processors

Christophe Leroy (CS GROUP) (1):
       powerpc: Remove dead non-preemption code

Ethan Nelson-Moore (1):
       powerpc/uaccess: correct check for CONFIG_PPC_E500 in 
mask_user_address()

Gautam Menghani (1):
       powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM

Junrui Luo (1):
       powerpc/spufs: fix out-of-bounds access in spufs_mem_mmap_access()

Rosen Penev (1):
       powerpc/85xx: Add fsl,ifc to common device ids

Shrikanth Hegde (1):
       powerpc/vtime: Initialize starttime at boot for native accounting

Thorsten Blum (1):
       powerpc/pseries: fix memory leak on krealloc failure in papr_init


  arch/powerpc/include/asm/preempt.h                        | 16 
----------------
  arch/powerpc/include/asm/uaccess.h                        |  2 +-
  arch/powerpc/kernel/dt_cpu_ftrs.c                         |  9 +++++++++
  arch/powerpc/kernel/time.c                                |  4 +++-
  arch/powerpc/lib/vmx-helper.c                             |  2 +-
  arch/powerpc/platforms/85xx/common.c                      |  2 ++
  arch/powerpc/platforms/cell/spufs/file.c                  |  6 ++++--
  arch/powerpc/platforms/pseries/Kconfig                    |  1 +
  arch/powerpc/platforms/pseries/papr_platform_attributes.c |  8 +++-----
  9 files changed, 24 insertions(+), 26 deletions(-)
  delete mode 100644 arch/powerpc/include/asm/preempt.h
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmpZtjMACgkQpnEsdPSH
ZJT+iBAAhKtQIVYpMtOUqzKjt0DwZaaayEMxKcgVCa07wolje/x50bC8l0D5Kpoi
QmQexojCT/00cfDkK7tiC+GUd1yr2eBMW/8AbBw3DqKBBdIiNNieWm//oRu5Zc7m
cPhrm17u0xTmZbzKeMp1fRsPZm7b+AwJmXoXj0B8wkfQiY1QKF8uR80xtNpx4Hsq
LOZQ4AjeOJOlMm/eprJlg657sLgPrBHIk+OZeO9LsU8UesRfpaA7swles4IwHRIU
3Gi7gQoAu9H7vl+9cSjbWbax7wCbmxAm94dNe0lPQ8awG0IyXKYRzYuE/J/By+hv
WjnHLFpWQYCjDwTrt4saZbplgzaiG7HO7GGHjcVMcmS6/qE41MiivRa8NHb/aMdJ
QO1vGw7QKwOE4zcvW6ZRZtYSjs544qr0Sxo46tfTg9iTTdkFDA4cmuqmZw7Msu2Q
EliKl7NTf/PY2BSYJzaPsIQyxIml0dQugAbHkjYbr/Uk4o+DztFOjapn3RbO1OLu
DpSW5N2Wc+ja3VDarr9oMAPUWt4IA6vfsGC9nXk2OhwAfK4P+h9asTLeRfNXTGFb
ZrzrfZkyxzgFsg/D2In/oT3OLOJqWneRvJkDXq22pR/kpYOkVfpw6kAat6hTT96U
9w2jPZF1L6o7b3PezyNqkJt80TfRrscJrUglYfZ/o+QHRDrqbLg=
=/Wf4
-----END PGP SIGNATURE-----

