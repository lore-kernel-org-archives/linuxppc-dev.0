Return-Path: <linuxppc-dev+bounces-21478-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC6ECD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 16:16:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPLbz6MPzz2xfB;
	Tue, 26 May 2026 02:16:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779725791;
	cv=none; b=SDSHfuwXheBTOL+MeCwe5IpCvn1F+03NDDemfKnchnhKuOXE2TVDn7jz58kk/9H+KaHTEZLuUOPH8KsS7W6Dv38xGLRPHW6LZXjwOPcDMFkuImxhTXFuELot8vBosiiPn0DNs1onNMsxXoHjN6kwZlxRA0xFchOd8gSk+7zTGk7a4ZVa0MiIPET3RtdHhmY4EL3yXpvjeHMvBprxRQz5uHBMjofxCasjo2emzF2sCGtOY4BHZm6ix+I+fSRi6o1OLCL+wwF9bWB6LDMzhsMVEXx1sgUwkJ6LyjobnoJneEgQ7SrdPDV6GShViq4o8qqATxrjc+99Kv33QcUSxPNWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779725791; c=relaxed/relaxed;
	bh=yryrgrfAa/N6UOBPX8wmxnNENSoVuZV8vp8LcNiCM44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oROcx+KFOCIesOat2axjUeHC25odZfIgZaOBebA7iYNm4PVp9bDDY/0ygohHIgoQTIp+RB0c9UjVVRWFGWsT2CVuExL36K598VxmQ5BBtWf4PIdzL07vrngTmlTi980pxNiAEse5gYSDU1eadQOH29t+ENCPoan0v54fuTqij/+I8LWp31hIR8prDs0q+/JS8mgDKuiQX4Umc2lKbmHwkAfrBBXrhGqL01qfjd2nf9nbWPX2iB14QDwpriph7NQs8J2NnMeTe8NI2HOKPoxhZrNs7T+WQYFbdoA2o0DRwo+6EHPGs4RxiwrDCGcESOdDEdqEupOikeYKHfvBVU89VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P8s7QwRG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P8s7QwRG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPLby59jBz2xbN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 02:16:29 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PFqiIx2737945;
	Mon, 25 May 2026 16:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yryrgrfAa/N6UOBPX8wmxnNENSoVuZV8vp8LcNiCM
	44=; b=P8s7QwRGqSPUj440gODPsvX2EUSON5Rrg/EhoYsl51UsBAJfeE4gtJnpQ
	X0pDSlxbGWgWwZo1f2p6qRj5c08gC3vo5G4xmRx47IiKihriFR/vj55nTnpNTyyr
	Z6ToNnxJQS4Q7qy4K2Lm4DApUcAtqBGJMMZeJhk02medgxkYfBHNojZlCVQur1td
	5/PcX/j1sFbE36RI4B8iYrfv2maPMqJnbLMZYPbkCb0HsfvPnfQHC66gokNSB5AD
	+N1WCzQpdqG3wZHqQtiWZv1IOChKwGQdCPvgLJoKqH9tuaYKem3vMoK03edDUyEQ
	LLBDvOyOqn75LRTERXSShQClv/56A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nugeec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 16:16:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PG96Gc010494;
	Mon, 25 May 2026 16:16:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebpxvwvs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 16:16:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64PGG8M412452122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 16:16:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99C202004B;
	Mon, 25 May 2026 16:16:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B378720043;
	Mon, 25 May 2026 16:16:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.105])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 May 2026 16:16:05 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Antonio Alvarez Feijoo <antonio.feijoo@suse.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Allow text relocations for pseries wrapper with binutils 2.46+
Date: Mon, 25 May 2026 21:46:01 +0530
Message-ID: <20260525161601.32097-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2MyBTYWx0ZWRfXzwc2CgDA2Sni
 nrbvUCDhefnJjIlk/HVJg3F8R5TLGzBsQKhISsvJ48wV9B+TEz/r9bv4xgGSpfc7Jo3GmMKDClk
 Bt4lR6KphOX0TKR8rdXxk4MSgOqW4GSsCULEZVz+oAn+0OHFn3IBkanCltjYo2nfG99bLiCNaEb
 XFfwknRMwYOr2/RwNX+QmC7TAGZ5izqnnP/5ZyerGX9+8vaLlPUMWj/ly6+rAHLyKHCZflZc5Kq
 UdiCtXTTtg7RVTuqioI95m+RyMxSayuc3KtFSMEh3cLpWmpWyP4Rc7Xj4YdWpXKw82vLd1KiwBu
 nfnhr4IqpzReyiv2O1jvslB3MPQ4SbjJLCVW1gE73CgU2ga9KaNF6f1XNDqJIRtYTGvSxFcw9PO
 Yagdc0GAZpJJJq1TckdSK3RFegXflkMX0PacfC8JuhKqQZgQc5UHUkORGf59GLUJs0uMdQu6xSZ
 LM6fGh3v0rRdYBxguUw==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a1475ce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=OLIXmKx2RgFzAWbePuEA:9
X-Proofpoint-ORIG-GUID: qT0MOeCROwf--tpLM31KFr8IiqUlYJ94
X-Proofpoint-GUID: BJMa9tVmhteqotsquINEIM8gTv_axPpj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250163

Binutils 2.46 changed the default linker behavior from '-z notext' to
'-z text', which treats dynamic relocations in read-only segments as
errors rather than warnings. This causes the pseries boot wrapper build
to fail with:

  /usr/bin/ld.bfd: arch/powerpc/boot/wrapper.a(crt0.o): warning:
    relocation against `_platform_stack_top' in read-only section `.text'
  /usr/bin/ld.bfd: error: read-only segment has dynamic relocations

The pseries wrapper uses '-pie' to create position-independent code.
However, crt0.S contains a pointer to '_platform_stack_top' in the .text
section, which requires a dynamic relocation at runtime. This creates
DT_TEXTREL (text relocations), which were allowed by default in binutils
2.45 and earlier (via implicit '-z notext') but are now rejected by
binutils 2.46+.

Add '-z notext' linker flag to explicitly allow text relocations for
the pseries platform, similar to what is already done for the epapr
platform. This restores the previous behavior and allows the boot
wrapper to build successfully with binutils 2.46+.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/boot/wrapper | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 1efd1206fcab..25321ce262e8 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -262,6 +262,7 @@ pseries)
     if [ "$format" != "elf32ppc" ]; then
 	link_address=
 	pie=-pie
+	notext='-z notext'
     fi
     make_space=n
     ;;

base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.50.1 (Apple Git-155)


