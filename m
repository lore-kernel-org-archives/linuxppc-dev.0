Return-Path: <SRS0=H3od=DQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B1DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2020 06:42:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7943A22245
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2020 06:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pQvedLpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7943A22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C6z6752X6zDqTM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2020 17:42:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ganeshgr@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=pQvedLpE; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C6z3h51LQzDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2020 17:40:48 +1100 (AEDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0996YCqB148669; Fri, 9 Oct 2020 02:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=DtioAdwJQ01XLARkLGPkjQAwRF4FUrHKEDRufIHUvo0=;
 b=pQvedLpEv9/0yCqRcs6wlDxGRwQMaXRXwp4PjMXmmJb5BacHkudoums08Y77tCvWSNBW
 gNcFnLGdW/q5B+2nSWqTrFrkeKnhslPMkSrqbhCatYUfX8SV8NnfdPV/WPPVKVymDLrC
 yMuI5Ok0Yu41MwATeGWFnsGKgmyRVYEl10xPVXLjuTAx1PBQSMx3/ePpRQPwfTNKLK+8
 QSKj2tD7pY5yIp9+HdrjLdr+HV4y/xECtJM2AsvhkzbaDP81EFIueeNVYm3Ht5QLJ4n6
 LoQ6Igw4Ufze9F4CXbIgR/NAQPhwtOvZw90ZzxILAyi4EkNLave7aqNoc+zNITxHFtmL Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 342jft0fag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2020 02:40:42 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0996YG0U148773;
 Fri, 9 Oct 2020 02:40:42 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 342jft0f9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2020 02:40:41 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0996RRkD003744;
 Fri, 9 Oct 2020 06:40:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04ams.nl.ibm.com with ESMTP id 3429hm0c7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2020 06:40:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0996eYhq25362918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2020 06:40:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B04311C052;
 Fri,  9 Oct 2020 06:40:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76CD111C050;
 Fri,  9 Oct 2020 06:40:32 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.89.116])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2020 06:40:32 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v4 0/2] powerpc/mce: Fix mce handler and add selftest
Date: Fri,  9 Oct 2020 12:10:03 +0530
Message-Id: <20201009064005.19777-1-ganeshgr@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-09_02:2020-10-09,
 2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090046
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
Cc: msuchanek@suse.de, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 keescook@chromium.org, npiggin@gmail.com, mahesh@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch series fixes mce handling for pseries, Adds LKDTM test
for SLB multihit recovery and enables selftest for the same,
basically to test MCE handling on pseries/powernv machines running
in hash mmu mode.

v4:
* Use radix_enabled() to check if its in Hash or Radix mode.
* Use FW_FEATURE_LPAR instead of machine_is_pseries().

v3:
* Merging selftest changes with patch 2/2, Instead of having separate
  patch.
* Minor improvements like adding enough comments, Makefile changes,
  including header file and adding some prints.

v2:
* Remove in_nmi check before calling nmi_enter/exit,
  as nesting is supported.
* Fix build errors and remove unused variables.
* Integrate error injection code into LKDTM.
* Add support to inject multihit in paca.


Ganesh Goudar (2):
  powerpc/mce: remove nmi_enter/exit from real mode handler
  lkdtm/powerpc: Add SLB multihit test

 arch/powerpc/kernel/mce.c               |   7 +-
 drivers/misc/lkdtm/Makefile             |   1 +
 drivers/misc/lkdtm/core.c               |   3 +
 drivers/misc/lkdtm/lkdtm.h              |   3 +
 drivers/misc/lkdtm/powerpc.c            | 156 ++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |   1 +
 6 files changed, 167 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/lkdtm/powerpc.c

-- 
2.26.2

