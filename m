Return-Path: <linuxppc-dev+bounces-26726-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4134FC79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 06:31:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfDbk41f2z2y8p;
	Tue, 08 Sep 2026 16:31:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788849074;
	cv=none; b=AlQKqytfk7tZ8mjhlfwHituKKM4uFP3QP2VYQHqSN0POnLxxYwvWdHZGLymNgOMgObKzolUnsAooGiO1EV1zSpNoGjQL8880rwr6C5y6t/vPNer0dtPQx+glrR7PnDPwsa0+rmkEm89+93rogzIHoyseuPpPr+iIxOKZxhA3opTqx/yxlbImLt9mcgZ+zog1ZVod1i88a4DyQ2qA5uZ2dIHFQYuMbQZ6tnIBKgCLj0+HPolu9VnciXbUwgEQ8MBCWE0ITa7d1c6BpbukCHnQoFORaMDpItVsOpKgoLLEuG/GGshGNYmuZh6bZn/2jCR6j2X2bG+TS5HL246j3HSSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788849074; c=relaxed/relaxed;
	bh=V34JaugQxeV4Go6LtcZQ+CAzlsquOP93taTuW5zRMwY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GFqD+bjNOKZmp0Yn952gPeBAcmj4jYAplkNnvuHvUunJMSPTM/keSZcsUyOQ1FTqFAYQwlfTRNImUl047oDzeHv0FBaIZRN6jsviJn6kFM/PdMc8cMGDlwsiGyr+JzYr5/GhfIQ6LH4qZetOlpIm1oYe9LJXc9WLhxIWd+GT12MIyHzynQv4CDnnpAd+Txi7X3X0g6J5MPldUdmQyCYApIjjUXEYcmSQaQ37KIWYR9BeekG6mSO1bghNh5fsjj60P5xHgVrlzAZlO7oY6CldEBixPci+j3gnVtTrlMc9r7jbaKOAz0xMB+GlsWOk+ZY0QZ9lso1hGYWWnwQ5fzi7GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YJx2YRgz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YJx2YRgz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfDbj3l7sz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 16:31:12 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68801ql62221168;
	Tue, 8 Sep 2026 06:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=V34JaugQxeV4Go6LtcZQ+CAzlsqu
	OP93taTuW5zRMwY=; b=YJx2YRgzD/bDkolL+43CQ21+WbXfz7RFxtar0IuUv+qD
	0/lrNAE+k2khjHYBuHtcr6w7R19OYzriVddWX25a7ZSJTtds8rV8IHa16dq6hJKj
	2tsMAOv6XLrweOoqOK9MkPbIqBuYwm3qDzErTOVUWW8QhHb7ScMtyHlVBRRvTxra
	7nvd8YYyaAMoBpdHrB/zJQV6O4E+P0ViD9ToZcMdzuCN5lfXlt/jA8Eq+7mgO1j1
	bSYU2VEFhiJ0UUFbw03Kf1EIGvKfm5v0LInKgWVwuqlksR/OZresNnW9TKvmuQ6X
	E8/bW7GQ4Z2/xpKktikH+uRrbICwsJNjw6ytx4kjKg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrmsbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 06:30:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6886QhEI008157;
	Tue, 8 Sep 2026 06:30:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwh20mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 06:30:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6886UcDZ26870404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 06:30:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 552B158054;
	Tue,  8 Sep 2026 06:30:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32AC85804E;
	Tue,  8 Sep 2026 06:30:31 +0000 (GMT)
Received: from [9.43.98.45] (unknown [9.43.98.45])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 06:30:30 +0000 (GMT)
Message-ID: <54e891f8-d549-4ab0-91ea-999d6e8dd385@linux.ibm.com>
Date: Tue, 8 Sep 2026 12:00:29 +0530
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
Cc: chleroy@kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mkchauras@gmail.com, mpe@ellerman.id.au, naveen@kernel.org,
        npiggin@gmail.com, ritesh.list@gmail.com, sbhat@linux.ibm.com,
        sshegde@linux.ibm.com, thorsten.blum@linux.dev, yijiangshan@kylinos.cn
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.3-2 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6a9fab90 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=EJlZcYTZVgbFLH6Yc1EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2NCBTYWx0ZWRfXzK0n68x+B9mW
 A7G2TNDoxsYZZVko2YbZTx5xkO+eAWhoUhWBizPQ7dHLJFlxuEtSs1uFKOHtRDxCUHSogmvt9jt
 LJMxpsKDpty79tvJ9h35SRjvbBtckFA=
X-Proofpoint-ORIG-GUID: dPAJrhxn7vc62P6f7SqkdGAsZpktiYQG
X-Proofpoint-GUID: 32g_EzjPSOQ3vE_BuAxOGdNyRwt6xZ0Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2NCBTYWx0ZWRfXyp+D1y8/x+8d
 vjRRpA/EnaOeU28bvJdPHDaHmIP7TJNYC2Zo2zdOy6CFV3rMgSni2eSJVRRpz5mvEUV3cTzMix+
 kp4CTjZNmljmDyIJES17Farjowijm3kjOT6bwgt+opnuZJLyW/l51OFZr8z9oO/p3NDKmqfTLkL
 hU3Oim/2jllSU52XsFzMuSlAjgYzm/jzSQ/Zc6YuSaSbxN/RCY6bPPUVN3NA5HUAdRIvL+mT4/K
 SMtj37KNQmqLuGMS3xcwLnSVvOrqZi7fFKt8liC+kBaL19XrIX9skQiC6Yae/7lq1CWv87VlXv6
 FNwp8fSE7l3Jlqu5oTArEitiGiEAu1aHb7MSImZJQ9XW0+6xIhONjvILJE+jfPwEhGsUAdF8gxu
 kvuziIdBg3VEceyT6OlO5c+PlSqKnZXWxoncsTLDYWf0xwEAPcHC2K890pT2JQWXbDXr1PJCaGL
 rKbsWDTWPLn6LWBgUiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080064

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Notable out of area changes:
   MAINTAINERS: powerpc: Add Ritesh and Shrikanth # 45a5f7285f83

