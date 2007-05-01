Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 203EEDDDFC
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 02:05:45 +1000 (EST)
Date: Tue, 1 May 2007 11:05:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] Remove duplicate export of __div64_32.
Message-ID: <20070501160538.GA24292@ld0162-tx32.am.freescale.net>
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

Change 3927f2e8f9afa3424bb51ca81f7abac01ffd0005 moved lib/lib64.c from
lib-y to obj-y, preventing the export in ppc_ksyms.c from overriding
the one in lib, and thus causing a duplicate-export warning.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/ppc_ksyms.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index ff252aa..c96fa9b 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -66,7 +66,6 @@ EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
-EXPORT_SYMBOL(__div64_32);
 
 EXPORT_SYMBOL(do_signal);
 EXPORT_SYMBOL(transfer_to_handler);
-- 
1.5.0.3
