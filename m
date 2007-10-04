Return-Path: <grant.likely@secretlab.ca>
Date: Wed, 03 Oct 2007 22:05:01 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Bootwrapper: Enable debug info on boot wrapper
To: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au, paulus@ozlabs.org
Message-id: <20071004040501.16923.68468.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Add '-g' to BOOTCFLAGS if CONFIG_DEBUG_INFO is set.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index cf80db3..9dfe79b 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -25,6 +25,10 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
+ifdef CONFIG_DEBUG_INFO
+BOOTCFLAGS	+= -g
+endif
+
 ifeq ($(call cc-option-yn, -fstack-protector),y)
 BOOTCFLAGS	+= -fno-stack-protector
 endif
