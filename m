Return-Path: <linuxppc-dev+bounces-25449-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ADDC55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 17:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFcZZ5k9Qz2ygW;
	Thu, 06 Aug 2026 03:18:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785950326;
	cv=none; b=Q457qR1IPdPwlYCcGEJshtjLJD4QgNKUI7FZilhR67a/DZqACnlSO2y1wXL+XunUOY9ksawUIlgIu2OUy6V8yS30mZ+INAJKmmaZLWzptM6nnlEnNMmx1AEy60l1c9CHc4ZTiQTfKA7yJ7nTeAL6daVKPpwvmHne9pnb5b0luNL66eYyE4k8w0YIxHU5HV8+O9lj3CHhdnJG1QMMmSERNYa7FAFkuh6UMa5gh5zgF3/yZ3PaBRtQWffSFWc/iGwqW9ofPtZVUyL0DapGJR5oTbb4Q9CHtlty6dFasfh1TMyoSISQrWWFtc7Fu3a1lpBHyhHXhLDqb1TDy7kll0gL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785950326; c=relaxed/relaxed;
	bh=cS+1OPt43LY9PVcLmNXnPTuZJ4WgQujUCM/knEjl0HU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RTTbivriS0thxaVk+rQXA94AbQ4WQgrx+W+5aSOtFQ4EAStxmdXV32UzeDtS0QrDAGwb+5/lJiYvJu8CgRaWRJNNd5RNzeCwnC4ojXf5TJFSthJaiOn3PezXsFpWGm0+T5Mc+kbIeDwNbEim5UCmbwT4IiGm376w3qZUstt8NG7BWDt9NzLwFQkAcmwlQiM274D2WWNRBN6Z5A8UrVeQ27dP7c/DiXGkdzqc2DH9U0OEo4bhrTrfyWLxjwYTz+ffiiYSLvb1rXSxRTnEKXzX3R9hlEuFXfMPGq7LCbquI79tQXpcSfvIpMdTjJOeFEPWI7fZUAkpn3k4/s1tPzY26A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/HuuOGd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/HuuOGd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFcZY3J48z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 03:18:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 25DA46011F;
	Wed,  5 Aug 2026 17:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10C71F000E9;
	Wed,  5 Aug 2026 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785950321;
	bh=cS+1OPt43LY9PVcLmNXnPTuZJ4WgQujUCM/knEjl0HU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=N/HuuOGdJ4jfuVsLPVIvPkgZ2xNnrprRB7r/nUGJooGCbWrE139e6SSrx7FR0hjRI
	 +TyBc/fziElSkTuwBIQAVqWtVWSFfwAcdYNOi3cJjZv8O6rbCo2qlNMk63qoF5/wk5
	 kuZWcKDDZ932oqPNnVIJ+HdWY6q2GH3ORzcRGbgpxJc6OsqQTQgTp6+UQfiw0a8KpW
	 fRMjh+lGP77i/eMjTki89xfFrULwI18IME78CpglYlx2twmiBE640OTeGkyE+XGHs7
	 lu3yg5x/qAc7tkFFRUugrtpqqTt9jvM9chRi8C/NK+tbdlisXGkYjQrMrjYN9XQEGn
	 ogQhEdgpLFOFQ==
Date: Wed, 5 Aug 2026 12:18:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Avinash Roy <avinash@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com,
	npiggin@gmail.com, chleroy@kernel.org, sbhat@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avinash Roy <avinash.roy1@linux.ibm.com>
Subject: Re: [PATCH] PCI: quirks: Add warm reset quirk for IBM Spyre
 accelerator
Message-ID: <20260805171840.GA2126423@bhelgaas>
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
In-Reply-To: <20260805125132.941270-1-avinash@linux.ibm.com>

On Wed, Aug 05, 2026 at 06:21:32PM +0530, Avinash Roy wrote:
> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> 
> The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
> reset method for reliable EEH recovery on pSeries/ppc64 platforms.
> 
> FLR alone is insufficient because it does not re-initialize the Spyre
> firmware state machine. On ppc64 with EEH enabled,
> pcibios_set_pcie_reset_state() is overridden in
> arch/powerpc/kernel/eeh.c to drive the platform-level PERST# signal via
> EEH PE operations, which is the correct mechanism for full device
> recovery after an EEH event.

This makes it sound like this mechanism is needed for EEH recovery for
*all* devices, not just Spyre.  If that's the case it sounds like we
need more than just a Spyre-specific quirk.

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
>   - Wait 250 ms for PCIe link retrain and device recovery
> 
> Signed-off-by: Avinash Roy <avinash.roy1@linux.ibm.com>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
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
> +
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

