Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DFAA6B70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 22:39:52 +1000 (EST)
Message-ID: <4A607185.6020302@gmail.com>
Date: Fri, 17 Jul 2009 14:41:41 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: arnd@arndb.de, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] powerpc/cell: strncpy does not null terminate string
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With `sizeof(string) - 1` strncpy() will null terminate the string.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
To test this:

#include <stdio.h>
#include <string.h>

char a[10];
char b[10];

int main()
{
        const char* str = "0123456789012";
        strncpy(a, str, sizeof(a));
        strncpy(b, str, sizeof(b) - 1);
        printf("String a was %s, b was %s\n", a, b);

        return 0;
}

Output:
String a was 0123456789012345678, b was 012345678

diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
index 07c234f..cfdbadb 100644
--- a/arch/powerpc/platforms/cell/celleb_setup.c
+++ b/arch/powerpc/platforms/cell/celleb_setup.c
@@ -80,7 +80,7 @@ static void celleb_show_cpuinfo(struct seq_file *m)
 
 static int __init celleb_machine_type_hack(char *ptr)
 {
-	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
+	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type) - 1);
 	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
 	return 0;
 }
