Return-Path: <linuxppc-dev+bounces-20632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AAECD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 05:18:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCDlg4q7nz2yZN;
	Sat, 09 May 2026 15:18:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778303887;
	cv=none; b=b5s2XibJsMd3qf7qTVQzzmKVKz8y7aKOiyb7hDz1pobOIr5/saV7SG3+ZA+q8h2Elz3JgqCtvyrzw4rB5VQxAN6yeRBqnEThkJ9pK6HNXjQMtWjtZ3Y34jPWqrNM0iZUZEz5PeIH3CvmdjLa44rL/SmmJAUb2C0Sj9Hlee9rFHY+9/BWRSO3xWwdw35F9gpXTXlNRXjp8nLJLRjiBvgI1sRM3lwDebGeAhk/8R+5cduG7urFOBbywQaFyONzeAUDIl44h/kxINF+D1gCdzRuDF3XkudimlslHLtTqtGPXpo2/t05Mt6VWlTIGYk5+6y8/nCgUETypv1B0hAkwvvhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778303887; c=relaxed/relaxed;
	bh=DVIK+r2LDB04RtXTmedV57v7uSpDj322jM0xR8dLgGE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WIoQugV77uTHjp0MlKLvx7Z3jp3qmKhwL3IKQy7ku35Eko4NSHjv/8brSjX8FMaZROB796CMmU7VHy2FyIUYi5D8ZCx4ysefsdOhdjIkyWQ7gKQR30iNyx5frLSlPCNxSBVAZLTM8eD7euefiaoG/+hVlbBMSyO6Y0APk8148dkyCGbp2JUfW54L1oMwbXEl75PUI+lagdSggm/foRaeUEejicD51t4H0/pJqde3AREyjfDG+00Ti4vIh88cpeWus84Vu3uJbEc9VIiSPUoQeL2UVHrLqArPonWQc6zdLQYEWuyQWlR8bvlsNZ3npjY9rzvKRLApkskYjg2/U1s4hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i4YTOp7C; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i4YTOp7C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCDlf0y8bz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 15:18:05 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64931Fqb2539714;
	Sat, 9 May 2026 05:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=DVIK+r2LDB04RtXTmedV57v7uSpD
	j322jM0xR8dLgGE=; b=i4YTOp7CAHAqi/cNFp81cByGcAAs8IouP1EnjB0pz+dH
	J9jN9dgm6wnH15bIvnJkIRxEgLXsKECcBYQuAc6VrBDVB+vsk8lHgGfu0c3u/cXu
	2duEXoGkjJYBJQSGp0rw/EQbM9attTn2Qn/1JrUTjd8XLCORyRQpDwQfSUnNqEIE
	H3VD77OECKhuK6iF+dU1Bey4l3iTjr1kmhHjPcSh3hCOl8V7zMTmgZ0clcgdGpT3
	5XdmX4VBw5SkE/zAnKMIvsEeRxaziqM78c3xae3qapPo8t6C4J/ssyDfN3kRyidX
	B3GliWBmdzlzLbvGLeNiZqeL/QS1m2/EvqliItUBXg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4g9w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 05:17:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64959a2b025460;
	Sat, 9 May 2026 05:17:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgtxmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 05:17:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6495HdPM18612846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 May 2026 05:17:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 251A158045;
	Sat,  9 May 2026 05:17:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCEA058050;
	Sat,  9 May 2026 05:17:32 +0000 (GMT)
