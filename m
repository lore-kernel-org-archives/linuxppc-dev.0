Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FDEA1A1D98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 17:31:46 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2F9BC14016A
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:31:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 17:31:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B8FDF3578055
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:31:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E7VZHF64880668
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:31:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E7V9xD032234
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:31:11 +1000
Date: Fri, 14 Aug 2015 17:30:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey@neuling.org,
 imunsie@au1.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: Probe after unbalanced kref check
Message-ID: <20150814073045.GA28724@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1439532199-12099-1-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439532199-12099-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 14, 2015 at 04:03:19PM +1000, Daniel Axtens wrote:
>In the complete hotplug case, EEH PEs are supposed to be released
>and set to NULL. Normally, this is done by eeh_remove_device(),
>which is called from pcibios_release_device().
>
>However, if something is holding a kref to the device, it will not
>be released, and the PE will remain. eeh_add_device_late() has
>a check for this which will explictly destroy the PE in this case.
>
>This check in eeh_add_device_late() occurs after a call to
>eeh_ops->probe(). On PowerNV, probe is a pointer to pnv_eeh_probe(),
>which will exit without probing if there is an existing PE.
>
>This means that on PowerNV, devices with outstanding krefs will not
>be rediscovered by EEH correctly after a complete hotplug. This is
>affecting CXL (CAPI) devices in the field.
>
>Put the probe after the kref check so that the PE is destroyed
>and affected devices are correctly rediscovered by EEH.
>
>Fixes: d91dafc02f42 ("powerpc/eeh: Delay probing EEH device during hotplug")
>Cc: stable@vger.kernel.org
>Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/kernel/eeh.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index af9b597b10af..8e61d717915e 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -1116,9 +1116,6 @@ void eeh_add_device_late(struct pci_dev *dev)
> 		return;
> 	}
>
>-	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
>-		eeh_ops->probe(pdn, NULL);
>-
> 	/*
> 	 * The EEH cache might not be removed correctly because of
> 	 * unbalanced kref to the device during unplug time, which
>@@ -1142,6 +1139,9 @@ void eeh_add_device_late(struct pci_dev *dev)
> 		dev->dev.archdata.edev = NULL;
> 	}
>
>+	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
>+		eeh_ops->probe(pdn, NULL);
>+
> 	edev->pdev = dev;
> 	dev->dev.archdata.edev = edev;
>
>-- 
>2.1.4
>
