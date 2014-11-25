Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94DA81A0297
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 03:10:13 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 16:10:09 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 660F217D8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 16:10:22 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAPGA6X912452268
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 16:10:07 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAPGA6cT031667
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:10:06 -0700
Subject: [PATCH] powerpc: drop useless warning in eeh_init()
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 25 Nov 2014 17:10:06 +0100
Message-ID: <20141125161006.1995.31789.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is what we get in dmesg when booting a pseries guest and
the hypervisor doesn't provide EEH support.

[    0.166655] EEH functionality not supported
[    0.166778] eeh_init: Failed to call platform init function (-22)

Since both powernv_eeh_init() and pseries_eeh_init() already complain when
hitting an error, it is not needed to print more (especially such an
uninformative message).

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 2248a19..7d62018 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -920,11 +920,8 @@ int eeh_init(void)
 		pr_warn("%s: Platform EEH operation not found\n",
 			__func__);
 		return -EEXIST;
-	} else if ((ret = eeh_ops->init())) {
-		pr_warn("%s: Failed to call platform init function (%d)\n",
-			__func__, ret);
+	} else if ((ret = eeh_ops->init()))
 		return ret;
-	}
 
 	/* Initialize EEH event */
 	ret = eeh_event_init();
