Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out3.tiscali.nl (smtp-out3.tiscali.nl [195.241.79.178])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E3F9DE010
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 00:20:34 +1100 (EST)
Message-ID: <47CFEF82.10709@tiscali.nl>
Date: Thu, 06 Mar 2008 14:20:02 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: paulus@samba.org, arnd@arndb.de
Subject: Re: [PATCH] PPC: in celleb_show_cpuinfo() convert strncpy(x, y,
	sizeof(x)) to strlcpy
References: <47CFEE9D.1020300@tiscali.nl>
In-Reply-To: <47CFEE9D.1020300@tiscali.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roel Kluin wrote:
> This patch was not yet tested. Please confirm it's right.

was too quick with the send button. the batch below is probably better
---
strncpy does not append '\0' if the length of the source string equals
the size parameter, strlcpy does.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
index f27ae1e..cbe09d9 100644
--- a/arch/powerpc/platforms/celleb/setup.c
+++ b/arch/powerpc/platforms/celleb/setup.c
@@ -81,8 +81,7 @@ static void celleb_show_cpuinfo(struct seq_file *m)
 
 static int __init celleb_machine_type_hack(char *ptr)
 {
-	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
-	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
+	strlcpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
 	return 0;
 }
 
