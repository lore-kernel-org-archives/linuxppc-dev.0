Return-Path: <linuxppc-dev+bounces-19301-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F3EE88D73
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 02:24:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnfY4750dz2yC9;
	Sat, 04 Apr 2026 13:24:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775269448;
	cv=none; b=Ua9Cw9NLTfTf8t8Qykegpmxi2xw6l2Qc0koYs6zzE8pKdXgVI8tc2l/b/wPt2SCCYbdZHR3zIXnj4Yus03ByRb4T6WjqZ3aXkJP9UfbFiapGvYmlrd75ZHILQVsGz7RWs6Gi2mtzUw9EdB6r0zY1b5QBAzPmqUMDQV30uYTScHuJEKECMrXG7kPNeRw8sNA5+fnlACkQ0iDT2lrZfom6fKijTNTQGQEyszSzQqWc6vAWVP4UgHAxYPa7kZOyuwfa68OBrpNfhErRjs6QzF5N3K3S+3gGxaWXXqo55/a6KhlkpLbR4gQve3howrrR3mLs1OuZOg09WU8Za0m9Q4Y74g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775269448; c=relaxed/relaxed;
	bh=GM88/7DaAO9BzPMxHwW5BfYtOFO6kFAMkmrpnqHjlNI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HGElG6k0jdgvN1tJs0TTO+6T/+FiYcKmuw3FU9TiBBnugF1OkojDMTsT4IIWVPtCnJgDq1Dv8Qeq52S0ziEHmfDL6YajKrVYj/d717mI3Z1iw9G6XuF1sgcogbp37TCUs0rNDwvEUSUXsNmnYN+t/EMZ26KzojpfXT4Y3dEiCQmeMd0cM2eRiWBn/mr4CAfHOlmJYbej5aHmk6dXKpMKVwQFmRpFft6Jv1GjRti4qWU+xGJuAZd9J8t/QYZKvmSkBqGfagQV2+icSn6UDZNeAAYqzP4MiCLEcZoDQaBQh8bIQ9JwTd7fFWueLjSf2EixbnUUn9HW+1ksI8sugucBMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H5pcoPxv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H5pcoPxv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnfY34hrBz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 13:24:06 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633M0VJS2506196;
	Sat, 4 Apr 2026 02:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=GM88/7DaAO9BzPMxHwW5BfYtOFO6
	kFAMkmrpnqHjlNI=; b=H5pcoPxvWcACjXwy3EUiH/pV2+zqREIf2bHTdU+0mN9r
	W8x3QnkbXfV6rGn6Mn8iMEW0rfuY1CyAsHFV/q9QY4/lAsSJXaLCmYwv7GvUHqch
	QfDXI8YD9UHJOUkBeIt44vziP4TS0r8j0Wti46/m9oSSiQqHq/1BLjOrPE1vwDFT
	gYq7VhtlDAkLAApGqa4eidfbMu/lfP3xoXydbcarXxWQGpEFeoSedMKVP9Qh1D4H
	IjQ0vtORQh/ZvWPyJTR0e+2mhFkVOrLoXpaGl9MIqrqwezwFFdfvnF+W+PtqK/Wa
	XOLadeNJ81LalZZ4XoICJhQwH4Mkop/UkOXYeoIXfg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3js2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 02:23:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633KJg6k031007;
	Sat, 4 Apr 2026 02:23:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk82q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 02:23:50 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6342Nn3x32506600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 02:23:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2DA358059;
	Sat,  4 Apr 2026 02:23:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D48A58058;
	Sat,  4 Apr 2026 02:23:46 +0000 (GMT)
