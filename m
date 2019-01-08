Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C41BC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 22:32:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72CB214C6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 22:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0tFW0jR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72CB214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z6T16F8szDqcK
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 09:32:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="d0tFW0jR"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z6Qt5NJVzDqbC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 09:30:29 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5171A20665;
 Tue,  8 Jan 2019 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546986627;
 bh=hXnMppBc3pgIEOn2BXm63YNiYbwzeHEpcsiQ/uzH2Vo=;
 h=Date:From:To:Cc:Subject:From;
 b=d0tFW0jR/zJ+oALZ7m+kmx7JDFbj56gT9DSOEyAOFtVIgHdRbs6E623oevDaD3oPV
 WkylKhjBM6wLu3nfjjb8r6wTPvVn5vX8AKIPBPKMtBj0lUFYH0Xf78VcSTJuEQLL0q
 T9uepaluzZlPF4O20miGOQvdPlplfzrYtmseR34s=
Date: Tue, 8 Jan 2019 16:30:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Kconfig label updates
Message-ID: <20190108223024.GA147017@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-pci@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

I want to update the PCI Kconfig labels so they're more consistent and
useful to users, something like the patch below.  IIUC, the items
below are all IBM-related; please correct me if not.

I'd also like to expand (or remove) "RPA" because Google doesn't find
anything about "IBM RPA", except Robotic Process Automation, which I
think must be something else.

Is there some text expansion of RPA that we could use that would be
meaningful to a user, i.e., something he/she might find on a nameplate
or in a user manual?

Ideally the PCI Kconfig labels would match the terms used in
arch/.../Kconfig, e.g.,

  config PPC_POWERNV
    bool "IBM PowerNV (Non-Virtualized) platform support"

  config PPC_PSERIES
    bool "IBM pSeries & new (POWER5-based) iSeries"

  config MARCH_Z900
    bool "IBM zSeries model z800 and z900"

  config MARCH_Z9_109
    bool "IBM System z9"

Bjorn


diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index e9f78eb390d2..1c1d145bfd84 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_POWERNV
-	tristate "PowerPC PowerNV PCI Hotplug driver"
+	tristate "IBM PowerNV PCI Hotplug driver"
 	depends on PPC_POWERNV && EEH
 	select OF_DYNAMIC
 	help
@@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_RPA
-	tristate "RPA PCI Hotplug driver"
+	tristate "IBM Power Systems RPA PCI Hotplug driver"
 	depends on PPC_PSERIES && EEH
 	help
 	  Say Y here if you have a RPA system that supports PCI Hotplug.
+	  This includes the earlier pSeries and iSeries.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rpaphp.
@@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_RPA_DLPAR
-	tristate "RPA Dynamic Logical Partitioning for I/O slots"
+	tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"
 	depends on HOTPLUG_PCI_RPA
 	help
 	  Say Y here if your system supports Dynamic Logical Partitioning
@@ -157,7 +158,7 @@ config HOTPLUG_PCI_SGI
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_S390
-	bool "System z PCI Hotplug Support"
+	bool "IBM System z PCI Hotplug Support"
 	depends on S390 && 64BIT
 	help
 	  Say Y here if you want to use the System z PCI Hotplug
