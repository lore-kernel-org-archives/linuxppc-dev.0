Return-Path: <linuxppc-dev+bounces-13950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A78CCF9E3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Nov 2025 21:55:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3CXc2Wjsz2yFq;
	Sat,  8 Nov 2025 08:55:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762552512;
	cv=none; b=kz8y17U+AhoGaubCV5GP8Im8XoXyer++9p+Z0LWBBYvFQvrGCVOt2bcfbcizOuZ9v0g8C3b6JpQKxRjmql9hiDIQIAWUTT5UwXJtRQ7ZegOG0cikpWRqrbL72wigu7zTF5Do+yjS33YGc2hlsXzne5452V3xlpQj5yn+bgoXBLvjGzcR/bJyLKVptPHJlYZY8zrTWN5AIbBA+TN6uKQqrZxuQgEEsJ8WfEPD/2uh3FQVNP8WD4LKlMULl68/gB85+/fNT+v6gYfpwMXWvOBX/bZgE/HDb1/oEyFCP9cdnQSjloTE0w9AuUOiJoSnDz3jwOKj6LVccQlDRJ1RuzidlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762552512; c=relaxed/relaxed;
	bh=u4p6rheCxqBx8Mi+Eoz64zsgM1KizuM7vmAkYy2tYXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IbHyroY6cXufBYmqAL24qslOmmizMkThLyJT6Pv2L6AQNo+i9u8Cg0vUKFKp0c0VhtomZEVJ3mokKpUX8M1MtQTTNy2AKWZiPYXKNEoV0ug+4V/yu8N6qG63VzWfrlcjbRz7GgEgzi34LE2mcTH/brQfuLYgD+rpYhucM0IwMIqe0oJtQvZ+A3k0DCbF1jzUaiLtOi2BqhLwAsMd9xGWIq11zTxEzI8OpPI22SgWz86W8HCuVZ+e0kK8DVjABglg+uWugPvqn7gKEDbZUQ2DJg6zAwqfgA9UYuqaA4ZZXm2kTwEU55RztK414gm7qEY2HZfpUGBlzZkSsiflUpPGqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aUJjnVDj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aUJjnVDj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d3CXZ25vZz2xxS
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Nov 2025 08:55:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8DE664460A;
	Fri,  7 Nov 2025 21:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58099C19421;
	Fri,  7 Nov 2025 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762552507;
	bh=bzXzOIrmU2vJW/viY2NN2SWyXWmWO2JsboNDeNZlPRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aUJjnVDjDdkeP2qaJRg2Kuo0S2Z73RKmtJH2ubSo5KjynyjWcGldUVnPG8hijsbnr
	 K69F0NuEHhSMsi+vDqF0KRrOdEymZWDhqwfTttcoZDT9rWqJYdL7a166x6hN1HjSjk
	 Qn7zjttAwzDJUZAW7GZLlCuubm/USgiN0Vbgc0aql4mFj92gJhUfEdQaTAPLTpA492
	 NwgmE0HNKlOgXIzp/3hbjLDQjFODEZ8R1TzyMgbpuq/cBQxRjCUSCR8oefoPcvBlxw
	 PlYPJeC8LXFF1WDinXBdexU5vy1O1ZxyM2UphM1S99298KVjXhpdKkAKZsWTK0s7b5
	 UTsJzxoZEHMIA==
Date: Fri, 7 Nov 2025 15:55:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
Message-ID: <20251107215506.GA1998504@bhelgaas>
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
In-Reply-To: <ogkty663ld7fe3qmbxyil47pudidenqeikol5prk7n3qexpteq@h77qi3sg5xo4>

On Fri, Nov 07, 2025 at 11:39:50AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 06, 2025 at 12:36:39PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Christian reported that f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and
> > ASPM states for devicetree platforms") broke booting on the A-EON X5000.
> > 
> > Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> > Fixes: df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms"
> > )
> > Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> > Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/quirks.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..44e780718953 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >   */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> >  
> > +/*
> > + * Remove ASPM L0s and L1 support from cached copy of Link Capabilities so
> > + * aspm.c won't try to enable them.
> > + */
> > +static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
> > +{
> > +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L0S;
> > +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L1;
> > +	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
> 
> From the commit message of the earlier version [1] you shared:
> 
>     Removing advertised features prevents aspm.c from enabling them, even if
>     users try to enable them via sysfs or by building the kernel with
>     CONFIG_PCIEASPM_POWERSAVE or CONFIG_PCIEASPM_POWER_SUPERSAVE.
> 
> Going by this reasoning, shouldn't we be doing this for the other
> quirks (quirk_disable_aspm_l0s_l1/quirk_disable_aspm_l0s) as well?

Yes, probably so.  I was thinking that could be done later to limit
the scope of v6.18 changes, but since we're enabling L0s/L1 when we
didn't before, we should probably update those quirks too.

I was hesitant because quirk_disable_aspm_l0s_l1_cap() isn't quite the
same as quirk_disable_aspm_l0s_l1() because pci_disable_link_state()
turns off states that are currently enabled and also prevents them
from being enabled in the future, but quirk_disable_aspm_l0s_l1_cap()
essentially just clears Link Capability bits.

But if we clear a Link Capability bit for a state that was already
enabled by firmware:

  - If POLICY_DEFAULT or POLICY_PERFORMANCE, I think we'll disable the
    state during enumeration:

      pci_scan_slot
	pcie_aspm_init_link_state
	  pcie_aspm_init_link_state
	    if (POLICY_DEFAULT || POLICY_PERFORMANCE)
	      pcie_config_aspm_path

  - If POLICY_POWERSAVE or POLICY_POWER_SUPERSAVE, I think we'll
    disable it in pci_enable_device():

      pci_enable_device
	do_pci_enable_device
	  pcie_aspm_powersave_config_link
	    if (POLICY_POWERSAVE || POLICY_POWER_SUPERSAVE)
	      pcie_config_aspm_path

If firmware enabled the state, it must at least be safe enough to
boot, and we should eventually disable it regardless of how the kernel
was built.

Bjorn

