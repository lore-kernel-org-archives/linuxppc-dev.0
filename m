Return-Path: <SRS0=vHfa=DC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1EC4363D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2020 10:42:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3620A21D91
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2020 10:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cgsv5k6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3620A21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ByT4l4FyVzDqkV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2020 20:42:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ganeshgr@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=Cgsv5k6l; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ByStF6Hl6zDqjn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2020 20:33:09 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08PAX2HR100726; Fri, 25 Sep 2020 06:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=h9HNhbyV5dt3LwlhQZ0YLlhD7ES6GB4s5TXcUsacFjs=;
 b=Cgsv5k6lSrfGLwfTpz0KepHYKauavk37na8DnHeKXP8GBMVw5qig5b1mQge56+y5KjqT
 +Hk6D5HjPWW/EtO+RPBVvWQ20prfWZEjl/RB3ikzCDXm3Ib+kxlgZaiswC/yGCglvAFe
 EC+NPa/NINIhDDkNFJSXiStI6oz85I+OAm7V90ZDFU7hIAPALFp6qol70m8QAmb+wfaI
 xyjvdR97N5EpL+taUT9PR+J7gTOSOJmFy3aCj3LN1AOEiWAAUyi1LIFx6JSL0zweepYd
 e+te8ivOLj+XUyW1Z5pDnZY8SfHALPZjGaNabUBrgBJNxJq76MX+fspSXbUOVBkn+Igh Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33sdxx1wst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 06:33:04 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08PAX4We101084;
 Fri, 25 Sep 2020 06:33:04 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33sdxx1wn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 06:33:04 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08PAW3Do024587;
 Fri, 25 Sep 2020 10:32:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04fra.de.ibm.com with ESMTP id 33n9m7u73e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 10:32:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08PAWixe20840816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2020 10:32:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0E534204D;
 Fri, 25 Sep 2020 10:32:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5942A42041;
 Fri, 25 Sep 2020 10:32:42 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.77.205.231])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2020 10:32:42 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v2 0/3] powerpc/mce: Fix mce handler and add selftest
Date: Fri, 25 Sep 2020 16:01:20 +0530
Message-Id: <20200925103123.21102-1-ganeshgr@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-25_08:2020-09-24,
 2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=901 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250072
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

v2:
* Remove in_nmi check before calling nmi_enter/exit,
  as nesting is supported.
* Fix build errors and remove unused variables.
* Integrate error injection code into LKDTM.
* Add support to inject multihit in paca.

Ganesh Goudar (3):
  powerpc/mce: remove nmi_enter/exit from real mode handler
  lkdtm/powerpc: Add SLB multihit test
  selftests/lkdtm: Enable selftest for SLB multihit

 arch/powerpc/kernel/mce.c               |  10 +-
 drivers/misc/lkdtm/Makefile             |   4 +
 drivers/misc/lkdtm/core.c               |   3 +
 drivers/misc/lkdtm/lkdtm.h              |   3 +
 drivers/misc/lkdtm/powerpc.c            | 132 ++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |   1 +
 6 files changed, 149 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/lkdtm/powerpc.c

-- 
2.26.2

