Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AA097DE733
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:27:50 +1000 (EST)
Message-ID: <4818F1BA.80408@am.sony.com>
Date: Wed, 30 Apr 2008 15:24:58 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 1/5] POWERPC: Fix slb.c compile warnings
References: <20080430215644.655638516@am.sony.com>
In-Reply-To: <20080430215644.655638516@am.sony.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arrange for a syntax check to always be done on the powerpc/mm/slb.c
DBG() macro by defining it to pr_debug() for non-debug builds. 

Also, fix these related compile warnings:

  slb.c:273: warning: format '%04x' expects type 'unsigned int', but argument 2 has type 'long unsigned int
  slb.c:274: warning: format '%04x' expects type 'unsigned int', but argument 2 has type 'long unsigned int'

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/mm/slb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -30,7 +30,7 @@
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
 #else
-#define DBG(fmt...)
+#define DBG pr_debug
 #endif
 
 extern void slb_allocate_realmode(unsigned long ea);
@@ -279,8 +279,8 @@ void slb_initialize(void)
 		patch_slb_encoding(slb_compare_rr_to_size,
 				   mmu_slb_size);
 
-		DBG("SLB: linear  LLP = %04x\n", linear_llp);
-		DBG("SLB: io      LLP = %04x\n", io_llp);
+		DBG("SLB: linear  LLP = %04lx\n", linear_llp);
+		DBG("SLB: io      LLP = %04lx\n", io_llp);
 	}
 
 	get_paca()->stab_rr = SLB_NUM_BOLTED;

-- 
