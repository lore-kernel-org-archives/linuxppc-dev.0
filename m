Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 610CADE083
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 06:15:34 +1100 (EST)
Date: Fri, 11 Jan 2008 13:14:57 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [DTC PATCH] Remove const from dtc_file::dir.
Message-ID: <20080111191457.GA10257@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 srcpos.c |    4 ++--
 srcpos.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/srcpos.c b/srcpos.c
index 7d0f0a7..c8eaa1e 100644
--- a/srcpos.c
+++ b/srcpos.c
@@ -104,7 +104,7 @@ struct dtc_file *dtc_open_file(const char *fname,
 	}
 
 out:
-	free((void *)file->dir);
+	free(file->dir);
 	free(file);
 	return NULL;
 }
@@ -114,6 +114,6 @@ void dtc_close_file(struct dtc_file *file)
 	if (fclose(file->file))
 		die("Error closing \"%s\": %s\n", file->name, strerror(errno));
 
-	free((void *)file->dir);
+	free(file->dir);
 	free(file);
 }
diff --git a/srcpos.h b/srcpos.h
index 8108539..3ed2334 100644
--- a/srcpos.h
+++ b/srcpos.h
@@ -25,7 +25,7 @@
 #include <stdio.h>
 
 struct dtc_file {
-	const char *dir;
+	char *dir;
 	const char *name;
 	FILE *file;
 };
-- 
1.5.3
