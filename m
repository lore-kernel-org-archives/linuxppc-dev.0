Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A30CF10089D
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 09:33:52 +1100 (EST)
Date: Sat, 28 Nov 2009 01:33:51 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 8/8] Change KERNEL_RELOC_SYMBOL to "_stext" on ppc32
Message-ID: <20091127223351.GH21805@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently staprun fails at send_relocation_kernel(), this is because
ppc32 doesn't have ".__start" symbol. I think we should use _stext,
just as other arches.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 runtime/staprun/staprun.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/runtime/staprun/staprun.c b/runtime/staprun/staprun.c
index 078be4c..5bd5163 100644
--- a/runtime/staprun/staprun.c
+++ b/runtime/staprun/staprun.c
@@ -372,7 +372,7 @@ int send_relocation_kernel ()
               free (line); line=NULL;
               if (symbol == NULL) continue; /* OOM? */
 
-#ifdef __powerpc__
+#ifdef __powerpc64__
 #define KERNEL_RELOC_SYMBOL ".__start"
 #else
 #define KERNEL_RELOC_SYMBOL "_stext"
-- 
1.6.3.3
