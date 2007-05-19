Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CBB2FDDED0
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 02:44:44 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Refuse to build 64-bit with GCC-4.2.0 and
	CONFIG_MODULES
Date: Sat, 19 May 2007 18:49:08 +0200
Message-Id: <11795933483251-git-send-email-segher@kernel.crashing.org>
In-Reply-To: <11795933481264-git-send-email-segher@kernel.crashing.org>
References: <11795933481264-git-send-email-segher@kernel.crashing.org>
Message-Id: <bd3cddd2f3192e3aba4d7c886e38d8d0037c3510.1179593209.git.segher@kernel.crashing.org>
In-Reply-To: <f7ff5aadda1b2962d6c45123ff944e9af6879306.1179593209.git.segher@kernel.crashing.org>
References: <f7ff5aadda1b2962d6c45123ff944e9af6879306.1179593209.git.segher@kernel.crashing.org>
Cc: sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

...since this won't work (compiler bug, see <http://gcc.gnu.org/PR31490>).

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/Makefile |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6238b58..1447c83 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -202,6 +202,14 @@ checkbin:
 			false; \
 		fi ; \
 	fi
+	@if test "$(call cc-fullversion)" = "040200" \
+	    && test "x${CONFIG_MODULES}${CONFIG_PPC64}" = "xyy" ; then \
+		echo -n '*** GCC-4.2.0 cannot compile the 64-bit powerpc ' ; \
+		echo 'kernel with modules enabled.' ; \
+		echo -n '*** Please use a different GCC version or ' ; \
+		echo 'disable kernel modules' ; \
+		false ; \
+	fi
 	@if ! /bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; then \
 		echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build ' ; \
 		echo 'correctly with old versions of binutils.' ; \
-- 
1.5.2.rc0.g4342-dirty
