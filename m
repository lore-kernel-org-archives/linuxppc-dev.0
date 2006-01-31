Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED90368A2D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 11:21:51 +1100 (EST)
Date: Tue, 31 Jan 2006 16:22:11 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: rheap allocator should honour alignment parameter
Message-ID: <20060131222211.GA10627@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pantelis Antoniou <pantelis@embeddedalley.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


From: Pantelis Antoniou <pantelis@embeddedalley.com>

Honour alignment parameter in the rheap allocator.

Signed-off-by: Pantelis Antoniou <pantelis@embeddedalley.com>

diff --git a/arch/ppc/lib/rheap.c b/arch/ppc/lib/rheap.c
--- a/arch/ppc/lib/rheap.c
+++ b/arch/ppc/lib/rheap.c
@@ -425,17 +425,21 @@ void *rh_detach_region(rh_info_t * info,
 	return (void *)s;
 }
 
-void *rh_alloc(rh_info_t * info, int size, const char *owner)
+void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owner)
 {
 	struct list_head *l;
 	rh_block_t *blk;
 	rh_block_t *newblk;
 	void *start;
 
-	/* Validate size */
-	if (size <= 0)
+	/* Validate size, (must be power of two) */
+	if (size <= 0 || (alignment & (alignment - 1)) != 0)
 		return ERR_PTR(-EINVAL);
 
+	/* given alignment larger that default rheap alignment */
+	if (alignment > info->alignment)
+		size += alignment - 1;
+
 	/* Align to configured alignment */
 	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
 
@@ -478,9 +482,21 @@ void *rh_alloc(rh_info_t * info, int siz
 
 	attach_taken_block(info, newblk);
 
+	/* for larger alignment return fixed up pointer  */
+	/* this is no problem with the deallocator since */
+	/* we scan for pointers that lie in the blocks   */
+	if (alignment > info->alignment)
+		start = (void *)(((unsigned long)start + alignment - 1) &
+				~(alignment - 1));
+
 	return start;
 }
 
+void *rh_alloc(rh_info_t * info, int size, const char *owner)
+{
+	return rh_alloc_align(info, size, info->alignment, owner);
+}
+
 /* allocate at precisely the given address */
 void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 {
diff --git a/arch/ppc/syslib/cpm2_common.c b/arch/ppc/syslib/cpm2_common.c
--- a/arch/ppc/syslib/cpm2_common.c
+++ b/arch/ppc/syslib/cpm2_common.c
@@ -148,8 +148,7 @@ uint cpm_dpalloc(uint size, uint align)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
-	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
+	start = rh_alloc_align(&cpm_dpmem_info, size, align, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
 	return (uint)start;
@@ -170,13 +169,12 @@ int cpm_dpfree(uint offset)
 EXPORT_SYMBOL(cpm_dpfree);
 
 /* not sure if this is ever needed */
-uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
+uint cpm_dpalloc_fixed(uint offset, uint size)
 {
 	void *start;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
 	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
 
diff --git a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
--- a/include/asm-ppc/commproc.h
+++ b/include/asm-ppc/commproc.h
@@ -74,7 +74,7 @@ static inline long IS_DPERR(const uint o
 extern	cpm8xx_t	*cpmp;		/* Pointer to comm processor */
 extern uint cpm_dpalloc(uint size, uint align);
 extern int cpm_dpfree(uint offset);
-extern uint cpm_dpalloc_fixed(uint offset, uint size, uint align);
+extern uint cpm_dpalloc_fixed(uint offset, uint size);
 extern void cpm_dpdump(void);
 extern void *cpm_dpram_addr(uint offset);
 extern void cpm_setbrg(uint brg, uint rate);
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -112,7 +112,7 @@ extern		cpm_cpm2_t	*cpmp;	 /* Pointer to
 
 extern uint cpm_dpalloc(uint size, uint align);
 extern int cpm_dpfree(uint offset);
-extern uint cpm_dpalloc_fixed(uint offset, uint size, uint align);
+extern uint cpm_dpalloc_fixed(uint offset, uint size);
 extern void cpm_dpdump(void);
 extern void *cpm_dpram_addr(uint offset);
 extern void cpm_setbrg(uint brg, uint rate);
diff --git a/include/asm-ppc/rheap.h b/include/asm-ppc/rheap.h
--- a/include/asm-ppc/rheap.h
+++ b/include/asm-ppc/rheap.h
@@ -62,6 +62,10 @@ extern int rh_attach_region(rh_info_t * 
 /* Detach a free region */
 extern void *rh_detach_region(rh_info_t * info, void *start, int size);
 
+/* Allocate the given size from the remote heap (with alignment) */
+extern void *rh_alloc_align(rh_info_t * info, int size, int alignment,
+		const char *owner);
+
 /* Allocate the given size from the remote heap */
 extern void *rh_alloc(rh_info_t * info, int size, const char *owner);
 
