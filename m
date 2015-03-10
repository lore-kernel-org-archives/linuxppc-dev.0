Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 675571A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 23:42:20 +1100 (AEDT)
Received: by ykp131 with SMTP id 131so533260ykp.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 05:42:18 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: book3e_64: fix the align size for paca_struct
Date: Tue, 10 Mar 2015 20:41:31 +0800
Message-Id: <1425991291-24462-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All the cache line size of the current book3e 64bit SoCs are 64 bytes.
So we should use this size to align the member of paca_struct.
This only change the paca_struct's members which are private to book3e
CPUs, and should not have any effect to book3s ones. With this, we save
192 bytes. Also change it to __aligned(size) since it is preferred over
__attribute__((aligned(size))).

Before:
	/* size: 1920, cachelines: 30, members: 46 */
	/* sum members: 1667, holes: 6, sum holes: 141 */
	/* padding: 112 */

After:
	/* size: 1728, cachelines: 27, members: 46 */
	/* sum members: 1667, holes: 4, sum holes: 13 */
	/* padding: 48 */

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Only update the commit log.

 arch/powerpc/include/asm/paca.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e5f22c6c4bf9..70bd4381f8e6 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -106,9 +106,9 @@ struct paca_struct {
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
 #ifdef CONFIG_PPC_BOOK3E
-	u64 exgen[8] __attribute__((aligned(0x80)));
+	u64 exgen[8] __aligned(0x40);
 	/* Keep pgd in the same cacheline as the start of extlb */
-	pgd_t *pgd __attribute__((aligned(0x80))); /* Current PGD */
+	pgd_t *pgd __aligned(0x40); /* Current PGD */
 	pgd_t *kernel_pgd;		/* Kernel PGD */
 
 	/* Shared by all threads of a core -- points to tcd of first thread */
-- 
2.1.0
