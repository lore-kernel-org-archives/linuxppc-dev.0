Subject: Re: Large TLBs on 40x
From: Josh Boyer <jwboyer@charter.net>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040810073502.A32095@home.com>
References: <20040804093937.B12758@home.com>
	 <285BFD4E-E638-11D8-852B-003065F9B7DC@embeddededge.com>
	 <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com>
	 <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com>
	 <20040810073502.A32095@home.com>
Content-Type: text/plain
Message-Id: <1092232201.32005.4.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0
Date: Wed, 11 Aug 2004 08:50:03 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-08-10 at 09:35, Matt Porter wrote:
> On Tue, Aug 10, 2004 at 02:04:44AM -0400, Dan Malek wrote:
> >
> > On Aug 9, 2004, at 10:21 PM, Josh Boyer wrote:
> >
> > > I have some boards I could test such a patch on.  Or is it a case of
> > > "this isn't trivial to do"?
> >
> > Ummmmm.....what are we talking about here?
> >
> > Both MPC8xx, and IBM40x have configuration options for
> > pinning some (small) amount of kernel space.  You can choose
> > to enable this if you wish, I don't think it is normally enabled.
> > I've never found a benchmark that proved either was better,
> > but I left the code there for others to experiment with.
>
> PPC40x no longer has this in 2.6. It has been deprecated by the dynamic
> large tlb support. He's looking for an option (like nobats) to cause
> kernel lowmem to not be mapped by large page entries.
>
> So, to answer the original question, I would suggest a patch
> that that uses a 'noltlb' cmdline option, then skips the PPC40x
> large page mapping in 4xx_mmu.c based on that. See the code
> that implements 'nobats' for an example.

Hm...  like this?  Against 2.6.8-rc4.

thx,
josh


diff -Naur -x '*.swp' linux-2.6.orig/arch/ppc/mm/4xx_mmu.c linux-2.6/arch/ppc/mm/4xx_mmu.c
--- linux-2.6.orig/arch/ppc/mm/4xx_mmu.c	2004-06-16 00:18:37.000000000 -0500
+++ linux-2.6/arch/ppc/mm/4xx_mmu.c	2004-08-11 08:25:11.000000000 -0500
@@ -52,6 +52,7 @@
 #include <asm/setup.h>
 #include "mmu_decl.h"

+extern int __map_without_ltlbs;
 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
@@ -102,6 +103,10 @@
 	p = PPC_MEMSTART;
 	s = 0;

+	if (__map_without_ltlbs) {
+		return s;
+	}
+
 	while (s <= (total_lowmem - LARGE_PAGE_SIZE_16M)) {
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
diff -Naur -x '*.swp' linux-2.6.orig/arch/ppc/mm/init.c linux-2.6/arch/ppc/mm/init.c
--- linux-2.6.orig/arch/ppc/mm/init.c	2004-08-11 08:03:55.000000000 -0500
+++ linux-2.6/arch/ppc/mm/init.c	2004-08-11 08:11:24.000000000 -0500
@@ -104,6 +104,7 @@
  * -- Cort
  */
 int __map_without_bats;
+int __map_without_ltlbs;

 /* max amount of RAM to use */
 unsigned long __max_memory;
@@ -204,6 +205,10 @@
 		__map_without_bats = 1;
 	}

+	if (strstr(cmd_line, "noltlb")) {
+		__map_without_ltlbs = 1;
+	}
+
 	/* Look for mem= option on command line */
 	if (strstr(cmd_line, "mem=")) {
 		char *p, *q;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
