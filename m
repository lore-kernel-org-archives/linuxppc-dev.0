Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 19/39] powerpc: uname should return ppc64le/ppcle on little
 endian builds
Date: Mon, 23 Sep 2013 12:04:53 +1000
Message-Id: <1379901913-5945-20-git-send-email-anton@samba.org>
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

We need to distinguish between big endian and little endian
environments, so fix uname to return the right thing.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Makefile | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 51cfb78..debfa2b 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -36,17 +36,26 @@ KBUILD_DEFCONFIG := ppc64_defconfig
 endif
 
 ifeq ($(CONFIG_PPC64),y)
-OLDARCH	:= ppc64
-
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)
 
 ifeq ($(new_nm),y)
 NM		:= $(NM) --synthetic
 endif
+endif
 
+ifeq ($(CONFIG_PPC64),y)
+ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+OLDARCH	:= ppc64le
+else
+OLDARCH	:= ppc64
+endif
+else
+ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+OLDARCH	:= ppcle
 else
 OLDARCH	:= ppc
 endif
+endif
 
 # It seems there are times we use this Makefile without
 # including the config file, but this replicates the old behaviour
-- 
1.8.1.2
