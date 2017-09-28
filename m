Return-Path: <seth.forshee@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2wf33wwGzDsSj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 23:34:35 +1000 (AEST)
Received: from mail-qt0-f199.google.com ([209.85.216.199])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <seth.forshee@canonical.com>)
 id 1dxYxU-00042y-S9
 for linuxppc-dev@lists.ozlabs.org; Thu, 28 Sep 2017 13:34:32 +0000
Received: by mail-qt0-f199.google.com with SMTP id 6so503756qtw.17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 06:34:32 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Shuah Khan <shuah@kernel.org>
Cc: Seth Forshee <seth.forshee@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc: Use snprintf to construct DSCR sysfs
 interface paths
Date: Thu, 28 Sep 2017 09:34:26 -0400
Message-Id: <20170928133426.19454-1-seth.forshee@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently sprintf is used, and while paths should never exceed
the size of the buffer it is theoretically possible since
dirent.d_name is 256 bytes. As a result this trips
-Wformat-overflow, and since the test is built with -Wall -Werror
the causes the build to fail. Switch to using snprintf and skip
any paths which are too long for the filename buffer.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
index 17fb1b43c320..1899bd85121f 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
@@ -53,6 +53,8 @@ static int check_all_cpu_dscr_defaults(unsigned long val)
 	}
 
 	while ((dp = readdir(sysfs))) {
+		int len;
+
 		if (!(dp->d_type & DT_DIR))
 			continue;
 		if (!strcmp(dp->d_name, "cpuidle"))
@@ -60,7 +62,9 @@ static int check_all_cpu_dscr_defaults(unsigned long val)
 		if (!strstr(dp->d_name, "cpu"))
 			continue;
 
-		sprintf(file, "%s%s/dscr", CPU_PATH, dp->d_name);
+		len = snprintf(file, LEN_MAX, "%s%s/dscr", CPU_PATH, dp->d_name);
+		if (len >= LEN_MAX)
+			continue;
 		if (access(file, F_OK))
 			continue;
 
-- 
2.14.1
