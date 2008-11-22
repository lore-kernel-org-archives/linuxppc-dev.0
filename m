Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 416A2DDE11
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Nov 2008 04:36:40 +1100 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH 20/32] uninorth-agp section mess
Message-Id: <E1L3wPK-0006Ym-Kq@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 22 Nov 2008 17:36:34 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


'aperture' is declared devinitdata (the whole word of it) and
is used from ->fetch_size() which can, AFAICS, be used on
!HOTPLUG after init time.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/agp/uninorth-agp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -27,7 +27,7 @@
 static int uninorth_rev;
 static int is_u3;
 
-static char __devinitdata *aperture = NULL;
+static char *aperture = NULL;
 
 static int uninorth_fetch_size(void)
 {