Please pull powerpc fixes for 7.3:

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.3-2

for you to fetch changes up to 45a5f7285f835adb3b74c9344c09a7bd2c4fb664:

   MAINTAINERS: powerpc: Add Ritesh and Shrikanth (2026-09-07 12:15:39 
+0530)

- ------------------------------------------------------------------
powerpc fixes for 7.3 #2

  - Clear TIF_SYSCALL_RET before syscall error return

  - Don't drop _TIF_RESTOREALL on syscall restart

  - Do not restore KUAP in arch_exit_to_user_mode_prepare()

  - pci-ioda: Fix the stale irq chip reference

  - Use inclusive range checks in add_usable_mem() and excluded memory

  - Fix irq_soft_mask corruption on replayed interrupt exit

  - MAINTAINERS: powerpc: Add Ritesh and Shrikanth

  - misc fixes and cleanups

Thanks to: Amit Machhiwal, Christophe Leroy (CS GROUP), Gautam Menghani, 
Harsh
Prateek Bora, Jiangshan Yi, Mukesh Kumar Chaurasiya (IBM), Ritesh Harjani
(IBM), Shivaprasad G Bhat, Shrikanth Hegde, Sourabh Jain, Tasmiya Nalatwad,
Thorsten Blum, Venkat Rao Bagalkote,

- ------------------------------------------------------------------
Jiangshan Yi (1):
       powerpc/pseries/pci: Fix misleading VF limit error message

Madhavan Srinivasan (1):
       MAINTAINERS: powerpc: Add Ritesh and Shrikanth

Mukesh Kumar Chaurasiya (IBM) (1):
       powerpc/entry: Fix irq_soft_mask corruption on replayed interrupt 
exit

Ritesh Harjani (IBM) (2):
       powerpc: Don't drop _TIF_RESTOREALL on syscall restart
       powerpc: Do not restore KUAP in arch_exit_to_user_mode_prepare()

Shivaprasad G Bhat (3):
       powerpc: pci-ioda: Fix the stale irq chip reference
       powerpc/eeh: Fix recursive locking on devices without EEH 
sensitive driver
       powerpc/rtas_pci: No hotplug on permanently removed device on pSeries

Shrikanth Hegde (1):
       powerpc/entry: Clear TIF_SYSCALL_RET before syscall error return

Thorsten Blum (4):
       powerpc/kexec_file: Use inclusive range checks in add_usable_mem()
       powerpc/kexec: Simplify kdump_extra_elfcorehdr_size()
       powerpc/kexec_file: Use inclusive range checks for excluded memory
       powerpc/ps3: Fix repository.c build failure


  MAINTAINERS                               |  2 ++
  arch/powerpc/include/asm/entry-common.h   | 12 +++++++++---
  arch/powerpc/kernel/eeh_driver.c          |  2 --
  arch/powerpc/kernel/interrupt.c           |  2 +-
  arch/powerpc/kernel/rtas_pci.c            |  8 ++++++++
  arch/powerpc/kernel/syscall.c             |  4 +++-
  arch/powerpc/kexec/file_load_64.c         | 10 +++-------
  arch/powerpc/platforms/powernv/pci-ioda.c |  6 ++----
  arch/powerpc/platforms/ps3/repository.c   |  5 ++++-
  arch/powerpc/platforms/pseries/pci.c      | 13 ++++++++-----
  10 files changed, 40 insertions(+), 24 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmqfqycACgkQpnEsdPSH
ZJQfcA//fLyVXSmS7lXIYoWtlE+qZbDtSH2k9sKbjYtB42EE7SMtIfk7c/ID7nMm
tL7bA6apAz+ih0bpjvtGhtASL3YgVlb5sRyW5L8UoxL8J/F7hYNBqPohOKvRL995
hYTUkef9t8aA/OZ5KJW4MsVL19Zkx1bQ57TjTTDG/Z9JFhrDZyknIr2tYEZvmrMF
1NH3sc5f0k8LjmFAeTfVoR7AJuR/kpnu07yT3XdS/QX6hlP89hkDW+ndfbCGkRb2
uZklJZsFRqPRCUCwZcLhcD2yKBLpMV0E7ZHH39REiMlv1gJ9PhC2Voi9W9bPADK3
ILuL8ZF8qeKyU4pVL/znr9qNG3GzJCYTF/K4aJyIxhNma/O9Hy8m+igC7/1o4gZA
SnhB90BoVB1BQpsploZ3YnhNhnz8MH23raTGswGIbRaRAX3KOM/bi4CC6sKYhimx
QYot5mJHyIkMQTZ0HwEx5CatUuQvdiAeeHafeUf0PD6LjqI8SUgfzrUa3SRfmSZM
gkWbYd1cJd0otLrmyOKA5EL3fNjVa8UIlGAd5vWERYFxlx4p43GtDxfOk6hQk4Yd
re6CbE9grgTH/OAsoROUItR1wvHdL9QkZlEEQPazfvdECFIU6xRoHGXJolBSm7XS
I/vRuh7Mo5iF9/hoS8wihldNsVked7coZbxW/LYLPaYXgMTCK7s=
=wh3X
-----END PGP SIGNATURE-----

