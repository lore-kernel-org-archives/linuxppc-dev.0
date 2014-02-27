Return-Path: <ben@codiert.org>
Received: from mail.servclub.de (mail.servclub.de
 [IPv6:2a01:4f8:121:443:0:5212:2342:4301])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C08A42C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 02:16:13 +1100 (EST)
Date: Thu, 27 Feb 2014 15:49:21 +0100
From: Benjamin Krill <ben@codiert.org>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Fix physical address range check comparision and force
 address to be virtual address
Message-ID: <20140227144915.GA27691@codiert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ralphbel@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous code added wrong TLBs and causes machine check errors.

Signed-off-by: Ralph E. Bellofatto <ralphbel@us.ibm.com>
Signed-off-by: Benjamin Krill <ben@codiert.org>
---
 arch/powerpc/mm/tlb_low_64e.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index c95eb32..6bf5050 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -1091,7 +1091,8 @@ tlb_load_linear:
 	ld	r11,PACATOC(r13)
 	ld	r11,linear_map_top@got(r11)
 	ld	r10,0(r11)
-	cmpld	cr0,r10,r16
+	tovirt(10,10)
+	cmpld	cr0,r16,r10
 	bge	tlb_load_linear_fault
 
 	/* MAS1 need whole new setup. */
-- 
1.8.5.3
