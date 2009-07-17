Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 72CB2B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 00:33:52 +1000 (EST)
Message-ID: <4A608A69.4060204@gmail.com>
Date: Fri, 17 Jul 2009 16:27:53 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: arnd@arndb.de
Subject: Re: [PATCH] powerpc/cell: strncpy does not null terminate string
References: <4A607185.6020302@gmail.com>
In-Reply-To: <4A607185.6020302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

strlcpy() will always null terminate the string.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Please use this one instead

diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
index 07c234f..1896cd8 100644
--- a/arch/powerpc/platforms/cell/celleb_setup.c
+++ b/arch/powerpc/platforms/cell/celleb_setup.c
@@ -80,7 +80,7 @@ static void celleb_show_cpuinfo(struct seq_file *m)
 
 static int __init celleb_machine_type_hack(char *ptr)
 {
-	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
+	strlcpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
 	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
 	return 0;
 }
