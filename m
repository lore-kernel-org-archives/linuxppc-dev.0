Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2188C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 12:39:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F09160D42
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 12:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F09160D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HTFbV0Y0Wz3c5X
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 23:39:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cyGjr5WC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=cyGjr5WC; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HTFXv71Zlz2yQH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Oct 2021 23:37:03 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CB4EVX025551; 
 Tue, 12 Oct 2021 08:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=N/oQw61XSfsHTPLzRuzCMqE363lBiTZg1nWSHVzFm2o=;
 b=cyGjr5WCW3bIjs6qjBqvt/aNfG5/tHXDimYPreaDNSsGPmMZmocfBNjc866diugqoC4d
 jL1LkFIqHS6ulXQek+3R/froEUT57vAbF2mVYtewbNuBcp+AkuURxz+6M07GX86hGIg0
 2OvtY6yKBr3GZQQLY6GoppjmQhpbyqiggAegWEZfR3yoKcxEOuwcFrnZCH2EvD8Wrixc
 qY/T21V6IRATCQrAMuGJvS8Xq2whajMliN3bW6nqbFPSf2nnjuO7Czm6x0Vs0RACP7dh
 CClvY7B5xpacoyivKlWBExgIRJP6cZOAuLQszjM+yRWFRvuajeSe0r52ZTYiKjMLov/i 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bn0x2v2m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Oct 2021 08:36:42 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CCINrQ002407;
 Tue, 12 Oct 2021 08:36:40 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bn0x2v2j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Oct 2021 08:36:40 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CCDqpS029292;
 Tue, 12 Oct 2021 12:31:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06ams.nl.ibm.com with ESMTP id 3bk2bj8hkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Oct 2021 12:31:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 19CCVNAW52494830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Oct 2021 12:31:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C037A405E;
 Tue, 12 Oct 2021 12:31:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E167FA407D;
 Tue, 12 Oct 2021 12:31:07 +0000 (GMT)
Received: from hbathini-workstation.ibm.com.com (unknown [9.43.27.69])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 12 Oct 2021 12:31:07 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: naveen.n.rao@linux.ibm.com, christophe.leroy@csgroup.eu,
 mpe@ellerman.id.au, ast@kernel.org, daniel@iogearbox.net
Subject: [RESEND PATCH v4 0/8] bpf powerpc: Add BPF_PROBE_MEM support in
 powerpc JIT compiler
Date: Tue, 12 Oct 2021 18:00:48 +0530
Message-Id: <20211012123056.485795-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J7roR7WtHHmlrd6HhJXQVmO527xKLI8E
X-Proofpoint-GUID: LuoesbDpX86Vlo3-kzooh5QvXBj9_-HF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_03,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 mlxlogscore=866 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120073
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: songliubraving@fb.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, kpsingh@kernel.org, paulus@samba.org, yhs@fb.com,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kafai@fb.com,
 Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Patch #1 & #2 are simple cleanup patches. Patch #3 refactors JIT
compiler code with the aim to simplify adding BPF_PROBE_MEM support.
Patch #4 introduces PPC_RAW_BRANCH() macro instead of open coding
branch instruction. Patch #5 & #7 add BPF_PROBE_MEM support for PPC64
& PPC32 JIT compilers respectively. Patch #6 & #8 handle bad userspace
pointers for PPC64 & PPC32 cases respectively.


Resending v4 after rebasing the series on top of bpf fix patches
posted by Naveen:

  - https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1633464148.git.naveen.n.rao@linux.vnet.ibm.com/
    ("[v2,00/10] powerpc/bpf: Various fixes")

Also, added Reviewed-by tag from Christophe for patches #3, #5, #6, #7 & #8.


Hari Bathini (4):
  bpf powerpc: refactor JIT compiler code
  powerpc/ppc-opcode: introduce PPC_RAW_BRANCH() macro
  bpf ppc32: Add BPF_PROBE_MEM support for JIT
  bpf ppc32: Access only if addr is kernel address

Ravi Bangoria (4):
  bpf powerpc: Remove unused SEEN_STACK
  bpf powerpc: Remove extra_pass from bpf_jit_build_body()
  bpf ppc64: Add BPF_PROBE_MEM support for JIT
  bpf ppc64: Access only if addr is kernel address

 arch/powerpc/include/asm/ppc-opcode.h |   2 +
 arch/powerpc/net/bpf_jit.h            |  17 ++++-
 arch/powerpc/net/bpf_jit_comp.c       |  68 +++++++++++++++--
 arch/powerpc/net/bpf_jit_comp32.c     | 101 ++++++++++++++++++++++----
 arch/powerpc/net/bpf_jit_comp64.c     |  72 ++++++++++++++----
 5 files changed, 219 insertions(+), 41 deletions(-)

-- 
2.31.1

