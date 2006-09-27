Return-Path: <SRS0+b3bad606449a68d80a45+1130+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0A0E67B1A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 17:19:05 +1000 (EST)
Subject: [PATCH] Use check_legacy_ioport() for ISAPnP
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Wed, 27 Sep 2006 08:18:55 +0100
Message-Id: <1159341535.3309.108.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index f2e0179..3ac5b12 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -1049,6 +1049,10 @@ static int __init isapnp_init(void)
 		printk(KERN_INFO "isapnp: ISA Plug & Play support disabled\n");
 		return 0;
 	}
+#ifdef CONFIG_PPC_MERGE
+	if (check_legacy_ioport(_PIDXR) || check_legacy_ioport(_PNPWRP))
+		return -EINVAL;
+#endif
 #ifdef ISAPNP_REGION_OK
 	if (!request_region(_PIDXR, 1, "isapnp index")) {
 		printk(KERN_ERR "isapnp: Index Register 0x%x already used\n", _PIDXR);

-- 
dwmw2