Received: from [9.43.96.227] (unknown [9.43.96.227])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  9 May 2026 05:17:32 +0000 (GMT)
Message-ID: <ee1f6b28-44c5-4567-a5a4-273ab31cf56e@linux.ibm.com>
Date: Sat, 9 May 2026 10:47:30 +0530
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
Cc: atrajeev@linux.ibm.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
        krzysztof.kozlowski@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com,
        mpe@ellerman.id.au, nathan@kernel.org, naveen@kernel.org,
        npiggin@gmail.com, ritesh.list@gmail.com, shivani@linux.ibm.com,
        sourabhjain@linux.ibm.com, tzimmermann@suse.de,
        Nicholas Piggin <npiggin@gmail.com>
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.1-2 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=69fec376 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=5f-d5yj9Zm1OtvFmugoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1MCBTYWx0ZWRfX29K5klJQ8uH0
 tlQmPFsdW8IoKNopRqXiqEhDoHazBHcJoM3a9r1vm/tVJt+BGKdVTeAUSPKTlRbOaKL0cY0kKA0
 PsTG7eLf5yCZoAjJJgndDjs30aQ97omjq62Vxl62hBoRxvkYs4sFkakYuF0U3mw2cXv6dUUkk5s
 vOebrWGYZYJEgddimFSOJnMluRupkxn22jaRmwrWI8+n6S1Bkh418wXNnIb9YfhSiH5bp9KDXwX
 YBGQ5IHmigLS/hLpLUgB4vwQWdJI3Gy6nXti7oTylVwGgNPYMVoY8xkEEPgMMGJ2mh8pIxMESIl
 FxnDpxx1F8wpYRnt1Hn3Ym1QfXJh6KkU7NR26Nx5ljrF/A0GtsoATFpTnbyMPkLxSlyaqrFWTNw
 9LnU4f/FuCgdYouVAH0tafV1/7QtjQECb+2GZBA/gECLQqmvNvucQG1dkQbt/OCy51Lo1DJdnDj
 KkELnmH6tfPCixU8n8Q==
X-Proofpoint-GUID: 3mXd5fO-X93Wag0r8U6-24RuKnIKDigS
X-Proofpoint-ORIG-GUID: bbHljrWxGyMCDteBkGliH2oFAlHI4Hp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090050

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull powerpc fixes for 7.1:

The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

   Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.1-2

