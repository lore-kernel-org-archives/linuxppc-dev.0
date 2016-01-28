Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28A6E1A1A14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 01:17:46 +1100 (AEDT)
Received: by mail-pf0-x234.google.com with SMTP id n128so24157953pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 06:17:46 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Daniel Borkmann <daniel@iogearbox.net>, Joe Perches <joe@perches.com>,
 Amitkumar Karwar <akarwar@marvell.com>,
 Nishant Sarmukadam <nishants@marvell.com>,
 Kalle Valo <kvalo@codeaurora.org>, Steve French <sfrench@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] lib: add "on" and "off" to strtobool
Date: Thu, 28 Jan 2016 06:17:06 -0800
Message-Id: <1453990627-19164-3-git-send-email-keescook@chromium.org>
In-Reply-To: <1453990627-19164-1-git-send-email-keescook@chromium.org>
References: <1453990627-19164-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several places in the kernel expect to use "on" and "off" for their
boolean signifiers, so add them to strtobool.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 lib/string.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 0323c0d5629a..091570708db7 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -635,12 +635,15 @@ EXPORT_SYMBOL(sysfs_streq);
  * @s: input string
  * @res: result
  *
- * This routine returns 0 iff the first character is one of 'Yy1Nn0'.
- * Otherwise it will return -EINVAL.  Value pointed to by res is
- * updated upon finding a match.
+ * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
+ * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
+ * pointed to by res is updated upon finding a match.
  */
 int strtobool(const char *s, bool *res)
 {
+	if (!s)
+		return -EINVAL;
+
 	switch (s[0]) {
 	case 'y':
 	case 'Y':
@@ -652,6 +655,21 @@ int strtobool(const char *s, bool *res)
 	case '0':
 		*res = false;
 		break;
+	case 'o':
+	case 'O':
+		switch (s[1]) {
+		case 'n':
+		case 'N':
+			*res = true;
+			break;
+		case 'f':
+		case 'F':
+			*res = false;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.6.3
