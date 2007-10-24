Return-Path: <oxymoron@waste.org>
Received: from waste.org (waste.org [66.93.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "waste.org", Issuer "waste.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 48105DDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 07:54:34 +1000 (EST)
Date: Wed, 24 Oct 2007 16:54:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Apparent kernel bug with GDB on ppc405
Message-ID: <20071024215421.GF19691@waste.org>
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
	<20071024204215.GC19691@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071024204215.GC19691@waste.org>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 24, 2007 at 03:42:16PM -0500, Matt Mackall wrote:
> On Wed, Oct 24, 2007 at 02:28:14PM -0600, Grant Likely wrote:
> > On 10/24/07, Matt Mackall <mpm@selenic.com> wrote:
> > > I'm trying to debug a trivial statically-linked hello world program on
> > > a Xilinx PPC 405 and I'm seeing the following behavior:
> > >
> > <snip>
> > >
> > > Any suggestions?
> > 
> > http://thread.gmane.org/gmane.linux.ports.ppc.embedded/11202
> > 
> > I was fighting with a similar problem almost 2 years ago.  Looks like
> > it might be related.  At some point the problem seemed to go away and
> > I determined what the root cause was.  :-(
> > 
> > I haven't been using gdb lately, so I don't know if it's the same
> > problem.  Nobody I had talked to had seen the issue on other 405
> > platforms.  It could very well be something virtex-specific.
> 
> Could be the same problem, but I'm seeing only your symptom 3 so far.
> 
> I've tried throwing some larger hammers at the problem. Flushing all
> of the dcache and icache (flush_dcache_all and
> flush_instruction_cache) isn't helping. But printk(".") does!

Well there was one remaining cache - the TLB. This patch seems to make
things work, but don't ask me why:

--- include/asm-ppc/cacheflush.h        (revision 10439)
+++ include/asm-ppc/cacheflush.h        (working copy)
@@ -11,6 +11,7 @@
 #define _PPC_CACHEFLUSH_H

 #include <linux/mm.h>
+#include <asm/tlbflush.h>

 /*
  * No cache flushing is required when address mappings are
@@ -35,10 +36,23 @@
 extern void flush_icache_user_range(struct vm_area_struct *vma,
                struct page *page, unsigned long addr, int len);

 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 do { memcpy(dst, src, len); \
      flush_icache_user_range(vma, page, vaddr, len); \
+     _tlbia(); \
 } while (0)

-- 
Mathematics is the supreme nostalgia of our time.
