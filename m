Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpKVK6Zx7zDqb3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 06:28:41 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MJNs3g062757
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 15:28:30 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29bt5bsxft-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 15:28:30 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 16:28:28 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2MJSJ3V32964684
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:28:24 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2MJS4HS014708
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:28:04 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, xinhui.pan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v4 0/3] powerpc/xmon: improvements and fixes
Date: Wed, 22 Mar 2017 16:27:48 -0300
Message-Id: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series contains some improvements and fixes to xmon:

1) Pan Xinhui fixed a long-term bug, in which the xmon debugger got
stuck enabled after invoked by sysrq, regardless the state it was
set in the kernel command-line.

2) A debugfs entry was added in order to allow users to enable/disable
xmon without needing a kernel reload.

3) The nobt option was dropped and some minor issues were fixed, like
a misplacement of __initdata.

@mpe: The series was rebased against powerpc-next.
Also, I sent the patchset before with multiple versions, now
all patches are the same version, v4.


Guilherme G. Piccoli (2):
  powerpc/xmon: drop the nobt option from xmon plus minor fixes
  powerpc/xmon: add debugfs entry for xmon

Pan Xinhui (1):
  powerpc/xmon: Fix an unexpected xmon on/off state change

 arch/powerpc/xmon/xmon.c | 59 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 16 deletions(-)

-- 
2.11.0
