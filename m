Return-Path: <linuxppc-dev+bounces-27472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA56C88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 08:39:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlC4754mLz2yGT;
	Wed, 16 Sep 2026 18:39:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789547975;
	cv=none; b=CKUyUKKlk64Ahzp9MPVHxVwI+38CTCPFZD54x4ENbbIMqs707lidYFpn9n8g0UUmTE7xC4d+53ZqhldHkYAnKiLyhvY/12Qx4o0tOp2P76JOfP1WdYNweuo694aKmyII5A5QX/ikUhB4PtUvbaKhGzDUi7rgPtlMfcXosNl+V6XuKVDy9mLWvguXcovPgWIMR6NAwZJu0IVBaelhb8k+LIB8dtjz/dBJAGd8cLxFKqtWyLPbL/Qol2RiVQOGFeZAc8DqVKEyRFguiodFwQaP0I2XXggmX7gawaOOhJ8GMwDfI4LG3VFaiiwxc89VI1HhoWcBESi4/HgBFVioe7yu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789547975; c=relaxed/relaxed;
	bh=GGdGRgtR+Seb1KAvhhBbWS3C1sesxmpG2tPKbItoA5g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Lk/dN4SNKhNqMCS1V65+fRpw6yFcbOo+Ktv/PKR+ID5qoM4FWysB3Ad4Qgx5OX497bhvq6QQpTyVS38/vT7Ynj2ICxpAqhxy7jqkTMnhPlF71LSjieR8Tehcpjm7rhFtA+CtzYUlyajxDHy32tIcf6CrYGjCgazXYwj8x+s083TBJOx0wAchqyGpM0rcM/q0X2oue1dMLZi+IspO6pQN92tTLMubbjgydzyyngZgfNdg9y2VmSDLDdYPiU9ssMsWv+740H4Sjw2xkE3czfIhZ5NFkuPU6aCMGyK3Cet4ob3THLqvcgeKnT+/mK8Fu4I590YzDQYGOYpCSqioX60dEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AHypWee3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AHypWee3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlC465lcjz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 18:39:34 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLVixf1951792;
	Wed, 16 Sep 2026 08:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=GGdGRgtR+Seb1KAvhhBbWS3C1ses
	xmpG2tPKbItoA5g=; b=AHypWee3W8E/jxFYLG8B+RPU3Y1BaM1pfYDNGpEUcmKG
	A3QbmjhPP6VStqNMGGfMcl0Av1ZEJNGCbNwN4CObOYI6M+pr4zdgZ0litb4QeK+p
	U8P2T0OS2u3xT60/sFCpHNbmiBra85vSEbYl07j1ydXq1Ujyy0Js2i+kL+mgzXEv
	9BLPMnZcTYviOnZiDXjYVS26DivTb0Y1+V6gyn10XSF4W068fAAvKvmcgcWRPHPX
	usaHTIMfnHnJLE6KkBujfGvEcScH2cwHkp6bp1EQvfnUbwcneWbVo1yu1d6cFUXC
	6zc2U6dNCdO3CD74J/tJhrlzZ9EAhip3MFo9hj2hZQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83ujvx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 08:39:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7duww388921;
	Wed, 16 Sep 2026 08:39:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsdg8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 08:39:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68G8dBku29426310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 08:39:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9628258058;
	Wed, 16 Sep 2026 08:39:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B41C5805D;
	Wed, 16 Sep 2026 08:39:06 +0000 (GMT)
Received: from [9.43.62.73] (unknown [9.43.62.73])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 08:39:05 +0000 (GMT)
Message-ID: <376f4338-8bd8-44bf-b132-ee7bcb5bc29e@linux.ibm.com>
Date: Wed, 16 Sep 2026 14:09:04 +0530
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
Cc: amachhiw@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com,
        sbhat@linux.ibm.com, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.3-4 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExMCBTYWx0ZWRfXzy56SgeNo99j
 IVZcWgH++R7InViu7NY9BYZr2IBGbhSHGZiU6nLK6HXUFqg07DBrTjFhZ6MNlxBs30huPViDTyN
 QH8LfJlUqO0YOjhzCRyIe77c2db5OiJXXmi60B5w+at1Jnyqqa+YJnaevRu9jlsgXSivwbGtWVl
 VcX0e9WGM5HauXceROVb7Z9ukxoQwRDJKWNNNZ4iWJtIByt66V77R5h+oVS8rdMVMEoUUojlkta
 RMq1tyPSCrmOtpkl1RmSp6p02FwVZ8Er392/bvJdfg53psEPWjwxb9csHB9OSIWewQcDOMUi506
 4maSStTy0B62Sxn+axg2/Q5JP8Uj6mYQ+qHgvf/HORTslHimwP2l/t8FaYySS6qvgFdodGOWbxp
 T5gm+rxZ/0MEb1Db662stlT4neWN+SE2AHV2kObnQHM+ZOmyqqprXx64WBIvmDAvtWkXZQcML3v
 N+lbfP7eMqt5Lu3xdJA==
