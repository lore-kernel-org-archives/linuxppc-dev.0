Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4Fv16CnfzDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 07:34:37 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] powerpc/rtas_flash: Move an assignment for the variable "rc"
 in manage_flash_write()
Message-ID: <026724c5-0907-d342-1fb3-f7af0bd1c765@users.sourceforge.net>
Date: Thu, 19 Jan 2017 21:33:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Jan 2017 21:20:09 +0100

A local variable was set to an error code before a concrete error situation
was detected. Thus move the corresponding assignment into an if branch
to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kernel/rtas_flash.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index db2b482af658..663904beff67 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -419,9 +419,10 @@ static ssize_t manage_flash_write(struct file *file, const char __user *buf,
 	op = -1;
 	if (buf) {
 		if (count > 9) count = 9;
-		rc = -EFAULT;
-		if (copy_from_user (stkbuf, buf, count))
+		if (copy_from_user(stkbuf, buf, count)) {
+			rc = -EFAULT;
 			goto error;
+		}
 		if (strncmp(stkbuf, reject_str, strlen(reject_str)) == 0) 
 			op = RTAS_REJECT_TMP_IMG;
 		else if (strncmp(stkbuf, commit_str, strlen(commit_str)) == 0) 
-- 
2.11.0
