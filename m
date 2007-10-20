Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 25DB7DDE44
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Oct 2007 04:46:25 +1000 (EST)
Date: Sat, 20 Oct 2007 20:47:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] restore arch/ppc/boot cflags
Message-ID: <20071020184753.GA8572@uranus.ravnborg.org>
References: <200710200858.l9K8w3Nn064775@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200710200858.l9K8w3Nn064775@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 20, 2007 at 03:58:03AM -0500, Milton Miller wrote:
> Commit 9a39e273d4df0560c724c5fe71f6314a0583ca2b removed the boot directory
> addition to CFLAGS that was being used by the subdirectory builds.  For the
> other files, that patch set EXTRA_CFLAGS, but Makefile.build explicitly
> sets that to empty as it is explicitly for a single directory only.
> Append to KBUILD_CFLAGS instead.

Neat - I had not figured out that the assignmnet took effect
recursively.
I have applied following patch.

	Sam

>From 437374e9a95062fe310b901e48585691edaf5dd0 Mon Sep 17 00:00:00 2001
From: Milton Miller <miltonm@bga.com>
Date: Sat, 20 Oct 2007 03:58:03 -0500
Subject: [PATCH] kbuild: restore arch/{ppc/xtensa}/boot cflags

Commit 9a39e273d4df0560c724c5fe71f6314a0583ca2b removed the boot directory
addition to CFLAGS that was being used by the subdirectory builds.  For the
other files, that patch set EXTRA_CFLAGS, but Makefile.build explicitly
sets that to empty as it is explicitly for a single directory only.
Append to KBUILD_CFLAGS instead.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/ppc/boot/Makefile    |    2 ++
 arch/xtensa/boot/Makefile |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/boot/Makefile b/arch/ppc/boot/Makefile
index 487dc66..500497e 100644
--- a/arch/ppc/boot/Makefile
+++ b/arch/ppc/boot/Makefile
@@ -13,6 +13,8 @@
 # modified by Cort (cort@cs.nmt.edu)
 #
 
+# KBUILD_CFLAGS used when building rest of boot (takes effect recursively)
+KBUILD_CFLAGS 	+= -fno-builtin -D__BOOTER__ -Iarch/$(ARCH)/boot/include
 HOSTCFLAGS	+= -Iarch/$(ARCH)/boot/include
 
 BOOT_TARGETS	= zImage zImage.initrd znetboot znetboot.initrd
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index 9c5185f..40aa55b 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -8,7 +8,8 @@
 #
 
 
-EXTRA_CFLAGS	+= -fno-builtin -Iarch/$(ARCH)/boot/include
+# KBUILD_CFLAGS used when building rest of boot (takes effect recursively)
+KBUILD_CFLAGS	+= -fno-builtin -Iarch/$(ARCH)/boot/include
 HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
 
 BIG_ENDIAN	:= $(shell echo -e __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
-- 
1.5.3.4.206.g58ba4
