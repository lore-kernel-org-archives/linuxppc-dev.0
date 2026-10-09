Return-Path: <linuxppc-dev+bounces-29105-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1A6CA6019
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 15:28:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1W2x2M2Hz30TQ;
	Sat, 10 Oct 2026 02:28:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791559689;
	cv=none; b=gOryzwvSPjfWwPAFkJxpnzswzEkcvFjAXrlfuUWhmY+n50EYYkE8zyhI4I2cgKCZN0v/qOJ+sw8qzB90BbUkZcOHsAg6AJxSL/Xh4tq2bYYXJ1kCpA4rrjRG8enznLUzxK/1BmYxR28KTgUWiCDybDOSQYp1q9GrCTE4NVlxziQdfPc34v0E9eTQQwiJCCA2Barl7a9ErYlV51FcAQvPp396e9ixBvayIxOMCy7Yvv7Hc9P4jjRMzuggCg9mWlAtKeRJtUMRRi2/8mJ9vssN1jYsuiJz0w9ILWuLin9Bh1oGPMKuosdiHjLMvsVY3CPQlduYjIcPachiXZdYK5Oggg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791559689; c=relaxed/relaxed;
	bh=IiS1UvmOMWNqNjEpqtlrQxFdLJAgjIxDH8wds6VmHdo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F1Y3g3WGa4hshkcAKwP6nx7D26MZ+gfQh2H3ESAYaChs+zc+8w0k3VuwdcRIj1ScndTft9MYY7uU22JXiCba6B2rjaQyv+StH+gPpGvTrySIisardugxi1DTWe5o6Y4RtCOakUsyXKub0UG8uNWpaU1IFVuctaHckDRbCRcCO3lo8p9bWPlbfB0jK8G9KFWxsbmUMxVfveS+iJ/bzBIGlwkCEFwOzglEMvl9TabRMNoECX0rjLsch9J1xyF9NzWCsuUIz6HuumF4+ttppiOIbjlEFNeU85C9BuOSCACppcxnxE0COXben0D9cxt4NYnYBUFXKw/djFdurVepx+394w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QP9T9/2y; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QP9T9/2y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1W2w15zzz30Ng
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 02:28:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 28CCD60DBD;
	Fri,  9 Oct 2026 15:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A309A1F000FF;
	Fri,  9 Oct 2026 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559684;
	bh=IiS1UvmOMWNqNjEpqtlrQxFdLJAgjIxDH8wds6VmHdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QP9T9/2y5bUFVqiIG9z/gf01T9noOv3mU/SGs2umbpBDYnQR2beitZJzKdRklZRN3
	 8vmgGx5NeFzzOAFOMXR/HNevFimKpVZbs4orTCXPXAwPG2TI16Sazjp7Sqo7nFh+tt
	 bADiFscufd+CQalNenQ/3/fLjKNlctJAv8e+DwboJVcvAeovxv7g+DbJo5lH3IYz3s
	 G6U17Na71nisZJIDD63krlHPo8WcWclnIlSKPROlZntmfmIe6BUGgKPtqtrISIdoPH
	 MEybWQ+fO95yE0U9paQyNgKhLC1iZxV48n7E6rN26O/2T2BUCb1XKTbWJkz2LV7p0a
	 zA16RkUj6ThgQ==
Date: Fri, 9 Oct 2026 10:28:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Avinash Roy <avinash@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com,
	npiggin@gmail.com, chleroy@kernel.org, sbhat@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avinash Roy <avinash.roy1@linux.ibm.com>
Subject: Re: [PATCH v2] PCI: quirks: Add warm reset quirk for IBM Spyre
 accelerator
Message-ID: <20261009152803.GA975637@bhelgaas>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821123401.1375297-1-avinash@linux.ibm.com>

On Fri, Aug 21, 2026 at 06:04:01PM +0530, Avinash Roy wrote:
> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> 
> The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
> reset method for reliable EEH recovery on pSeries/ppc64 platforms.

