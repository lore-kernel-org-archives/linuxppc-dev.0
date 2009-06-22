Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C4383B714D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 06:19:58 +1000 (EST)
Message-ID: <4A4003AD.20408@gmail.com>
Date: Tue, 23 Jun 2009 00:20:29 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: jk@ozlabs.org
Subject: [PATCH] spufs: remove redundant test on unsigned
References: <4A3FF508.3000304@gmail.com>
In-Reply-To: <4A3FF508.3000304@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unsigned `len' cannot be less than 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Or should it be `if (!buf || len > MAX)' and what should MAX be then?

diff --git a/arch/powerpc/platforms/cell/spufs/sputrace.c b/arch/powerpc/platforms/cell/spufs/sputrace.c
index d0b1f3f..8f799ee 100644
--- a/arch/powerpc/platforms/cell/spufs/sputrace.c
+++ b/arch/powerpc/platforms/cell/spufs/sputrace.c
@@ -73,7 +73,7 @@ static ssize_t sputrace_read(struct file *file, char __user *buf,
 {
 	int error = 0, cnt = 0;
 
-	if (!buf || len < 0)
+	if (!buf)
 		return -EINVAL;
 
 	while (cnt < len) {
