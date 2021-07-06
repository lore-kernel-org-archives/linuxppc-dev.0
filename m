Return-Path: <SRS0=+jbz=L6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAF9C07E96
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Jul 2021 07:33:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893936198D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Jul 2021 07:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893936198D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GJvSM1gVXz3blP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Jul 2021 17:33:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PhCbiGcZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ravi.bangoria@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=PhCbiGcZ; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GJvRL0wDsz2xvN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jul 2021 17:33:01 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1667WfZi143499; Tue, 6 Jul 2021 03:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lZ4qsYbOJ5hS/I1BBboGbRI6TUSy9NGSN+NVfKexDWc=;
 b=PhCbiGcZuCjrVr7RVfiKZTdhjQC3hcHQGkqVQK+GlCErkl3PRk7yidz2Zj6VhzcN3E+I
 O5Z5aQVri6V8RH0x9gqMmp7ydfOHU0BETz73vt/IZCKNRGBxuBr6DkP7NhVqijQIaeo5
 JagX461F/wtMPROuDPFsESpn6nklVRqfG6bcvjuFmxU6WsHUV/wme/tuuLMMeGYlWvWJ
 KH5xWNzmsoZc6j+QkiLgA7CsH6G+U1Wy+t3CjuNIBzxhHhY8BesuyBqwjvGgPQANTtth
 metdNZ9WJ51Fxc7tKpVsmrZDl8XFRDgy+n22H4lpG7ldvPNRvl05480It8lPCrdrYk7t nA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 39mbkds3bu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jul 2021 03:32:43 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1667WhJ6143675;
 Tue, 6 Jul 2021 03:32:43 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0b-001b2d01.pphosted.com with ESMTP id 39mbkds393-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jul 2021 03:32:43 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1667WXwa011758;
 Tue, 6 Jul 2021 07:32:33 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06fra.de.ibm.com with ESMTP id 39jf5hgknw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jul 2021 07:32:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1667WUGT21758398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jul 2021 07:32:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E35752051;
 Tue,  6 Jul 2021 07:32:30 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.43.134])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2464C5204E;
 Tue,  6 Jul 2021 07:32:23 +0000 (GMT)
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: naveen.n.rao@linux.ibm.com, mpe@ellerman.id.au, ast@kernel.org,
 daniel@iogearbox.net
Subject: [PATCH 0/4] bpf powerpc: Add BPF_PROBE_MEM support for 64bit JIT
Date: Tue,  6 Jul 2021 13:02:07 +0530
Message-Id: <20210706073211.349889-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TQkSYD5K5pP8OT5IyTc7z8mncuFrIcBn
X-Proofpoint-ORIG-GUID: eiPqO5UqTagzaLt96Gqsr8r_wUgwew9O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-06_02:2021-07-02,
 2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=880 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060037
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
Cc: ravi.bangoria@linux.ibm.com, songliubraving@fb.com, netdev@vger.kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, kpsingh@kernel.org,
 paulus@samba.org, sandipan@linux.ibm.com, yhs@fb.com, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kafai@fb.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Patch #1, #2 are simple cleanup patches. Patch #3 adds
BPF_PROBE_MEM support with PowerPC 64bit JIT compiler.
Patch #4 adds explicit addr > TASK_SIZE_MAX check to
handle bad userspace pointers.

Ravi Bangoria (4):
  bpf powerpc: Remove unused SEEN_STACK
  bpf powerpc: Remove extra_pass from bpf_jit_build_body()
  bpf powerpc: Add BPF_PROBE_MEM support for 64bit JIT
  bpf powerpc: Add addr > TASK_SIZE_MAX explicit check

 arch/powerpc/net/bpf_jit.h        |   8 ++-
 arch/powerpc/net/bpf_jit_comp.c   |  25 ++++++--
 arch/powerpc/net/bpf_jit_comp32.c |   4 +-
 arch/powerpc/net/bpf_jit_comp64.c | 100 +++++++++++++++++++++++++++++-
 4 files changed, 124 insertions(+), 13 deletions(-)

-- 
2.26.3

