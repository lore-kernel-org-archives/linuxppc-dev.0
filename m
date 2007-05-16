Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C353DDEF4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 23:08:16 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix ppc_rtas_progress_show()
Date: Wed, 16 May 2007 15:12:17 +0200
Message-Id: <11793211373667-git-send-email-segher@kernel.crashing.org>
Message-Id: <7d7d6e5cfd145fbb21fc1a0eff172e58e7e0b602.1179321103.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes the warning

	arch/powerpc/kernel/rtas-proc.c: In function 'ppc_rtas_progress_show':
	arch/powerpc/kernel/rtas-proc.c:382: warning: the address of
		'progress_led' will always evaluate as 'true'

by fixing the code to do what it presumably is meant to do.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/kernel/rtas-proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index 190b7ed..f2e3bc7 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -379,7 +379,7 @@ static ssize_t ppc_rtas_progress_write(struct file *file,
 /* ****************************************************************** */
 static int ppc_rtas_progress_show(struct seq_file *m, void *v)
 {
-	if (progress_led)
+	if (progress_led[0])
 		seq_printf(m, "%s\n", progress_led);
 	return 0;
 }
-- 
1.5.2.rc0.g4342-dirty
