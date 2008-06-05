Return-Path: <hugh@veritas.com>
Received: from extu-mxob-2.symantec.com (extu-mxob-2.symantec.com
	[216.10.194.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-2.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DEFFDE061
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 23:45:08 +1000 (EST)
Date: Thu, 5 Jun 2008 14:44:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] libata: fix G5 SATA broken on -rc5
In-Reply-To: <20080605135444.7a1e5158@core>
Message-ID: <Pine.LNX.4.64.0806051436180.5315@blonde.site>
References: <alpine.LFD.1.10.0806042018060.3473@woody.linux-foundation.org>
	<20080605112436.GA4533@aepfle.de>
	<Pine.LNX.4.64.0806051255340.28792@blonde.site>
	<20080605135444.7a1e5158@core>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix G5 SATA irq 18: nobody cared, reported on -rc5 by Olaf Hering:
fixlet to a57c1bade5a0ee5cd8b74502db9cbebb7f5780b2 libata-sff:
Fix oops reported in kerneloops.org for pnp devices with no ctl
    
Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

 drivers/ata/libata-sff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6.26-rc5/drivers/ata/libata-sff.c	2008-06-05 07:18:07.000000000 +0100
+++ linux/drivers/ata/libata-sff.c	2008-06-05 12:42:39.000000000 +0100
@@ -278,7 +278,7 @@ static u8 ata_sff_irq_status(struct ata_
 		    	return status;
 	}
 	/* Clear INTRQ latch */
-	status = ata_sff_check_status(ap);
+	status = ap->ops->sff_check_status(ap);
 	return status;
 }
 
