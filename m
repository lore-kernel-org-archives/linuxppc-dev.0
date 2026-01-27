Return-Path: <linuxppc-dev+bounces-16305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEAECA6C92
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jan 2026 08:50:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0fH93Tdlz2xjP;
	Tue, 27 Jan 2026 19:49:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769503797;
	cv=none; b=m6l/R/EDaogEXUp/VYUGTAqoOsL/SFbtziu02ZAuACHuakFZSr/DJ2svQeIFhugA8ZQCr/zrmZYmYVzsrcDTPy1uJon6rdlIHsVRKvZLTrL3hz19HE3xPi4WOov0py+OigjxVjcQrrf/zt7S1PNZVzp6F6cv/8a1COH12YkZKcTSk4beWf3OMiwL/MFIGxDYMnciM+O7mrCoALv0m9SfNuakS5eeqkAUtPs8VYP2x20W+ENrLzoUl/lJI7Z83NJlhCT1Q7oyL8yoWb4yWrk9IpcfhGn64Kkox3rCpG+AI4aMt5eUMHW8EPd+g5UDMmOUeR8VbVd10k8c9hpHbXiuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769503797; c=relaxed/relaxed;
	bh=IK2Im8FtyDa+N0jemZAwMsjUhAlQA7jbhs0IYdDSDcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/eZxRtbiLNXEvnvjbSCqVCpMm+8phmDXF0d/+4hOhYhqYa7BncaHDS+EtQMN0Ii+6Bf60iro6oZtTjVWHpgpzvgQCKBztEaVWfRZ0AihWIOnHn+WlBcg24emH8U3k++F+vL1eCLw2JfAbGSW8P7QE3PemspGXAE+8olhT87mX+FsgtltjGm/HnUCspVOegpaPgow/SgmGZ8S9e+jbDIAVTykrb3IyfggcWKTHQpCyU9fRm8q6XLw432Dfsh9gYQW5/jXP70wdex4bdBh3yJp2pRtYVq7pC4guIDGoWEusJtFsM4E61SXj4P69tWSYFjqSLF1O1TRdgGptvPr9Qn+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RacN185f; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RacN185f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0fH85WBvz3bf3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2026 19:49:56 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R723ix013597;
	Tue, 27 Jan 2026 08:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IK2Im8FtyDa+N0jem
	ZAwMsjUhAlQA7jbhs0IYdDSDcQ=; b=RacN185fuLNm+djP7UetrBh3dyZiEvNP7
	o8jS1gAeais7hox496lsrSkHytC9k/Bw8cq8oza328DQoLV9MQfjWjZMV8hz16LJ
	qNypQf9ZqHp3qP47kNTbgUoxgMfgEo50jyoMHktKjcmAqOZUyiooefviRfWghNuQ
	zBBANtQDDQUp6vS5/yADGgE77Jrtj+jGexksHIP3T6RGyL8o33uzcNvaBfR6iyyB
	O75I2xhivWvRZl4FCdc4ynlthpt9NbN39IW1vVXDGouPYhhSb2tiy+CkDJ3MmueZ
	yLeHPlCBdPIFER6oNlqWhG2tFjHwFsUznkh0ILigsEUEeFnr85/wg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6vdka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 08:49:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60R4BhTb018394;
	Tue, 27 Jan 2026 08:49:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41qqfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 08:49:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60R8nYub25821500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 08:49:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF0432004B;
	Tue, 27 Jan 2026 08:49:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35E0C20040;
	Tue, 27 Jan 2026 08:49:32 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.105])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 08:49:31 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, llvm@lists.linux.dev,
        Maryam Moghadas <maryammo@ca.ibm.com>
Subject: [PATCH v2 2/3] powerpc64/ftrace: fix OOL stub count with clang
Date: Tue, 27 Jan 2026 14:19:25 +0530
Message-ID: <20260127084926.34497-3-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127084926.34497-1-hbathini@linux.ibm.com>
References: <20260127084926.34497-1-hbathini@linux.ibm.com>
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
X-Proofpoint-GUID: AQFmo85ljkW9szpQpX_RcaVUI2tkXMHG
X-Proofpoint-ORIG-GUID: AQFmo85ljkW9szpQpX_RcaVUI2tkXMHG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA3MSBTYWx0ZWRfX9ICBxqyqtKAi
 pdFxxxI5MhMLVYFn9auSWUPL6RDpdlBdp25b4+Et2XInIyObIBNJN/NNnIhhruKU5P7ua7NCAHC
 HJnK0Vo72psw9myp+IR1U4tg4LNXzRINDADXEw1cNCe/B5dNzDeuicd0cZsizK8AUxuinDQ+M3j
 /gZsUdBrr9DoYEXIG/HnmY/6RW2PYBMnLG1C48HN+WcJ174iBjyNBz47y4O+cE9QrpG51WrSSs9
 KVeksFjD2kYZ/p2KUroRoEI0rWiNZYonCnNV/NgEHyY3Z2JCtvVry+H3wvKb4DxH/V4oAH5Hl2L
 udGZkkAV+iJ8U5cKa/u3McjqWNmEBI1QFI4xLZmuOUysabNWqn+lZV3rXmXhCYGX3/Rg+jR3THn
 68JiZh1B4R1IMXdFQlRvKiXRvzKCD0E4Q+pq0XwCcsIM6uWkuUZwxJrJ0c6kiJVDecw2zflZbGx
 J+IUpLWl/V2O2nFACmA==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=69787c24 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=_5KToPWuY_tjwTr7hf0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270071

The total number of out-of-line (OOL) stubs required for function
tracing is determined using the following command:

    $(OBJDUMP) -r -j __patchable_function_entries vmlinux.o

While this works correctly with GNU objdump, llvm-objdump does not
list the expected relocation records for this section. Fix this by
using the -d option and counting R_PPC64_ADDR64 relocation entries.
This works as desired with both objdump and llvm-objdump.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

* No changes since v1.


 arch/powerpc/tools/ftrace-gen-ool-stubs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
index bac186bdf64a..9218d43aeb54 100755
--- a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
+++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
@@ -15,9 +15,9 @@ if [ -z "$is_64bit" ]; then
 	RELOCATION=R_PPC_ADDR32
 fi
 
-num_ool_stubs_total=$($objdump -r -j __patchable_function_entries "$vmlinux_o" |
+num_ool_stubs_total=$($objdump -r -j __patchable_function_entries -d "$vmlinux_o" |
 		      grep -c "$RELOCATION")
-num_ool_stubs_inittext=$($objdump -r -j __patchable_function_entries "$vmlinux_o" |
+num_ool_stubs_inittext=$($objdump -r -j __patchable_function_entries -d "$vmlinux_o" |
 			 grep -e ".init.text" -e ".text.startup" | grep -c "$RELOCATION")
 num_ool_stubs_text=$((num_ool_stubs_total - num_ool_stubs_inittext))
 
-- 
2.52.0


