Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A319DDE09
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 21:28:18 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id lA1ASc6F007664
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 21:28:38 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lA1AUZPJ185152
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 21:30:35 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA1AQIkI018559
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 21:26:36 +1100
Date: Thu, 1 Nov 2007 14:05:27 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.24-rc1-git9 - Missing include file in kallsyms.h
Message-ID: <20071101083527.GB8350@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, rusty@rustcorp.com.au,
	torvalds@linux-foundation.org
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Build with randconfig fails with following error with the
2.6.24-rc4-git9

include/linux/kallsyms.h:56: error: ‘NULL’ undeclared (first use in this
function)
include/linux/kallsyms.h:56: error: (Each undeclared identifier is
reported only once
include/linux/kallsyms.h:56: error: for each function it appears in.)
make[2]: *** [arch/powerpc/platforms/cell/spu_callbacks.o] Error 1
make[1]: *** [arch/powerpc/platforms/cell] Error 2
make: *** [arch/powerpc/platforms] Error 2

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index f73de6f..82de2fb 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -6,6 +6,7 @@
 #define _LINUX_KALLSYMS_H
 
 #include <linux/errno.h>
+#include <linux/stddef.h>
 
 #define KSYM_NAME_LEN 128
 #define KSYM_SYMBOL_LEN (sizeof("%s+%#lx/%#lx [%s]") + (KSYM_NAME_LEN - 1) + \

--
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
