Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC5F2DDE40
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 03:14:59 +1000 (EST)
Date: Tue, 8 May 2007 12:14:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] Mark prop unused in early_init_dt_scan_chosen().
Message-ID: <20070508171451.GA8893@ld0162-tx32.am.freescale.net>
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

The prop variable is only referenced when initrd support is
turned on.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/prom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index caef555..6705459 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -720,7 +720,7 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
 					    const char *uname, int depth, void *data)
 {
 	unsigned long *lprop;
-	u32 *prop;
+	u32 __attribute__((unused)) *prop;
 	unsigned long l;
 	char *p;
 
-- 
1.5.0.3
