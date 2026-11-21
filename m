Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDF606A335
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2026 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bvncTHAs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWpRS10zhz2xLt;
	Sat, 21 Nov 2026 21:32:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795257124;
	cv=none; b=XY8iLByGiVTqLjj9dQEuspkpe+4+O2BM67olKQ7QogoXhGvH76D1qm4kfDdsKlE72D/xyeCQsZf4oag1OppUmmBvXHkbZULxTySyzlproR2A3bVp9tfBwCg7exPxPQAN1ByDpuuOYHg4fJvvwPjoXIddy0tO6ZgDkmFZnEUF0C6FCru6VRsStH8N4A10m7raMYsiqu1zlcfdFkMy/K4BP4R/My4L7fTEC5aFo1mqFQa6rFySYCsQqprFgDGhGTlrAOI1sshUaXsWvTGEug7jL8ioIlIsO9osfF+lKu0wL8uNTFaNU+yvb79nyZ8WC2AuTjpMXiYPUaOkTl5VTrC+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795257124; c=relaxed/relaxed;
	bh=jdJKIgDv9dm6oaMmegLimaVtFd/sQ6zcQh3xk77sQmQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IueURGmF3iT9AczGv+8SaVbikMuLEz5Nx2VU4yu5kpyraRLAR1x4CLbE+ncmMReW9gNAu6Mv01dfOOqwmNX5VrwK56Yu4Ikk8NvjtnMbYxKyaWFcgmy/Kqe6YN35CmdO0KAesAYz6AH6Q0kZEd6SdnJImlDQ6o+vgw4SM7mnJliJv4LlIw3yBRk/+syqpITAOfdgX7U3WPRD6knE68uai09b6pOn29P19S4WsGKVycGUJTI34iEkGEGS3L4b7uq6CLwof/bEvvbSEhVYxSqu0dNMANl1QIehqtwLigGBuggSCr1upM/0Id0rR4kSOOxnFDPyvmz1sBML8Z2BN0KtRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bvncTHAs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bvncTHAs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWpRQ6pS4z2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 21:32:02 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AL8Yc4I1404379;
	Sat, 21 Nov 2026 10:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=jdJKIgDv9dm6oaMmegLimaVtFd/s
	Q6zcQh3xk77sQmQ=; b=bvncTHAs1oGlMtquTJ4ok9dMVLc0y2uFNNfDYl7sytCJ
	PPqIT6led04a8dmRP3XJYeNHT9HPS4ZuuD+VVTwwsnrJ/dPWLWU79iI+k/f02lYh
	qjbxtUMvBNTQcLlJbC9f8YAlG2cVPpf2c9DkFbI2Swz9x/eCRQVQD78oomx07ryi
	8FB7Wu02UPHg+9QchdYzD1NZrYUxhc7xjhLZuZSU1GZkuCOASNHWfc0oslaFZ2kK
	B+RlicKOMlddxK4dOmNdRCFk5em+5ngdLjJ0II4UWZ4jD8/npbEeCiy41XLcDK8w
	jTRqUpqi7X+wW3Mlv3exN3pACDxkrg9h7yjP2FhAbw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fk18at-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Nov 2026 10:31:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AL8JMiu1440735;
	Sat, 21 Nov 2026 10:31:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j34n4s9xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Nov 2026 10:31:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ALAVcHb46924208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Nov 2026 10:31:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12D6D58063;
	Sat, 21 Nov 2026 10:31:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC8D58059;
	Sat, 21 Nov 2026 10:31:31 +0000 (GMT)
