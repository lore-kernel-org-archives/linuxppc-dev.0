Date: Sat, 14 Feb 2004 17:46:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Missing isa_ symbols
Message-ID: <20040214164611.GA15893@lst.de>
References: <20040203210321.GA19689@lst.de> <20040203231728.GF1860@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040203231728.GF1860@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 03, 2004 at 04:17:28PM -0700, Tom Rini wrote:
> On PPC32, CONFIG_ISA is kinda hack'ish.  I know it will / must work on
> PRePs, and it _may_ but I'm not certain of some CHRP machines as well.
> So you can probably look at the i386 versions of the functions (save for
> udelay as Ben mentioned) and do something like:
> if (_machine == _MACH_prep) {
>  ... do i386 version ...
> } else
>  return -EINVAL; // whatever

Well, there's no really sane error return for any of those, but as these
routines are clearly for isa drivers only I'd just implement the prep
versions.

Does this patch look okay?

--- 1.16/include/asm-ppc/io.h	Wed Feb  4 06:31:18 2004
+++ edited/include/asm-ppc/io.h	Fri Feb 13 07:30:39 2004
@@ -199,6 +199,26 @@
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))

 /*
+ * ISA space is 'always mapped' on a typical prep system, no need to
+ * explicitly ioremap() it. The fact that the ISA IO space is mapped
+ * to PAGE_OFFSET is pure coincidence - it does not mean ISA values
+ * are physical addresses. The following constant pointer can be
+ * used as the IO-area pointer (it can be iounmapped as well, so the
+ * analogy with PCI is quite large):
+ */
+#define __ISA_IO_base ((char *)(PAGE_OFFSET))
+
+#define isa_readb(a) readb(__ISA_IO_base + (a))
+#define isa_readw(a) readw(__ISA_IO_base + (a))
+#define isa_readl(a) readl(__ISA_IO_base + (a))
+#define isa_writeb(b,a) writeb(b,__ISA_IO_base + (a))
+#define isa_writew(w,a) writew(w,__ISA_IO_base + (a))
+#define isa_writel(l,a) writel(l,__ISA_IO_base + (a))
+#define isa_memset_io(a,b,c)		memset_io(__ISA_IO_base + (a),(b),(c))
+#define isa_memcpy_fromio(a,b,c)	memcpy_fromio((a),__ISA_IO_base + (b),(c))
+#define isa_memcpy_toio(a,b,c)		memcpy_toio(__ISA_IO_base + (a),(b),(c))
+
+/*
  * Map in an area of physical address space, for accessing
  * I/O devices etc.
  */
@@ -265,6 +285,13 @@
 	return (void*) mm_ptov (address);
 #endif
 }
+
+/*
+ * ISA I/O bus memory addresses are 1:1 with the physical address.
+ */
+#define isa_virt_to_bus virt_to_phys
+#define isa_page_to_bus page_to_phys
+#define isa_bus_to_virt phys_to_virt

 /*
  * Change "struct page" to physical address.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
