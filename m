Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75E7C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 09:29:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE26820850
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 09:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE26820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439Vfg5jYczDqQK
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 20:29:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439VcK0PF1zDr9B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 20:27:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 439VcJ4Sl1z8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 20:27:12 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 439VcJ42wcz9s7h; Thu,  6 Dec 2018 20:27:12 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sandipan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 439VcJ0T7Nz9s55
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2018 20:27:11 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB69NmIR007486
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2018 04:27:10 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p703tatr2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Dec 2018 04:27:09 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sandipan@linux.ibm.com>;
 Thu, 6 Dec 2018 09:27:07 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Dec 2018 09:27:04 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB69R3TC10355060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Dec 2018 09:27:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C69064C059;
 Thu,  6 Dec 2018 09:27:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2AB54C04E;
 Thu,  6 Dec 2018 09:27:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.195.22.129])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  6 Dec 2018 09:27:02 +0000 (GMT)
From: Sandipan Das <sandipan@linux.ibm.com>
To: daniel@iogearbox.net, ast@kernel.org
Subject: [PATCH bpf] bpf: powerpc: fix broken uapi for BPF_PROG_TYPE_PERF_EVENT
Date: Thu,  6 Dec 2018 14:57:01 +0530
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120609-4275-0000-0000-000002ECE4C1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120609-4276-0000-0000-000037F9F3D6
Message-Id: <20181206092701.4153-1-sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=924 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060085
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
Cc: naveen.n.rao@linux.ibm.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now that there are different variants of pt_regs for userspace and
kernel, the uapi for the BPF_PROG_TYPE_PERF_EVENT program type must
be changed by exporting the user_pt_regs structure instead of the
pt_regs structure that is in-kernel only.

Fixes: 002af9391bfb ("powerpc: Split user/kernel definitions of struct pt_regs")
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/include/asm/perf_event.h          | 2 ++
 arch/powerpc/include/uapi/asm/Kbuild           | 1 -
 arch/powerpc/include/uapi/asm/bpf_perf_event.h | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/uapi/asm/bpf_perf_event.h

diff --git a/arch/powerpc/include/asm/perf_event.h b/arch/powerpc/include/asm/perf_event.h
index 8bf1b6351716..16a49819da9a 100644
--- a/arch/powerpc/include/asm/perf_event.h
+++ b/arch/powerpc/include/asm/perf_event.h
@@ -26,6 +26,8 @@
 #include <asm/ptrace.h>
 #include <asm/reg.h>
 
+#define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
+
 /*
  * Overload regs->result to specify whether we should use the MSR (result
  * is zero) or the SIAR (result is non zero).
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index a658091a19f9..3712152206f3 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -1,7 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += bpf_perf_event.h
 generic-y += param.h
 generic-y += poll.h
 generic-y += resource.h
diff --git a/arch/powerpc/include/uapi/asm/bpf_perf_event.h b/arch/powerpc/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 000000000000..b551b741653d
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef struct user_pt_regs bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
-- 
2.19.2

