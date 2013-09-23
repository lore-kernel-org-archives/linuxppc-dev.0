Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 39/39] powerpc: Work around little endian gcc bug
Date: Mon, 23 Sep 2013 12:05:13 +1000
Message-Id: <1379901913-5945-40-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Temporarily work around an ICE we are seeing while building
in little endian mode:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=57134

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index d3c91bf..607acf5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -66,7 +66,7 @@ endif
 UTS_MACHINE := $(OLDARCH)
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
-override CC	+= -mlittle-endian
+override CC	+= -mlittle-endian -mno-strict-align
 override AS	+= -mlittle-endian
 override LD	+= -EL
 override CROSS32CC += -mlittle-endian
-- 
1.8.1.2
