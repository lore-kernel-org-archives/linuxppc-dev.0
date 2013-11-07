Return-Path: <rusty@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E6102C014B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 12:21:47 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rusty@au1.ibm.com>;
 Thu, 7 Nov 2013 11:21:29 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 496A52BB0056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 12:21:27 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA713utb7275000
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 12:03:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rA71LQAh016454
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 12:21:26 +1100
From: Rusty Russell <rusty@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc: Set eflags correctly for ELF ABIv2 core dumps.
Date: Thu,  7 Nov 2013 11:46:50 +1030
Message-Id: <1383787012-16455-2-git-send-email-rusty@au1.ibm.com>
In-Reply-To: <1383787012-16455-1-git-send-email-rusty@au1.ibm.com>
References: <1383787012-16455-1-git-send-email-rusty@au1.ibm.com>
Cc: Rusty Russell <rusty@au1.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We leave it at zero (though it could be 1) for old tasks.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/include/asm/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 54c7445..8b89268 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -106,6 +106,8 @@ do {								\
 } while (0)
 # endif /* COMPAT */
 
+#define ELF_CORE_EFLAGS (is_elf2_task() ? 2 : 0)
+
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
  * have the READ_IMPLIES_EXEC personality flag set automatically. This
-- 
1.8.3.2
