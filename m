Return-Path: <srs0=emdd=iy=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410wqP5KGMzF1xq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 14:36:33 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 410wqP4g69z8tLb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 14:36:33 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 410wqN75HCzB3h5
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2018 14:36:32 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w564YZBn107007
 for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2018 00:36:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2je3bqaawq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Jun 2018 00:36:31 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 6 Jun 2018 05:36:28 +0100
Subject: [RFC PATCH 0/4] powerpc/pseries: Machien check handler improvements.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 06 Jun 2018 10:06:23 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152825972491.24560.4626614298142965406.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series includes some improvement to Machine check handler
for pseries. Patch 1 fixes an issue where machine check handler crashes
kernel while accessing vmalloc-ed buffer while in nmi context.
Patch 3 dumps the SLB contents on SLB MCE errors to improve the debugability.
Patch 4 display's the MCE error details on console.

---

Mahesh Salgaonkar (4):
      powerpc/pseries: convert rtas_log_buf to linear allocation.
      powerpc/pseries: Define MCE error event section.
      powerpc/pseries: Dump and flush SLB contents on SLB MCE errors.
      powerpc/pseries: Display machine check error details.


 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    1 
 arch/powerpc/include/asm/rtas.h               |  109 +++++++++++++++++++
 arch/powerpc/kernel/rtasd.c                   |    2 
 arch/powerpc/mm/slb.c                         |   35 ++++++
 arch/powerpc/platforms/pseries/ras.c          |  145 +++++++++++++++++++++++++
 5 files changed, 290 insertions(+), 2 deletions(-)

--
Signature
