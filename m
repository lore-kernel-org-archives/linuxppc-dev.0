Return-Path: <linuxppc-dev+bounces-19232-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF51D6AB10
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 20:40:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmtyV1VYCz2xls;
	Fri, 03 Apr 2026 07:40:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775162402;
	cv=none; b=eweSsYcJ+yahau2irtDphFS4nR80N77+wwNfygFQOYUZBbwmCUu0iFtsu0riWHHmuWfXOIbGDlAn/IyRDX5U2DCp8nq9O7VageYfcmc3dE1D/3pE6wzFlvVmbY3wwH6fcrLej0HUlOq1nEI24GjiX43hh3iaXymJJMoWPMS+OiwFsZoWaL03LK00mn1+Oj3PjC6Xa4x7RaP+AL+6rLkMgdscHZtjTNPbepdQ/jK5WQct3uPNnDHShc6kT5+YOxV7IZHxXTMPwZ9+edXPSPNVgnhOoM+hJwky7lO2jFElVGScKcixChMllC7SeZ/zIF8zUfcXezyC6PVsDPMrAvCcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775162402; c=relaxed/relaxed;
	bh=kZCeFcCIi0X17MCEWkI15QCWUEMcn5r3CWz0xmNaEvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8txMLuLXpGcXx0X+gF82x3uyisfW+YLr3h8hk5kh4HRyMBggLyVv0fuyrgAycI2LNCSt2jv8vMCPlhaj8X0HMsqlm6dUYjc4gTZzlns0OtB2/6p90nSvG58a1kAAgFEqedoePnMj6lUfg41ZlZVFs5uSWfDGJzQbxvzRzpUVQ2XcozxmhtilQnCnMzAONjHbAjbR46v8HESK+zgmqPBrGQM0pmmrg112IwMzibNpJ1YNUBayLrpGKoWQEup2UmyU4GT0Vf/yQEKFxp/SouFsG5UDHmIj+KhGZtVDGRgs7y4tmPUGVaxdxsPgOVlNH3PxARc2ikf7T4E18e8ezhkDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K4Wwvqzg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K4Wwvqzg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmtyS2Ljfz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:39:59 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632DF5eJ4120021;
	Thu, 2 Apr 2026 20:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kZCeFcCIi0X17MCEWkI15QCWUEMcn5r3CWz0xmNaE
	vM=; b=K4WwvqzgylvQ2j6VEXjVOMljtjBFgrdn8iZIv8LOjTcaIaaswnIY9S6/G
	cKCa0Y71+k/ITZoW+LnUQq4FiAF8/Q0zWoPI3QWw7qj6UA3VwkmS2Htog+4IUGC4
	60jGk9dOqpePKMd0ud1LpL0jhGUrnK6jg3YeI/jyBwoD0jaX1YgU7WA+W4mXxrd9
	sL0dnAl68YzienNVgWNoQbW2fYnkld+ZyGwuNxxDvFOilNahlq9+EjRi25pM+n6G
	fELBNs8CTsOnvIwY7X6WWyyAQ7pNiS5VXCV3eTc6Z3OqHGirsufQDlomjIdg8ubv
	TjkP2CB4kFX7aaRIRcKAPjtdGxsuQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnxgxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:39:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632Gh9Wu030990;
	Thu, 2 Apr 2026 20:39:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk3fpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:39:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632KdqGs29557088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 20:39:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E06AB20043;
	Thu,  2 Apr 2026 20:39:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8F6120040;
	Thu,  2 Apr 2026 20:39:49 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 20:39:49 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 0/5] powerpc/bpf: Add support for verifier selftest
Date: Thu,  2 Apr 2026 20:40:06 -0400
Message-ID: <20260403004011.44417-1-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: rHaXkN2ewF9hrlZWCQcyC5ObKmET-t4P
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ced41c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UrLCjDVe54a93DmA31EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE4MSBTYWx0ZWRfX44zvfjXFj584
 qpSrX54YOLMd8sieXdpI1LMW2twq+gkYTNjZfdZ2NYIEEvpAhs8aBQ5Vn6l7l2SnqgVnG/dDObK
 KRZKI3bVy0VrbjivBwEV8OZzZU+XSvpVY6VbVuQJBw+vXPuRcVcchuzyF/o4HlqY3WFmLArdyyQ
 6b5b62V5oURryXwfFUh+zG6fGPi7D6HFUYN5ndxi86gJhe0cFiYZO4Y6ZJKfaOkRNZ5laZKu6ad
 NaMcuzIUIOIZBPilvQjMyLO+GXld5EMPTD29Rzd0k7TIGWLjh1iEknPbm1y/ahcxotLyyUhXOZK
 gjwExpawcIEp9bH9YRqb6/gVI0IqD+5VB50OLXOSP2B9//ioJrlclpTcI4SbcZRos+pwrcceUpQ
 Nl87tr+YABwOod001pdD9FZSwhsgToFfTSJjiin+kkZHz14sTyQtIixAsbTUy47Yj6f9g3c9G92
 2wGuC+q6JNQgEN/Wb9A==
X-Proofpoint-ORIG-GUID: rHaXkN2ewF9hrlZWCQcyC5ObKmET-t4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020181

From: Abhishek Dubey <adubey@linux.ibm.com>

The verifier selftest validates JITed instructions by matching expected
disassembly output. The first two patches fix issues in powerpc instruction
disassembly that were causing test flow failures. The fix is common for 
64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
architecture tag in the third patch, enabling proper test filtering in
verifier test files. Introduce verifier testcases for tailcalls on powerpc64
in the final patch.

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

v1->v2:
  Added fix-patch to correct memory alignment in-place
  Moved the optional alignmnet NOP before OOL stub

[v1]: https://lore.kernel.org/bpf/20260225013627.22098-1-adubey@linux.ibm.com

The patch series is rebased on top of following patch in powerpc-next:
https://lore.kernel.org/bpf/20260402161026.289827-1-skb99@linux.ibm.com

Abhishek Dubey (5):
  powerpc/bpf: fix alignment of long branch trampoline address
  powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
  selftest/bpf: Fixing powerpc JIT disassembly failure
  selftest/bpf: Enable verifier selftest for powerpc64
  selftest/bpf: Add tailcall verifier selftest for powerpc64

 arch/powerpc/net/bpf_jit.h                    |  4 +-
 arch/powerpc/net/bpf_jit_comp.c               | 65 +++++++++++++----
 arch/powerpc/net/bpf_jit_comp64.c             |  4 +-
 .../selftests/bpf/jit_disasm_helpers.c        | 13 +++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
 .../bpf/progs/verifier_tailcall_jit.c         | 69 +++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  5 ++
 7 files changed, 142 insertions(+), 19 deletions(-)

-- 
2.52.0


