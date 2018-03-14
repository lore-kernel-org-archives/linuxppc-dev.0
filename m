Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401msL1rRCzDqHy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 09:40:53 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EMcG6h128716
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:40:51 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gq9kcph4f-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:40:51 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 18:40:50 -0400
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
Subject: [PATCH v3 0/5] Setup RFI flush after PowerVM LPM migration
Date: Wed, 14 Mar 2018 19:40:37 -0300
Message-Id: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset allows for setup_rfi_flush() to be called again
after PowerVM LPM (live partition mobility) aka LPAR migration,
in order to possibly switch to a different flush method.

The patches are mostly from Michael Ellerman, I have rebased to
powerpc/linux.git merge branch as of commit d8443ef (March 14).

Testcase and results sent as the last email in the series.

v3: add patch 4 to tell flush types are 'available' and not 'Using'.
    remove plumbing patch.

v2: add plumbing patch between platforms and setup code to
    force init fallback flush.

Mauricio Faria de Oliveira (1):
  rfi-flush: Differentiate enabled and patched flush types

Michael Ellerman (4):
  rfi-flush: Move the logic to avoid a redo into the debugfs code
  rfi-flush: Make it possible to call setup_rfi_flush() again
  rfi-flush: Always enable fallback flush on pseries
  rfi-flush: Call setup_rfi_flush() after LPM migration

 arch/powerpc/include/asm/setup.h          |  2 +-
 arch/powerpc/kernel/setup_64.c            | 25 ++++++++++++++++---------
 arch/powerpc/lib/feature-fixups.c         |  9 ++++++++-
 arch/powerpc/platforms/pseries/mobility.c |  3 +++
 arch/powerpc/platforms/pseries/pseries.h  |  2 ++
 arch/powerpc/platforms/pseries/setup.c    | 12 ++----------
 6 files changed, 32 insertions(+), 21 deletions(-)

-- 
2.7.4