for you to fetch changes up to f583bd5f64d40e083dde5bb22846c4d93e59d471:

   powerpc/pasemi: Drop redundant res assignment (2026-05-06 07:49:19 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.1 #2

  - Fix KASAN sanitization flag for core_$(BITS).o

  - Fixes for handling offset values in pseries htmdump

  - Fix interrupt mask in cpm1_gpiochip_add16()

  - ps3/pasemi fixes to drop redundant result assignment

  - Fixes in papr-hvpipe code path

  - powerpc/perf: Update check for PERF_SAMPLE_DATA_SRC marked events

Thanks to:
Aboorva Devarajan, Athira Rajeev, Christophe Leroy (CS GROUP), Geert
Uytterhoeven, Haren Myneni, Krzysztof Kozlowski, Mukesh Kumar Chaurasiya 
(IBM),
Nathan Chancellor, Ritesh Harjani (IBM), Shivani Nittor, Sourabh Jain, 
Thomas
Zimmermann, Venkat Rao Bagalkote

- ------------------------------------------------------------------
Athira Rajeev (4):
       powerpc/pseries/htmdump: Free the global buffers in htmdump 
module exit
       powerpc/pseries/htmdump: Fix the offset value used in processor 
configuration dump
       powerpc/pseries/htmdump: Fix the offset value used in htm status dump
       powerpc/pseries/htmdump: Add memory configuration dump support to 
htmdump module

Christophe Leroy (CS GROUP) (1):
       powerpc/8xx: Fix interrupt mask in cpm1_gpiochip_add16()

Krzysztof Kozlowski (2):
       powerpc/ps3: Drop redundant result assignment
       powerpc/pasemi: Drop redundant res assignment

Nathan Chancellor (1):
       powerpc/vdso: Drop -DCC_USING_PATCHABLE_FUNCTION_ENTRY from 
32-bit flags with clang

Ritesh Harjani (IBM) (9):
       pseries/papr-hvpipe: Fix race with interrupt handler
       pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
       pseries/papr-hvpipe: Fix null ptr deref in 
papr_hvpipe_dev_create_handle()
       pseries/papr-hvpipe: Fix & simplify error handling in 
papr_hvpipe_init()
       pseries/papr-hvpipe: Fix the usage of copy_to_user()
       pseries/papr-hvpipe: Simplify spin unlock usage in 
papr_hvpipe_handle_release()
       pseries/papr-hvpipe: Kill task_struct pointer from struct 
hvpipe_source_info
       pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
       pseries/papr-hvpipe: Fix style and checkpatch issues in 
enable_hvpipe_IRQ()

Shivani Nittor (1):
       powerpc/perf: Update check for PERF_SAMPLE_DATA_SRC marked events

Sourabh Jain (2):
       powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
       powerpc/vmx: avoid KASAN instrumentation in enter_vmx_ops() for kexec

Thomas Zimmermann (1):
       arch/powerpc: Drop CONFIG_FIRMWARE_EDID from defconfig files


  arch/powerpc/configs/amigaone_defconfig      |   1 -
  arch/powerpc/configs/chrp32_defconfig        |   1 -
  arch/powerpc/configs/g5_defconfig            |   1 -
  arch/powerpc/configs/pasemi_defconfig        |   1 -
  arch/powerpc/configs/powernv_defconfig       |   1 -
  arch/powerpc/configs/ppc64_defconfig         |   1 -
  arch/powerpc/configs/ppc64e_defconfig        |   1 -
  arch/powerpc/configs/skiroot_defconfig       |   1 -
  arch/powerpc/kernel/vdso/Makefile            |   6 +
  arch/powerpc/kexec/Makefile                  |   2 +-
  arch/powerpc/lib/vmx-helper.c                |   9 +-
  arch/powerpc/perf/core-book3s.c              |   5 +-
  arch/powerpc/platforms/8xx/cpm1.c            |   4 +-
  arch/powerpc/platforms/pasemi/pci.c          |   3 +-
  arch/powerpc/platforms/ps3/device-init.c     |   4 +-
  arch/powerpc/platforms/pseries/htmdump.c     | 133 ++++++++++++--
  arch/powerpc/platforms/pseries/papr-hvpipe.c | 181 +++++++++++---------
  arch/powerpc/platforms/pseries/papr-hvpipe.h |   1 -
  18 files changed, 235 insertions(+), 121 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmn+wtYACgkQpnEsdPSH
ZJSYihAAglGB3V+ICTWx2ic7FHPJp2uiuEhbvwdjrLhloqRVpOrs00TxS3Eso1q+
ySXqrr2u5qsPUeMr8h4VqiCnc7eGsfmfJaheItVs69Klv4FnexTilJgH8BpRc5z3
qHVPAZBAv1laCTN5uRm4pXBrv3V/vGWLtHjTkqBnkGGgy82luJlV5nyUvOYfR0IR
eRYWn2BxqvkFCQn0FzdPktJJuOuTca3u/DwA1s1IwsrBqdIblDUPCdXwlzXaB2p7
YmlFBjCXkcdu2MlNC1qWx+zJQqFCEXt2l58daW5HIGt/Fw7mNYr6EzoxnSgT2SvQ
33dzLtxOELEFZrUhZ/IgvMwnv7awS34gzNWXtowkuSdI+W6gFNPu3ahv8xQluF2K
+3gamy9lVudD1EAUBkr60dJLjYcCualClXh24U9pcZIdehmBFLInRC6gVyPJxAu4
hcGNNTCYtPzejUFi/8BywnsVZ9uRCwk2iLbYF8EzaJV9m9fciZetnm6IFs48L9zw
2P+qq9B8FdAmEyd0f1RKymFr4tBA05nrFex4P/5ujEWBOr1sUVIJvbaxPxpFs1vt
FykuXyzeJERyt7elKH0rTglxikxMVVFNLZ+pJMJh5R7fMZg7RTxSMCWCaBH2ecRb
MOmDYpWUsOsbsW+oIKqYEDRnYy8wz/hH0mQMWM8Xm5ZLmg2Il70=
=v1Hy
-----END PGP SIGNATURE-----

