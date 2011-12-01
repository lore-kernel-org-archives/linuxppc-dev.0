Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 6/8] powerpc/boot: Add mfdcrx
Date: Thu,  1 Dec 2011 18:39:22 +1100
Message-Id: <1322725164-4391-7-git-send-email-tony@bakeyournoodle.com>
In-Reply-To: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
References: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Needed for currituck support.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/boot/dcr.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

I chose to use a #define to keep with the style of m[tf]dcr in the same file.

diff --git a/arch/powerpc/boot/dcr.h b/arch/powerpc/boot/dcr.h
index 645a7c9..cc73f7a 100644
--- a/arch/powerpc/boot/dcr.h
+++ b/arch/powerpc/boot/dcr.h
@@ -9,6 +9,12 @@
 	})
 #define mtdcr(rn, val) \
 	asm volatile("mtdcr %0,%1" : : "i"(rn), "r"(val))
+#define mfdcrx(rn) \
+	({	\
+		unsigned long rval; \
+		asm volatile("mfdcrx %0,%1" : "=r"(rval) : "r"(rn)); \
+		rval; \
+	})
 
 /* 440GP/440GX SDRAM controller DCRs */
 #define DCRN_SDRAM0_CFGADDR				0x010
-- 
1.7.6.4
