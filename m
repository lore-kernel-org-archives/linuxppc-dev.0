Return-Path: <linuxppc-dev+bounces-22877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5018CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 15:58:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkXth0Dw3z2yVZ;
	Tue, 23 Jun 2026 01:58:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782143931;
	cv=none; b=TaFld8Uzm7/4nobX+SBXbrXBWa/NJv3DvzzI2cYRRDOEJxzwfDDox+A69HII7oecI0poLjhNyRsvw+ZKqchmu7RDIZfljgBAXpxARCCaSW064zzkcSR6BW6a1eJIWxN3n7VsTGZ0cY254iyET0sNMPl+WVPXCy91Y1WoRfivCeaGi53CJwQcbx80LnZ9OsIhnFvFfcBuLUkhAcMahm7lwic0YPYZul1J7wOOP+kPN7CLChJSgPIq4sPOpDBsoNswObtY1MnFRiYduEgZHPT1TiNw8+XBeOxe+U1kMhjUwwnjTpYylL59gcNFZTnhMc5JHwWL7uEDlRL7Uav0w5tv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782143931; c=relaxed/relaxed;
	bh=UkLwf4/QyP1Yi6wvnPkjGleUk0Fd5AHHFeNFSuwbkvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYlwdH9ZOsVEcgfuG90i9VMWc+fOOwsLDwK0757SAV7x9efcmBZWUz72eZYqyi6/hpVjd/jqNolJkDa3cSBE6+4w5ycsaF91I/osTv42/M6UCvp0kt0PzVsjJErYXBeGL6FRE7BFBZfAO2okyvrBz5PZPmOjowilOHZRVqGfwU+qc7nDiNfUC/NKs5xHHFuED3V+gl21+96TDjhoADgz36W/51hXI1BSMLYFfHJHWWQ6HEvQZFNIP5pNy6h3cWgpPOAyIxId1qOE/hrL1MjzQaZmT/BqWoF+Auej2uuI3qlO6kLgtnm7pyhYfyLO5IOhAB2ZIe1Cdk8d9pjkJn81fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOArqTVY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOArqTVY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkXtg0lFYz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 01:58:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 864BD601F6;
	Mon, 22 Jun 2026 15:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169121F000E9;
	Mon, 22 Jun 2026 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143928;
	bh=UkLwf4/QyP1Yi6wvnPkjGleUk0Fd5AHHFeNFSuwbkvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LOArqTVY8dxdyrbj8R264+4IzWm9EqpHZ+kDQNK4SSKP/LvTJwRcQUrBrV3idAEom
	 dGUfDxuabwKyRZ7l5YqeNoH22AnMS1VYRNLAudVVo7aq+cg8dm6uGFpob4lcdx7VE1
	 Ev/c0EnaFKPa/rmXkHgq+o+k2scb+vXRwl+6ZeV73/OPVjkS+Hisfn5nhUdWBYUnok
	 munwLR3PVvTuHxUzxsuN3XkATfUJ7EPBVrRuXte+dLDNVJKv/3qzjOpWfV1cC08aBN
	 ofzCWNqIGVa33s+RPwHTwOwDZD1M0l0jj9H8X0s04UkLe8DSLi80nn9nYZXJCwNtKQ
	 Z4eUUz62/qSpg==
Date: Mon, 22 Jun 2026 17:58:38 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: pnv_php: Use common error handling code in
 pnv_php_alloc_slot()
Message-ID: <tlemzejir3wi3rff2x65bbqqknzel4nwy3fnlvruyg7fll4p44@zqrf3z2cxhuu>
References: <5cd04727-44c5-4ace-af86-d3c227234d4b@web.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cd04727-44c5-4ace-af86-d3c227234d4b@web.de>

On Thu, Jun 11, 2026 at 11:25:12AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 11 Jun 2026 11:16:49 +0200
> 
> Use an additional label so that a bit of exception handling can be better
> reused at the end of an if branch.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pci/hotplug/pnv_php.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index ff92a5c301b8..e448f1802002 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -791,16 +791,15 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
>  		return NULL;
>  
>  	php_slot->name = kstrdup(label, GFP_KERNEL);
> -	if (!php_slot->name) {
> -		kfree(php_slot);
> -		return NULL;
> -	}
> +	if (!php_slot->name)
> +		goto free_php_slot;
>  
>  	/* Allocate workqueue for this slot's interrupt handling */
>  	php_slot->wq = alloc_workqueue("pciehp-%s", WQ_PERCPU, 0, php_slot->name);
>  	if (!php_slot->wq) {
>  		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
>  		kfree(php_slot->name);
> +free_php_slot:

Really? What kind of coding practice is this?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

