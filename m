Return-Path: <medp@primagraphics.co.uk>
Received: from mail.primagraphics.com (unknown [81.20.3.25])
	by ozlabs.org (Postfix) with SMTP id 250072BF4B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 21:57:44 +1100 (EST)
Message-ID: <4193459F.8010803@primagraphics.co.uk>
Date: Thu, 11 Nov 2004 10:57:35 +0000
From: Mark Powell <medp@primagraphics.co.uk>
MIME-Version: 1.0
To: Neil Wilson <NWilson@Airspan.com>
References: <3506EDCDEC47904CBE6FD2E1DEEA8984020CFB73@fs5.airspan.com>
In-Reply-To: <3506EDCDEC47904CBE6FD2E1DEEA8984020CFB73@fs5.airspan.com>
Content-Type: multipart/mixed; boundary="------------090705060500090005080301"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mmap64/open64/pread etc on 440GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090705060500090005080301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

FWIW, the attached might help.

This is something I added to our 2.4.25 (10-May-04) tree to allow me do 
the same thing on our '440GP platform.
The patch adds a file to arch/ppc/mm that provides an 
io_remap_page_range64() function, analogous to ioremap64().
drv_mmap.c is the body of the mmap() entry point in my driver for an 
example.

Hope it is useful

-- 
Mark Powell, Senior Software Engineer
Primagraphics, Curtiss-Wright Controls Embedded Computing
Tel: +44 (0) 1763 852222
Email: medp@primagraphics.com


Neil Wilson wrote:

> 
>  
>
>>I'm working on some patches to fix 36-bit support for
>>io_remap_page_range() and to fix some problems with set_pte() 
>>and friends on 36-bit platforms. This is the first bit 
>>necessary to make this work at all in 2.6. I should be 
>>posting something RSN. ;)
>>
>>-Matt
>>    
>>
>
>Okay, thanks for the info.
>
>Guess I will have to put together a simple kernel driver so the hardware
>boys can get 36bit access for now.
>
>Neil
>
>  
>

--------------090705060500090005080301
Content-Type: text/plain;
 name="mm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm.patch"

