Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9490ADDEE0
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 16:42:13 +1000 (EST)
Date: Wed, 15 Aug 2007 16:42:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Use of_get_property in ipmi code
Message-Id: <20070815164212.4228dce4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Corey Minyard <minyard@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


get_property has been renamed to of_get_property.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/ipmi/ipmi_si_intf.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 96d2f9e..d57083a 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2251,19 +2251,19 @@ static int __devinit ipmi_of_probe(struct of_device *dev,
 		return ret;
 	}
 
-	regsize = get_property(np, "reg-size", &proplen);
+	regsize = of_get_property(np, "reg-size", &proplen);
 	if (regsize && proplen != 4) {
 		dev_warn(&dev->dev, PFX "invalid regsize from OF\n");
 		return -EINVAL;
 	}
 
-	regspacing = get_property(np, "reg-spacing", &proplen);
+	regspacing = of_get_property(np, "reg-spacing", &proplen);
 	if (regspacing && proplen != 4) {
 		dev_warn(&dev->dev, PFX "invalid regspacing from OF\n");
 		return -EINVAL;
 	}
 
-	regshift = get_property(np, "reg-shift", &proplen);
+	regshift = of_get_property(np, "reg-shift", &proplen);
 	if (regshift && proplen != 4) {
 		dev_warn(&dev->dev, PFX "invalid regshift from OF\n");
 		return -EINVAL;
-- 
1.5.2.4
