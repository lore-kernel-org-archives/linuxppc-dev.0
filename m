Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FB831A0239
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 03:21:20 +1100 (AEDT)
In-Reply-To: <20160204161527.5F3AC692CD@newverein.lst.de>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Mon, 25 Jan 2016 16:31:46 +0100
Subject: [PATCH v7 07/10] ppc64 ftrace: disable profiling for some files
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20160204162114.09AD4692E0@newverein.lst.de>
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
