Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 3D56CDE1B8
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 04:03:00 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] dtc: supply a definition for YYRHSLOC if there isn't one
Date: Wed, 16 Jul 2008 13:53:57 -0400
Message-Id: <1216230837-17557-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, jdl@jdl.com,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It seems that some machines, like a default RHEL4 install, will
not have a definition for YYRHSLOC, and that prevents building
dtc.  This supplies what appears to be the standard definition
for it in the event that the host system does not have it defined.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 srcpos.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/srcpos.h b/srcpos.h
index e17c7c0..fa4d001 100644
--- a/srcpos.h
+++ b/srcpos.h
@@ -39,6 +39,10 @@ typedef struct YYLTYPE {
     struct dtc_file *file;
 } YYLTYPE;
 
+#if ! defined(YYRHSLOC)
+#define YYRHSLOC(Rhs, K) ((Rhs)[K])
+#endif
+
 #define YYLTYPE_IS_DECLARED	1
 #define YYLTYPE_IS_TRIVIAL	1
 #endif
-- 
1.5.6.2
