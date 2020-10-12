Return-Path: <SRS0=fZjV=DT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB7C433E7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 07:30:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF5D20790
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 07:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DHBhZ54f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF5D20790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C8r1k2ckPzDqjJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 18:30:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=us.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=linuxram@us.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=DHBhZ54f; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C8qz81vSDzDqP9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2020 18:28:12 +1100 (AEDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09C73i5t136077; Mon, 12 Oct 2020 03:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=MV10Bu4IT96mlbyfXjgvHbCX1OVkXR5VOhKmyKvOBtQ=;
 b=DHBhZ54f+yGpNCtPDur9eu9wbSnZryPDp26NbG+vTpmrK3lxfuOf77VBvPrWP/+vpUQM
 jJHOmRDlivWw8lJn725uFBcOcmh8B/HA3fSzY01KzKowB/Mn2Ox/V6e/VvFKKcL932RU
 5gi7qQtRLrsYmifBlvqNt25kIfcuxxJol5+oBv+fp9bQmmu7UoMEKyJBfYwu1/mTCyz4
 xTTjm8Ispb8imkHuI7EinXGgefEdMpeajxsfwW7zgsVBu7zMOmagV4cX4KrQs7WMwZUF
 f0TKXHWbTF3h7AwMnlgY6KINhjeL6da8anKWCiQ+F+FT9X+tsKOaf41Jd1LygSOIjshd dQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 344jcdrmwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2020 03:28:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09C7MYIn017156;
 Mon, 12 Oct 2020 07:28:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03ams.nl.ibm.com with ESMTP id 3434k81s8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2020 07:28:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09C7S4UC25035080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2020 07:28:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C619BA406F;
 Mon, 12 Oct 2020 07:28:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33A10A405E;
 Mon, 12 Oct 2020 07:28:03 +0000 (GMT)
Received: from ram-ibm-com.ibm.com (unknown [9.85.204.94])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 12 Oct 2020 07:28:02 +0000 (GMT)
From: Ram Pai <linuxram@us.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC v1 0/2] Plumbing to support multiple secure memory backends.
Date: Mon, 12 Oct 2020 00:27:41 -0700
Message-Id: <1602487663-7321-1-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-12_03:2020-10-12,
 2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=812
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010120061
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
Cc: farosas@linux.ibm.com, linuxram@us.ibm.com, bharata@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Secure VMs are currently supported by the Ultravisor backend.

Enhance the plumbing to support multiple backends. Each backend shall
provide the implementation for the necessary and sufficient calls
in order to support secure VM.

Also as part of this change, modify the ultravisor implementation to
be a plugin that provides an implementation of the backend.

Ram Pai (2):
  KVM: PPC: Book3S HV: rename all variables in book3s_hv_uvmem.c
  KVM: PPC: Book3S HV: abstract secure VM related calls.

 arch/powerpc/include/asm/kvm_book3s_uvmem.h   | 100 ---------
 arch/powerpc/include/asm/kvmppc_svm_backend.h | 250 ++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_mmu_radix.c        |   6 +-
 arch/powerpc/kvm/book3s_hv.c                  |  28 +--
 arch/powerpc/kvm/book3s_hv_uvmem.c            | 288 +++++++++++++++-----------
 5 files changed, 432 insertions(+), 240 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/kvm_book3s_uvmem.h
 create mode 100644 arch/powerpc/include/asm/kvmppc_svm_backend.h

-- 
1.8.3.1

