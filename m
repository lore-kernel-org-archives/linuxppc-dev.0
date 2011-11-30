Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 5/6] powerpc/boot: Add mfdcrx
Date: Wed, 30 Nov 2011 16:23:59 +1100
Message-Id: <1322630640-13708-6-git-send-email-tony@bakeyournoodle.com>
In-Reply-To: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/boot/dcr.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dcr.h b/arch/powerpc/boot/dcr.h
index 645a7c9..51b5893 100644
--- a/arch/powerpc/boot/dcr.h
+++ b/arch/powerpc/boot/dcr.h
@@ -9,6 +9,12 @@
 	})
 #define mtdcr(rn, val) \
 	asm volatile("mtdcr %0,%1" : : "i"(rn), "r"(val))
+#define mfdcrx(rn) \
+	({	\
+		unsigned long rval; \
+		asm volatile("mfdcrx %0,%1" : "=r"(rval) : "g"(rn)); \
+		rval; \
+	})
 
 /* 440GP/440GX SDRAM controller DCRs */
 #define DCRN_SDRAM0_CFGADDR				0x010
-- 
1.7.6.4