Received: from [9.43.78.55] (unknown [9.43.78.55])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Nov 2026 10:31:31 +0000 (GMT)
Message-ID: <cfa609ff-9ccc-417c-a816-56b364d0bf76@linux.ibm.com>
Date: Sat, 21 Nov 2026 16:01:29 +0530
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
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: christophe.leroy@csgroup.eu, gautam@linux.ibm.com, haoxiang_li2024@163.com,
        kmehltretter@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com,
        mpe@ellerman.id.au, nathan@kernel.org, naveen@kernel.org,
        nnmlinux@linux.ibm.com, npiggin@gmail.com, ritesh.list@gmail.com,
        sourabhjain@linux.ibm.com, sshegde@linux.ibm.com,
        yadavgaurav386@gmail.com
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.4-3 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA0MCBTYWx0ZWRfX9Q9Lj3pVN/Ca
 K3V7cdEIUoFla6SxX/Fy1K9FSTg4cvAKwCKRSJqR0IG8rj42+uMyg0WeWZ37elfV0TgugM+LCbz
 No5tLBi2FGf1GpT0iem3qclKdlDaTuGj+YViYSdfuO0cUVdgbPGYoe+HBTgfFZowCWoXFneTi/X
 a/0nGSzBaLHpOpNvGFHkVGfgPeIR4hX/AmTYZPdW4ixDT+jfw+Br4DjRSqOcqGs73l7JX28FRKW
 65qVgyKZrzvxxZov/hewOekpAop6UVjppqs429ttSokN0AD6NyORAQalQEBYVqF72yxgol8AOgD
 iBve3w5q1dR0BF24ZB4kWRVuKqpQrQqXfWe/ZaH98Q+1uE/O+UB/Nsdw/rSO+La5PyOqLutXY5l
 fcEZVPMvEJWfQbwt4wiPWbGnPgl6lwRMeGF5kOS0z9hRuspY25KCllQsCvZgUQmJghIeK3LTgxb
 vKG7TpUdQYXs/qqPMKA==
X-Proofpoint-ORIG-GUID: ZmTQZLLfdCAOmt6NIdtxa6FSK3HZobML
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA0MCBTYWx0ZWRfX2cvn2Uzz5nQR
 kNrPXQ37mUMA7YxGNFbfILBVMFHw/qajlkOkI0vcsa/5aSE4G5vUuYLYQ9MOIB4YY6yfMJP3PEO
 VKifS3D2kPbedF5KK03LrFpuV2UPPec=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b01730c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=74eMd-3HS0dJZZGCnroA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: G-q7SvJ_JzZQHtjS9b3gJ4RvrY9vDfwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210040
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull some more powerpc fixes for 7.4:

Notable out of area changes:
   MAINTAINERS: Update OCXL maintainer details # d836398542f1

The following changes since commit 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd:

   Merge tag 'mm-nonmm-hotfixes-stable-2026-11-18-00-06' of 
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2026-11-18 
09:51:04 -0800)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.4-3

for you to fetch changes up to bd6d2f87c2239d10bf5f37ab52b3968565528417:

   KVM: PPC: Fix TOCTOU kernel stack disclosure via kvm_run->mmio.len 
