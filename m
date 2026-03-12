Return-Path: <linuxppc-dev+bounces-18088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9A1FED2EB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 08:31:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWgnD4sw2z3cFm;
	Thu, 12 Mar 2026 19:31:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773304272;
	cv=none; b=i7QzH/vX3YNYWiAjP5RfUyxgmMoX5cZ6hLP89D21hx1Kk4S6WcEPjbV9uSwO3BXZSnmvANBNZxzkZfT2vRwdWvtJGSaALEH3ucrPxkZlWwBThpZhEg09w7FNWxSK4UG70CeShuUigPRGvWFVzndfalM+rO1vRmAMiKMxwtWuYHhH+TPs52QQkLM6Oa2vtXN6V88YyTtvEBkxBVv4sKwDwq3Na+N+rx2wC/WuJ9PGnHuhLeCamdT+EK5MZiilAkU41T7biX6fMkOpyjgA7NZjoOB3qYRAkjeuTexiYKoYiRTSu/UuBQMCHIQRNJmIIm9jQ7w+XFDRuegwcJOnSrAMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773304272; c=relaxed/relaxed;
	bh=5ZH4PHkOHkDThWvmzwJcMgKyuSUPY6nsZTtq75SMCbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8MOoEy3hVoQOrZTVbct9Ry9XabhGGio7wo9EsSgQYY9PabtYC3O+pJ+Pi5Is2kWgPJ5CrURbaGkez95qt5yQV9o4IdhCcmf1tYDwKAli3h1tX8gQKLLnAe9fKGkTo9247rFsozL7vOFdVIJ0AVsVlwfG8/YR3V4w96C79bxfCXy0Hqk4rD08vex53ND49L1/RQkP34KlqQ6ARtrCcQmpD1tEUGJwP+Q46cP5H5EGKSBUy3OWtNKdAtbtdql2aIpwSnoPBCWxaUVpQIs2im5+hMUKdh01UAxzMQ6L+8NvitRz7dtNK1pG9I7z8B6K0cHrXIYPU5mqQ/lbm2kz+BcCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OApxvjK/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OApxvjK/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWgnC4kVZz3cFN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 19:31:11 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWDe62306667;
	Thu, 12 Mar 2026 08:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5ZH4PHkOHkDThWvmzwJcMgKyuSUPY6nsZTtq75SMC
	bo=; b=OApxvjK/d0qKkx1bvXKXoKevLXjjlRjPyLI7zYS4JE6zzkAfjRdssbQCx
	pO0/MkSNqGIvgvHnIbRW85zWPeyZHt83grCq7++kX3LbmAbIm//4nd5hzkyJ+Prj
	jruea+BqRXx49AEb6ytFVzFq2ewhBdrFsKUdaQS1H0QWpjRm1F9tQe+i1EwdX3+k
	YC01yeneJ7736YlX5xDN9LKoZDf0kWsEoDfkETzmMhJLcLlcMPZu3dFFpWVw2v3f
	nYIw3Ls+8Dm9EkNMFZKSpeTKWVqJCJcQuQDUglbcbP4x23Ej46N9AGGHH6bFAnDE
	+OoVrs1l6npFalINM2JEHOtbu4oig==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh969nr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:31:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C4JH2F006563;
	Thu, 12 Mar 2026 08:30:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9hk5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:30:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62C8Ut7r49545474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 08:30:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCF2F20043;
	Thu, 12 Mar 2026 08:30:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92D6F2004B;
	Thu, 12 Mar 2026 08:30:53 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 08:30:53 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>
Subject: [PATCH v3 0/2] powerpc/crash: backup region offset update to eflcorehdr
Date: Thu, 12 Mar 2026 14:00:48 +0530
Message-ID: <20260312083051.1935737-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2MyBTYWx0ZWRfX5vsIj0tq2mww
 vrcRE7YQESqjy1xtIOkLj82b2PjGLWD+bKJ7wwKjXb9P2FEq7wcI4a1uKG0fFbx7rNR7GA4G9sA
 L+QNuF8IdU8EfsQVKMcAXwgIznZKdcI9/zRreeAXkLzIx8/Wbp8TCzqOiLexdRo0rIY7Uuxyu5L
 fQeZBR3rSpFxFkcq3LXL51spK0ihpnXAOm79gOezUVJnlw42qmFIcRrt3A3sPzX7VQGsn/78c3I
 3x0OInOnoKOqijiEBzAW2sNvgO39HKsfrf20a3yMgxJZDySYFcXgz9jzlqVeNYtYaM7C33ExL08
 VlYeeEIu5wqmCfHwGUaB+iyuTFnnuVTptSL4lf9S+qHXt8ZEuQcKW439utwXFmC2vYQQKU3hguu
 MhRd3ahLKNSdpgDPpCcDXk0bdNVZXQ6HxhTT/AA4AT0LSBixbd/L/N0qzfwEgfrQGNpPFRNvB9/
 SkcfwT5D3b14cz7N59A==
