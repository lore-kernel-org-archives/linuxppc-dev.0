Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFq5TzKzF3D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:41:03 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJY17d101610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:41:00 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf8mj1cmx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:41:00 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:59 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 09/11] powerpc/tm: Do not restore default DSCR
Date: Wed, 12 Sep 2018 16:40:17 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-10-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the previous TM code, trecheckpoint was being executed in the middle of
an exception, thus, DSCR was being restored to default kernel DSCR value
after trecheckpoint was done.

With this current patchset, trecheckpoint is executed just before getting
to userspace, at ret_from_except_lite, for example. Thus, we do not need to
set default kernel DSCR value anymore, as we are leaving kernel space.  It
is OK to keep the checkpointed DSCR value into the live SPR, mainly because
the transaction is doomed and it will fail soon (after RFID), so,
continuing with the pre-checkpointed DSCR value is what seems correct.

That said, we must set the DSCR value that will be used in userspace now.
Current trecheckpoint() function sets it to the pre-checkpointed value
prior to lines being changed in this patch, so, removing these lines would
keep the pre-checkpointed values.

Important to say that we do not need to do the same thing with tm_reclaim,
since it already set the DSCR to the default value, after TRECLAIM is
called, in the following lines:

        /* Load CPU's default DSCR */
        ld      r0, PACA_DSCR_DEFAULT(r13)
        mtspr   SPRN_DSCR, r0

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/tm.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 6bffbc5affe7..5427eda69846 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -493,10 +493,6 @@ restore_gprs:
 	mtlr	r0
 	ld	r2, STK_GOT(r1)
 
-	/* Load CPU's default DSCR */
-	ld	r0, PACA_DSCR_DEFAULT(r13)
-	mtspr	SPRN_DSCR, r0
-
 	blr
 
 	/* ****************************************************************** */
-- 
2.19.0
