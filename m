Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Oct 2006 16:36:49 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [POWERPC] 32-bit early_init() should zero from __bss_start to
	__bss_stop only
Message-ID: <20061025233649.GB17461@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, early_init() in setup_32.c zeroes from '_bss_start' to '_end'.
It should only zero from '__bss_start' to '__bss_stop'.  This patch does that.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 setup_32.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
---

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a4c2964..c682e9a 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -95,7 +95,8 @@ unsigned long __init early_init(unsigned
 
 	/* First zero the BSS -- use memset_io, some platforms don't have
 	 * caches on yet */
-	memset_io((void __iomem *)PTRRELOC(&__bss_start), 0, _end - __bss_start);
+	memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
+			__bss_stop - __bss_start);
 
 	/*
 	 * Identify the CPU type and fix up code sections
