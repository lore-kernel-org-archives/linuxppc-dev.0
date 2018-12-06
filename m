Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82365C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:27:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0033D20850
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0033D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439jGN1QcHzDr0f
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:27:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439hqF1C1rzDqtk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 04:07:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 439hqD5fCPz8tPZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 04:07:20 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 439hqD4lNpz9s6w; Fri,  7 Dec 2018 04:07:20 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mdroth@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 439hqC46cVz9s55
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2018 04:07:19 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB6GxN27155120
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2018 12:07:17 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p76rtbug5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Dec 2018 12:07:16 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mdroth@linux.vnet.ibm.com>;
 Thu, 6 Dec 2018 17:07:16 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Dec 2018 17:07:14 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB6H7Dd718809064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Dec 2018 17:07:13 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 564D1124053;
 Thu,  6 Dec 2018 17:07:13 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3811A124055;
 Thu,  6 Dec 2018 17:07:13 +0000 (GMT)
Received: from localhost (unknown [9.53.179.197])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  6 Dec 2018 17:07:13 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH] bpf: fix overflow of bpf_jit_limit when PAGE_SIZE >= 64K
Date: Thu,  6 Dec 2018 11:06:46 -0600
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 18120617-0072-0000-0000-000003D55569
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010182; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127892; UDB=6.00582089; IPR=6.00908023; 
 MB=3.00024501; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-06 17:07:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120617-0073-0000-0000-00004A5A8D53
Message-Id: <20181206170646.3736-1-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060145
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
Cc: linuxppc-dev@ozlabs.org, Sandipan Das <sandipan@linux.ibm.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit ede95a63b5 introduced a bpf_jit_limit tuneable to limit BPF
JIT allocations. At compile time it defaults to PAGE_SIZE * 40000,
and is adjusted again at init time if MODULES_VADDR is defined.

For ppc64 kernels, MODULES_VADDR isn't defined, so we're stuck with
the compile-time default at boot-time, which is 0x9c400000 when
using 64K page size. This overflows the signed 32-bit bpf_jit_limit
value:

  root@ubuntu:/tmp# cat /proc/sys/net/core/bpf_jit_limit
  -1673527296

and can cause various unexpected failures throughout the network
stack. In one case `strace dhclient eth0` reported:

  setsockopt(5, SOL_SOCKET, SO_ATTACH_FILTER, {len=11, filter=0x105dd27f8}, 16) = -1 ENOTSUPP (Unknown error 524)

and similar failures can be seen with tools like tcpdump. This doesn't
always reproduce however, and I'm not sure why. The more consistent
failure I've seen is an Ubuntu 18.04 KVM guest booted on a POWER9 host
would time out on systemd/netplan configuring a virtio-net NIC with no
noticeable errors in the logs.

Fix this by limiting the compile-time default for bpf_jit_limit to
INT_MAX.

Fixes: ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict unpriv allocations")
Cc: linuxppc-dev@ozlabs.org
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 kernel/bpf/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b1a3545d0ec8..55de4746cdfd 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -365,7 +365,8 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
 }
 
 #ifdef CONFIG_BPF_JIT
-# define BPF_JIT_LIMIT_DEFAULT	(PAGE_SIZE * 40000)
+# define BPF_MIN(x, y) ((x) < (y) ? (x) : (y))
+# define BPF_JIT_LIMIT_DEFAULT	BPF_MIN((PAGE_SIZE * 40000), INT_MAX)
 
 /* All BPF JIT sysctl knobs here. */
 int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
-- 
2.17.1

