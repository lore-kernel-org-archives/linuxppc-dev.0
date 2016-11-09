Return-Path: <andrew.shadura@collabora.co.uk>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDKsn6r7KzDvWV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 20:01:17 +1100 (AEDT)
From: Andrew Shadura <andrew.shadura@collabora.co.uk>
To: linuxppc-dev@lists.ozlabs.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Shuah Khan <shuah@kernel.org>, Cyril Bur <cyrilbur@gmail.com>
Subject: [PATCH RESEND] tools-powerpc: Return false instead of -1
Date: Wed,  9 Nov 2016 09:55:04 +0100
Message-Id: <20161109085504.10799-1-andrew.shadura@collabora.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Senna Tschudin <peter.senna@gmail.com>

Returning a negative value for a boolean function seem to have the
undesired effect of returning true. require_paranoia_below() is a
boolean function, but the variable used to store the return value is an
integer, receiving -1 or 0. This patch convert rc to bool, replace -1
by false, and 0 by true.

This issue was found by the following Coccinelle semantic patch:
<smpl>
@@
identifier f, ret;
constant C;
typedef bool;
@@
bool f (...){
<+...
ret = -C;
...
* return ret;
...+>
}
</smpl>

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>
---
 tools/testing/selftests/powerpc/pmu/lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
index 8b992fa..5bf5dd4 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.c
+++ b/tools/testing/selftests/powerpc/pmu/lib.c
@@ -193,9 +193,9 @@ bool require_paranoia_below(int level)
 	long current;
 	char *end, buf[16];
 	FILE *f;
-	int rc;
+	bool rc;
 
-	rc = -1;
+	rc = false;
 
 	f = fopen(PARANOID_PATH, "r");
 	if (!f) {
@@ -218,7 +218,7 @@ bool require_paranoia_below(int level)
 	if (current >= level)
 		goto out_close;
 
-	rc = 0;
+	rc = true;
 out_close:
 	fclose(f);
 out:
-- 
2.9.3