Received: from [9.43.119.166] (unknown [9.43.119.166])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 02:23:45 +0000 (GMT)
Message-ID: <3ae2afe3-ac3c-4f92-9073-1b8630496f82@linux.ibm.com>
Date: Sat, 4 Apr 2026 07:53:43 +0530
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
Cc: christophe.leroy@csgroup.eu, gbatra@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.0-4 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -VNdhe0VHcOjTRDKdD3IUKn1xdDgMhHE
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69d07637 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=tdziVfyBbCxcOtdxMhcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PnwUp3DLXBx0kW05nfsOynF3SF8Q_5Vz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAxOCBTYWx0ZWRfXzQx3iFEnu8Vw
 3FAkmgwWMBQ49cIx3EublGGv7i0KVkEKWxjguirnQrON+i2QtubP6nmsAWfL/iJPZrSL6xIPfqo
 uWd27/j33R30QOaUAYDBo8fLzQUkIjoFITS1eoxdYVvJ1F3OI28On4wShPTT3T8Eb3LN32bCXwa
 i9JeDGT9ur4d/rSvTzdJUTTThMws0fob17uwBPUIumWlVzCtk/wzywdIxGNbT46M4WSWe0vWVRs
 FRY3sYszjywT/JSvls+bPFFaXlVqZ1Y9cGWlPD4CYA5rVVvOg3xV27aavhTqbIEqtLpW64GA25N
 V3wXUpeNa5jaG3zVpvdGqpzl2bPUXRg1VqqDRAEn0EjBmE+T0r+pJCxuqajs9utAp2U0clwRvuA
 RT/FE2t1JFNhyfsHEPOSCXYn9/jMS4o9myeUF9aqDam1ZoM+/IIokJe5uj6DlNHVQZZtt4lOkVF
 jw1U666I2MVUZOrofAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040018

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull powerpc fix for 7.0:

This pull request contains a fix for powerpc powernv platform to handle
incorrectly bypassing DMA APIs while allocating and mapping buffers
for DMA operations. Kindly pull it.

Thanks
Maddy

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

   Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.0-4

for you to fetch changes up to 328335a79487ec38d6b0e1aa807785b0f75e594d:

   powerpc/powernv/iommu: iommu incorrectly bypass DMA APIs (2026-04-01 
22:08:55 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.0 #4

  - fix iommu incorrectly bypassing DMA APIs

Thanks to: Dan Horak, Gaurav Batra, Ritesh Harjani (IBM)

- ------------------------------------------------------------------
Gaurav Batra (1):
       powerpc/powernv/iommu: iommu incorrectly bypass DMA APIs


  arch/powerpc/kernel/dma-iommu.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmnQdVoACgkQpnEsdPSH
ZJT8qRAArE9XDDIw5fIb8C99PxgSH9tlhoteCQYffzAJKt/TMgsa7lNS024KbcAm
tTExwwoRtpmN52qa8yK85YR2EeXod+P+snyfb8zy36ljpr/NqxM2Psuu77XI+lYV
PJmkuwkRIE9BwGOoAvCsngKzgj4HJo8T0jF3MEbSx1PFTqmDcsc/MNvU21lFJ3tz
utIN1kJdklBDV8lpFsZuQrQiHXhpptjI7h7Xygl1NNuSjNZs5xqINCSOPrOKxIuJ
9yACEMAqEx+Us7chLbJnhhO92iTphux1WA6lINWif+n9YMEme3tbGi8k31Jnkygv
TNjeCKW2z5S9YXqZxUXL0ZetjSHc9Ur8iad5jcsfxlvrhjsgFHsD9rmtaDM6rVTW
HaSA5HnQnBB6TjEGpiDS6AmDyDn2y0gBF4h0eQU0yDI2nOp2EB7N+AE6n392kFHk
Paa29nZF5OegGIbZa04I2yaoJDXlo2BHmXVASju+BMRfyOapl6MdlyP5L8BOO+26
ZjWGD02hcUy1OjQbeVbNNpFBi6A8/aQJqYCEJXZheJfHixZzF29aCRKeUsCEdhC5
i9XEhxUnHJW5ntyt+alu8FSMjANJshhB3frljdD1zXRGnTX1sGgGBkt52s8annB/
66KaySIr2CtHdnr0PhgzcOUE5bXsm0PgGPqa5/1w4408/nnGGG8=
=+FHI
-----END PGP SIGNATURE-----

