Return-Path: <jk@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 737D8DE1B7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 15:00:52 +1100 (EST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1/3] powerpc: Fix page_ins details in lppaca comments
Message-Id: <1236830152.728754.855135891014.1.gpush@pingu>
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

The page_ins member ends at byte 0x3, not 0x4. Also, fix up the
alignment.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/include/asm/lppaca.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 25aaa97..b063121 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -133,7 +133,7 @@ struct lppaca {
 //=============================================================================
 // CACHE_LINE_4-5 0x0180 - 0x027F Contains PMC interrupt data
 //=============================================================================
-	u32	page_ins;			// CMO Hint - # page ins by OS  x00-x04
+	u32	page_ins;		// CMO Hint - # page ins by OS  x00-x03
 	u8	pmc_save_area[252];	// PMC interrupt Area           x04-xFF
 } __attribute__((__aligned__(0x400)));
 
