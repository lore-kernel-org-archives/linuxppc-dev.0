Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org
MIME-Version: 1.0
Subject: [PATCH] kexec-tools, ppc64: fix build error on ppc64
Date: Wed, 05 May 2010 11:48:53 +1000
Message-ID: <15110.1273024133@neuling.org>
Cc: Maxim Uvarov <muvarov@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 "some kexec MIPS
improvements" broke pp64 as it turned on -Werror for all archs.

This fixes the warning and hence ppc64 building.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
I've posted a second patch to fix the issue of changing one archs
Makefile, effecting all other archs.

 kexec/arch/ppc64/fs2dt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: kexec-tools/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools/kexec/arch/ppc64/fs2dt.c
@@ -357,7 +357,8 @@ static void putprops(char *fn, struct di
  * Compare function used to sort the device-tree directories
  * This function will be passed to scandir.
  */
-static int comparefunc(const void *dentry1, const void *dentry2)
+static int comparefunc(const struct dirent **dentry1,
+		       const struct dirent **dentry2)
 {
 	char *str1 = (*(struct dirent **)dentry1)->d_name;
 	char *str2 = (*(struct dirent **)dentry2)->d_name;
