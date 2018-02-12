Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zg04L0vbSzF0Xg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 20:00:17 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1C902Yx004552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 04:00:15 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g35j3d2yr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 04:00:15 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 12 Feb 2018 09:00:12 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param
 xmon=off
Date: Mon, 12 Feb 2018 14:29:56 +0530
Message-Id: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Presently sysrq key for xmon('x') is registered during kernel init
irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
even if 'xmon=off' is passed on the kernel command line.

This minor patch updates setup_xmon_sysrq() to register
'sysrq_xmon_op' only when variable 'xmon_on' is set.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 82e1a3ee6e0f..3b995474b102 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3642,8 +3642,7 @@ static struct sysrq_key_op sysrq_xmon_op = {
 
 static int __init setup_xmon_sysrq(void)
 {
-	register_sysrq_key('x', &sysrq_xmon_op);
-	return 0;
+	return xmon_on ? register_sysrq_key('x', &sysrq_xmon_op) : 0;
 }
 device_initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
-- 
2.14.3
