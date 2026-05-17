Return-Path: <linuxppc-dev+bounces-21008-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0A0CD4F47
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 17:40:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJSrx4cpZz2xfB;
	Mon, 18 May 2026 03:40:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779039649;
	cv=none; b=lQ8FzT4I812YY7ou8UFLmfvxo2QCzoxgr10gmpaLkqY8paQBZ71DRYU/h4mDqEk1MfZwJr/3VXvDnmLLcCuijJDzl2qhee99H3QyHkf8KXzJqlKmyGHfqNdFWp125D+FWWVmrg0UuQHjbWBufUxgwLXYjw/DfX9wYf8OKKmcQSirUaw7q+KdmUq0swoW3MKAT21pRC2mKKJL1egMHToawYRQXyafZKdohQ5v8U+cejG1sO4v5aC8ddjrFbi0rWuh9eU5U2amtVzbB2OKbM7k0nQg6yIbgwFpR/CbMa5nNGFfuNZPX0t55PAS0vwMSKiuwT7nIy74h2rppTuN83eQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779039649; c=relaxed/relaxed;
	bh=QdWsGgPZ5jZnC7RWqDFsCAd/CZNEz7qUwHdyKk6WXF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwhSt6XdR1om748VPl6Cg0YaVJSfKkjquVeGqYSpPP0w6ijZVIStradWhEWlydjV6ltYDeB1RlU3J7MVzWYfOLTkCn0ihKH+t8DkjKXXOz4/3/DLD5EsigpV2gduPD3Gjm7MAdQ1pG31Ve3GKqlzsN4ojlKEcdJEM5+mkp/V7eQoHQguGKaVU7kyDOlnvFQoKDYu+ynxU6Ds7zP7SEQb8wUY5qKyWeJ8HLl74zt0ctLQnD38sJXBGH9FvFut9KVf4v8uECc9bR0KfFIAjDj8/GgxgSMJba6bxk84oWEDzQMrbGhlAYtl7QT/Wj3JwS+u/P9AcmjC3aNetIU9+kRsVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Az7DPPiM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Az7DPPiM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJSrv6l24z2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 03:40:47 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HBuOJo3974750;
	Sun, 17 May 2026 17:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QdWsGgPZ5jZnC7RWqDFsCAd/CZNEz7qUwHdyKk6WX
	F0=; b=Az7DPPiMcSBmuiGhOXXKNmQyB/qxsh3//V8A57MsxxzijA2drRuWv8YZF
	wo8ETdX0svpPXYwvYqsHPL6T1PVyiNwImYQKe5QAKXt3WjO3IEz8tK8UBGwNgseZ
	1UvkCrKDRxhcPb5OlJ6MPRYEtmlHGvqMGolMf0FV1LPluEYgaIzc3FQ7x6SCI9cO
	+NwWzxEPCHWt7iF/q+vwsyxRb1u6PjKafjQ2EncbrUNVlbKl+h46kpfgTqir8nyO
	18OzLULxA5JM8cfaWvgI9Dhcl9j32Y1LAVXA0YF8Xt/pYCnV+HahBtvcVPCzTZw1
	KQZ38hNOSHcIN3LykkJZ4RXzak01A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mcng4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64HHd7rC021278;
	Sun, 17 May 2026 17:40:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vjj97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64HHePWm36897172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 May 2026 17:40:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE9F02004E;
	Sun, 17 May 2026 17:40:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E22FB20040;
	Sun, 17 May 2026 17:40:22 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 17 May 2026 17:40:22 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v4 0/5] powerpc/bpf: Add support for verifier selftest
