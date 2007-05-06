Return-Path: <tnt@246tNt.com>
Received: from outmx033.isp.belgacom.be (outmx033.isp.belgacom.be
	[195.238.6.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C34E7DDE42
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 01:39:11 +1000 (EST)
Received: from outmx033.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx033.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l46Fd56X027554
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 17:39:06 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/8] powerpc: Fix the MODALIAS generation in modpost for of
	devices
Date: Sun,  6 May 2007 17:38:45 +0200
Message-Id: <11784659351487-git-send-email-tnt@246tNt.com>
In-Reply-To: <11784659324066-git-send-email-tnt@246tNt.com>
References: <11784659324066-git-send-email-tnt@246tNt.com>
Cc: PPC dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the devices may have multiple (or none) compatible properties,
the uevent generated internally by the kernel may have multiple
"C..." entries. So the MODALIAS stored in the module must have
wilcard before and after the compatible entry.
Also, if the 'compatible' field is not used for matching, there
will be no 'C' and that must handled as well.

The previous code handled all those case incorrectly and it
"mostly" worked ... but not always.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 scripts/mod/file2alias.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index b2f73ff..4903292 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -354,11 +354,16 @@ static int do_pcmcia_entry(const char *filename,
 
 static int do_of_entry (const char *filename, struct of_device_id *of, char *alias)
 {
+    int len;
     char *tmp;
-    sprintf (alias, "of:N%sT%sC%s",
+    len = sprintf (alias, "of:N%sT%s",
                     of->name[0] ? of->name : "*",
-                    of->type[0] ? of->type : "*",
-                    of->compatible[0] ? of->compatible : "*");
+                    of->type[0] ? of->type : "*");
+
+    if (of->compatible[0])
+        sprintf (&alias[len], "%sC%s",
+                     of->type[0] ? "*" : "",
+                     of->compatible);
 
     /* Replace all whitespace with underscores */
     for (tmp = alias; tmp && *tmp; tmp++)
-- 
1.5.1.2
