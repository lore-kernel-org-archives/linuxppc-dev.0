Return-Path: <pantelis@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id B66DF68A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 03:16:51 +1100 (EST)
From: Pantelis Antoniou <pantelis@embeddedalley.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Misunderstanding with function cpm_dpalloc in Linux 2.6.x
Date: Wed, 25 Jan 2006 18:14:16 +0200
References: <000001c621b5$f8e45ab0$5201a8c0@GEG2400>
In-Reply-To: <000001c621b5$f8e45ab0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZP61DtYafqDk9lI"
Message-Id: <200601251814.17331.pantelis@embeddedalley.com>
Reply-To: pantelis@embeddedalley.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_ZP61DtYafqDk9lI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 25 January 2006 15:48, Laurent Lagrange wrote:
> 
> Hello,
> 
> I work on MPC boards with Linux 2.6.9 and I have a problem with the
> cpm_dpalloc function.
> 
> In the file cpm2_common.c the function "uint cpm_dpalloc(uint size, uint
> align)" is intended
> to allocate a piece of memory in the dpram. This piece of memory has at
> least "size" bytes
> and I beleived that the returned address should be aligned on "align" bytes.
> 
> This function calls "void *rh_alloc(rh_info_t * info, int size, const char
> *owner)" from rheap.c file.
> In this function the alignment is only used to calculate the right size with
> the formula :
> size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
> It seems to be right but the alignment is not used to retreive an aligned
> start address.
> 
> So if I do the following sequential calls, I have the following results :
> cpm_dpalloc(16, 8)	-> 	0XC0		-> right aligned
> cpm_dpalloc(64, 64)	-> 	0XD0		-> wrong aligned -> must be 0x100
> cpm_dpalloc(16, 8)	-> 	0X110		-> right aligned but wrong to use
> cpm_dpalloc(24, 8)	-> 	0X1200		-> right aligned but wrong to use
> 
> I can have the wanted values if instead of size, I try to allocate (size +
> align - 1) bytes
> but I don't think it is the solution.
> 
> Perhaps, I don't understand the allocation theory.
> Any idea ?
> 
> Thanks all
> Laurent
> 
> 

Laurent Hi,

Yes this is a know bug. This patch fixes it.

Marcelo, please apply - we have this hanging for quite a while.

Pantelis

--Boundary-00=_ZP61DtYafqDk9lI
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cpm2-dpalloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpm2-dpalloc.patch"

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
 

--Boundary-00=_ZP61DtYafqDk9lI--
