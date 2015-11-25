Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7904A1A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 04:29:35 +1100 (AEDT)
In-Reply-To: <20151125172608.9588569260@newverein.lst.de>
References: <20151125172608.9588569260@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Wed, 25 Nov 2015 17:42:52 +0100
Subject: [PATCH v4 7/9] ppc64 ftrace: disable profiling for some files
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20151125172932.A542C69260@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch complements the "notrace" attribute for selected functions.
It adds -mprofile-kernel to the cc flags to be stripped from the command
line for code-patching.o and feature-fixups.o, in addition to "-pg"

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/lib/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index a47e142..98e22b2 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -6,8 +6,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
-CFLAGS_REMOVE_code-patching.o = -pg
-CFLAGS_REMOVE_feature-fixups.o = -pg
+CFLAGS_REMOVE_code-patching.o = -pg -mprofile-kernel
+CFLAGS_REMOVE_feature-fixups.o = -pg -mprofile-kernel
 
 obj-y += string.o alloc.o crtsavres.o ppc_ksyms.o code-patching.o \
 	 feature-fixups.o
-- 
1.8.5.6
