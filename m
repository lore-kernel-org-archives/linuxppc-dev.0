Date: Fri, 4 Jun 2004 17:29:15 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: [RFC] Simple ioremap cache
Message-ID: <20040605002915.GA17603@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all!

I'd like to present simple optimization I have been using for a while in my
PPC 4xx tree.

PPC 4xx on-chip peripheral I/O registers are located in the same physical page:

	40x -   EF60'0000
	44x - 1'4000'0000

Different device drivers ioremap different parts of this page. Currently ioremap
implementation doesn't track previous requests and we end up with different
virtual mappings for the same physical page.

Here is ioremap profile I recorded on Ebony (PPC440GP) with only serial, EMAC &
i2c drivers enabled (2.6.7-rc2):

	ioremap(0x00000001fffffe00, 0x00001000) -> 0xfdfffe00 (0xfdfff000)
	ioremap(0x0000000148000000, 0x00002000) -> 0xfdffd000 (0xfdffd000)
	ioremap(0x000000020ec80000, 0x00001000) -> 0xfdffc000 (0xfdffc000)
	ioremap(0x0000000208000000, 0x00010000) -> 0xfdfec000 (0xfdfec000)
	ioremap(0x000000020ec00000, 0x00001000) -> 0xfdfeb000 (0xfdfeb000)
	ioremap(0x0000000140000200, 0x00001000) -> 0xfdfea200 (0xfdfea000)
	ioremap(0x0000000140000300, 0x00001000) -> 0xfdfe9300 (0xfdfe9000)
	ioremap(0x0000000140000800, 0x00001000) -> 0xd1000800 (0xd1000000)
	ioremap(0x0000000140000780, 0x00001000) -> 0xd1002780 (0xd1002000)
	ioremap(0x0000000140000900, 0x00001000) -> 0xd1004900 (0xd1004000)
	ioremap(0x0000000140000400, 0x00001000) -> 0xd1006400 (0xd1006000)
	ioremap(0x0000000140000500, 0x00001000) -> 0xd1008500 (0xd1008000)

	first number - phys address, second - size, third - ioremap result and
	the forth one - ioremap result with PAGE_MASK applied

As you can see we could save a lot of TLB misses by using just one mapping for
_all_ 440GP peripherals (440GP has a 64-entry software-managed TLB).

To optimize ioremap allocation I implemented very simple ioremap cache. I chose
to cache only page-sized allocations, also I used simple 10 entry array with
linear search. ioremap is called mostly during driver initialization so it
seemed quite reasonable not to over-complicate this stuff :)

Here is ioremap profile _after_ my patch applied:

	ioremap(0x00000001fffffe00, 0x00001000) -> 0xfdfffe00 (0xfdfff000)
	ioremap(0x0000000148000000, 0x00002000) -> 0xfdffd000 (0xfdffd000)
	ioremap(0x000000020ec80000, 0x00001000) -> 0xfdffc000 (0xfdffc000)
	ioremap(0x0000000208000000, 0x00010000) -> 0xfdfec000 (0xfdfec000)
	ioremap(0x000000020ec00000, 0x00001000) -> 0xfdfeb000 (0xfdfeb000)
	ioremap(0x0000000140000200, 0x00001000) -> 0xfdfea200 (0xfdfea000)
	ioremap(0x0000000140000300, 0x00001000) -> 0xfdfea300 (0xfdfea000)
	ioremap(0x0000000140000800, 0x00001000) -> 0xfdfea800 (0xfdfea000)
	ioremap(0x0000000140000780, 0x00001000) -> 0xfdfea780 (0xfdfea000)
	ioremap(0x0000000140000900, 0x00001000) -> 0xfdfea900 (0xfdfea000)
	ioremap(0x0000000140000400, 0x00001000) -> 0xfdfea400 (0xfdfea000)
	ioremap(0x0000000140000500, 0x00001000) -> 0xfdfea500 (0xfdfea000)


I have several questions on how we can enhance my simple hack so it can be
acceptable into mainline:

0) Do we really need such stuff in mainline :) ?

1) Should this feature be enabled for all ppc32 archs or only for 4xx? I
made ioremap profile for 2.6.6 kernel running on my G4 Powerbook and
haven't noticed a lot of ioremap regions overlap (there was one instance where
my patch would have helped if I've increased cache size to 32 entries).

2) Should we cache allocation bigger than 4K? From Ebony and tipb profiles it
doesn't seem advantogeous. Maybe other CPUs can benefit from the bigger sizes.

3) Should cache size (currently hardcoded to 10 entries) be made configurable?

4) Other enhancements I haven't thought of...

Comments/suggestions?

Here is the patch against current linux-2.5:

===== arch/ppc/mm/pgtable.c 1.19 vs edited =====
--- 1.19/arch/ppc/mm/pgtable.c	Sat May 22 14:56:23 2004
+++ edited/arch/ppc/mm/pgtable.c	Fri Jun  4 16:28:44 2004
@@ -10,6 +10,8 @@
  *    Copyright (C) 1996 Paul Mackerras
  *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
