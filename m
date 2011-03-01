Return-Path: <anton@samba.org>
Date: Tue, 1 Mar 2011 17:00:47 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Add pgprot_writecombine
Message-ID: <20110301170047.601c83b7@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


A number of drivers are using pgprot_writecombine() to enable write
combining on userspace mappings. Implement it on powerpc.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 89f1587..88b0bd9 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -170,6 +170,7 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
 #define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
 				            _PAGE_COHERENT | _PAGE_WRITETHRU))
 
+#define pgprot_writecombine pgprot_noncached_wc
 
 struct file;
 extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
