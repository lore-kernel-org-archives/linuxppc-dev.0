Message-ID: <39118EF1.89359645@ccrl.mot.com>
Date: Thu, 04 May 2000 09:53:37 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: non-cacheable memory/sym53c8xx driver
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
Thanks for the tips on allocating non-cacheable memory regions. But I'm
still a bit stuck. I've been working to get the sym53c8xx scsi driver
working on an 8xx system. The problems are completely cache related.
Once I got past endian issues, I found that if I completely disable the
data cache the driver works fine and I can access scsi devices.
Obviously a non-optimal solution. I don't understand how the cache works
in desktop systems, but my guess is that PCI devices can snoop on the
processor's cache - which is what makes this driver work in a desktop
system. Obviously this isn't true for 8xx. So the obvious (at least to
me) solution is to ensure that any memory that the SCSI controller reads
or writes to is not cached. Conviently the driver has its own allocation
routines to allocate these regions of memory which are shared between
the processor and the SCSI controller. I *belive* that every structure
in main memory that the SCSI controller accesses is allocated by these
routines.  I took a shot at making these regions non-cacheable, but
I don't understand these routines well enough to know what I'm doing.
I've included the relavent section of the sym53c8xx.c. You can see what
I've added - following the examples in fec.c for marking pages
non-cacheable. When the flush_tlb_page() call is un-commented it causes
a kernal crash - "kernel access of bad area". That's why I added
flush_dcache_range() at the bottom but it doesn't seem to help. As it
is, with dcache enabled and these additions to the allocation routines,
I still have problems with the SCSI controller accessing bad data
(because the real data is in the cache). So I have two questions:
- why does flush_tlb_page cause kernel access to bad memory?
- is what I'm doing correct to ensure that the pointer returned by
__m_alloc() will be pointing to regions of memory that are not
cacheable?

Thanks,
Steve

/*
** Simple power of two buddy-like allocator
** ----------------------------------------
** This simple code is not intended to be fast, but to provide
** power of 2 aligned memory allocations.
** Since the SCRIPTS processor only supplies 8 bit arithmetic,
** this allocator allows simple and fast address calculations
** from the SCRIPTS code. In addition, cache line alignment
** is guaranteed for power of 2 cache line size.
*/

#define MEMO_SHIFT 4 /* 16 bytes minimum memory chunk */
#define MEMO_PAGE_ORDER 0 /* 1 PAGE maximum (for now (ever?) */
typedef unsigned long addr; /* Enough bits to bit-hack addresses */

#define MEMO_FREE_UNUSED /* Free unused pages immediately */

struct m_link {
 struct m_link *next; /* Simple links are enough */
};

#ifndef GFP_DMA_32BIT
#define GFP_DMA_32BIT 0 /* Will this flag ever exist */
#endif

#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,0)
#define get_pages(order) __get_free_pages(GFP_ATOMIC | GFP_DMA_32BIT,
order)
#else
#define get_pages(order) __get_free_pages(GFP_ATOMIC | GFP_DMA_32BIT,
order, 0)
#endif

/*
** Lists of available memory chunks.
** Starts with 16 bytes chunks until 1 PAGE chunks.
*/
static struct m_link h[PAGE_SHIFT-MEMO_SHIFT+MEMO_PAGE_ORDER+1];

/*
** Allocate a memory area aligned on the lowest power of 2
** greater than the requested size.
*/
static void *__m_alloc(int size)
{
 int i = 0;
 int s = (1 << MEMO_SHIFT);
 int j;
 addr a ;
#ifdef CONFIG_8xx
 pte_t *pte;
#endif

 if (size > (PAGE_SIZE << MEMO_PAGE_ORDER))
  return 0;

 while (size > s) {
  s <<= 1;
  ++i;
 }

 j = i;
 while (!h[j].next) {
  if (s == (PAGE_SIZE << MEMO_PAGE_ORDER)) {
   h[j].next = (struct m_link *)get_pages(MEMO_PAGE_ORDER);
   if (h[j].next)
    h[j].next->next = 0;
#if CONFIG_8xx
     pte = va_to_pte(&init_task, (int) h[j].next);
     pte_val(*pte) |= _PAGE_NO_CACHE;
     /* flush_tlb_page(current->mm->mmap, h[j].next); */
#endif
   break;
  }
  ++j;
  s <<= 1;
 }
 a = (addr) h[j].next;
 if (a) {
  h[j].next = h[j].next->next;
  while (j > i) {
   j -= 1;
   s >>= 1;
   h[j].next = (struct m_link *) (a+s);
   h[j].next->next = 0;
  }
 }
#ifdef CONFIG_8xx
 flush_dcache_range(a, a+size);
#endif
#ifdef DEBUG
 printk("m_alloc(%d) = %p\n", size, (void *) a);
#endif
 return (void *) a;
}


--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