Date: Sun, 17 May 2026 17:40:38 -0400
Message-ID: <20260517214043.12975-1-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: QYIM5TJUb7Ati4bexMi3mbR5wKG_43RZ
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a09fd8e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UrLCjDVe54a93DmA31EA:9
X-Proofpoint-ORIG-GUID: QYIM5TJUb7Ati4bexMi3mbR5wKG_43RZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5MCBTYWx0ZWRfX1EnRNxeyankE
 JpGSI4w4ct0JNE/Jsnk3bQ4Omgi4lmnEOR/S87mRKf8Oh2H/JGvePQ7m+JR4Wcst1mmzKyYh23h
 /yRTyYaeDVVwP7kvppFdmRommAZu/FoLXLAWG5Uiei7+wZ0A4NrOdCosiu3IQU+uZU7HHMBXKLh
 +4yfSc24+KTR1unUyGyErinlYZIOnpA/v489KJgDBkd/m4F0P4zd8RbFggDYZZnwl3QcdZmv4Et
 pvNSm2EwHWFCk3fwEj+PvqFzvung/1wH+2naWlyDrXYxlx2SyeB4LnOjy4C6p4uIrMrZv3YLlGa
 Y10+QyAbpioQEIaZX6ZQVOWX0XHa34pKZtrWEDSxxsDqwWGFeBwoBwSm5SgdL1Jtdg+k/cD0Zvv
 DoNWH53WV9nEuO9+oCsfARkEv+DLcBnTDGqmq82c3ZvSFkSkmh5Rse9NiJl/0t7+hF3UOAxnCTE
 X/cEthHbgYOCovJmeJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170190

From: Abhishek Dubey <adubey@linux.ibm.com>

The verifier selftest validates JITed instructions by matching expected
disassembly output. The first two patches fix issues in powerpc instruction
disassembly that were causing test flow failures. The fix is common for 
64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
architecture tag in the third patch, enabling proper test filtering in
verifier test files. Introduce verifier testcases for tailcalls on powerpc64
in the final patch.

The first patch in series is fix patch, correcting memory alignment with
8-byte boundary for long branch trampoline address. The subsequent
patches enables verifier selftests on powerpc.

