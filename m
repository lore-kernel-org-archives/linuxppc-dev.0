Return-Path: <linuxppc-dev+bounces-25557-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F7BC5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:43:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGj2W32sKz3c2h;
	Fri, 07 Aug 2026 21:43:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786102995;
	cv=none; b=WR/oR/tN5r5lFpnGB4kmbTBban6ZE+L7KmUMERBtd0KqcD2qJ4mMEyjMZQh5HmQVzXbeEK/pMU3iGxJF3D4/h02ZSCGSMvw01mWzJewMBlhfGt1NolOQA0zwg2EUrrJqwzH6cZ4iGuihPd9fy4PcrrZvHKAWvCiy+EGpI3A6a+1qW+vbFZ0WeSRzcfSjtf2gmMLqRbCGITuZxlxzzcHYt98uwRKPUOqHWrBWHlNKys7TZT5Tan/okOFAPeF7aw/bv5RX7ZHgd6cn5i07olMo+8o4rSqZ/XUxIOk5TR8KnB7Tex/mHsnjle3v8wmBLHjF10eF8X+vktz+aoWANhpgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786102995; c=relaxed/relaxed;
	bh=EV1+fR08bAmo2EeMY58QqpN6yZosr/TaKNchy8kJnMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLcwQF/nZBIs6mVm6HYInaPwOGqL5TCVbp8gxaN1RPY+tXqZAp/GUgLME80QADOsjuFlqDajdoXxOyMIHoIBJuZ0F1umXGLtV0ojfsap0KSOgyXe3amHax9eDAGP/axLGPQqrCOGzZcWZnjBFgdWS3abqUM0nXww38RieTGL6gbAKHHZA5Vh/yvofhg/F3HDSl1qkDTnqaj54QC9oty6w7oIfjMTDWO0RAtcOZoxd3EGOMcjBYMttZM5mk22XBhXxrJ9781P5ly8IyCTAShHpdD8uqZ+eNTagpyR/uDoLwgZmZ8O51YBghAD+6FRTpBvmd9xGatkOwjTjWcRcUhe7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tSIHHdMX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tSIHHdMX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGj2V0MhVz3c2P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 21:43:13 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770JZlC4064146;
	Fri, 7 Aug 2026 11:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EV1+fR08bAmo2EeMY58QqpN6yZosr/TaKNchy8kJn
	MM=; b=tSIHHdMXFB6y0S1B/5IaXUtGsCdJICN/1XgwJiccDpKJV0ajfXdJjL+71
	5WpNEWE2jY4q5cpeyyBPTopTck4R1x6AWZOc+BblyOLQCkLCa0a0hNhwvnpaM4gV
	jb0bgGLH28jFvpLH767rVcv5o/ApI2XoBf/nXhlecP4k9zz1U0TWhlH1Oy48Kphw
	5EsNdsBLZ/ld8b5nNqi43HE7u0CvtJx7tXvWBUP5//iA7SoufTncDHVh2ihPfjL9
	J9tJZ8ay+VAyx+KbgrHclgtJBjfnAZI+MsoGRlDNVpmpnkFj/JKd5IRPsjKChZjH
	rNbt+GLfI0M4nncSH2hZvoA5QCqlA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02bjb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:42:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BfGjx005743;
	Fri, 7 Aug 2026 11:42:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgqa6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:42:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BgmBV43450878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:42:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2AD72004B;
	Fri,  7 Aug 2026 11:42:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B2A20043;
	Fri,  7 Aug 2026 11:42:44 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.23.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:42:44 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v11 0/8] powerpc/bpf: address missing verifier selftest coverage
Date: Fri,  7 Aug 2026 17:12:35 +0530
Message-ID: <cover.1785871099.git.skb99@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75c4be cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=N7QzuYTHEryR9oxcy7gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX7Qq1soX7CbC6
 6BZjQ0eamnBKOI3wGYponX/0m93lnWzzTfxG5MMs3LMQxSkYpQPhMvBRMjmPxi3t12P9roUL8Bm
 magaEH/gIWK3KPXFxgiSC2OgsJPNXf6DRGAXYiaWnq8KcmUcVu1YYB67918L418UgYtjlnpVgWC
 Tc1Qn2m51u5r/pKyXAAoq305VetvZYhPpoAnaBHHWsmK6qBa3CIs8lyjOoZwhU9QaGYfKAgdeXB
 SmjoSFUUFHfxjgqMHMafkNKBN3HehkUUM6Gb96Pq7SDiaUSgOsUrHm9zCyK+z4G8HoSXvFhXlbz
 eFyjgCyrLImHFLl7vVSrQ+BOPRgBJEzw66Vf79GJjlI2/VV1eemu24A6BTPcVQXTahebA/0oUoS
 ZxWamZlIwxRrWXo07z30gClOr73T/wd12eUPKraxr0lKHx2z77eSCUPYqykTTI1TtEPINIur563
 sZNyeQa+EvhNUfyxOWg==
