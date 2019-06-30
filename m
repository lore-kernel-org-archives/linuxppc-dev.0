Return-Path: <SRS0=xcTM=U5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA9C5B57E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:43:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02F12070D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02F12070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45c3vG2nyZzDqs3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 18:43:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45c3ll2hgkzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2019 18:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45c3ll1j74z9s8m; Sun, 30 Jun 2019 18:37:23 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: df5be5be8735ef2ae80d5ae1f2453cd81a035c4b
X-Patchwork-Hint: ignore
In-Reply-To: <20190605033814.127962-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH kernel] powerpc/pci/of: Fix OF flags parsing for 64bit BARs
Message-Id: <45c3ll1j74z9s8m@ozlabs.org>
Date: Sun, 30 Jun 2019 18:37:23 +1000 (AEST)
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
Cc: Shawn Anastasio <shawn@anastas.io>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-06-05 at 03:38:14 UTC, Alexey Kardashevskiy wrote:
> When the firmware does PCI BAR resource allocation, it passes the assigned
> addresses and flags (prefetch/64bit/...) via the "reg" property of
> a PCI device device tree node so the kernel does not need to do
> resource allocation.
> 
> The flags are stored in resource::flags - the lower byte stores
> PCI_BASE_ADDRESS_SPACE/etc bits and the other bytes are IORESOURCE_IO/etc.
> Some flags from PCI_BASE_ADDRESS_xxx and IORESOURCE_xxx are duplicated,
> such as PCI_BASE_ADDRESS_MEM_PREFETCH/PCI_BASE_ADDRESS_MEM_TYPE_64/etc.
> When parsing the "reg" property, we copy the prefetch flag but we skip
> on PCI_BASE_ADDRESS_MEM_TYPE_64 which leaves the flags out of sync.
> 
> The missing IORESOURCE_MEM_64 flag comes into play under 2 conditions:
> 1. we remove PCI_PROBE_ONLY for pseries (by hacking pSeries_setup_arch()
> or by passing "/chosen/linux,pci-probe-only");
> 2. we request resource alignment (by passing pci=resource_alignment=
> via the kernel cmd line to request PAGE_SIZE alignment or defining
> ppc_md.pcibios_default_alignment which returns anything but 0). Note that
> the alignment requests are ignored if PCI_PROBE_ONLY is enabled.
> 
> With 1) and 2), the generic PCI code in the kernel unconditionally
> decides to:
> - reassign the BARs in pci_specified_resource_alignment() (works fine)
> - write new BARs to the device - this fails for 64bit BARs as the generic
> code looks at IORESOURCE_MEM_64 (not set) and writes only lower 32bits
> of the BAR and leaves the upper 32bit unmodified which breaks BAR mapping
> in the hypervisor.
> 
> This fixes the issue by copying the flag. This is useful if we want to
> enforce certain BAR alignment per platform as handling subpage sized BARs
> is proven to cause problems with hotplug (SLOF already aligns BARs to 64k).
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Sam Bobroff <sbobroff@linux.ibm.com>
> Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
> Reviewed-by: Shawn Anastasio <shawn@anastas.io>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/df5be5be8735ef2ae80d5ae1f2453cd81a035c4b

cheers
