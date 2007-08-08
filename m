Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zrtps0kp.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 43F1FDDEDC
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 02:24:35 +1000 (EST)
Message-ID: <46B9EE37.6060600@nortel.com>
Date: Wed, 08 Aug 2007 10:24:23 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: help with ppc sections -- no luck, any ideas?
References: <46A8F22E.6010701@nortel.com>
In-Reply-To: <46A8F22E.6010701@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Well, I've played around with the sections a bit more, and just can't 
seem to get it to work.  As soon as I apply the following, the kernel 
refuses to boot.  (And if I remove the changes to _GLOBAL, then it 
refuses to boot if I enable CONFIG_KPROBES.)


Index: linux/include/asm-ppc/processor.h
===================================================================
--- linux.orig/include/asm-ppc/processor.h	2007-08-02 16:12:16.000000000 
-0600
+++ linux/include/asm-ppc/processor.h	2007-08-02 16:26:06.000000000 -0600
@@ -38,9 +38,20 @@

  #define _GLOBAL(n)\
  	.stabs __stringify(n:F-1),N_FUN,0,0,n;\
+	.section ".text"; \
  	.globl n;\
  n:

+#ifdef CONFIG_KPROBES
+#define _KPROBE(n)\
+	.stabs __stringify(n:F-1),N_FUN,0,0,n;\
+	.section ".kprobes.text","a"; \
+	.globl n;\
+n:
+#else
+#define _KPROBE(n) _GLOBAL(n)
+#endif
+
  /*
   * this is the minimum allowable io space due to the location
   * of the io areas on prep (first one at 0x80000000) but
Index: linux/arch/ppc/kernel/misc.S
===================================================================
--- linux.orig/arch/ppc/kernel/misc.S	2007-08-02 16:12:16.000000000 -0600
+++ linux/arch/ppc/kernel/misc.S	2007-08-02 16:24:43.000000000 -0600
@@ -624,7 +624,7 @@
   *
   * flush_icache_range(unsigned long start, unsigned long stop)
   */
-_GLOBAL(flush_icache_range)
+_KPROBE(flush_icache_range)
  BEGIN_FTR_SECTION
  	blr				/* for 601, do nothing */
  END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)





Based on Segher's comments I tried changing it to:

+	.section ".text","ax"; \


but that didn't work either.


Anyone else got any suggestions on how I might force 
flush_icache_range() into a ".kprobes.text" section?

Chris
