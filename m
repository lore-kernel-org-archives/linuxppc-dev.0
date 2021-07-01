Return-Path: <SRS0=ZiU1=LZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2531C11F67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 15:10:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8ED613E3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 15:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8ED613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GG1qB4VgQz3bjc
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 01:10:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wmz1RiM5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=naveen.n.rao@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=Wmz1RiM5; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GG1pc2gRcz302c
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2021 01:09:43 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 161F6BRq044774; Thu, 1 Jul 2021 11:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=emUGj6DJ1Og55PV16oW0zaaUTY5DEtf4p1ekcJZNYiM=;
 b=Wmz1RiM5fRdEZFoDJuJyUpgdRY065JurxkmdKRFsCGSFFD932SG01mVaKx1gGjypb0pt
 szQgDBDDoBwqg3i7uMuoFF31G37BJV5x3VBm3R1BMU6YyrfCr0zcGeX3/mqonblQ9J5Q
 fxlBOfhwmRrfxhix3owxWWA75LrQyxPymbZqM5BbqakLmQq0ml9m84Ztso9s4WAGaclE
 do5wOzaCbjHx7Cih9hUXDED4WP0rQBacWHCXriLJKxQ8A9hIs4fSz3XMGVwQjJgWULJT
 7kkZutjusRdpki0I9wQpV3DgE7iMA/n2rrLOwejIDWe+t//MWJgWV9+4LZEcGySrWhr+ aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 39hf9h9jyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jul 2021 11:09:24 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161F9Ou2065443;
 Thu, 1 Jul 2021 11:09:24 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 39hf9h9jxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jul 2021 11:09:23 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161ErOUs020620;
 Thu, 1 Jul 2021 15:09:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma02fra.de.ibm.com with ESMTP id 39duv8ha65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jul 2021 15:09:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 161F9JjY31130002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jul 2021 15:09:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99E19AE874;
 Thu,  1 Jul 2021 15:09:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D4B3AE86B;
 Thu,  1 Jul 2021 15:09:15 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.115.110])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jul 2021 15:09:14 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/2] powerpc/bpf: Fix issue with atomic ops
Date: Thu,  1 Jul 2021 20:38:57 +0530
Message-Id: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4YwvqNMIJ9Lohi2dqOfj4stLNMUnMWTf
X-Proofpoint-ORIG-GUID: WynGNAWE5fxhH5JZXWwYVP-m88UPNn66
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-01_08:2021-07-01,
 2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=974 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010092
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
Cc: Brendan Jackman <jackmanb@google.com>, Jiri Olsa <jolsa@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The first patch fixes an issue that causes a soft lockup on ppc64 with 
the BPF_ATOMIC bounds propagation verifier test. The second one updates 
ppc32 JIT to reject atomic operations properly.

- Naveen

Naveen N. Rao (2):
  powerpc/bpf: Fix detecting BPF atomic instructions
  powerpc/bpf: Reject atomic ops in ppc32 JIT

 arch/powerpc/net/bpf_jit_comp32.c | 14 +++++++++++---
 arch/powerpc/net/bpf_jit_comp64.c |  4 ++--
 2 files changed, 13 insertions(+), 5 deletions(-)


base-commit: 086d9878e1092e7e69a69676ee9ec792690abb1d
-- 
2.31.1

