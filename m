Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPYX04LDKzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 11:18:08 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1H0EQXI058877
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:05 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28nnyb16wg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:05 -0500
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 22:18:03 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A213A1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:02 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1H0I14j28835886
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:18:01 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1H0I0HV017361
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:18:00 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, xinhui.pan@linux.vnet.ibm.com,
 gpiccoli@linux.vnet.ibm.com
Subject: [PATCH 0/3] powerpc/xmon: improvements and fixes
Date: Thu, 16 Feb 2017 22:17:54 -0200
Message-Id: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
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
stuck enabled after user invoked it using sysrq, regardless of its
state set in the kernel command-line.

2) A debugfs entry was added in order to allow user to enable/disable
xmon without need a kernel reload.

3) The nobt option was dropped and some minor issues were fixed, like
a misplacement of __initdata.

@Pan Xinhui: I did a minor modification in your commit message, feel
free to improve it if you think it isn't ok.

Thanks!


Guilherme G. Piccoli (2):
  powerpc/xmon: drop the nobt option from xmon, yet keeping the
    functionality
  powerpc/xmon: add debugfs entry for xmon

Pan Xinhui (1):
  powerpc/xmon: Fix an unexpected xmon on/off state change

 arch/powerpc/xmon/xmon.c | 61 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 12 deletions(-)

-- 
2.7.4
