Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 673B71A02B3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 08:13:26 +1100 (AEDT)
Received: by mail-pf0-x229.google.com with SMTP id o185so74720896pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Feb 2016 13:13:26 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Amitkumar Karwar <akarwar@marvell.com>,
 Nishant Sarmukadam <nishants@marvell.com>,
 Kalle Valo <kvalo@codeaurora.org>, Steve French <sfrench@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] lib: add "on"/"off" support to kstrtobool
Date: Fri,  5 Feb 2016 13:12:48 -0800
Message-Id: <1454706769-8729-4-git-send-email-keescook@chromium.org>
In-Reply-To: <1454706769-8729-1-git-send-email-keescook@chromium.org>
References: <1454706769-8729-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for "on" and "off" when converting to boolean.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
- add dropped descripion change, andy.shevchenko
---
 lib/kstrtox.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index e8ba4a013e82..d8a5cf66c316 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -326,9 +326,9 @@ EXPORT_SYMBOL(kstrtos8);
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
 int kstrtobool(const char *s, bool *res)
 {
@@ -346,6 +346,20 @@ int kstrtobool(const char *s, bool *res)
 	case '0':
 		*res = false;
 		return 0;
+	case 'o':
+	case 'O':
+		switch (s[1]) {
+		case 'n':
+		case 'N':
+			*res = true;
+			return 0;
+		case 'f':
+		case 'F':
+			*res = false;
+			return 0;
+		default:
+			break;
+		}
 	default:
 		break;
 	}
-- 
2.6.3
