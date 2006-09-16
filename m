Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-res-R.bigfish.com (outbound-res.frontbridge.com
	[63.161.60.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 66E8A679E7
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2006 03:35:39 +1000 (EST)
Message-ID: <450C35E5.4040605@am.sony.com>
Date: Sat, 16 Sep 2006 10:35:33 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc: minor fix of numa message
References: <45097273.8070103@am.sony.com>
	<1158282267.10020.2.camel@localhost.localdomain>
In-Reply-To: <1158282267.10020.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Thu, 2006-09-14 at 08:17 -0700, Geoff Levand wrote:
>> This is a very minor fix that effects no current system.  The NUMA startup
>> message values for 'Top of RAM' and 'Memory hole size' were reported
>> incorrectly if more than one lmb region was added.
>> 
>> A comment in the lmb code states that lmb_analyze() must be called before
>> lmb_phys_mem_size().
> 
> But we've already called it in early_init_devtree()?

Yes, of course you are correct.  Updated patch follows.

-Geoff


This is a very minor comment change to the powerpc lbm code reflect current
usage.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Index: cell--common--4/arch/powerpc/mm/lmb.c
===================================================================
--- cell--common--4.orig/arch/powerpc/mm/lmb.c
+++ cell--common--4/arch/powerpc/mm/lmb.c
@@ -285,7 +285,9 @@
 	return base;
 }
 
-/* You must call lmb_analyze() before this. */
+/* You must call lmb_analyze() sometime before this, typcally just after
+ * adding regions.
+ */
 unsigned long __init lmb_phys_mem_size(void)
 {
 	return lmb.memory.size;
