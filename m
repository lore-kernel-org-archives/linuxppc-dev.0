Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 67640DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 13:31:09 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so403020ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 19:31:07 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by terra with esmtp (Exim 4.69) (envelope-from <jonsmirl@gmail.com>)
	id 1Kvjmz-0006jx-Q8
	for linuxppc-dev@ozlabs.org; Thu, 30 Oct 2008 22:31:05 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Fix format string warning in arch/powerpc/boot/main.c
To: linuxppc-dev@ozlabs.org
Date: Thu, 30 Oct 2008 22:31:05 -0400
Message-ID: <20081031023105.25877.93051.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix format string warning in arch/powerpc/boot/main.c

 BOOTCC  arch/powerpc/boot/main.o
arch/powerpc/boot/main.c: In function 'prep_kernel':
arch/powerpc/boot/main.c:65: warning: format '%08x' expects type
'unsigned int', but argument 3 has type 'long unsigned int'

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 arch/powerpc/boot/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index ae32801..5afa1d4 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -63,7 +63,7 @@ static struct addr_range prep_kernel(void)
 		 */
 		if ((unsigned long)_start < ei.loadsize)
 			fatal("Insufficient memory for kernel at address 0!"
-			       " (_start=%p, uncomressed size=%08x)\n\r",
+			       " (_start=%p, uncomressed size=%08lx)\n\r",
 			       _start, ei.loadsize);
 
 		if ((unsigned long)_end < ei.memsize)
