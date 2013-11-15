Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D75BA2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 17:36:13 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 15 Nov 2013 12:06:08 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B96591258053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 12:06:54 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAF6a1G918022416
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 12:06:01 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAF6a3OE027635
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 12:06:03 +0530
Message-ID: <1384497360.2491.5.camel@ThinkPad-T5421>
Subject: [PATCH powerpc] Fix compiling error in rng.c
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 15 Nov 2013 14:36:00 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch tries to fix following compiling errors, by including the
needed header file:

arch/powerpc/platforms/pseries/rng.c: In function 'pseries_get_random_long':
arch/powerpc/platforms/pseries/rng.c:20: error: 'PLPAR_HCALL_BUFSIZE' undeclared (first use in this function)
...

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/rng.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
index a702f1c..62c7838 100644
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -13,7 +13,7 @@
 #include <linux/of.h>
 #include <asm/archrandom.h>
 #include <asm/machdep.h>
-
+#include <asm/hvcall.h>
 
 static int pseries_get_random_long(unsigned long *v)
 {
