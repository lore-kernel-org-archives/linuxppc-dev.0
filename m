Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CC606A8A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akpEE/dG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWNsg27Zjz2xwN;
	Sat, 21 Nov 2026 05:19:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795198791;
	cv=none; b=OtaZ8AOhJYMfhBaqqtRHyU+cF9h0h2DsUV04heyxJbCaQNb2ilMfsxQe51uGFv5uF2uU62fuXgrjtvXPXb/9nQ2dzG0g0S/3UrdN8j4I+yd1gvwQGDrG4cVmxFMLGB7un9QE04ysOb+Ndp/FtvGQyiRnoI2rjtKkY9fmWMvtInhFhCM7Na9pJaIFIzqk9fAJmOc/MPUBNLxADT/iK9W+BhOLAvGWkXADI+iH2s10REyfK3fPLkj42kIqrze36U+056Hwm1uSoQ6ELmm1+R4+MH7nTYVF63xCUuCAV3+uhf2VjxQZ1VqgGfzKXS2DwpU14D9E3ZycYubQcMEETYRDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795198791; c=relaxed/relaxed;
	bh=5Vhbt7aW3jWHIeGfBwm+6fRLbamSR1yw/0kxYWIIdZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kaaVhtC3khRwkWkr3iqZiw1jr71LLgeLbThVDNJ6+OvxpJQkbE14nPj0XW24RaBCMejqcvwzOR4433oor8s80sszZmsVpv9aCzx8wuGOShEoXkgRee4RQ4wNbnwL3HpUB7y6Qm9zEwHDlxp4Bk1CSGiNhOAPTNS8SyCrPyiyk9OH2wdl0JY/kSZKEqbLeLax3dJkUQqAuFwyJgL3ciR9l38otJ8fpuuY/8482fv6psD7Y67ojAFuBtwCd+ZIyEmbh2gyAgbMu4CRy75Zh5RsfF7EboVcEjoTpuySTR6WQOs2+mNeWv7XFYDKnIUpsqAlyx+fd6MGhqThh49izAkM1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akpEE/dG; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akpEE/dG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWNsf1W0bz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 05:19:50 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6E553633C9;
	Fri, 20 Nov 2026 18:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB121F000F0;
	Fri, 20 Nov 2026 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198786;
	bh=5Vhbt7aW3jWHIeGfBwm+6fRLbamSR1yw/0kxYWIIdZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=akpEE/dGvzTVKXG44McHDOZeqdy4kbz+M72BYyCuS8m9ySpFgszqdxQwiAI9raS/Y
	 x7UMfxeVB+x1/opIhppv5+xHQ2U9hrhCRfQSoNnCb9pSteB73hFRa7gjyzzHylqzBD
	 wz+hRpFB35xxc5Tfj9JDXSf3pKZJ+eS54Jw3PPQ9krWwg0LmNosYlLmS5I8NOGUmOe
	 LI2EcY7o7V9OBOY1q/N3FHBZnfjv3PqZr2zFqsGrZpKSJ9oJaLSU+t2Gt62TQ/HoE8
	 P5q21HdhZsjxL3Qo92xU8KtSyKuTeMMtam8UXF/Wq2BzEs1QJIIXK2Tgn/Y8sAiHJL
	 MPyKavkBMfmFg==
Date: Fri, 20 Nov 2026 12:19:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Darshit Shah <darnshah@amazon.de>, Jason Perlow <jperlow@gmail.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>
Subject: Re: [PATCH v2 0/7] Error reporting for AER-incapable devices
Message-ID: <20261120181945.GA904595@bhelgaas>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 11:40:00AM +0100, Lukas Wunner wrote:
> Bjorn suggests "the PCI core should do pci_enable_pcie_error_reporting()
> independent of whether the device has an AER Capability":
> 
> https://lore.kernel.org/r/20260826212619.GA1566339@bhelgaas/
> 
> This is done in patch [7/7].  The preceding patches contain prep work.
> 
> For context, PCIe r7.1 sec 6.2.1 defines two error reporting paradigms:
> AER and baseline capability.  The latter relies (solely) on the error
> enable/status bits in the Device Control and Device Status registers,
> which exist on every PCIe device.  The kernel has supported the AER
> paradigm for 20 years.  With the present series, it gains support for
> the baseline capability paradigm.
> 
> Patches [1/7] and [2/7] reinstate DPC on AER-incapable Downstream Ports.
> The kernel used to support this until 2018.  It is hereby fixed because
> it eases introduction of baseline capability error reporting in the
> subsequent patches.
> 
> 
> Changes v1 -> v2:
> 
> * Patch [1/7]:
>   * On AER-capable devices, infer severity from AER Extended Capability
>     instead of Device Status register because the latter also logs masked
>     errors (Sathya).
>   * Fix storytelling in commit message because 4e5fad429bd1 changed
>     behavior, not 708b20003624 (Sathya).
> 
> * Patch [3/7]:
>   * New patch to clear error status bits more selectively (sashiko).
> 
> * Patch [4/7]:
>   * Clear Fatal Errors as well on recovery failure (Sathya, sashiko).
> 
> * Patch [6/7]:
>   * Amend kernel-doc of pci_aer_unmask_internal_errors() (Sathya).
> 
> * Patch [7/7]:
>   * Convert AER severity to Device Status bit with new severity2devsta[]
>     array, instead of renumbering AER severity (sashiko).
>   * On entry of aer_get_device_error_info(), clear info->mask and
>     info->first_error (Sathya, sashiko).
>   * Emit "(no details available)" message for AER-incapable devices
>     as well as for devices whose AER registers are deliberately not
>     read on Fatal Errors (Sathya).
>   * Amend commit message to inform that System Errors may be raised
>     by AER-incapable devices if they have no AER- or DPC-capable
>     port in their ancestry (Sathya).
> 
> Link to v1:
> 
> https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de/
> 
> 
> Lukas Wunner (6):
>   PCI/DPC: Avoid access to non-existent AER capability
>   PCI/DPC: Reinstate support for AER-incapable ports
>   PCI/ERR: Clear error status bits more selectively
>   PCI/AER: Drop AER native check from handles_cxl_errors()
>   PCI/AER: Move AER capability check out of pcie_aer_is_native()
>   PCI/AER: Enable baseline capability error reporting
> 
> Yury Murashka (1):
>   PCI/ERR: Avoid stale error status bits on recovery failure
> 
>  .../ABI/testing/sysfs-bus-pci-devices-aer     | 26 +++++--
>  Documentation/PCI/pcieaer-howto.rst           |  9 +--
>  drivers/pci/pcie/aer.c                        | 76 +++++++++++++------
>  drivers/pci/pcie/aer_cxl_rch.c                |  3 +-
>  drivers/pci/pcie/dpc.c                        | 46 +++++++----
>  drivers/pci/pcie/err.c                        | 14 +++-
>  6 files changed, 120 insertions(+), 54 deletions(-)

Applied to pci/aer for v7.5, thanks!

