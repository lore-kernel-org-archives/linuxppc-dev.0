Return-Path: <linuxppc-dev+bounces-20447-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE706FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 08:47:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8sZt36RSz2xMV;
	Tue, 05 May 2026 18:47:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777970838;
	cv=none; b=JE6dGpLJLRLEm23vW5ZYrvTETB4AGrnOKq/xMzmaHTNEKPLzD4A4Y06BVihr7+yDap9XOb6YAHhew+jO9nx+xfNl281FND2uJja8EdzsdHOWP0JnzcLEYbBXOGeVj7I13fGhs7/GCke5eSOJRcTBKykok1OwL3iR2UCmyHxJvratPFBe7mo+XUctZJIw5e9RDvHZbq3MOiJgMyrvmhWJf6aOVOBXXDW13gjcTH2KU50E+WBPC7fhTR6fsys4bxrF1no45qUYG+YRsWDyMHjBZcEFkPJyn5+OGsH/ctbS5oqbR8s9ByVeCKzzEATRGE4q5/Or+6M/PEWIJz1XGwCIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777970838; c=relaxed/relaxed;
	bh=5Na7IXRZ/72oLwytpx60uSxkDXqVGppe5KHvcHFGxxg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NqGtKJYg35FdCTqSMMTNc+jE+NUw8hR+cDZahHByqfueD1n69pTLw84h6jUppqAWsr+/gsoS9BFHvBfJ0V/K4szbqR1XB4KJfwClSP6SeTrAjrkE2bI+Ics9rFbVtHVeue5Fe2ZYLqqOzFeFFdvkGchqG7AURDgWf1G19nviPFI0y8/Kcux1TMCYIHinAETsm7ETihvW+epa/qY+E0Jh4joc/3ZpqNyflxlnbQbGxpO7YmF7y5cm2AQx/LCef1O9XlebL4KPIowuzqbRdHepLmjp+cnbOnVFCLKE+hirY4H3Vme4nGCHfvUbbzd3MGxNxlOPykRjuvA5EK20WwushA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y+OUpNYa; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y+OUpNYa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8sZs0CQ6z2xGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 18:47:16 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645681db2606962;
	Tue, 5 May 2026 08:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5Na7IXRZ/72oLwytpx60uSxkDXqVGppe5KHvcHFGx
	xg=; b=Y+OUpNYamjvhwIVM3nU9Zmgp4MPiyqawiP56HvLbVMcQmc8ZWYcM7rUOG
	3wZ7y6KfB8yzA/lRa+qQdefUgnbBWhnYeXAbq2TGGJMWjCyKQopAMjOScf2z8hsf
	gvW/YQ2IzwH6yp2wDHDKWjBxvHB7eng5CWLhngOdOFFNUbAf2qsEXIjWcMDKR5FA
	Jz5/QYAvwTsO+EacXLo83Q0gXbdkifWwQlDGv7GvfZVkoDnbKua8UE0vzSM+FfdO
	evZkmtGs5RSovLFGtATk4T+sZ66XyPvHweHfIiUJrWYAavgpHLhShp8RHuKKXUQO
	qfplAaA8VT6rjLd5V/PHxaQhAmA5Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7asb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:46:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6458dRQL032044;
	Tue, 5 May 2026 08:46:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg8mra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:46:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6458kc1D41156930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 08:46:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF2AC2004B;
	Tue,  5 May 2026 08:46:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43D8020043;
	Tue,  5 May 2026 08:46:33 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.bl1-in.ibm.com (unknown [9.123.13.4])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 08:46:33 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: nathan@kernel.org, nsc@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org, ojeda@kernel.org, masahiroy@kernel.org,
        lossin@kernel.org, tamird@kernel.org, thomas.weissschuh@linutronix.de,
        rostedt@goodmis.org, ihor.solodrai@linux.dev, thuth@redhat.com,
        pmladek@suse.com, aliceryhl@google.com, elver@google.com,
        kees@kernel.org, legion@kernel.org, ardb@kernel.org,
        yuxuan.zuo@outlook.com, alexghiti@rivosinc.com,
        alexandre.chartre@oracle.com, bp@alien8.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sv@linux.ibm.com
