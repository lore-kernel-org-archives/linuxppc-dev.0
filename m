Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 46EB9680F4
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Aug 2005 21:49:20 +1000 (EST)
Date: Sun, 28 Aug 2005 13:49:15 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Message-ID: <20050828114915.GA16138@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] fix -Wundef warning for CONFIG_8xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


happens with allnoconfig + CONFIG_SWAP, introduced with -rc4

linux-2.6.12/arch/ppc/mm/init.c:565:7: warning: "CONFIG_8xx" is not defined

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/ppc/mm/init.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12/arch/ppc/mm/init.c
===================================================================
--- linux-2.6.12.orig/arch/ppc/mm/init.c
+++ linux-2.6.12/arch/ppc/mm/init.c
@@ -562,7 +562,7 @@ void flush_dcache_icache_page(struct pag
 #ifdef CONFIG_BOOKE
 	__flush_dcache_icache(kmap(page));
 	kunmap(page);
-#elif CONFIG_8xx
+#elif defined(CONFIG_8xx)
 	/* On 8xx there is no need to kmap since highmem is not supported */
 	__flush_dcache_icache(page_address(page)); 
 #else