It sounds like if you plugged a Spyre into an x86/arm64/etc platform,
it would still need a dedicated warm reset quirk because the issue is
with Spyre, not with pSeries.

> FLR alone is insufficient because it does not re-initialize firmware
> state machine for the current version of the card. The existing API
> pci_set_pcie_reset_state() is used to drive the platform-level
> PERST# using the EEH interfaces by adding a device specific quirk.
> 
> The reset function is placed in arch/powerpc/platforms/pseries/pci.c
> where the EEH infrastructure is already present, declared in
> pseries.h, and registered in the generic pci_dev_reset_methods[] table
> in drivers/pci/quirks.c under a CONFIG_PPC_PSERIES guard.
> 
> This reset method is only registered when CONFIG_PPC_PSERIES is enabled,
> so it is not available on other platforms.
> 
> Reset sequence:
>   - Assert PERST# via pcie_warm_reset, hold 250 ms
>   - Deassert PERST# via pcie_deassert_reset
>   - Wait 250 ms for PCIe link retrain 	
> 
> Signed-off-by: Avinash Roy <avinash.roy1@linux.ibm.com>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> 
> ---
> Changelog
> v1: https://lore.kernel.org/linux-pci/20260805125100.1-1-avinash.roy1@linux.ibm.com/
> 
>    Reworded the commit message to highlight the warm reset requirement being
>    a need of the current card and not a platform deficiency.
> 
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 84e4ffe957a8..7aa58d57208f 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/string.h>
> +#include <linux/delay.h>
>  
>  #include <asm/eeh.h>
>  #include <asm/pci-bridge.h>
> @@ -236,6 +237,41 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
>  			 fixup_winbond_82c105);
>  
> +/*
> + * Reset Spyre adapter using pci_set_pcie_reset_state()
> + * This is specifically for PPC platforms where EEH (Enhanced Error Handling)
> + * requires this reset method for proper device recovery.

This comment still suggests that the issue is related to the platform,
not the adapter itself.  I know reset_spyre() will only *work* on
pSeries because pcibios_set_pcie_reset_state() is only implemented
there.

> + */
> +int reset_spyre(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (probe)
> +		return 0;
> +
> +	/* Assert warm reset */
> +	ret = pci_set_pcie_reset_state(dev, pcie_warm_reset);
> +	if (ret) {
> +		pci_err(dev, "Failed to assert reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for reset to take effect */
> +	msleep(250);
> +
> +	/* Deassert reset */
> +	ret = pci_set_pcie_reset_state(dev, pcie_deassert_reset);
> +	if (ret) {
> +		pci_err(dev, "Failed to deassert reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for device to recover */
> +	msleep(250);
> +
> +	return 0;
> +}
> +
>  static enum pci_bus_speed prop_to_pci_speed(u32 prop)
>  {
>  	switch (prop) {
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 3968a6970fa8..79c194aeb3c6 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -92,6 +92,10 @@ extern struct pci_controller_ops pseries_pci_controller_ops;
>  int pseries_msi_allocate_domains(struct pci_controller *phb);
>  void pseries_msi_free_domains(struct pci_controller *phb);
>  
> +/* PCI device reset method for Spyre adapter */
> +struct pci_dev;
> +int reset_spyre(struct pci_dev *dev, bool probe);
> +
>  extern int CMO_PrPSP;
>  extern int CMO_SecPSP;
>  extern unsigned long CMO_PageSize;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..1b8ab5d9764b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4237,6 +4237,11 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PPC_PSERIES
> +/* Defined in arch/powerpc/platforms/pseries/pci.c */
> +int reset_spyre(struct pci_dev *dev, bool probe);
> +#endif

Given that we need these ifdefs anyway, I think it would be simpler to
just include the reset_spyre() implementation here.  It doesn't look
like it needs anything pSeries-specific, since
pci_set_pcie_reset_state() is already available.

>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4252,6 +4257,10 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +#ifdef CONFIG_PPC_PSERIES
> +	{ PCI_VENDOR_ID_IBM, 0x06a7,
> +		reset_spyre},
> +#endif
>  	{ 0 }
>  };