+ *  Simple ioremap cache added by Eugene Surovegin <ebs@ebshome.net>, 2004
+ *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
  *
@@ -59,6 +61,17 @@
 #define p_mapped_by_bats(x)	(0UL)
 #endif /* HAVE_BATS */

+/* simple ioremap cache */
+#define IOREMAP_CACHE_SIZE	10
+static spinlock_t ioremap_cache_lock = SPIN_LOCK_UNLOCKED;
+static int ioremap_cache_active_slots;
+static struct ioremap_cache_entry {
+	phys_addr_t 		pa;
+	unsigned long		va;
+	unsigned long		flags;
+	int			users;
+} ioremap_cache[IOREMAP_CACHE_SIZE];
+
 #ifdef CONFIG_44x
 /* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
 #define PGDIR_ORDER	1
@@ -137,6 +150,84 @@
 	__free_page(ptepage);
 }

+static unsigned long ioremap_cache_check(phys_addr_t pa, unsigned long size,
+					    unsigned long flags)
+{
+	unsigned long va = 0;
+	int i;
+
+	if (size != 0x1000)
+		return 0;
+
+	spin_lock(&ioremap_cache_lock);
+	if (!ioremap_cache_active_slots)
+		goto out;
+
+	for (i = 0; i < IOREMAP_CACHE_SIZE; ++i)
+		if (ioremap_cache[i].pa == pa &&
+		    ioremap_cache[i].flags == flags)
+		{
+			va = ioremap_cache[i].va;
+			++ioremap_cache[i].users;
+			break;
+		}
+out:
+	spin_unlock(&ioremap_cache_lock);
+
+	return va;
+}
+
+static void ioremap_cache_add(phys_addr_t pa, unsigned long va, unsigned long size,
+				unsigned long flags)
+{
+	int i;
+
+	if (size != 0x1000)
+		return;
+
+	spin_lock(&ioremap_cache_lock);
+	if (ioremap_cache_active_slots == IOREMAP_CACHE_SIZE)
+		goto out;
+
+	for (i = 0; i < IOREMAP_CACHE_SIZE; ++i)
+		if (!ioremap_cache[i].pa){
+			ioremap_cache[i].pa = pa;
+			ioremap_cache[i].va = va;
+			ioremap_cache[i].flags = flags;
+			ioremap_cache[i].users = 1;
+			++ioremap_cache_active_slots;
+			break;
+		}
+out:
+	spin_unlock(&ioremap_cache_lock);
+}
+
+static int ioremap_cache_del(unsigned long va)
+{
+	int i, res = 0;
+	va &= PAGE_MASK;
+
+	spin_lock(&ioremap_cache_lock);
+	if (!ioremap_cache_active_slots)
+		goto out;
+
+	for (i = 0; i < IOREMAP_CACHE_SIZE; ++i)
+		if (ioremap_cache[i].va == va){
+			res = --ioremap_cache[i].users;
+			if (!res){
+				ioremap_cache[i].pa = 0;
+				ioremap_cache[i].va = 0;
+				ioremap_cache[i].flags = 0;
+				--ioremap_cache_active_slots;
+			}
+			break;
+		}
+out:
+	spin_unlock(&ioremap_cache_lock);
+
+	return res;
+}
+
 #ifndef CONFIG_44x
 void *
 ioremap(phys_addr_t addr, unsigned long size)
@@ -210,6 +301,14 @@
 	if ((v = p_mapped_by_bats(p)) /*&& p_mapped_by_bats(p+size-1)*/ )
 		goto out;

+	if ((flags & _PAGE_PRESENT) == 0)
+		flags |= _PAGE_KERNEL;
+	if (flags & _PAGE_NO_CACHE)
+		flags |= _PAGE_GUARDED;
+
+	if ((v = ioremap_cache_check(p, size, flags)))
+		goto out;
+
 	if (mem_init_done) {
 		struct vm_struct *area;
 		area = get_vm_area(size, VM_IOREMAP);
@@ -220,11 +319,6 @@
 		v = (ioremap_bot -= size);
 	}

-	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= _PAGE_KERNEL;
-	if (flags & _PAGE_NO_CACHE)
-		flags |= _PAGE_GUARDED;
-
 	/*
 	 * Should check if it is a candidate for a BAT mapping
 	 */
@@ -238,6 +332,7 @@
 		return NULL;
 	}

+	ioremap_cache_add(p, v, size, flags);
 out:
 	return (void *) (v + ((unsigned long)addr & ~PAGE_MASK));
 }
@@ -250,8 +345,9 @@
 	 */
 	if (v_mapped_by_bats((unsigned long)addr)) return;

-	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
-		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
+	if (!ioremap_cache_del((unsigned long)addr))
+		if (addr > high_memory && (unsigned long) addr < ioremap_bot)
+			vunmap((void *) (PAGE_MASK & (unsigned long)addr));
 }

 int

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
