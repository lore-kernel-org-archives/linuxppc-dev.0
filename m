Return-Path: <linuxppc-dev+bounces-28474-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF49CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:38:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvBRQ0nKHz2yvy;
	Tue, 29 Sep 2026 18:38:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790671138;
	cv=none; b=P9c7kkyqMW0JAWdsf3IbYMwW43zLML/j6kfqEqOXwH+NfV5WLWCRkPYcwwz84E2JYAjMjt6rTrT/Vq/g14x6x/k4imo/i/PsL9ntuYNvXebURzjFE2FGZE7i1S7RhdwacveQ0BN1/L6usOKzjp138KdrLbSAcaVnMuIqBgzCoRaE6eg31oJr1Ouk5XphJWJTMQHq4wwsUQJQy1J63eymuPiPMLt8jQtHXFo0PLA+hdTh1scPA9uUTc/TpcEJcs0koFNGhN1clK5njYZT/tvt8oDiTNM8DDepsLD7zMesiOZhSX2HEG3mDJ3BAWmCE7hQMFaMZGCuV4OVa+9KUxnW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790671138; c=relaxed/relaxed;
	bh=pe0XGgQPH2TCUWy6EpgQ8V8mBs24kQE8Z25hfhfzcak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+LEbgMW8/sDmG9sUmnp6fei1ii9P6pSeJ+TPVIyIEnU7tWb76ajXfxjlTu8lY0tFRjW6xHgmAn5BGorCglQaDTxgObb4jnqvfrfWvhK5fWsE4kAmLY0vSAMtOA6VLhePGfY4oaDGJFUgs/Di4M7bwV4UoFK50xnrlJaf5RVsGHWSBKeGFT+h1ohAYWnGK7QyEpeMf50PLJs/S07JN4YMbyr28x8WoujEgb2kCp0MHoy5H+jeAhz2aisJZq+u1swfSUwHQiitz5fHrePotCTfcgO+JArrbxxTLUk9oi35z6UgpsrSY7mU04au7kwM5qxshzViIBr/pmQ7y+UySdPLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LwPenIhO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LwPenIhO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvBRP2qpSz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:38:57 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46GN71209874;
	Tue, 29 Sep 2026 05:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pe0XGgQPH2TCUWy6EpgQ8V8mBs24kQE8Z25hfhfzc
	ak=; b=LwPenIhOBK2aZrRGPP6THX9ygEynagMiCopl9cF8mr52pVMZlKVoqmd00
	EtlxBQWJPpyQ72FYACEdn0pSqC9jzzrZvTulNe+OF8WtxOBm0Ms+VVDh0zOffcKb
	8Jj2ZtnBUpyOzuAN978AMjbnmFOG6xwvUtKp0TrnJZMUk9tTkgyMd9lYff1uYBIG
	wWAQwvDSIxJvVZh1qz6sYm/pwHmgi+58dI15geJ6klGI90KYNArY2WeZkFzKNaDi
	akn21jGufuO730qZCCA1tLAR/mjOMSxTQD9Ru2GRrqp7I/HL2LrphB4RndhrVagh
	J75l8o6LBG2dzGkuTmKo3wdlr/1Qw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr5cqx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:51:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4HeOm1184333;
	Tue, 29 Sep 2026 05:51:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcprk56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:51:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T5pmAJ50266582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 05:51:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31FDB20040;
	Tue, 29 Sep 2026 05:51:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2014520043;
	Tue, 29 Sep 2026 05:51:41 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 05:51:40 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: sv@linux.ibm.com, alexandre.chartre@oracle.com, alexghiti@rivosinc.com,
        aliceryhl@google.com, ardb@kernel.org, bp@alien8.de,
        chleroy@kernel.org, elver@google.com, ihor.solodrai@linux.dev,
        jpoimboe@kernel.org, kees@kernel.org, legion@kernel.org,
        lossin@kernel.org, maddy@linux.ibm.com, masahiroy@kernel.org,
        mpe@ellerman.id.au, nathan@kernel.org, npiggin@gmail.com,
        nsc@kernel.org, ojeda@kernel.org, peterz@infradead.org,
        pmladek@suse.com, rostedt@goodmis.org, tamird@kernel.org,
        thomas.weissschuh@linutronix.de, thuth@redhat.com,
        yuxuan.zuo@outlook.com, sourabhjain@linux.ibm.com,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v2 0/6] objtool: Fixup alternate feature relative addresses
