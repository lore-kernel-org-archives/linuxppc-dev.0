Return-Path: <jk@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80C83DE1C2
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 15:00:52 +1100 (EST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 2/3] powerpc: Add dispatch trace log fields to lppaca
Message-Id: <1236830152.729016.80970422404.2.gpush@pingu>
In-Reply-To: <1236830152.728754.855135891014.1.gpush@pingu>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 12 Mar 2009 14:55:52 +1100
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PAPR v2.3 defines fields in the virtual processor area for a dispatch
trace log (DLT). Since we'd like to use the DLT, add the necessary
fields to struct lppaca.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/include/asm/lppaca.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index b063121..68235f7 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -97,7 +97,7 @@ struct lppaca {
 	u64	saved_gpr4;		// Saved GPR4                   x28-x2F
 	u64	saved_gpr5;		// Saved GPR5                   x30-x37
 
-	u8	reserved4;		// Reserved			x38-x38
+	u8	dtl_enable_mask;	// Dispatch Trace Log mask	x38-x38
 	u8	donate_dedicated_cpu;	// Donate dedicated CPU cycles  x39-x39
 	u8	fpregs_in_use;		// FP regs in use               x3A-x3A
 	u8	pmcregs_in_use;		// PMC regs in use              x3B-x3B
@@ -134,7 +134,9 @@ struct lppaca {
 // CACHE_LINE_4-5 0x0180 - 0x027F Contains PMC interrupt data
 //=============================================================================
 	u32	page_ins;		// CMO Hint - # page ins by OS  x00-x03
-	u8	pmc_save_area[252];	// PMC interrupt Area           x04-xFF
+	u8	reserved8[148];		// Reserved                     x04-x97
+	volatile u64 dtl_idx;		// Dispatch Trace Log head idx	x98-x9F
+	u8	reserved9[96];		// Reserved                     xA0-xFF
 } __attribute__((__aligned__(0x400)));
 
 extern struct lppaca lppaca[];
