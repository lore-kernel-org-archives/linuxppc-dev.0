Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sBXGz4DPGzDr2T
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 05:43:05 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: olof@lixom.net,
	Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Sat, 13 Aug 2016 19:42:57 +0100 (BST)
Message-ID: <48a33908b3a.5917bc37@auth.smtp.1and1.co.uk>
Subject: [PATCH RFC] powerpc/pasemi: Remove hardcoded bus numbers on smbus
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6d4b6c10434fcfb1.bb"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6d4b6c10434fcfb1.bb
Content-Type: text/plain

The pasemi smbus controller uses PCI_FUNC(dev->devfn) to define which
number bus to attach to, however this fails when something else is 
probed first, for example an ATI Radeon graphics card will claim 9 or
10 busses, including the ones the pasemi wants.
Patch the driver to call i2c_add_adapter rather than
i2c_add_numbered_adapter.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

I've tested this on my X1000, and can now see the pasemi busses when I
run i2cdetect, and can even see devices on bus 0, but as this is probably
the first time we've had this working, more testing will be needed.

I don't know why the bus tries to use bus numbers 0-2, I couldn't see
any reason, maybe Olof has an idea?

Regards
Darren

----=_BOUNDARY.6d4b6c10434fcfb1.bb
Content-Type: text/plain;
	name="i2c.patch"
Content-Disposition: attachment;
	filename="i2c.patch";
	size=852

diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index df1dbc9..ecce83e 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -365,7 +365,7 @@ static int pasemi_smb_probe(struct pci_dev *dev,
 	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
-	smbus->adapter.nr = PCI_FUNC(dev->devfn);
+	smbus->adapter.nr = -1;
 
 	/* set up the sysfs linkage to our parent device */
 	smbus->adapter.dev.parent = &dev->dev;
@@ -373,7 +373,7 @@ static int pasemi_smb_probe(struct pci_dev *dev,
 	reg_write(smbus, REG_CTL, (CTL_MTR | CTL_MRR |
 		  (CLK_100K_DIV & CTL_CLK_M)));
 
-	error = i2c_add_numbered_adapter(&smbus->adapter);
+	error = i2c_add_adapter(&smbus->adapter);
 	if (error)
 		goto out_release_region;
 

----=_BOUNDARY.6d4b6c10434fcfb1.bb--
