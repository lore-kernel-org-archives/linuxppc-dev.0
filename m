Return-Path: <SRS0=uOHI=ZR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C36C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 11:21:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34B92084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 11:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34B92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47M4Nr3bqWzDqch
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 22:21:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47M3dG3Sw5zDqXt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2019 21:47:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47M3dF4vDKz9sRd; Mon, 25 Nov 2019 21:47:13 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9d72dcef891030545f39ad386a30cf91df517fb2
In-Reply-To: <20191118065553.30362-1-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/powernv: Disable native PCIe port management
Message-Id: <47M3dF4vDKz9sRd@ozlabs.org>
Date: Mon, 25 Nov 2019 21:47:13 +1100 (AEDT)
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
Cc: linux-pci@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-11-18 at 06:55:53 UTC, Oliver O'Halloran wrote:
> On PowerNV the PCIe topology is (currently) managed by the powernv platform
> code in Linux in cooperation with the platform firmware. Linux's native
> PCIe port service drivers operate independently of both and this can cause
> problems.
> 
> The main issue is that the portbus driver will conflict with the platform
> specific hotplug driver (pnv_php) over ownership of the MSI used to notify
> the host when a hotplug event occurs. The portbus driver claims this MSI on
> behalf of the individual port services because the same interrupt is used
> for hotplug events, PMEs (on root ports), and link bandwidth change
> notifications. The portbus driver will always claim the interrupt even if
> the individual port service drivers, such as pciehp, are compiled out.
> 
> The second, bigger, problem is that the hotplug port service driver
> fundamentally does not work on PowerNV. The platform assumes that all
> PCI devices have a corresponding arch-specific handle derived from the DT
> node for the device (pci_dn) and without one the platform will not allow
> a PCI device to be enabled. This problem is largely due to historical
> baggage, but it can't be resolved without significant re-factoring of the
> platform PCI support.
> 
> We can fix these problems in the interim by setting the
> "pcie_ports_disabled" flag during platform initialisation. The flag
> indicates the platform owns the PCIe ports which stops the portbus driver
> from being registered.
> 
> This does have the side effect of disabling all port services drivers
> that is: AER, PME, BW notifications, hotplug, and DPC. However, this is
> not a huge disadvantage on PowerNV since these services are either unused
> or handled through other means.
> 
> Cc: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9d72dcef891030545f39ad386a30cf91df517fb2

cheers
