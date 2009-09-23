Return-Path: <Bernhard.Weirich@riedel.net>
Received: from dfallbackip1.mail.eu.uu.net (dhuumrelay1.dtm.ops.eu.uu.net
	[194.139.33.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 30F1FB7B7A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 19:09:00 +1000 (EST)
Received: from dhuumrelay1.dtm.ops.eu.uu.net (dfallbackip1.mail.eu.uu.net
	[195.129.12.192])
	by dfallbackip1.mail.eu.uu.net (8.14.1/8.14.1) with ESMTP id
	n8N6iwf8027584
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 06:44:58 GMT
Received: from mail.riedel.net (mail.riedel.net [213.70.193.150])
	by dhuumrelay1.dtm.ops.eu.uu.net (8.14.1/8.14.1) with ESMTP id
	n8N6iqfe027571
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 06:44:53 GMT
From: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 23 Sep 2009 08:44:49 +0200
Subject: Re: [PATCH] powerpc/mm: Fix 40x and 8xx vs. _PAGE_SPECIAL
Message-ID: <CE92B8B581B4584FB8CA86B51EDE8AC5243C568B05@wupexchange.riedel.net>
References: <1253679146.7103.270.camel@pasglop>
In-Reply-To: <1253679146.7103.270.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Works perfectly here. Thank you for the patch, I was not feeling confident =
enough to play around with the page bits :)

Bernhard WEIRICH
Software Development
________________________________________
Von: Benjamin Herrenschmidt [benh@kernel.crashing.org]
Gesendet: Mittwoch, 23. September 2009 06:12
An: Weirich, Bernhard; Rex Feany
Cc: linuxppc-dev list
Betreff: [PATCH] powerpc/mm: Fix 40x and 8xx vs. _PAGE_SPECIAL

The test to check whether we have _PAGE_SPECIAL defined is broken,
since we always define it, just not always to a meaninful value :-)

That broke 8xx and 40x under some circumstances.

This fixes it by adding _PAGE_SPECIAL for both of these since they
had a free PTE bit, and removing the condition around advertising
it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Bernhard, Rex, please let me know if that works for you.


diff --git a/arch/powerpc/include/asm/pte-40x.h b/arch/powerpc/include/asm/=
pte-40x.h
index 6c3e1f4..ec0b0b0 100644
--- a/arch/powerpc/include/asm/pte-40x.h
+++ b/arch/powerpc/include/asm/pte-40x.h
@@ -43,6 +43,7 @@
 #define        _PAGE_NO_CACHE  0x004   /* I: caching is inhibited */
 #define        _PAGE_WRITETHRU 0x008   /* W: caching is write-through */
 #define        _PAGE_USER      0x010   /* matches one of the zone permissi=
on bits */
+#define        _PAGE_SPECIAL   0x020   /* software: Special page */
 #define        _PAGE_RW        0x040   /* software: Writes permitted */
 #define        _PAGE_DIRTY     0x080   /* software: dirty page */
 #define _PAGE_HWWRITE  0x100   /* hardware: Dirty & RW, set in exception *=
/
diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/=
pte-8xx.h
index 94e9797..dd5ea95 100644
--- a/arch/powerpc/include/asm/pte-8xx.h
+++ b/arch/powerpc/include/asm/pte-8xx.h
@@ -32,6 +32,7 @@
 #define _PAGE_FILE     0x0002  /* when !present: nonlinear file mapping */
 #define _PAGE_NO_CACHE 0x0002  /* I: cache inhibit */
 #define _PAGE_SHARED   0x0004  /* No ASID (context) compare */
+#define _PAGE_SPECIAL  0x0008  /* SW entry, forced to 0 by the TLB miss */

 /* These five software bits must be masked out when the entry is loaded
  * into the TLB.
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/a=
sm/pte-common.h
index c3b6507..f2b3701 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -25,9 +25,6 @@
 #ifndef _PAGE_WRITETHRU
 #define _PAGE_WRITETHRU        0
 #endif
-#ifndef _PAGE_SPECIAL
-#define _PAGE_SPECIAL  0
-#endif
 #ifndef _PAGE_4K_PFN
 #define _PAGE_4K_PFN           0
 #endif
@@ -179,7 +176,5 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 #define HAVE_PAGE_AGP

 /* Advertise support for _PAGE_SPECIAL */
-#ifdef _PAGE_SPECIAL
 #define __HAVE_ARCH_PTE_SPECIAL
-#endif
