Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD8606A329
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 18:07:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSJqN443fz2xLm;
	Mon, 16 Nov 2026 05:07:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794766032;
	cv=none; b=dTQjshQKbXz3lZ1tvLLIHqfoPj0RBEtYlotVq1fy/ziE1m4df6/zDz2CnA2x193hTD7H0ClzSoK47DAoSVx2YaRTxP/cjiyRis9fvztqIcNqIwqvuUPWrrK+ATbwJlLvEvM4xCdqVAJwEOSVYGl2FCaBqESQEVDxIGha9IMnU34dN5qUEUInZ/r/snJOsxrvsbKTXCD9AvJQtyjQuWISYC0bSIZLlZEzfl/SAc1SzQUO6uIPeA8GaXHLelYlEWMfRJcepbR10YShLx4a95DbtD2aXbMjBTg+R743t1YHagVADrf1oKYWjsxjlInjKYofqcw+Nc7l02T115BfSnqyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794766032; c=relaxed/relaxed;
	bh=EQ6kRznTinREoIuzVBbxmzS9hOEhoTl38G8AURcRJc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVq45I+Nz6lJonxoWclHCa+CJfJ6zcwAs4WtLvlV+wODblarPyqR7hkOAE7FagByoJC71TIJ2p/lX3MCuDDoYPaMbZICpU/ZQUbMt0Nh/15HgwiwxfV/MwAq/lBTW7VAf1e8sMA8BqvOt/PzuXzfjbM1/OT3aQN4o/BgO2jiSOxHBoQtEfONYMDGyVJI20QZfl2+u9EzBnHShDqgaZBNC8RMa8UqoVxoPQjRvIJfgCvkwYpe9lMN+LZmK87Bo++6AcrdCl6W0zuAYMhZo50wef49my6TYPCS/aqKSPFc9/VKyEawG28kLOzJ+hhrZqfzzLKFalA+xva+dJ5rCHzsbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSJqM0tS8z2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 05:07:10 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 5B0793A2B;
	Sun, 15 Nov 2026 19:07:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 33E276024661; Sun, 15 Nov 2026 19:07:06 +0100 (CET)
Date: Sun, 15 Nov 2026 19:07:06 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/7] PCI/DPC: Reinstate support for AER-incapable ports
Message-ID: <avn0yqCrX0uZl_a1@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de>
 <02a33171-b901-400b-921a-c40fe167b424@linux.intel.com>
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
In-Reply-To: <02a33171-b901-400b-921a-c40fe167b424@linux.intel.com>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 29, 2026 at 12:04:32PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> > Downstream Port Containment does not mandate presence of an Advanced Error
> > Reporting capability, so a Downstream Port may support DPC, but not AER
> > (PCIe r7.1 sec 6.2.11.2).
> > 
> > Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
> > ownership") seemingly inadvertently constrained DPC to AER-supporting
> > Downstream Ports by inserting a call to pcie_aer_is_native() in
> > dpc_probe(), which implicitly checks for presence of an AER capability.
> > 
> > Drop the call.
[...]
> I don't think 708b20003624 changed behavior here.  At the time,
> get_port_device_capability() only instantiated the DPC service if
> pcie_ports_dpc_native was set or the AER service was instantiated,
> and the latter required dev->aer_cap and native AER control

There are two separate issues preventing DPC on non-AER-capable ports:

- Commit 4e5fad429bd1 ("PCI/DPC: Do not enable DPC if AER control
  is not allowed by the BIOS") inserted a problematic check in
  get_port_device_capability().  This was fixed by 97ca178c899d
  ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER"),
  which is tagged for stable but missing a Fixes tag.

- Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing
  for AER ownership") inserted a problematic check in dpc_probe().
  This is fixed by the present patch.

You're right that 708b20003624 did not change behavior, but I still
think that it is the correct commit to cite in the Fixes tag.

If I would instead reference 97ca178c899d (as you suggest), it would
be picked up by stable maintainers for all stable kernels containing
97ca178c899d.  The combination of both patches would then reinstate
DPC on non-AER-capable ports.  Great.  However that commit did not
actually break anything, so it doesn't feel right to put it in a
Fixes tag.

So I tend to keep the Fixes tag as it is.  Let me know if you disagree.

> Also, for stable kernels, is there any way to note that this patch needs
> to be picked with patch 1. Otherwise DPC driver might access AER config
> without aer_cap.

The syntax specified in Documentation/process/stable-kernel-rules.rst
looks like this:

    Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
    Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
    Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
    Cc: <stable@vger.kernel.org> # 3.3.x

However the SHA-1 hash of the first patch in the series isn't known
until the patch is applied and the maintainer would then have to
manually update the referenced SHA-1 in the second patch when
applying it, which is tedious.  In practice, I've found that this
doesn't work and the best one can do is keep an eye on Sasha's
and Greg's e-mails when they apply patches and alert them whenever
something is wrong or missing.

Thanks,

Lukas

