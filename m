Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268C0C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 11:56:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFB864FE4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 11:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFB864FE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsR5X6Tnvz3dG9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 22:56:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LUYjC8cH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ravi.bangoria@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=LUYjC8cH; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsR535jjKz3cJq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Mar 2021 22:55:35 +1100 (AEDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 125BXdcS012986; Fri, 5 Mar 2021 06:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tThMMiURIYel2tcEV6/s2VlXRYF5FWm2p5ebEVtrexM=;
 b=LUYjC8cHEyyiFRiSzq78oKOfa2CQHAAaR9ibE2taXdpa4O8y/t8nbVM3Q3jc1+O/4n+J
 bkZ4dWxqJCpxD8whJ24L/8wVd9jMCRR7jgFhe5mSSld7SamyjOW1yewXC0deKQKsFWkM
 pVPnrl4lM44NMfTAVdopkDtdmmqfz+xYn4AS789aA9ck1pC1XWuZPUNSPIQWMkpNljGL
 +YHtfewk33fsk+z2A27x/87I7vOCB/SpwhjtN2iTtcvcSH8hynXe/p0JvWNZsUUnI6BU
 Cz/j1muApuenl2iArsTcrz3LKmq4MYvVXoWXcOZWsPeY7KewU9oyD9omW3E5t3GOk8ck zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 373kk9ry2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Mar 2021 06:54:57 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 125BXgA1013171;
 Fri, 5 Mar 2021 06:54:56 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 373kk9ry1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Mar 2021 06:54:56 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125BreLC030755;
 Fri, 5 Mar 2021 11:54:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 37293fsycm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Mar 2021 11:54:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 125Bspes45875634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Mar 2021 11:54:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FCB8AE04D;
 Fri,  5 Mar 2021 11:54:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F29DAE045;
 Fri,  5 Mar 2021 11:54:48 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.43.205])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  5 Mar 2021 11:54:48 +0000 (GMT)
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v4] powerpc/uprobes: Validation for prefixed instruction
Date: Fri,  5 Mar 2021 17:24:33 +0530
Message-Id: <20210305115433.140769-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-05_05:2021-03-03,
 2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050058
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
Cc: ravi.bangoria@linux.ibm.com, jniethe5@gmail.com, oleg@redhat.com,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 sandipan@linux.ibm.com, naveen.n.rao@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As per ISA 3.1, prefixed instruction should not cross 64-byte
boundary. So don't allow Uprobe on such prefixed instruction.

There are two ways probed instruction is changed in mapped pages.
First, when Uprobe is activated, it searches for all the relevant
pages and replace instruction in them. In this case, if that probe
is on the 64-byte unaligned prefixed instruction, error out
directly. Second, when Uprobe is already active and user maps a
relevant page via mmap(), instruction is replaced via mmap() code
path. But because Uprobe is invalid, entire mmap() operation can
not be stopped. In this case just print an error and continue.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
v3: https://lore.kernel.org/r/20210304050529.59391-1-ravi.bangoria@linux.ibm.com
v3->v4:
  - CONFIG_PPC64 check was not required, remove it.
  - Use SZ_ macros instead of hardcoded numbers.

 arch/powerpc/kernel/uprobes.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index e8a63713e655..4cbfff6e94a3 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -41,6 +41,13 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
 	if (addr & 0x03)
 		return -EINVAL;
 
+	if (cpu_has_feature(CPU_FTR_ARCH_31) &&
+	    ppc_inst_prefixed(auprobe->insn) &&
+	    (addr & (SZ_64 - 4)) == SZ_64 - 4) {
+		pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.27.0

