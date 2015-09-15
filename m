Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 381A41A2C22
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 11:24:22 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 744051401AD
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 11:24:21 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id t8F1OHTh007853
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 20:24:18 -0500
Message-ID: <1442280257.9229.28.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/boot: Specify ABI v2 when building an LE boot wrapper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Tue, 15 Sep 2015 11:24:17 +1000
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

The kernel does it, not the boot wrapper, which breaks with some
cross compilers that still default to ABI v1.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: stable@vger.kernel.org
--

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 73eddda..4eec430 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -28,6 +28,9 @@ BOOTCFLAGS	+= -m64
 endif
 ifdef CONFIG_CPU_BIG_ENDIAN
 BOOTCFLAGS	+= -mbig-endian
+else
+BOOTCFLAGS	+= -mlittle-endian
+BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
 endif
 
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc	
