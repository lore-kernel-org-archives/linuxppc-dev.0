Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwBq55kFLzDrnx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 07:49:33 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25Khq2o087777
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 15:49:32 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gh9253pxp-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 15:49:31 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Mon, 5 Mar 2018 13:49:31 -0700
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gromero@linux.vnet.ibm.com, mpe@ellerman.id.au, cyrilbur@gmail.com
Subject: [PATCH] Fixes for selftest tm-unavailable
Date: Mon,  5 Mar 2018 15:48:54 -0500
Message-Id: <1520282935-20111-1-git-send-email-gromero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent fix by mpe for tm-trap [1] (thanks for fixing it! really
sorry for the late reply, I got dragged away by the darn thingy)
caught my attention to the fact that tm-unavailable needs a similar
fix. Also before that on Feb. Cyril Bur proposed another small fix for
the same selftest [2]. Since Cyril's change is not merged yet I
decided to take Cyril's fix into account as well. Finally, I also
noted that tm-unavailable is not using the test harness, thus I
added it to tm-unavailable.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=192b2e742c06af399e8eecb4a17265
[2] https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-February/169111.html

Gustavo Romero (1):
  selftests/powerpc: Skip tm-unavailable if TM is not enabled

 .../testing/selftests/powerpc/tm/tm-unavailable.c  | 24 ++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.7.4