Date: Tue, 29 Sep 2026 11:21:31 +0530
Message-ID: <20260929055138.43489-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX+nYf47CARK/c
 ymXPKD4poCVbwQ80zZzWG/0d5KO9uTi3th8SweXahuJDZLyna6Pm81Kh93aSiBZ6oN5myccePx6
 yRhiki4b5f/w3qX/n2kSvS1Y+JRxUr82shrl6/f4dmc2Po3WsUc1kVXJ1P3cC0bnwUSQT1/HWH7
 1oSi35IUzQGKulmnOz/BIjuSK9R0yY6NgBsKK7bbbLp2hkUJqeH83PX1tOPd8YSOoTZ65dg8M2e
 hMzjxmAyc5iCNVj6n1LWPRKKUDU0U8l8ccT5YfRWBSnsl/BKJmFZxbQp5wifomrEylwx6WEtIxJ
 iF4TpgnBQqVLr162PDpL6jooExZKmURp1d7j14WQ/+YTFsBcwyZQvXk5KBpcmfHrFDfP5o6JaoN
 HHqF/mlqz4BblfZ32SWykTNHkA70vGiijXhc7Uvmcq17twNTd42GMSqyoBW0CI6gbBEzXc/PR8e
 4sOUq0AcMqJfMlrmgAg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abb51fb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=voM4FWlXAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=IU41D-RyQVv7tfW9ZU8A:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: dhCZPIIybb4UzADOrbAVduzRf7RkoPXn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX8Z8SmxgUrjpd
 dya/fmRc9BnXt3ls+UzaFwv60pjvLXq/T02gO1xVf2atWLwiR01XzwDjbxnYWHcQsEzCf2mVSRx
 WDo3zdPIM/5n27gQ2PNX2JfW1AzF/tE=
X-Proofpoint-GUID: HtSyefSDlVC23X3uppAzHDijw2-OkAo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290022

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

--
Changes since v1: https://lore.kernel.org/all/20260505084628.17940-1-sv@linux.ibm.com/
- rebase to upstream master
- 1/6: in arch_decode_instruction() added comment describing opcode 16.
- 1/6: in arch_decode_instruction() added missing logic to add AA flag to offset.

Changes since RFC-v4: https://lore.kernel.org/all/20260316062237.30948-1-sv@linux.ibm.com/
- 4/6: In the instruction validation logic, update insn_call_dest() handling
  to allow unannotated intra-function calls when opts.ftr_fixup is enabled,
  and continue processing the instruction.
- 3/6: In the function processing logic, skip zero-length symbols before
  performing function boundary validation, as suggested by Sashiko.
- 3/6: In the function processing loop, add func_off to track the
  absolute/local offset and replace sym_for_each_insn() with an explicit
  loop.
- 1/6: In process_alt_data(), skip files that do not use opt.link.
- 1/6: In process_fixup_entries(), handle realloc() failure and return
  -1` when allocation fails.
- 1/6: In check_and_flatten_fixup_entries(), remove dead code that
  redundantly resets the fixup entry parent.
- 1/6: In is_local_symbol(), fix the local-symbol detection logic and add
  a comment explaining the new check.
- 1/6: In process_alt_relocations(), check that ftr_alt->data and
  ftr->data->d_buf are initialized before accessing them.
- 1/6: Remove redundant line deletions and perform minor cleanup.

Changes in V4:
- consolidate emit-relocs remove-section logic for
  CONFIG_ARCH_VMLINUX_NEEDS_RELOCS and CONFIG_HAVE_OBJTOOL_FTR_FIXUP
  configs as suggested by Nathan Chancellor.

Changes in V3:
- Split code into individual patches
- Put objtool call into cmd_link_vmlinux
- Move HAVE_OBJTOOL_FEATURE_FIXUP from arch/Kconfig to 
  arch/powerpc/Kconfig 

Changes in V2:
- Added implementation support for ppc64 LE, BE, ppc32 BE.

---

 Makefile                                  |   7 +
 arch/powerpc/Kconfig                      |   3 +
 arch/powerpc/Makefile                     |   5 +
 arch/powerpc/include/asm/feature-fixups.h |   2 +-
 arch/powerpc/kernel/vmlinux.lds.S         |   8 +-
 arch/powerpc/lib/feature-fixups.c         |  12 -
 scripts/Makefile.lib                      |   4 +-
 scripts/Makefile.vmlinux                  |  11 +-
 tools/objtool/arch/powerpc/decode.c       |  11 +
 tools/objtool/arch/powerpc/special.c      | 451 ++++++++++++++++++++++
 tools/objtool/builtin-check.c             |   2 +
 tools/objtool/check.c                     |  55 ++-
 tools/objtool/elf.c                       |   3 +
 tools/objtool/include/objtool/builtin.h   |   1 +
 tools/objtool/include/objtool/special.h   |  56 +++
 tools/objtool/special.c                   |  29 ++
 16 files changed, 632 insertions(+), 28 deletions(-)

-- 
2.54.0


