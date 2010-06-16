Return-Path: <dkirjanov@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BA9FB7D7F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 00:34:55 +1000 (EST)
Date: Wed, 16 Jun 2010 14:34:44 +0000
From: Denis Kirjanov <dkirjanov@hera.kernel.org>
To: benh@kernel.crashing.org, sfr@canb.auug.org.au
Subject: [PATCH] powerpc/iseries: fix constant warning
Message-ID: <20100616143444.GA5095@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix smatch warning: constant 0x8000000000000000 is so big it is unsigned long

Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>
---
arch/powerpc/include/asm/abs_addr.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/abs_addr.h b/arch/powerpc/include/asm/abs_addr.h
index 98324c5..c3bffc3 100644
--- a/arch/powerpc/include/asm/abs_addr.h
+++ b/arch/powerpc/include/asm/abs_addr.h
@@ -69,7 +69,7 @@ static inline unsigned long phys_to_abs(unsigned long pa)
  * Legacy iSeries Hypervisor calls
  */
 #define iseries_hv_addr(virtaddr)	\
-	(0x8000000000000000 | virt_to_abs(virtaddr))
+	(0x8000000000000000UL | virt_to_abs(virtaddr))
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_ABS_ADDR_H */
