Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F13A1DDE23
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 08:11:03 +1100 (EST)
Date: Fri, 4 Jan 2008 15:10:45 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [PATCH 2/3] Handle absolute pathnames correctly in dtc_open_file.
Message-ID: <20080104211045.GB28991@ld0162-tx32.am.freescale.net>
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

Also, free file->dir when freeing file.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 srcpos.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/srcpos.c b/srcpos.c
index 7340c33..7a0c47e 100644
--- a/srcpos.c
+++ b/srcpos.c
@@ -86,6 +86,16 @@ struct dtc_file *dtc_open_file(const char *fname,
 		return file;
 	}
 
+	if (fname[0] == '/') {
+		file->file = fopen(fname, "r");
+
+		if (!file->file)
+			goto out;
+
+		file->name = strdup(fname);
+		return file;
+	}
+
 	if (!search)
 		search = &default_search;
 
@@ -100,6 +110,7 @@ struct dtc_file *dtc_open_file(const char *fname,
 	}
 
 out:
+	free((void *)file->dir);
 	free(file);
 	return NULL;
 }
@@ -109,5 +120,6 @@ void dtc_close_file(struct dtc_file *file)
 	if (fclose(file->file))
 		die("Error closing \"%s\": %s\n", file->name, strerror(errno));
 
+	free((void *)file->dir);
 	free(file);
 }
-- 
1.5.3