Subject: [PATCH v1 0/6] objtool: Fixup alternate feature relative addresses
Date: Tue,  5 May 2026 14:16:22 +0530
Message-ID: <20260505084628.17940-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA3OSBTYWx0ZWRfXyVA3d8v0trbM
 d7nkiFJsjKkGzeBpgKeLFu1VAwSrQfI3sUOMRYQ5Ecr1NyEZzPv+1NLwl5sACrZzFeL5DKoosV2
 ycSD2yQTkF+pf6uyrkpwF9Ayee3x/7kC23kxyJZZwigYwtIcKI9UpSZ6yvLb7/gKpuE31zbW8rd
 nePAlTYzgMG/hqWbIZGLXQs9Ap1OGy/kaAT4OeMbPEU+jm7SnqtRG2mRjSnRz/yMLFuCCuet/Dr
 zahoIxz5MFbu/c/N0vWzYebVeC+dkHUhu/8FUpoj9nCNjT0UpNlTHnhq51SQY2MMzrkX0+1MIww
 s/P19W14p6SLyX3McO2uWee7kGloovat1ioLb3Uvv+Tz0SqVs5HMJQNkaQsaSNXmMHwyNzC9A0w
 JAIC3XqGrSs2maxRoA8OZUH0VfqDYwbWOA2TQgXvS8d1RGuy6lYy1E/kbxzIMyXWEFhOho8v0tF
 G/GgWlRD9hwWw8LZpBg==
X-Proofpoint-GUID: Z9Zlm4gkl6emT9XnCkYhJmZ5Hd4YWJxK
X-Proofpoint-ORIG-GUID: DWXbNVg7f_Y1MF2SOnkRAES5Xx0kuGIs
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f9ae74 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=voM4FWlXAAAA:8 a=pGLkceISAAAA:8
 a=6NrjVYLyXoVgFYLQaH8A:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050079

This patch series implements build-time fixup of alternate feature
relative addresses for powerpc.

Previously, Nicholas Piggin proposed a build-time solution using a
custom PowerPC tool [1], which provided the foundation for this approach.
The current implementation leverages objtool's existing ELF parsing
infrastructure to do the same.

This patchset applies atop powerpc/merge branch.

[1] Original PowerPC tool approach:
    http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20170521010130.13552-1-npiggin@gmail.com/

Testing:
Build and Boot tested on ppc64le, ppc64be, and ppc32be configs.

Sathvika Vasireddy (6):
  objtool/powerpc: Add build-time fixup of alternate feature branch
    targets
  objtool: Set ELF_F_LAYOUT flag to preserve vmlinux segment layout
  objtool: Fix "can't find starting instruction" warnings on vmlinux
  objtool/powerpc: Skip jump destination analysis and unnanotated
    intra-function call warnings for --ftr-fixup
  kbuild: Add objtool integration for PowerPC feature fixups
  powerpc: Enable build-time feature fixup processing by default

 Makefile                                  |   7 +
 arch/powerpc/Kconfig                      |   3 +
 arch/powerpc/Makefile                     |   5 +
 arch/powerpc/include/asm/feature-fixups.h |   2 +-
 arch/powerpc/kernel/vmlinux.lds.S         |   8 +-
 arch/powerpc/lib/feature-fixups.c         |  12 -
 scripts/Makefile.lib                      |   4 +-
 scripts/Makefile.vmlinux                  |  11 +-
 tools/objtool/arch/powerpc/decode.c       |  15 +-
 tools/objtool/arch/powerpc/special.c      | 451 ++++++++++++++++++++++
 tools/objtool/builtin-check.c             |   2 +
 tools/objtool/check.c                     |  57 ++-
 tools/objtool/elf.c                       |   4 +
 tools/objtool/include/objtool/builtin.h   |   1 +
 tools/objtool/include/objtool/special.h   |  56 +++
 tools/objtool/special.c                   |  29 ++
 16 files changed, 637 insertions(+), 30 deletions(-)

-- 
2.43.0


