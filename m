Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E4B1DDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 22:23:02 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id lAEB9tHD007855
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 22:09:55 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAEBCRfp237876
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 22:12:27 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAEA7viJ031085
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 21:07:58 +1100
Date: Wed, 14 Nov 2007 16:24:10 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: akpm@linux-foundation.org
Subject: [PATCH] 2.6.24-rc2-mm1 powerpc (iseries)- build failure - mm/stab.c
Message-ID: <20071114105410.GA16846@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com, paulus@samba.org,
	linux-kernel@vger.kernel.org
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

The kernel builds fails with following error, with randconfig

  CC      arch/powerpc/mm/stab.o
arch/powerpc/mm/stab.c: In function ‘stab_initialize’:
arch/powerpc/mm/stab.c:282: error: implicit declaration of function ‘HvCall1’
arch/powerpc/mm/stab.c:282: error: ‘HvCallBaseSetASR’ undeclared (first use in this function)
arch/powerpc/mm/stab.c:282: error: (Each undeclared identifier is reported only once
arch/powerpc/mm/stab.c:282: error: for each function it appears in.)
make[1]: *** [arch/powerpc/mm/stab.o] Error 1
make: *** [arch/powerpc/mm] Error 2

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
--- linux-2.6.24-rc2/arch/powerpc/mm/stab.c	2007-11-14 05:22:55.000000000 -0500
+++ linux-2.6.24-rc2/arch/powerpc/mm/~stab.c	2007-11-14 05:23:18.000000000 -0500
@@ -21,6 +21,10 @@
 #include <asm/abs_addr.h>
 #include <asm/firmware.h>
 
+#ifdef CONFIG_PPC_ISERIES
+#include <asm/iseries/hv_call.h>
+#endif /* CONFIG_PPC_ISERIES */
+
 struct stab_entry {
 	unsigned long esid_data;
 	unsigned long vsid_data;

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
