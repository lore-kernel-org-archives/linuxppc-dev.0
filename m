Subject: Re: PATCH: 2.2 series FEC driver performance improvements
To: stephane.laroche@colubris.com (Stiphane Laroche)
Date: Wed, 23 Aug 2000 10:57:00 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <39A2BC18.2589D75E@colubris.com> from "Stiphane Laroche" at Aug 22, 2000 01:44:57 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000823005700.B7369F@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A partly satisfied customer writes:
> I've installed your patch, as I liked very much the changes you made.
>
> I cannot get it to link though:
> arch/ppc/8xx_io/8xx_io.a: In function `fec_enet_rx':
> arch/ppc/8xx_io/8xx_io.a(.text+0x3198): undefined reference to
> `invalidate_dcache_range'
...
> My kernel is based on a hardhat kernel (2.2.13-7).   Any ideas why I don't have
> that function?

Hmmm.  Sounds like it's missing from your kernel; it's not used by many other
drivers.  Applying the patch below should add it for you.

> Are you planning to make the same kind of improvements in the 10Mbit driver
> (enet.c)?

Our project only has a FEC-based interface, so probably not.  Most of the
changes are in fec_enet_rx, and cpm_enet_rx looks almost identical.  It
shouldn't be hard to apply the equivalent changes to enet.c by hand.

Regards,
Graham


Index: arch/ppc/kernel/head.S
===================================================================
RCS file: /u/archive/epc/sw/linux/arch/ppc/kernel/head.S,v
diff -u -r1.1.1.2 -r1.1.1.3
--- arch/ppc/kernel/head.S	2000/01/04 03:38:24	1.1.1.2
+++ arch/ppc/kernel/head.S	2000/03/10 01:11:12	1.1.1.3
@@ -2450,6 +2578,29 @@
        bdnz    1b
        sync                            /* wait for dcbst's to get to ram */
        blr
+
+/*
+ * Like above, but invalidate the D-cache.  This is used by the 8xx
+ * to invalidate the cache so the PPC core doesn't get stale data
+ * from the CPM (no cache snooping here :-).
+ *
+ * invalidate_dcache_range(unsigned long start, unsigned long stop)
+ */
+_GLOBAL(invalidate_dcache_range)
+       li      r5,CACHE_LINE_SIZE-1
+       andc    r3,r3,r5
+       subf    r4,r3,r4
+       add     r4,r4,r5
+       srwi.   r4,r4,LG_CACHE_LINE_SIZE
+       beqlr
+       mtctr   r4
+
+1:     dcbi    0,r3
+       addi    r3,r3,CACHE_LINE_SIZE
+       bdnz    1b
+       sync                            /* wait for dcbst's to get to ram */
+       blr
+

 /*
  * Flush a particular page from the DATA cache


Index: include/asm-ppc/cache.h
===================================================================
RCS file: /u/archive/epc/sw/linux/include/asm-ppc/cache.h,v
retrieving revision 1.2
diff -u -r1.2 cache.h
--- include/asm-ppc/cache.h	2000/01/04 05:32:03	1.2
+++ include/asm-ppc/cache.h	2000/08/18 05:42:36
@@ -21,6 +21,7 @@

 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 extern void flush_dcache_range(unsigned long start, unsigned long stop);
+extern void invalidate_dcache_range(unsigned long start, unsigned long stop);

 static inline unsigned long unlock_dcache(void)
 {
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
