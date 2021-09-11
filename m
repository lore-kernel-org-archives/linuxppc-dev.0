Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE88C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 11:09:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7DB60FE6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 11:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A7DB60FE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H694c4V6xz2yJf
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 21:09:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=c7NELGpA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=c7NELGpA; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H693w3cD0z2y1R
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Sep 2021 21:09:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1631358554;
 bh=wCFs7QKhXMzS395kRZvRG47SpyWfFbs7z3zfl/ErxEA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=c7NELGpAh1HsCHqwY/uRPbVYXKqVYXvcpRQ7aAvLfrWo90t0t5JU4N5P5r1ljt3gd
 PVbtiY8u7jdCKuRrfL5DQucozCtmh/F7bFuUTJ+i+bpd7CsdQdknWHzExu+DvVIKtB
 uwLsrNPAELnlQpfGWJznYWBnjeSFXzWC1Cw3nK24plV5lEcWTFF1f42ZB5iMfSm/pa
 kKTVmte0UiwKhq93/QjxY9h1DRoEpQGfDYwBWQbUWcvFlw7+FKl3M4FUaSgcoxozKZ
 jSuPF+4DgNWfuChV3mQU6o/y5ZsSfBK4JQOfYjX0nTy3szz6t9mImirD8OXV4GtB7v
 xNGxQdtKhjO+w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4H693t161rz9sW5;
 Sat, 11 Sep 2021 21:09:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Niklas Schnelle <schnelle@linux.ibm.com>, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: Re: [PATCH 1/1] powerpc: Drop superfluous pci_dev_is_added() calls
In-Reply-To: <20210910141940.2598035-2-schnelle@linux.ibm.com>
References: <20210910141940.2598035-1-schnelle@linux.ibm.com>
 <20210910141940.2598035-2-schnelle@linux.ibm.com>
Date: Sat, 11 Sep 2021 21:09:13 +1000
Message-ID: <87wnnnl67a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Niklas Schnelle <schnelle@linux.ibm.com> writes:
> On powerpc, pci_dev_is_added() is called as part of SR-IOV fixups
> that are done under pcibios_add_device() which in turn is only called in
> pci_device_add() whih is called when a PCI device is scanned.

Thanks for cleaning this up for us.

> Now pci_dev_assign_added() is called in pci_bus_add_device() which is
> only called after scanning the device. Thus pci_dev_is_added() is always
> false and can be dropped.

My only query is whether we can pin down when that changed.

Oliver said:

  The use of pci_dev_is_added() in arch/powerpc was because in the past
  pci_bus_add_device() could be called before pci_device_add(). That was
  fixed a while ago so It should be safe to remove those calls now.

I trawled back through the history a bit but I can't remember/find which
commit changed that, Oliver can you remember?

cheers

> diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
> index 28aac933a439..deddbb233fde 100644
> --- a/arch/powerpc/platforms/powernv/pci-sriov.c
> +++ b/arch/powerpc/platforms/powernv/pci-sriov.c
> @@ -9,9 +9,6 @@
>  
>  #include "pci.h"
>  
> -/* for pci_dev_is_added() */
> -#include "../../../../drivers/pci/pci.h"
> -
>  /*
>   * The majority of the complexity in supporting SR-IOV on PowerNV comes from
>   * the need to put the MMIO space for each VF into a separate PE. Internally
> @@ -228,9 +225,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>  
>  void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
>  {
> -	if (WARN_ON(pci_dev_is_added(pdev)))
> -		return;
> -
>  	if (pdev->is_virtfn) {
>  		struct pnv_ioda_pe *pe = pnv_ioda_get_pe(pdev);
>  
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index f79126f16258..2188054470c1 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -74,7 +74,6 @@
>  #include <asm/hvconsole.h>
>  
>  #include "pseries.h"
> -#include "../../../../drivers/pci/pci.h"
>  
>  DEFINE_STATIC_KEY_FALSE(shared_processor);
>  EXPORT_SYMBOL(shared_processor);
> @@ -750,7 +749,7 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
>  	const int *indexes;
>  	struct device_node *dn = pci_device_to_OF_node(pdev);
>  
> -	if (!pdev->is_physfn || pci_dev_is_added(pdev))
> +	if (!pdev->is_physfn)
>  		return;
>  	/*Firmware must support open sriov otherwise dont configure*/
>  	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
> -- 
> 2.25.1
