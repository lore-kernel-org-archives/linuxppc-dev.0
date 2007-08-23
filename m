Return-Path: <jesper.juhl@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by ozlabs.org (Postfix) with ESMTP id B28CBDDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 09:48:01 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so640176mue
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 16:47:59 -0700 (PDT)
Resent-Message-ID: <200708240144.07135.jesper.juhl@gmail.com>
Message-Id: <91dcfc2a1b0be436d04f9bc45bb6f8657a8d6ff4.1187912217.git.jesper.juhl@gmail.com>
In-Reply-To: <1554af80879a7ef2f78a4d654f23c248203500d9.1187912217.git.jesper.juhl@gmail.com>
References: <1554af80879a7ef2f78a4d654f23c248203500d9.1187912217.git.jesper.juhl@gmail.com>
From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Fri, 24 Aug 2007 01:45:08 +0200
Subject: [PATCH 04/30] powerpc: Don't cast kmalloc return value in ibmebus.c
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Heiko J Schick <schickhj@de.ibm.com>,
	Joachim Fenkes <fenkes@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Jesper Juhl <jesper.juhl@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

kmalloc() returns a void pointer so there is absolutely no need to
cast it in ibmebus_chomp().

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---
 arch/powerpc/kernel/ibmebus.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 9a8c9af..9514e66 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -383,7 +383,8 @@ static int ibmebus_match_path(struct device *dev, void *data)
 
 static char *ibmebus_chomp(const char *in, size_t count)
 {
-	char *out = (char*)kmalloc(count + 1, GFP_KERNEL);
+	char *out = kmalloc(count + 1, GFP_KERNEL);
+
 	if (!out)
 		return NULL;
 
-- 
1.5.2.2
