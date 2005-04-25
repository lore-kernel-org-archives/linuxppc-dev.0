Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B51567B27
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 16:04:24 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPwhm-0007Ry-1D@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Mon, 25 Apr 2005 07:04:26 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc iomem annotations: pmac_low_i2c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-ebony/arch/ppc/platforms/pmac_low_i2c.c RC12-rc3-ppc-i2c/arch/ppc/platforms/pmac_low_i2c.c
--- RC12-rc3-ebony/arch/ppc/platforms/pmac_low_i2c.c	Fri Feb  6 22:04:13 2004
+++ RC12-rc3-ppc-i2c/arch/ppc/platforms/pmac_low_i2c.c	Mon Apr 25 01:36:32 2005
@@ -54,7 +54,7 @@
 	int			mode;		/* Current mode */
 	int			channel;	/* Current channel */
 	int			num_channels;	/* Number of channels */
-	unsigned long		base;		/* For keywest-i2c, base address */
+	void __iomem *		base;		/* For keywest-i2c, base address */
 	int			bsteps;		/* And register stepping */
 	int			speed;		/* And speed */
 };
@@ -154,14 +154,12 @@
 
 static inline u8 __kw_read_reg(struct low_i2c_host *host, reg_t reg)
 {
-	return in_8(((volatile u8 *)host->base)
-		+ (((unsigned)reg) << host->bsteps));
+	return in_8(host->base + (((unsigned)reg) << host->bsteps));
 }
 
 static inline void __kw_write_reg(struct low_i2c_host *host, reg_t reg, u8 val)
 {
-	out_8(((volatile u8 *)host->base)
-		+ (((unsigned)reg) << host->bsteps), val);
+	out_8(host->base + (((unsigned)reg) << host->bsteps), val);
 	(void)__kw_read_reg(host, reg_subaddr);
 }
 
@@ -370,7 +368,7 @@
 		break;
 	}	
 	host->mode = pmac_low_i2c_mode_std;
-	host->base = (unsigned long)ioremap(np->addrs[0].address + aoffset,
+	host->base = ioremap(np->addrs[0].address + aoffset,
 						np->addrs[0].size);
 	host->func = keywest_low_i2c_func;
 }