X-Proofpoint-ORIG-GUID: B9orIwc-jf-_lhJxxSa8Eozrr_aAYhyV
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b279c4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=h0ihOahIyXu_IyCkdeYA:9
X-Proofpoint-GUID: JKIPdl1NfbPaQNJve4H8G8JcOFgZTldX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120063

On a kernel crash, purgatory copies the first 64 KB of the crashed
kernel memory to the backup memory region reserved within crashkernel
memory for the kdump kernel. This ensures that the capture kernel can
use the first 64 KB of memory to place the exception vectors and other
required data.

However, in the elfcorehdr prepared using the kexec_file_load syscall,
or the one recreated during a memory hotplug event, the offset of the
program header representing the first 64 KB of memory is set to 0,
whereas it should point to the backup region.

This has not caused issues so far because the first 64 KB is usually
identical in both the crashed and capture kernels. However, this is
only an assumption and is not guaranteed to always hold true.

Therefore, update the offset of the program header representing the
first 64 KB of the crashed kernel memory in the elfcorehdr prepared for
the kdump kernel.

Testing:
=======

Git Tree: https://github.com/sourabhjains/linux/commits/kdump-backup-region-offset/

The above tree contains an additional patch that introduces a new sysfs
interface to dump the kdump elfcorehdr to the dmesg/console.

$> cat /sys/kernel/kexec/crash_elfcorehdr_print 
ELF Program Header Summary:
  Total Program Headers: 13 (0xd)
  PT_LOAD segments:      4 (0x4)
  PT_NOTE segments:      9 (0x9)

Program Headers:
Index Type               Offset             VirtAddr           PhysAddr     FileSize     MemSize  Flags   
================================================================================
0x0   PT_NOTE            0x3fd966400        0x0                0x3fd966400        0x218              0x218              ---
0x1   PT_NOTE            0x3fd996400        0x0                0x3fd996400        0x218              0x218              ---
0x2   PT_NOTE            0x3fd9c6400        0x0                0x3fd9c6400        0x218              0x218              ---
0x3   PT_NOTE            0x3fd9f6400        0x0                0x3fd9f6400        0x218              0x218              ---
0x4   PT_NOTE            0x3fda26400        0x0                0x3fda26400        0x218              0x218              ---
0x5   PT_NOTE            0x3fda56400        0x0                0x3fda56400        0x218              0x218              ---
0x6   PT_NOTE            0x3fda86400        0x0                0x3fda86400        0x218              0x218              ---
0x7   PT_NOTE            0x3fdab6400        0x0                0x3fdab6400        0x218              0x218              ---
0x8   PT_NOTE            0xa2c0000          0x0                0xa2c0000          0x10024            0x10024            ---
0x9   PT_LOAD            0x1af40000         0xc000000000000000 0x0                0x10000            0x10000            RWX
0xa   PT_LOAD            0x10000            0xc000000000010000 0x10000            0x17ff0000         0x17ff0000         RWX
0xb   PT_LOAD            0x2ec70000         0xc00000002ec70000 0x2ec70000         0x1390000          0x1390000          RWX
0xc   PT_LOAD            0x58000000         0xc000000058000000 0x58000000         0x3a8000000        0x3a8000000        RWX

So, once kdump is successfully loaded using the kexec command,
for example:

$ kexec --initrd=/boot/initramfs-`uname -r`.img /boot/vmlinuz-`uname -r` --append="`cat /proc/cmdline`" -pds

Running cat /sys/kernel/kexec/crash_elfcorehdr_print prints the
elfcorehdr in the above format. The offset of the program header
representing the first 64 KB can be easily observed.

Changlog:

v1:
https://lore.kernel.org/all/20260303134722.2814049-1-sourabhjain@linux.ibm.com/

v2:
https://lore.kernel.org/all/20260307052102.944952-1-sourabhjain@linux.ibm.com/
 - Fix build error: 'struct kimage' has no member named 'arch'
   How?
   Define ARCH_HAS_KIMAGE_ARCH and struct kimage_arch when
   CONFIG_KEXEC_FILE or CONFIG_CRASH_DUMP is enabled so that
   kimage->arch.backup_start is available with the kexec_load syscall.

v3:
- Fix a typo in a commit message 01/02
- Add a comment for a helper function in 02/02
- Add Reviewed-by tag
- No functional changes

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Aditya Gupta <adityag@linux.ibm.com>

Sourabh Jain (2):
  powerpc/crash: fix backup region offset update to elfcorehdr
  powerpc/crash: Update backup region offset in elfcorehdr on memory
    hotplug

 arch/powerpc/include/asm/kexec.h  | 14 +++++--
 arch/powerpc/kexec/crash.c        | 64 +++++++++++++++++++++++++++++++
 arch/powerpc/kexec/file_load_64.c | 29 +-------------
 3 files changed, 76 insertions(+), 31 deletions(-)

-- 
2.52.0


