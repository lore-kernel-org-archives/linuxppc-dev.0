Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E935DDE3A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 01:08:33 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix VDSO compile warning
Date: Wed, 16 May 2007 17:12:16 +0200
Message-Id: <11793283363025-git-send-email-segher@kernel.crashing.org>
Message-Id: <7f6b534db16116013b0f802a2dc8bd87c7e16508.1179328270.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maybe the type should have been char[] instead of __u8[]
in the first place, but this will do.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/kernel/vdso.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 4245579..cef01e4 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -670,7 +670,7 @@ static int __init vdso_init(void)
 	/*
 	 * Fill up the "systemcfg" stuff for backward compatiblity
 	 */
-	strcpy(vdso_data->eye_catcher, "SYSTEMCFG:PPC64");
+	strcpy((char *)vdso_data->eye_catcher, "SYSTEMCFG:PPC64");
 	vdso_data->version.major = SYSTEMCFG_MAJOR;
 	vdso_data->version.minor = SYSTEMCFG_MINOR;
 	vdso_data->processor = mfspr(SPRN_PVR);
-- 
1.5.2.rc0.g4342-dirty
