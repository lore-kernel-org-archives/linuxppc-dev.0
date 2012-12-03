Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D8D72C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2012 17:19:34 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 3 Dec 2012 11:49:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id AE6D31258057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2012 11:49:08 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB36JP5522741074
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Dec 2012 11:49:25 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB3BnGVI006261
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Dec 2012 22:49:16 +1100
Message-ID: <1354515562.3243.27.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [PATCH powerpc] Fix MAX_STACK_TRACE_ENTRIES too low warning for ppc32
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 03 Dec 2012 14:19:22 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christian Kujau <lists@nerdbynature.de>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes MAX_STACK_TRACE_ENTRIES too low warning for ppc32,
which is similar to commit 12660b17. 

Reported-by: Christian Kujau <lists@nerdbynature.de>
Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
Tested-by: Christian Kujau <lists@nerdbynature.de>
---
 arch/powerpc/kernel/entry_32.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index d22e73e..e514de5 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -439,6 +439,8 @@ ret_from_fork:
 ret_from_kernel_thread:
 	REST_NVGPRS(r1)
 	bl	schedule_tail
+	li	r3,0
+	stw	r3,0(r1)
 	mtlr	r14
 	mr	r3,r15
 	PPC440EP_ERR42
-- 
1.7.9.5