diff -urN --exclude=CVS ../10-May-04/arch/ppc/mm/44x_remap.c ./arch/ppc/mm/44x_remap.c
--- ../10-May-04/arch/ppc/mm/44x_remap.c	Thu Jan  1 01:00:00 1970
+++ ./arch/ppc/mm/44x_remap.c	Thu Jun  3 16:54:44 2004
@@ -0,0 +1,102 @@
+/* 
+ * Implementation of remap_page_range() for IBM440GP where physical
+ * addresses are 36 bits.
+ * 
+ * This differs form ioremap64() in that it manipulates the
+ * current process's page tables.
+ * 
+ * $Id: 44x_remap.c,v 1.1 2004/06/03 15:54:44 medp Exp $
+ * $Log: 44x_remap.c,v $
+ * Revision 1.1  2004/06/03 15:54:44  medp
+ * Added io_remap_page_range64
+ *
+ */
+#include <linux/mm.h>
+
+
+static inline void forget_pte(pte_t page)
+{
+	if (!pte_none(page)) {
+		printk("forget_pte: old mapping existed!\n");
+		BUG();
+	}
+}
+
+/*
+ * maps a range of physical memory into the requested pages. the old
+ * mappings are removed. any references to nonexistent pages results
+ * in null mappings (currently treated as "copy-on-access")
+ */
+static inline void io_remap_pte_range64(pte_t * pte, unsigned long address, unsigned long size,
+	phys_addr_t phys_addr, pgprot_t prot)
+{
+	unsigned long end;
+
+	address &= ~PMD_MASK;
+	end = address + size;
+	if (end > PMD_SIZE)
+		end = PMD_SIZE;
+	do {
+		pte_t oldpage;
+		oldpage = ptep_get_and_clear(pte);
+
+ 		set_pte(pte, mk_pte_phys(phys_addr, prot));
+		forget_pte(oldpage);
+		address += PAGE_SIZE;
+		phys_addr += PAGE_SIZE;
+		pte++;
+	} while (address && (address < end));
+}
+
+static inline int io_remap_pmd_range64(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
+	phys_addr_t phys_addr, pgprot_t prot)
+{
+	unsigned long end;
+
+	address &= ~PGDIR_MASK;
+	end = address + size;
+	if (end > PGDIR_SIZE)
+		end = PGDIR_SIZE;
+	phys_addr -= address;
+	do {
+		pte_t * pte = pte_alloc(mm, pmd, address);
+		if (!pte)
+			return -ENOMEM;
+		io_remap_pte_range64(pte, address, end - address, address + phys_addr, prot);
+		address = (address + PMD_SIZE) & PMD_MASK;
+		pmd++;
+	} while (address && (address < end));
+	return 0;
+}
+
+/*  Note: this is only safe if the mm semaphore is held when called. */
+int io_remap_page_range64(unsigned long from, phys_addr_t phys_addr, unsigned long size, pgprot_t prot)
+{
+	int error = 0;
+	pgd_t * dir;
+	unsigned long beg = from;
+	unsigned long end = from + size;
+	struct mm_struct *mm = current->mm;
+
+	phys_addr -= from;
+	dir = pgd_offset(mm, from);
+	flush_cache_range(mm, beg, end);
+	if (from >= end)
+		BUG();
+
+	spin_lock(&mm->page_table_lock);
+	do {
+		pmd_t *pmd = pmd_alloc(mm, dir, from);
+		error = -ENOMEM;
+		if (!pmd)
+			break;
+		error = io_remap_pmd_range64(mm, pmd, from, end - from, phys_addr + from, prot);
+		if (error)
+			break;
+		from = (from + PGDIR_SIZE) & PGDIR_MASK;
+		dir++;
+	} while (from && (from < end));
+	spin_unlock(&mm->page_table_lock);
+	flush_tlb_range(mm, beg, end);
+	return error;
+}
diff -urN --exclude=CVS ../10-May-04/arch/ppc/mm/Makefile ./arch/ppc/mm/Makefile
--- ../10-May-04/arch/ppc/mm/Makefile	Tue Dec 16 20:12:55 2003
+++ ./arch/ppc/mm/Makefile	Thu Jun  3 16:54:44 2004
@@ -19,7 +19,7 @@
 
 obj-$(CONFIG_PPC_STD_MMU)	+= hashtable.o ppc_mmu.o tlb.o
 obj-$(CONFIG_40x)		+= 4xx_mmu.o
-obj-$(CONFIG_44x)		+= 44x_mmu.o
+obj-$(CONFIG_44x)		+= 44x_mmu.o 44x_remap.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= cachemap.o
 
 include $(TOPDIR)/Rules.make

--------------090705060500090005080301
Content-Type: text/plain;
 name="drv_mmap.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drv_mmap.c"

/*
 * - Function ----------------------------------------------------------------
 *
 *  sentric_fpga_mmap
 *
 *      This function maps the FPGA register block to user space.
 *
 *  Parameters:
 *      filep           Pointer to file struct for this device.
 *      vma             Pointer to the virtual memory area struct to map to.
 *
 *  Returns:
 *      0 success, -ve number is an error code.
 *
 *  Notes:
 *      None.
 * ---------------------------------------------------------------------------
 */
int
sentric_fpga_mmap(struct file *filep, struct vm_area_struct *vma)
{
    unsigned long off;
    phys_addr_t phys;
    unsigned long vsize, psize;

    /* Convert requested offset in units of pages to bytes */
    /* This is the offset from base of FPGA regs region, should always be 0 */
    off = vma->vm_pgoff << PAGE_SHIFT;

    /* physical address */
    phys = SENTRIC_FPGA_ADDR;

    /* Check that the user hasn't asked for more than is available */
    vsize = vma->vm_end - vma->vm_start;
    psize = PAGE_SIZE - off;
    if (vsize > psize) {
        printk("sentric_fpga:mmap: requested too much i/o space: %ld\n", vsize);
        return -EINVAL;
    }

    /* Use non-cached accesses as this is shared-memory */
    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

    /* Don't try to swap out physical pages.. */
    vma->vm_flags |= VM_RESERVED;

    /* Don't dump addresses that are not real memory to a core file. */
    vma->vm_flags |= VM_IO;

    if (io_remap_page_range64(vma->vm_start, phys, vsize, vma->vm_page_prot)) {
        return -EAGAIN;
    }

    return 0;
} /* sentric_fpga_mmap() */


--------------090705060500090005080301--
