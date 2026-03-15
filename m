Return-Path: <linuxppc-dev+bounces-18194-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D3DD58B0A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 03:43:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYPGF6LT7z2yYy;
	Sun, 15 Mar 2026 14:43:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773546229;
	cv=none; b=W+42E36hxNcz8xfLQvY2gpjGtg2dYOeAMIRwDNiUEt0J0XYqVu5ZofCQ8P4QDIAxzXsOLFMExJ4GKR8NvQf/hukfltaofb/LaVlBh88MSuHsNeaeDlLcXxg1z1+wCbTtY8vbXreYIj4hxfbRE5cvURDdjjXaMi/8B/VP2XrfO0fnxLupJex94WWr5sau0vpOSLV0UUryiNKrHR2kt21s798D21uWYi8G0Pf4/3Y03FKps2F7K6FuxUpKLfdf5wEjjOy7+szIx830SEuRtrCI5tyGM6EZAyyHsWBqd1dg6+k0MokkTwlOx46e+3yRDkVTJivocvFSq524P1pdmtc2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773546229; c=relaxed/relaxed;
	bh=eVazFm72ow5WvcHKA6FTbPJhz46RKeSbuwnC889MOXY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=b0s0lJUJJ3Yj5eRbOg/EvTtQDpcyOyOSZYRzV86CBbnsz7oHburWURpfN4OzcbpQUIQgPfKAUwhDs3NZ96L1Gz1jgeycVs2ADnb8ToohavH/frcj3PYwyoDXgHOv+Mtlawx7D+WXFaWRxhzWrSi2O7Dp2qTGCiJNP7Ph6/8bDHg12Ky/dE3rQ3reLj9krxezgzJz5Va7ZEHspq3/mU1PesggaGiJ8t8ydsMnW9q68jasPoepl1yvH3ExajxIlQ5gRwPlBwVNmhLpFX4MSJhktXAgSsexFMOn5/Bq29pG0UA2FkfDQowHlERCma4Ydo30qNIZy4kn0CtqV8zunsl5DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ev1lkRRT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ev1lkRRT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYPGD3681z2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 14:43:47 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62F3TQam3015916;
	Sun, 15 Mar 2026 03:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=eVazFm72ow5WvcHKA6FTbPJhz46R
	KeSbuwnC889MOXY=; b=Ev1lkRRTesq7YMoejhPR7OYdWMkkKOU7vv7DHxUSxL6o
	oD+0u56QE3mZxEBc+2ouNfHapIdh8XW2e+CyK1dKxfQW6pUqLm5J1GJaW4mR/q4x
	G4YgVzfPjpSa5EyZ7QRh8nFN+7uGMDzxORlLTPqI66CKoEoQKEEA6zdpESOoZroC
	kaix1Kqxo19G4+cuLjT85BOOjtZF5/GSaeRM9FMx5dMm+4Y/9fr5MvWZ3uLHZ9rj
	yn+puY4DRQs4Bvy1rPNQDoN19Ye0sSNiPTEO7Ij9sDjprlweIFw9wTlPSSb26mVN
	2E2envAfGR6IjNuqsdvyvPG4n232R1v6/25Rvaxbjg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau2ud3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 03:43:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62F0bI9x013996;
	Sun, 15 Mar 2026 03:43:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxrby6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 03:43:23 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62F3hLbW22020740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 03:43:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C97395805B;
	Sun, 15 Mar 2026 03:43:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B36758058;
	Sun, 15 Mar 2026 03:43:17 +0000 (GMT)
Received: from [9.43.97.251] (unknown [9.43.97.251])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Mar 2026 03:43:16 +0000 (GMT)
Message-ID: <a192e75f-10c2-4733-8a19-11ef8600747c@linux.ibm.com>
Date: Sun, 15 Mar 2026 09:13:15 +0530
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
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, naveen@kernel.org,
        nilay@linux.ibm.com, npiggin@gmail.com, ritesh.list@gmail.com,
        sayalip@linux.ibm.com, vmalik@redhat.com
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.0-3 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDAyNiBTYWx0ZWRfX5+4kWmeguioV
 qs0ENcQutBsiJZH/bsq7uihqX8FmNAZHL7YWq5A21ZsjJrHg7MAgEusAc5YCiOTvTgWFIGk7ibt
 YY/JwywcfBtd06Zb2tOkgm7OuSdv1BznYyXYggf+9XqvA3smD30HNA0Ix//+mNRnSDugQbQN+ss
 lOossd7GQWRvPCVg1G3WZAdqWOQTdemFCKWUbflEDC0WbfQ4pfFkbSb4yw5E1qso/uIbZ2r1gM8
 +C9h1JSnLoK6DMlLINYgQ6BlE7cUp/GtEX++PEA1SFVI2VjxZW9Pt+yIhQMH2E0cTDE6Q270ZCW
 WFQ/YXc7ET/3k/l/HGtDxvtG5MrQtTyUmc2D+DMgCg7tVjXtTFGNfiICs2rPqK7WtlL2Hwy4Y82
 8FEkFd4sVZ5cX3DxhCakbrZTw1vyw3mN3lDAcZYsQCd0Leul482HSXTYiuHDQPzf+v5CQ/7KLu3
 /ZWyprLAoyVR0oFuytA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b62adc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=mhrRyvz5pYDq6wfP8tsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FZZL_HDu9-Kj-j8TB7VMlWpxVpS7yeJS
