Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D41761A1D74
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:05:59 +1000 (AEST)
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8E21F140293
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 16:05:57 +1000 (AEST)
Received: by pacrr5 with SMTP id rr5so53452727pac.3
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 23:05:56 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: [PATCH] powerpc/eeh: Probe after unbalanced kref check
Date: Fri, 14 Aug 2015 16:03:19 +1000
Message-Id: <1439532199-12099-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the complete hotplug case, EEH PEs are supposed to be released
and set to NULL. Normally, this is done by eeh_remove_device(),
which is called from pcibios_release_device().

However, if something is holding a kref to the device, it will not
be released, and the PE will remain. eeh_add_device_late() has
a check for this which will explictly destroy the PE in this case.

This check in eeh_add_device_late() occurs after a call to
eeh_ops->probe(). On PowerNV, probe is a pointer to pnv_eeh_probe(),
which will exit without probing if there is an existing PE.

This means that on PowerNV, devices with outstanding krefs will not
be rediscovered by EEH correctly after a complete hotplug. This is
affecting CXL (CAPI) devices in the field.

Put the probe after the kref check so that the PE is destroyed
and affected devices are correctly rediscovered by EEH.

Fixes: d91dafc02f42 ("powerpc/eeh: Delay probing EEH device during hotplug")
Cc: stable@vger.kernel.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/eeh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index af9b597b10af..8e61d717915e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1116,9 +1116,6 @@ void eeh_add_device_late(struct pci_dev *dev)
 		return;
 	}
 
-	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
-		eeh_ops->probe(pdn, NULL);
-
 	/*
 	 * The EEH cache might not be removed correctly because of
 	 * unbalanced kref to the device during unplug time, which
@@ -1142,6 +1139,9 @@ void eeh_add_device_late(struct pci_dev *dev)
 		dev->dev.archdata.edev = NULL;
 	}
 
+	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
+		eeh_ops->probe(pdn, NULL);
+
 	edev->pdev = dev;
 	dev->dev.archdata.edev = edev;
 
-- 
2.1.4
