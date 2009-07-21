Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ACF44B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 20:15:12 +1000 (EST)
Message-ID: <4A6595AD.9000209@gmail.com>
Date: Tue, 21 Jul 2009 12:17:17 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Ken Kawakami <ken.kawakami@toshiba.co.jp>
Subject: [PATCH] powerpc/cell: replace strncpy by strlcpy
References: <4A607185.6020302@gmail.com>
In-Reply-To: <4A607185.6020302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	cbe-oss-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace strncpy() and explicit null-termination by strlcpy()

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Arnd-san, Ken-san,

Thanks for reviewing,

> We prefer to take the patch which is replacing the two lines with one.

Doozo.

diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
index 07c234f..e538455 100644
--- a/arch/powerpc/platforms/cell/celleb_setup.c
+++ b/arch/powerpc/platforms/cell/celleb_setup.c
@@ -80,8 +80,7 @@ static void celleb_show_cpuinfo(struct seq_file *m)
 
 static int __init celleb_machine_type_hack(char *ptr)
 {
-	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
-	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
+	strlcpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
 	return 0;
 }
 