X-Proofpoint-ORIG-GUID: PZ-4_aQnmEd1cHW9rlxJDiO3iR51JDtD
X-Proofpoint-GUID: D8i8Q5RISMew4bHvUSs5ZR1B1RQJWKb0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExMCBTYWx0ZWRfX5tKyewUTGJ92
 QsVemMVWWth7Q/ySg0uL1kI8Iwrc5r/+MnFSTaZcu0yfRifi50hbvSCieLEe3xXK9EFEsvDbQUm
 K9L2cCtf43LorOzhu1Bctmpc1q13GCk=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaa55b2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=YphJct1P6AXYnbWLuX4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160110

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull some more powerpc fixes for 7.3:

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

   Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.3-4

for you to fetch changes up to 0b271f7d7f5ed45bc498a03ce0aa9cfd8402fc71:

   powerpc/iommu: Fix the overflow validation in iommu_tce_check_ioba 
(2026-09-16 13:43:58 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.3 #4

  - PPC/KVM - fix use-after-free in kvmhv_emulate_tlbie_all_lpid()
  - PPC/KVM - fix secure device page leak on uv_page_in() failure
  - powerpc/iommu: Fix the overflow validation in iommu_tce_check_ioba

Thanks to: Amit Machhiwal, Gautam Menghani, Ritesh Harjani (IBM), R 
Nageswara
Sastry, Shivaprasad G Bhat

- ------------------------------------------------------------------
Amit Machhiwal (2):
       KVM: PPC: Book3S HV: fix use-after-free in 
kvmhv_emulate_tlbie_all_lpid()
       KVM: PPC: Book3S HV: fix secure device page leak on uv_page_in() 
failure

Shivaprasad G Bhat (1):
       powerpc/iommu: Fix the overflow validation in iommu_tce_check_ioba


  arch/powerpc/kernel/iommu.c         | 2 +-
  arch/powerpc/kvm/book3s_hv_nested.c | 2 ++
  arch/powerpc/kvm/book3s_hv_uvmem.c  | 5 ++++-
  3 files changed, 7 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmqqVRQACgkQpnEsdPSH
ZJTLjxAAgE1vT6J9m8qhtOPBSLpRnkSbRjXIRny1QeroWPUOzPIWvoZLOFLKyJDe
/Cb0/92tx8Qba45PoZVajFmczXXQjPDyl71YNfgMcwlIIM95gxBC2dTfBYoJaa4E
L8r1dMtoNbFjEoIdzQrwSakiWlGL4pkS/12pII13nHx+YPfPsS+sBK0uLJmHOlWi
G9ZKx42mGLCg9fyK0AP63Ob33T0rg07+ndTG033k2PesEngANTZzb8tHt0StIk1z
rnMyztnvRqEH9FUw8pqmmYQkTVLCJVcqD4yDIuUIfowxuXQJLXT3y6EkvABXap0l
TtWNlGFB1oe2pwa5skz8oO6G+esbaDR2qBIiAARQ93/h8idhDBWLrv9OA023oaHM
xMwowoIDRXrKBNmdLFbRq5hA3Nry0omPyPPtQv84nU0chShWsFQ6N6wmr25WEGJj
GfFfnml3ZgC5JXq+pL+6Az/x56YbB+eujiuSO1o24FrqJ8kWfYwuBhZoP4O99D38
nZQgCOy0R3snz1BS1Us0xoWo1MHWnK8skqQQxOsDxQJL7aonHSZ8FGsdAiKoyiVf
nfU6JUkZLw+Fm1X7MsN9Gp4/cpxS+1ZKJjpuEQrTDO5OX4sPV17bsxiwZPIFNN0G
yS/79ogcfdDQHGoPOspJMWqZGvZoAkLYB/KwY9UjIbB8xkdOaGA=
=kc9e
-----END PGP SIGNATURE-----

