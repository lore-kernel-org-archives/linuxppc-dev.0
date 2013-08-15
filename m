Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9FB562C0233
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 21:50:52 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 3/3] powerpc: check CPU_FTR_COHERENT_ICACHE in
 __flush_dcache_icache for 64bit kernel
Date: Thu, 15 Aug 2013 19:45:18 +0800
Message-ID: <1376567118-16946-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <20130807060950.GC26904@pek-khao-d1.corp.ad.wrs.com>
References: <20130807060950.GC26904@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't need to flush the dcache and invalidate the icache on the
CPU which has CPU_FTR_COHERENT_ICACHE set. Also add the missing
required isync in this case.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Add the isync.

 arch/powerpc/kernel/misc_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 971d7e7..992a78e 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -207,6 +207,10 @@ _GLOBAL(flush_inval_dcache_range)
  *	void __flush_dcache_icache(void *page)
  */
 _GLOBAL(__flush_dcache_icache)
+BEGIN_FTR_SECTION
+	isync
+	blr
+END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 /*
  * Flush the data cache to memory 
  * 
-- 
1.8.3.1
