Message-ID: <37F30E08.448@idecnet.com>
Date: Thu, 30 Sep 1999 09:16:31 +0200
From: Epicom <epicom@idecnet.com>
MIME-Version: 1.0
To: Kari Hameenaho <kari.hameenaho@khaho.pp.fi>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC860 cachelines corrected for glibc, need to correct also in kernel ?
References: <37F0FBC6.B4D8637A@khaho.pp.fi>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kari Hameenaho wrote:
> 
> There was previous correction in this mailing list for cachelines in glibc
> to be used in PPC860.
> 
> >Ok, here's how to build glibc for embedded PPC:
> 
> >First you must remove the assumption that cachelines are 32 bytes:
> >Apply this diff, and simply move sysdeps/powerpc/memset.S out of the
> >way for now:
> 
> >diff -ur orig/glibc-2.1.1/sysdeps/powerpc/dl-machine.c glibc-2.1.1/sysdeps/powerpc/dl-machine.c
> >--- orig/glibc-2.1.1/sysdeps/powerpc/dl-machine.c       Fri Mar  5 23:41:23 1999
> >+++ glibc-2.1.1/sysdeps/powerpc/dl-machine.c    Mon May 17 20:59:06 1999
> >@@ -250,7 +250,11 @@
> >         PowerPC processors have line sizes of exactly 32 bytes.  */
> >
> >       size_modified = lazy ? rel_offset_words : PLT_INITIAL_ENTRY_WORDS;
> >+#ifdef PPC_CACHELINESIZE_32
> >       for (i = 0; i < size_modified; i+= 8)
> >+#else
> >+      for (i = 0; i < size_modified; i+= 4)
> >+#endif
> >        PPC_DCBST (plt + i);
> >       PPC_DCBST (plt + size_modified - 1);
> >       PPC_SYNC;
> >
> 
> We have trouble with PCI bus master boards in Motorola MBX board (PPC860):
> seems like a cache problem, all data not correct as read from PCI bus.
> We have used kernels 2.2.5, 2.3.10 and 2.3.18.
> The memory area is reserved by __get_free_pages(GFP_KERNEL | GFP_DMA,5);
> 
> The situation is improved a lot (it may even be correctred totally) by
> changing
> cache setting in file ppc-asm/cache.h:
> 
> /* bytes per L1 cache line */
> #define        L1_CACHE_BYTES  32
> 
> =>
> 
> /* bytes per L1 cache line */
> #define        L1_CACHE_BYTES  16
> 
> There is also L1_CACHE_PAGES in this file, but it seems that that is not used
> anywhere.
> 
> Is this correct change or should we change something else to make access to
> DRAM more reliable
> from PCI ?
> Is anybody else having problems with PCI bus master access in PPC860 ?
> 
> ---
> Kari Hämeenaho

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
