Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS3ZV3fKNzDqwh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:58:58 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L1rTV8131819
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:58:56 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r2sjnny6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:58:56 -0500
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 22:58:53 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 6D4BD352006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:58:17 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L1woa437290076
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 22:58:50 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L1wn7a031919
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 22:58:50 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, xinhui.pan@linux.vnet.ibm.com,
 gpiccoli@linux.vnet.ibm.com
Subject: [PATCH v2 0/3] powerpc/xmon: improvements and fixes
Date: Mon, 20 Feb 2017 22:58:39 -0300
Message-Id: <1487642322-28380-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
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

Guilherme G. Piccoli (2):
  powerpc/xmon: drop the nobt option from xmon plus minor fixes
  powerpc/xmon: add debugfs entry for xmon

Pan Xinhui (1):
  powerpc/xmon: Fix an unexpected xmon on/off state change


 arch/powerpc/xmon/xmon.c | 62 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 12 deletions(-)

-- 
2.7.4
