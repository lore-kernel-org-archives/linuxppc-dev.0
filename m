Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D46D02C0110
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 15:30:24 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <stuart.yoder@freescale.com>, <James.Yang@freescale.com>
Subject: [PATCH 1/2 v2] powerpc: debug control and status registers are 32bit
Date: Thu, 16 May 2013 11:04:31 +0530
Message-ID: <1368682472-4268-2-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1368682472-4268-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1368682472-4268-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v1->v2
 - Subject line was not having 1/2

 arch/powerpc/include/asm/processor.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index d7e67ca..5213577 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -168,10 +168,10 @@ struct thread_struct {
 	 * The following help to manage the use of Debug Control Registers
 	 * om the BookE platforms.
 	 */
-	unsigned long	dbcr0;
-	unsigned long	dbcr1;
+	uint32_t	dbcr0;
+	uint32_t	dbcr1;
 #ifdef CONFIG_BOOKE
-	unsigned long	dbcr2;
+	uint32_t	dbcr2;
 #endif
 	/*
 	 * The stored value of the DBSR register will be the value at the
@@ -179,7 +179,7 @@ struct thread_struct {
 	 * user (will never be written to) and has value while helping to
 	 * describe the reason for the last debug trap.  Torez
 	 */
-	unsigned long	dbsr;
+	uint32_t	dbsr;
 	/*
 	 * The following will contain addresses used by debug applications
 	 * to help trace and trap on particular address locations.
-- 
1.5.6.5