X-Proofpoint-ORIG-GUID: 2Kb4iY4IJAnu31pkrYjuXNWhMmFYU9yK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfXxnK00vI+VdXA
 9KEsLw7aYeZJOdv7Rf71vnU3jXCH02Lu+aI31pyiIfVXG4whApQ+72fIEGQbie6lrw3Ab69Tfol
 i+j0BUljDYfiSXUGMsHTjrr+SItQi6w=
X-Proofpoint-GUID: 2Kb4iY4IJAnu31pkrYjuXNWhMmFYU9yK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070087
Message-ID: <20260807114235.fnfFpb3oRhGqxOZoV_aG21fhBNSreXLZO0WpUPqB65c@z>

From: Abhishek Dubey <adubey@linux.ibm.com>

The verifier selftest validates JITed instructions by matching expected
disassembly output. The first two patches fix issues in powerpc instruction
disassembly that were causing test flow failures. The fix is common for 
64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
architecture tag in the third patch, enabling proper test filtering in
verifier test files. Introduce verifier testcases for tailcalls on
powerpc64.

The first patch in series is fix patch, correcting memory alignment with
8-byte boundary for long branch address field. The subsequent patches
enables verifier selftests on powerpc. The fifth patch in the series fixes
incorrect comparator usage for comparing tailcall info with tailcall
threshold. The last two patches fix JIT buffer overflow for large BPF progs
and private stack memory leak (identified by bot during reviews).

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

v10->v11:
  Moved function prototype change from patch 2 to patch 1
  Fixed commit message for patch 1 and patch 4
  Fixed extable entry generation condition
  Added reviewed and acked tags by Hari

v9->v10:
  Modified expected JIT instruction in selftest for
  CONFIG_PPC_KERNEL_PCREL incase of PPC_LI64 instruction.
  Fix for stale entries in exception table 
  Update ARCH_POWERPC64 enum value to 0x40 to resolve rebase
  conflict with ARCH_LOONGARCH (0x20).

v8->v9:
  Dynamic pass handling until code keeps shrinking
  Fix private stack memory leak

v7->v8:
  Fixed bot identified issues of alt_exit_addr and BPF_EXIT
  Fixed 32-bit ppc function signature mismatch

v6->v7:
  Fixed JIT buffer overflow in case of large BPF progs
  Addressed remaining bot comments

v5->v6:
  Changed alignment NOP emittion dependency on fimage layout
  Adjust tail truncate length for 32-bit ppc
  Addressed few minor bot comments

v4->v5:
  Handled alignment NOP emit logic and corresponding stub offsets
  Handled image buffer overflow problem in last pass
  Above changes took care of other bot reviews
  Included LLVMDisposeMessage() for graceful freeing
  Adjusted parameters in bpf_jit_build_fentry_stubs for ppc32
  Adjusted expected JIT inst. in tailcall test for
CONFIG_PPC_KERNEL_PCREL config
  Added fix patch at last for inaccurate use of cmplwi inst. 

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
[v4]: https://lore.kernel.org/bpf/20260517214043.12975-1-adubey@linux.ibm.com
[v5]: https://lore.kernel.org/bpf/20260519233812.18787-1-adubey@linux.ibm.com
[v6]: https://lore.kernel.org/bpf/20260529015855.364704-1-adubey@linux.ibm.com
[v7]: https://lore.kernel.org/bpf/20260611153826.31187-1-adubey@linux.ibm.com
[v8]: https://lore.kernel.org/bpf/20260616164741.32252-1-adubey@linux.ibm.com
[v9]: https://lore.kernel.org/bpf/20260623231411.6216-1-adubey@linux.ibm.com/
[v10]: https://lore.kernel.org/all/26e8e6fa5d0279ec92281d5324678f00294e2cb7.1785906979.git.skb99@linux.ibm.com/

Abhishek Dubey (8):
  powerpc/bpf: fix alignment of long branch trampoline address
  powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
  selftest/bpf: Fixing powerpc JIT disassembly failure
  selftest/bpf: Enable verifier selftest for powerpc64
  powerpc64/bpf: fix compare instruction emitted for tailcall
  selftest/bpf: Add tailcall verifier selftest for powerpc64
  powerpc/bpf: fix buffer overflow in JIT for large BPF programs
  powerpc64/bpf: fix percpu private stack leak on JIT failure

 arch/powerpc/net/bpf_jit.h                    |  20 +++-
 arch/powerpc/net/bpf_jit_comp.c               | 102 +++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c             |   7 +-
 arch/powerpc/net/bpf_jit_comp64.c             |  15 +--
 .../selftests/bpf/jit_disasm_helpers.c        |  25 ++++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../bpf/progs/verifier_tailcall_jit.c         |  74 +++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |   5 +
 8 files changed, 209 insertions(+), 40 deletions(-)

-- 
2.54.0