Issue Details:
--------------

    The Long branch stub in the trampoline implementation[1] provides
    flexibility to handles short as well as long branch distance to
    actual trampoline. Whereas, the 8 bytes long dummy_tramp_addr field
    sitting before long branch stub leads to failure when enabling
    verifier based seltest for ppc64.
    
    The verifier selftests require disassembing the final jited image
    to get native instructions. Later the disassembled instruction
    sequence is matched against sequence of instructions provided in
    test-file under __jited() wrapper. The final jited image contains
    Out-of-line stub and Long branch stub as part of epilogue jitting
    for a bpf program. The 8 bytes space for dummy_tramp is sandwiched
    between both above mentioned stubs. These 8 bytes contain memory
    address of dummy trampoline during trampoline invocation which don't
    correspond to any powerpc instructions. So, disassembly fails
    resulting in failure of verifier selftests.
    
    The following code snippet shows the problem with current arrangement
    made for dummy_tramp_addr.
    
    /* Out-of-line stub */
    mflr    r0  
    [b|bl]  tramp
    mtlr    r0 //only with OOL 
    b       bpf_func + 4 
    /* Long branch stub */
    .long   <dummy_tramp_addr>  <---Invalid bytes sequence, disassembly fails
    mflr    r11 
    bcl     20,31,$+4
    mflr    r12 
    ld      r12, -8-SZL(r12)
    mtctr   r12 
    mtlr    r11 //retain ftrace ABI 
    bctr

    Consider test program binary of size 112 bytes:
    0:  00000060 10004de8 00002039 f8ff21f9 81ff21f8 7000e1fb 3000e13b
    28: 3000e13b 2a006038 f8ff7ff8 00000039 7000e1eb 80002138 7843037d
    56: 2000804e a602087c 00000060 a603087c bcffff4b c0341d00 000000c0
    84: a602687d 05009f42 a602887d f0ff8ce9 a603897d a603687d 2004804e

    Disassembly output of above binary for ppc64le:
    pc:0     left:112    00 00 00 60  :  nop
    pc:4     left:108    10 00 4d e8  :  ld 2, 16(13)
    pc:8     left:104    00 00 20 39  :  li 9, 0
    pc:12    left:100    f8 ff 21 f9  :  std 9, -8(1)
    pc:16    left:96     81 ff 21 f8  :  stdu 1, -128(1)
    pc:20    left:92     70 00 e1 fb  :  std 31, 112(1)
    pc:24    left:88     30 00 e1 3b  :  addi 31, 1, 48
    pc:28    left:84     30 00 e1 3b  :  addi 31, 1, 48
    pc:32    left:80     2a 00 60 38  :  li 3, 42
    pc:36    left:76     f8 ff 7f f8  :  std 3, -8(31)
    pc:40    left:72     00 00 00 39  :  li 8, 0
    pc:44    left:68     70 00 e1 eb  :  ld 31, 112(1)
    pc:48    left:64     80 00 21 38  :  addi 1, 1, 128
    pc:52    left:60     78 43 03 7d  :  mr    3, 8
    pc:56    left:56     20 00 80 4e  :  blr
    pc:60    left:52     a6 02 08 7c  :  mflr 0
    pc:64    left:48     00 00 00 60  :  nop
    pc:68    left:44     a6 03 08 7c  :  mtlr 0
    pc:72    left:40     bc ff ff 4b  :  b .-68
    pc:76    left:36     c0 34 1d 00  :
    ...

    Failure log:
    Can't disasm instruction at offset 76: c0 34 1d 00 00 00 00 c0 a6 02 68 7d 05 00 9f 42
    --------------------------------------

    Observation:
    Can't disasm instruction at offset 76 as this address has
    ".long <dummy_tramp_addr>" (0xc0341d00000000c0)
    But valid instructions follow at offset 84 onwards.

    Move the long branch address space to the bottom of the long
    branch stub. This allows uninterrupted disassembly until the
    last 8 bytes. Exclude these last bytes from the overall
    program length to prevent failure in assembly generation.

    Following is disassembler output for same test program with moved down
    dummy_tramp_addr field:
    .....
    .....
    pc:68    left:44     a6 03 08 7c  :  mtlr 0
    pc:72    left:40     bc ff ff 4b  :  b .-68
    pc:76    left:36     a6 02 68 7d  :  mflr 11
    pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
    pc:84    left:28     a6 02 88 7d  :  mflr 12
    pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
    pc:92    left:20     a6 03 89 7d  :  mtctr 12
    pc:96    left:16     a6 03 68 7d  :  mtlr 11
    pc:100   left:12     20 04 80 4e  :  bctr
    pc:104   left:8      c0 34 1d 00  :

    Failure log:
    Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
    ---------------------------------------
    Disassembly logic can truncate at 104, ignoring last 8 bytes.

    Update the dummy_tramp_addr field offset calculation from the end
    of the program to reflect its new location, for bpf_arch_text_poke()
    to update the actual trampoline's address in this field.

    [1] https://lore.kernel.org/all/20241030070850.1361304-18-hbathini@linux.ibm.com

v3->v4:
  Changed logic for emitting alignment NOP

v2->v3:
  Removed fixed NOP from bottom of long branch stub
  Rebased on top of bpf-next

v1->v2:
  Added fix-patch to correct memory alignment in-place
  Moved the optional alignmnet NOP before OOL stub

[v1]: https://lore.kernel.org/bpf/20260225013627.22098-1-adubey@linux.ibm.com
[v2]: https://lore.kernel.org/bpf/20260403004011.44417-1-adubey@linux.ibm.com
[v3]: https://lore.kernel.org/bpf/20260411221413.44304-1-adubey@linux.ibm.com

Abhishek Dubey (5):
  powerpc/bpf: fix alignment of long branch trampoline address
  powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
  selftest/bpf: Fixing powerpc JIT disassembly failure
  selftest/bpf: Enable verifier selftest for powerpc64
  selftest/bpf: Add tailcall verifier selftest for powerpc64

 arch/powerpc/net/bpf_jit.h                    |  4 +-
 arch/powerpc/net/bpf_jit_comp.c               | 60 ++++++++++++----
 arch/powerpc/net/bpf_jit_comp64.c             |  4 +-
 .../selftests/bpf/jit_disasm_helpers.c        | 13 +++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
 .../bpf/progs/verifier_tailcall_jit.c         | 69 +++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  5 ++
 7 files changed, 136 insertions(+), 20 deletions(-)

-- 
2.52.0


