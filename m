Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-red-R.bigfish.com (outbound-red.frontbridge.com
	[216.148.222.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B268667B76
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jul 2006 06:56:29 +1000 (EST)
Message-ID: <44C68544.9000609@am.sony.com>
Date: Tue, 25 Jul 2006 13:55:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] clean up pseries hcall interfaces
References: <591B6A09961C354991CD653B274DC8C2023662CB@ussdixms03.am.sony.com>
	<20060725144124.GA3769@krispykreme>
In-Reply-To: <20060725144124.GA3769@krispykreme>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard wrote:
> Hi Geoff,
> 
>> Seems like this in needed too...  Untested.
> 
> Looks good but the patch appears to be line wrapped in a few places.
> 
> Anton

Sorry, I sent that out with a Web based mail client.  This one
should be OK.

-Geoff


Change the scope of some pSeries routines now called through
ppc_md to static.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

--
Index: a/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- a.orig/arch/powerpc/platforms/pseries/lpar.c	2006-07-18 12:37:47.000000000 -0700
+++ a/arch/powerpc/platforms/pseries/lpar.c	2006-07-20 05:18:59.000000000 -0700
@@ -268,7 +268,7 @@
 				cpu, hwcpu, vpa, ret);
 }

-long pSeries_lpar_hpte_insert(unsigned long hpte_group,
+static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
  			      unsigned long va, unsigned long pa,
  			      unsigned long rflags, unsigned long vflags,
  			      int psize)
@@ -494,7 +494,7 @@
  * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
  * lock.
  */
-void pSeries_lpar_flush_hash_range(unsigned long number, int local)
+static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 {
 	int i;
 	unsigned long flags = 0;