(2026-11-21 13:16:10 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.4 #3

  -  powerpc32/bpf: return false from bpf_jit_supports_fsession() on ppc32
  -  PPC32: Fix hard_irq_disable to follow tracing and lockdep state
  -  KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
  -  KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
  -  KVM: PPC: Hard disable interrupts before guest entry
  -  KVM: PPC: BookE: Use vcpu_err() instead of printk() in 
kvmppc_dump_vcpu()
  -  MAINTAINERS updates
  -  misc fixes and cleanups

Thanks to:
Christian Zigotzky, Dan Carpenter, Fabiano Rosas, Gaurav Yadav, Gautam
Menghani, Haoxiang Li, Karl Mehltretter, Mahesh Salgaonkar, Mukesh Kumar
Chaurasiya (IBM), Narayana Murty N, Nathan Chancellor, Ritesh Harjani 
(IBM), R
Nageswara Sastry, Shrikanth Hegde

- ------------------------------------------------------------------
Gaurav Yadav (1):
       KVM: PPC: BookE: Use vcpu_err() instead of printk() in 
kvmppc_dump_vcpu()

Gautam Menghani (1):
       KVM: PPC: Book3S HV: Use u8 to store guest's interrupt priorities

Haoxiang Li (1):
       KVM: PPC: Book3S HV: Clean up on uvmem initialization failure

Karl Mehltretter (1):
       powerpc32/bpf: return false from bpf_jit_supports_fsession() on ppc32

Mahesh Salgaonkar (2):
       MAINTAINERS: Update EEH maintainer details
       MAINTAINERS: Update OCXL maintainer details

Narayana Murty N (1):
       KVM: PPC: Fix TOCTOU kernel stack disclosure via kvm_run->mmio.len

Nathan Chancellor (1):
       powerpc/xmon: Avoid unsequenced accesses to tsk in show_task()

Ritesh Harjani (IBM) (7):
       KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
       KVM: PPC: Book3S: Don't call __ffs() on an empty 
pending_exceptions bitmap
       KVM: PPC: BookE: Don't call __ffs() on an empty 
pending_exceptions bitmap
       KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
       KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit
       KVM: PPC: Book3S HV: Fix error handling during vcore create
       KVM: PPC: Book3s: nestedv2: Free the guest state buffers if vcpu 
create fails

Shrikanth Hegde (3):
       PPC32: Fix hard_irq_disable to follow tracing and lockdep state
       KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
       KVM: PPC: Hard disable interrupts before guest entry


  MAINTAINERS                           |  4 +-
  arch/powerpc/include/asm/hw_irq.h     |  2 +-
  arch/powerpc/include/asm/kvm_host.h   |  2 +
  arch/powerpc/include/asm/kvm_ppc.h    |  4 +-
  arch/powerpc/kvm/book3s.c             |  2 +-
  arch/powerpc/kvm/book3s_hv.c          | 17 ++--
  arch/powerpc/kvm/book3s_hv_p9_entry.c | 13 +++-
  arch/powerpc/kvm/book3s_rtas.c        |  5 +-
  arch/powerpc/kvm/book3s_xive.c        |  2 +-
  arch/powerpc/kvm/booke.c              | 31 ++++----
  arch/powerpc/kvm/powerpc.c            | 82 ++++++++++++--------
  arch/powerpc/net/bpf_jit_comp.c       |  2 +-
  arch/powerpc/xmon/xmon.c              |  3 +-
  13 files changed, 101 insertions(+), 68 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmsBcpUACgkQpnEsdPSH
ZJRoBRAAr4kEXq/mAZ8qicAMEeHG38UnFob+0oSPSF3LjjtVTVOVS79AK0ifACRT
Xhph8Emwo9P3DQj1Hqc1pT/iFKdq2FBdszjfpa9VNbFYcdQ7PM59QcynpQKtACC/
wBcEMe9tEIEpDb3hNGVL1C7UCQHSLWdDp633C+WsjnuqpBKLBsauxM85BzAmcZGL
oUp5Pj5WfEAwfxJqMR//SX0uYBY4YAv9NnpNkHozYTK2W9nrFc4QHkpYqiKDS1cF
YlwgmDa8qTATlyLDFEr4oJ35FbqONqJLJbCXabKETspz9tAQD+SGzR8KSwC66lsO
SeG8W7r395sr3Tsy8MPOwZ/RxiN+sycDEVum/5cD8qAbZ7HP6o7IWHJHNyplw2Io
qgzMGApudGnuNsXmvV1/z2f4/ZeVg8v80sSQO27WyRcGe5/ttNTwr/vfX4MlrN/L
I++rnumuiBbmqTCiaCF+Mx5ndC9ZKovgU8TT5+FRyu4SDAXBJqNlPZw1ASb29g2O
vk7ZBnvDcZ1nFsKMetLBBcIBm2+59T0LE4bBISkeg/H0Fmy5rka19CgIqhCpPkF8
tsz7tm2yUahE8OKADqP7PerSAsdHjKeZrsO6PRVFDbR+7WD0YQpSakw5RuxXC2rD
P5LqD2OG5pZOsj+OMa3n6Dz9bT5PZqvhB9fPhXLvplZ/onCFOIg=
=JDbG
-----END PGP SIGNATURE-----

