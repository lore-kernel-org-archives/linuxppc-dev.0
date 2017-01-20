Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4pdF0pz3zDqS2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 05:09:36 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>, R.T.Dickinson <rtd@a-eon.com>,
 Pat Wall <pjwall@mac.com>
Date: Fri, 20 Jan 2017 17:46:39 +0000 (GMT)
Message-ID: <49760dd87cb.596db16f@auth.smtp.1and1.co.uk>
Subject: [PATCH v2] powerpc/pasemi: Remove hardcoded bus numbers on smbus
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pasemi smbus controller uses PCI_FUNC(dev->devfn) to define which
number bus to attach to, however this fails when something else is 
probed first, for example an ATI Radeon graphics card will claim 9 or
10 busses, including the ones the pasemi wants.
Patch the driver to call i2c_add_adapter rather than
i2c_add_numbered_adapter.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

  v2 - remove unnecessary smbus->adapter.nr initialisation.

diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index df1dbc9..05847fd 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -365,7 +365,6 @@ static int pasemi_smb_probe(struct pci_dev *dev,
    smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
    smbus->adapter.algo = &smbus_algorithm;
    smbus->adapter.algo_data = smbus;
-   smbus->adapter.nr = PCI_FUNC(dev->devfn);
 
    /* set up the sysfs linkage to our parent device */
    smbus->adapter.dev.parent = &dev->dev;
@@ -373,7 +372,7 @@ static int pasemi_smb_probe(struct pci_dev *dev,
    reg_write(smbus, REG_CTL, (CTL_MTR | CTL_MRR |
          (CLK_100K_DIV & CTL_CLK_M)));
 
-   error = i2c_add_numbered_adapter(&smbus->adapter);
+   error = i2c_add_adapter(&smbus->adapter);
    if (error)
        goto out_release_region;
 
