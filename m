Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E0E41A0E2D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 08:53:44 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 behanw@converseincode.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] powerpc: Don't use -mno-strict-align on clang
Date: Tue, 26 May 2015 08:53:28 +1000
Message-Id: <1432594410-31198-5-git-send-email-anton@samba.org>
In-Reply-To: <1432594410-31198-1-git-send-email-anton@samba.org>
References: <1432594410-31198-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We added -mno-strict-align in commit f036b3681962 (powerpc: Work around little
endian gcc bug) to fix gcc bug http://gcc.gnu.org/bugzilla/show_bug.cgi?id=57134

Clang doesn't understand it. We need to use a conditional because we can't use the
simpler call cc-option here.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 7c08b4e..9cf7c7c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -65,7 +65,10 @@ endif
 
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
-override CC	+= -mlittle-endian -mno-strict-align
+override CC	+= -mlittle-endian
+ifneq ($(COMPILER),clang)
+override CC	+= -mno-strict-align
+endif
 override AS	+= -mlittle-endian
 override LD	+= -EL
 override CROSS32CC += -mlittle-endian
-- 
2.1.4
