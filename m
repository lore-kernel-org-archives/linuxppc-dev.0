Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52B631A073D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 14:28:49 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C5FFB14141A
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:48 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 18 Nov 2015 13:28:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EB8EC2CE8055
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:44 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAI3ScrF33882116
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:46 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAI3SCp6027540
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:12 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] powerpc: Explicitly disable math features when copying
 thread
Date: Wed, 18 Nov 2015 14:26:51 +1100
Message-Id: <1447817215-15804-5-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With threads leaving the math bits enabled in their saved MSR to indicate
that the hardware is hot and a restore is not needed, children need to turn
it off as when they do get scheduled, there's no way their registers could
have been hot.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 398f7bf..441d9e5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1243,6 +1243,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 		f = ret_from_fork;
 	}
+	childregs->msr &= ~(MSR_FP|MSR_VEC|MSR_VSX);
 	sp -= STACK_FRAME_OVERHEAD;
 
 	/*
-- 
2.6.2
