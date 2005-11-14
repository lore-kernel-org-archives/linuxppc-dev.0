Return-Path: <galak@gate.crashing.org>
Date: Mon, 14 Nov 2005 17:21:44 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0511141721190.9033-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: put page page_to_virt for Book-e processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Book-E processors use page_to_virt since we have to always translate.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 62ac3a10f41d7d300cf82846348f65eab0dbfd40
tree 039f1c393bd77fb8c6daf1c8ebd883c9a72be6e2
parent ed24c128ba54329d142c4d4c7c5e05cec6065b08
author Kumar Gala <galak@kernel.crashing.org> Mon, 14 Nov 2005 17:22:35 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 14 Nov 2005 17:22:35 -0600

 include/asm-powerpc/page.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/page.h b/include/asm-powerpc/page.h
index 18c1e5e..e34a2ba 100644
--- a/include/asm-powerpc/page.h
+++ b/include/asm-powerpc/page.h
@@ -53,6 +53,7 @@
 #endif
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
