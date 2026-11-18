Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB60606C727
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQMF2R9P
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVBVs53v5z2xdX;
	Thu, 19 Nov 2026 06:29:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795030165;
	cv=none; b=Y0hvQarwidq5Vhqejn0os3nV2o9Dl64cKlxMatlGRXRlxJQZZLBVXvVmJ6uMyfDMG/p4FMSyBZ+BqjafTLvsdyoYj2TH2Msb1Fgys4CqqZG8wBM1VGZQZACN7fyc8LRZo2Mhca7GhFLeAh2TxQ8K2/pASdUfIq/wNYP+4HFijzj3ZhFWrs5TOBZbJUFAONUN95NiEvPwPQSNC5QU8VbKH1VBiBsj0VDO2Q5S0sFdVy1Y3J9BhFhVwLSHE5OBqZbA8q7mTTszdwNs+9bBUa65K5kglQ7+LuJnBPHzb3raZaE6SAWkY2jjZwzyD1zV04hXuJzVj3dmnOHgru3TEMRdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795030165; c=relaxed/relaxed;
	bh=JJVam/uvZJBrgEkalBet5PVx2RW+nfigUefm/MSs4n4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdkxoaimpDfHfzyRygxitOBqlvapbEO1GMRGQU9uRZ2yF/DQHlJiS5evH6ejw8euRZQUPNO0K8fwAAHZKmuS0VRwdJzbz5qCgovWQprGH8SQPWTRL9t1lqqSk+t2qTeeGToL5J1QvUdVnDE1s4jAchYODUBpkmksFj8X8W4gry9CRsDazlRdqPSwx6Q+6dbYvPao/8IxmvNZXF0qF5tkJnK9I4dxGOq63omBmk6spJc49H5v4s//+m+CXlbrPsNZkfr8h0tkW3cRvnj+ZxYUcaUDrMImAAC5PT8vYbqmXY207Rqa069KPg6YcypzTLNQxgmbhPfQV9JFydpwazNk3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQMF2R9P; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQMF2R9P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVBVr4297z2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:29:24 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 448A341208;
	Wed, 18 Nov 2026 19:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A260E1F000C9;
	Wed, 18 Nov 2026 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030162;
	bh=JJVam/uvZJBrgEkalBet5PVx2RW+nfigUefm/MSs4n4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EQMF2R9PZs0N8mIRRWGUD6gKWClhjyEwi9hhRXRFtask4MefFvRdlvqwYTEdjfgeF
	 SgPtKyzPxKDwpHVxzuWZyNdx4JouHyyJzK3IOsr2j/6Ms7mqp0oiVGBVChQJV6tvXe
	 la0Z9shVkj7Bws2hWiErxteYhdqmvkCSa+5mkHUYkvUs9NcxLJvjUEh16y6LWyFUJw
	 Y3pKsewHD11SrmLztX4KnTLxtg0sg1w2jXuYLcgzJQ79JByvIMOl00exu90tdFgzs9
	 AfaOFNXGCJsymqIA7Ku29q7STnqQytuQgb53dcdy8XI7aaLRpbSsjmM4uMV67xfD1g
	 mUFQohWucDh2g==
Date: Wed, 18 Nov 2026 19:29:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Radu
 Rendec <radu@rendec.net>, Avadhut Naik <avadhut.naik@amd.com>, Kai-Heng
 Feng <kaihengf@nvidia.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 08/19] ACPI: extlog: Align extlog_print_pcie() and
 ghes_handle_aer()
Message-ID: <20261118192912.7c222427@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-9-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-9-pierre.gondois@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 12:10:18 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> In order to unify extlog_print_pcie() with ghes_handle_aer() and
> prepare to remove one of the functions, align the behaviour of the
> 2 functions. Thus:

Say which function you are changing.

> - Submit the decoded snapshot through aer_recover_queue() instead of
>   just printing the error.

That's a major functional change.  I'm kind of making the assumption
that something handled the aer recovery previously that wasn't via
this path?  So do we now handle it twice?  I can't figure out how
this works on systems using extlog but it is certainly a bold change to make :)


> - Override the mapped AER severity with AER_FATAL when CPER_SEC_RESET
>   is set so the AER worker selects the frozen-channel recovery path
>   when it finds an unmasked uncorrectable error.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/acpi_extlog.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 125f7931b98bc..e09ea571c32f5 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -8,9 +8,11 @@
>  
>  #include <linux/module.h>
>  #include <linux/acpi.h>
> +#include <linux/aer.h>
>  #include <linux/cper.h>
>  #include <linux/ratelimit.h>
>  #include <linux/edac.h>
> +#include <linux/pci.h>
>  #include <linux/ras.h>
>  #include <cxl/event.h>
>  #include <acpi/ghes.h>
> @@ -138,7 +140,6 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>  	struct aer_capability_regs aer_regs = {};
> -	struct pci_dev *pdev;
>  	unsigned int devfn;
>  	unsigned int bus;
>  	int aer_severity;
> @@ -156,6 +157,9 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
>  		return;
>  
>  	aer_severity = cper_severity_to_aer(gdata->error_severity);
> +	/* A component reset by firmware needs reinitialization. */
> +	if (gdata->flags & CPER_SEC_RESET)
> +		aer_severity = AER_FATAL;
>  
>  	aer_cap_regs_unpack(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
>  
> @@ -163,12 +167,7 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
>  	bus = pcie_err->device_id.bus;
>  	devfn = PCI_DEVFN(pcie_err->device_id.device,
>  			  pcie_err->device_id.function);
> -	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> -	if (!pdev)
> -		return;
> -
> -	pci_print_aer(pdev, aer_severity, &aer_regs);
> -	pci_dev_put(pdev);
> +	aer_recover_queue(domain, bus, devfn, aer_severity, &aer_regs);
>  #endif
>  }
>  


