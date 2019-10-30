Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E11CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 12:59:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8792080F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 12:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8792080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4737nH3RyHzF4Ms
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 23:58:59 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4736qp6JCCzF4CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 23:16:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4736qp4MGXz9sPq; Wed, 30 Oct 2019 23:16:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a8a30219ba78b1abb92091102b632f8e9bbdbf03
In-Reply-To: <20191016162833.22509-1-fbarrat@linux.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, sbobroff@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powernv/eeh: Fix oops when probing cxl devices
Message-Id: <4736qp4MGXz9sPq@ozlabs.org>
Date: Wed, 30 Oct 2019 23:16:06 +1100 (AEDT)
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
Cc: clombard@linux.ibm.com, andrew.donnellan@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-10-16 at 16:28:33 UTC, Frederic Barrat wrote:
> Recent cleanup in the way EEH support is added to a device causes a
> kernel oops when the cxl driver probes a device and creates virtual
> devices discovered on the FPGA:
> 
>     BUG: Kernel NULL pointer dereference at 0x000000a0
>     Faulting instruction address: 0xc000000000048070
>     Oops: Kernel access of bad area, sig: 7 [#1]
>     ...
>     NIP [c000000000048070] eeh_add_device_late.part.9+0x50/0x1e0
>     LR [c00000000004805c] eeh_add_device_late.part.9+0x3c/0x1e0
>     Call Trace:
>     [c000200e43983900] [c00000000079e250] _dev_info+0x5c/0x6c (unreliable)
>     [c000200e43983980] [c0000000000d1ad0] pnv_pcibios_bus_add_device+0x60/0xb0
>     [c000200e439839f0] [c0000000000606d0] pcibios_bus_add_device+0x40/0x60
>     [c000200e43983a10] [c0000000006aa3a0] pci_bus_add_device+0x30/0x100
>     [c000200e43983a80] [c0000000006aa4d4] pci_bus_add_devices+0x64/0xd0
>     [c000200e43983ac0] [c00800001c429118] cxl_pci_vphb_add+0xe0/0x130 [cxl]
>     [c000200e43983b00] [c00800001c4242ac] cxl_probe+0x504/0x5b0 [cxl]
>     [c000200e43983bb0] [c0000000006bba1c] local_pci_probe+0x6c/0x110
>     [c000200e43983c30] [c000000000159278] work_for_cpu_fn+0x38/0x60
> 
> The root cause is that those cxl virtual devices don't have a
> representation in the device tree and therefore no associated pci_dn
> structure. In eeh_add_device_late(), pdn is NULL, so edev is NULL and
> we oops.
> 
> We never had explicit support for EEH for those virtual
> devices. Instead, EEH events are reported to the (real) pci device and
> handled by the cxl driver. Which can then forward to the virtual
> devices and handle dependencies. The fact that we try adding EEH
> support for the virtual devices is new and a side-effect of the recent
> cleanup.
> 
> This patch fixes it by skipping adding EEH support on powernv for
> devices which don't have a pci_dn structure.
> 
> The cxl driver doesn't create virtual devices on pseries so this patch
> doesn't fix it there intentionally.
> 
> Fixes: b905f8cdca77 ("powerpc/eeh: EEH for pSeries hot plug")
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a8a30219ba78b1abb92091102b632f8e9bbdbf03

cheers
