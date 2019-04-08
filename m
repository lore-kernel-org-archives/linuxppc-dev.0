Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E812AC10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 13:22:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0912147A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 13:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0912147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dB0s4SjLzDqF3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 23:22:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d9xx0bDYzDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 23:19:48 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x38DIOn8016188
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2019 09:19:44 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rr72q82nb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 09:19:44 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 8 Apr 2019 14:19:43 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 8 Apr 2019 14:19:41 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x38DJeqk25165826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Apr 2019 13:19:40 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6DA4112065;
 Mon,  8 Apr 2019 13:19:40 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 946C4112062;
 Mon,  8 Apr 2019 13:19:38 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.54.201])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  8 Apr 2019 13:19:38 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/3] Reduce memory usage for mm_context_t
Date: Mon,  8 Apr 2019 18:49:31 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040813-0040-0000-0000-000004DDFD6C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010889; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01186116; UDB=6.00621189; IPR=6.00966873; 
 MB=3.00026343; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-08 13:19:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040813-0041-0000-0000-000008E9026B
Message-Id: <20190408131934.27959-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-08_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=754 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080111
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch moves hash translation related context variables to another structure
and runtime allocate that based on translation mode.

Aneesh Kumar K.V (3):
  powerpc/mm: Add helpers for accessing hash translation related
    variables
  powerpc/mm: Move slb_addr_linit to early_init_mmu
  powerpc/mm: Reduce memory usage for mm_context_t for radix

 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 35 +++++++-
 arch/powerpc/include/asm/book3s/64/mmu.h      | 88 +++++++++++++------
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  | 50 +++++++++++
 arch/powerpc/kernel/paca.c                    | 12 +--
 arch/powerpc/kernel/setup-common.c            |  7 +-
 arch/powerpc/mm/hash_utils_64.c               | 14 +--
 arch/powerpc/mm/mmu_context_book3s64.c        | 16 +++-
 arch/powerpc/mm/slb.c                         |  2 +-
 arch/powerpc/mm/slice.c                       | 49 +++++------
 arch/powerpc/mm/subpage-prot.c                |  8 +-
 arch/powerpc/mm/tlb_nohash.c                  |  6 ++
 11 files changed, 211 insertions(+), 76 deletions(-)

-- 
2.20.1

