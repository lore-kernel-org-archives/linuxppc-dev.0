Return-Path: <srs0=biht=3n=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyfH22t1WzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 18:32:46 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vyfH22GHmz8svk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 18:32:46 +1000 (AEST)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vyfH15dhKz9s86
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2017 18:32:45 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 81so1133398pgh.3
 for <linuxppc-dev@ozlabs.org>; Wed, 05 Apr 2017 01:32:45 -0700 (PDT)
Message-ID: <1491381158.28260.36.camel@gmail.com>
Subject: [PATCH] powerpc/kconfig: Turn CONFIG_RELOCATABLE on
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Date: Wed, 05 Apr 2017 18:32:38 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most distros will want it on by default and I've missed
turning it on during developer testing. Having it on ensures
we are testing our patches with the config enabled.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e0120ce..22584e5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -494,6 +494,7 @@ config RELOCATABLE
 	depends on (PPC64 && !COMPILE_TEST) || (FLATMEM && (44x || FSL_BOOKE))
 	select NONSTATIC_KERNEL
 	select MODULE_REL_CRCS if MODVERSIONS
+	default y
 	help
 	  This builds a kernel image that is capable of running at the
 	  location the kernel is loaded at. For ppc32, there is no any
-- 
2.9.3