X-Proofpoint-GUID: nesO4PaR2ohwKRHT7E92I9iLVBAprjPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603150026

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull some more powerpc fixes for 7.0:

The following changes since commit 35e4f2a17eb40288f9bcdb09549fa04a63a96279:

   powerpc/pseries: Correct MSI allocation tracking (2026-03-07 16:02:28 
+0530)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.0-3

for you to fetch changes up to 82f73ef9c41e0623e0a8bdce4fa44a7237709f0c:

   powerpc/iommu: fix lockdep warning during PCI enumeration (2026-03-13 
12:13:35 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.0 #3

  - Fix KUAP warning in VMX usercopy path
  - Fix lockdep warning during PCI enumeration
  - Fix to move CMA reservations to arch_mm_preinit
  - Fix to check current->mm is alive before getting user callchain

Thanks to: Aboorva Devarajan, Christophe Leroy (CS GROUP), Dan Horák, 
Nicolin
Chen, Nilay Shroff, Qiao Zhao, Ritesh Harjani (IBM), Saket Kumar Bhaskar,
Sayali Patil, Shrikanth Hegde, Venkat Rao Bagalkote, Viktor Malik,

- ------------------------------------------------------------------
Nilay Shroff (1):
       powerpc/iommu: fix lockdep warning during PCI enumeration

Ritesh Harjani (IBM) (1):
       powerpc/mem: Move CMA reservations to arch_mm_preinit

Sayali Patil (2):
       powerpc: fix KUAP warning in VMX usercopy path
       powerpc/selftests/copyloops: extend selftest to exercise 
__copy_tofrom_user_power7_vmx

Viktor Malik (1):
       powerpc, perf: Check that current->mm is alive before getting 
user callchain


  arch/powerpc/include/asm/uaccess.h                   | 65 
++++++++++++++------
  arch/powerpc/kernel/iommu.c                          |  2 +-
  arch/powerpc/kernel/setup-common.c                   | 10 ---
  arch/powerpc/lib/copyuser_64.S                       |  1 +
  arch/powerpc/lib/copyuser_power7.S                   | 45 +++++---------
  arch/powerpc/lib/vmx-helper.c                        |  2 +
  arch/powerpc/mm/mem.c                                | 14 +++++
  arch/powerpc/perf/callchain.c                        |  5 ++
  arch/powerpc/perf/callchain_32.c                     |  1 -
  arch/powerpc/perf/callchain_64.c                     |  1 -
  tools/testing/selftests/powerpc/copyloops/.gitignore |  4 +-
  tools/testing/selftests/powerpc/copyloops/Makefile   | 11 +++-
  tools/testing/selftests/powerpc/copyloops/stubs.S    |  8 ---
  tools/testing/selftests/powerpc/copyloops/validate.c | 15 ++++-
  14 files changed, 107 insertions(+), 77 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmm2KfUACgkQpnEsdPSH
ZJQkvg/+MnI6Iskx0pzZTYLI+PDEOPgQt/qNoIgHBIruIoEivfv03JF0IkCejHu/
LH7CPTCKPztrfA3Hcz97eQDqpFk0ITfCxt+LS6k3HpB6AWEQlnrdzqggTPjkto0c
e/vPIQn9lTud36AQNCUV2NaZipRQ86CCsuOr7ctakHfKLc1Mje2j9ZPfxyPxIkFl
lpmx22xC/j3kLzH8EiCPjBu6jR/kOaf2lB3cE6T250YKKm6ualSTqSjgZExdMwrj
U3bmG8Vce6DHFl/HctHV8tycPKkfKwcZ5Ddz2iHZCs5XUkRgAGVPL3DHK9k9mR0D
Z7KVMaelJWEQJ0rEkiaHhGV9DrSz5LfNw9N+r6CFXiyKYBnlVqCxqg/k3DWf3XvB
BzyRd9wAaLsVysCPCa5FrnthqtAFaM9OklDmpmY4+NKQ6Yo2QFcygHgcyVVjys1e
nH+nLVYsNxfHXj1csFp/MgmVqwQ3IxR+nsZ3U+ssxPGq2Zj520GhdLbWuHtJq581
JZ+V+ZbULtoCmZ/yVo4WJIeYUYtTTWKHnqKhK9706ycgTqn47bM+5Zr8NJR/xr2g
ZwBqQwNZhUSiAKpEHofVxVrQRhkXYvb3ETMVExPTGK9vObKQTM8iehmkvZMAw9st
ftk4hdMDHR4HkhboLI2+hWM529GGtF/PI7SA3PhRRH0RoXvUTE8=
=jE92
-----END PGP SIGNATURE-----

