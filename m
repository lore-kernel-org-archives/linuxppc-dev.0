Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1879C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 11:04:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270AB2081C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 11:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270AB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4374xr0Q3fzDqMh
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 22:04:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4374vf0934zDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2018 22:02:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4374vc6qfmz9sD4; Sun,  2 Dec 2018 22:02:04 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 78e7b15e17ac175e7eed9e21c6f92d03d3b0a6fa
X-Patchwork-Hint: ignore
In-Reply-To: <20181128032048.11665-2-radu.rendec@gmail.com>
To: Radu Rendec <radu.rendec@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/1] Fix NULL pointer access in PowerPC MSI teardown code
Message-Id: <4374vc6qfmz9sD4@ozlabs.org>
Date: Sun,  2 Dec 2018 22:02:04 +1100 (AEDT)
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
Cc: Radu Rendec <radu.rendec@gmail.com>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-28 at 03:20:48 UTC, Radu Rendec wrote:
> The arch_teardown_msi_irqs() function assumes that controller ops
> pointers were already checked in arch_setup_msi_irqs(), but this
> assumption is wrong: arch_teardown_msi_irqs() can be called even when
> arch_setup_msi_irqs() returns an error (-ENOSYS).
> 
> This can happen in the following scenario:
> 
>   * msi_capability_init() calls pci_msi_setup_msi_irqs()
>   * pci_msi_setup_msi_irqs() returns -ENOSYS
>   * msi_capability_init() notices the error and calls free_msi_irqs()
>   * free_msi_irqs() calls pci_msi_teardown_msi_irqs()
> 
> This is easier to see when CONFIG_PCI_MSI_IRQ_DOMAIN is not set and
> pci_msi_setup_msi_irqs() and pci_msi_teardown_msi_irqs() are just
> aliases to arch_setup_msi_irqs() and arch_teardown_msi_irqs().
> 
> The call to free_msi_irqs() upon pci_msi_setup_msi_irqs() failure seems
> legit, as it does additional cleanup; e.g. list_del(&entry->list) and
> kfree(entry) inside free_msi_irqs() do happen (MSI descriptors are
> allocated before pci_msi_setup_msi_irqs() is called and need to be
> cleaned up if that fails).
> 
> Signed-off-by: Radu Rendec <radu.rendec@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/78e7b15e17ac175e7eed9e21c6f92d

cheers
