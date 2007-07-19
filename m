Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound9-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6682ADDF88
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 07:47:16 +1000 (EST)
Message-ID: <469FDBDC.5030700@am.sony.com>
Date: Thu, 19 Jul 2007 14:47:08 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: PS3: Fix build with 32-bit toolchains
References: <fa686aa40707191249r1e73f6f7s7f2aa4502919e98a@mail.gmail.com>
In-Reply-To: <fa686aa40707191249r1e73f6f7s7f2aa4502919e98a@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PS3 bootwrapper files use instructions only available on
64-bit CPUs.  Add the code generation directive '.machine "ppc64"'
for toolchains configured for 32-bit CPUs.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
Paul,

Please apply for 2.6.23-rc1.

 arch/powerpc/boot/ps3-head.S   |    2 ++
 arch/powerpc/boot/ps3-hvcall.S |    2 ++
 2 files changed, 4 insertions(+)

--- a/arch/powerpc/boot/ps3-head.S
+++ b/arch/powerpc/boot/ps3-head.S
@@ -20,6 +20,8 @@
 
 #include "ppc_asm.h"
 
+	.machine "ppc64"
+
 	.text
 
 /*
--- a/arch/powerpc/boot/ps3-hvcall.S
+++ b/arch/powerpc/boot/ps3-hvcall.S
@@ -20,6 +20,8 @@
 
 #include "ppc_asm.h"
 
+	.machine "ppc64"
+
 /*
  * The PS3 hypervisor uses a 64 bit "C" language calling convention.
  * The routines here marshal arguments between the 32 bit wrapper
