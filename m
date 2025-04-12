Return-Path: <linuxppc-dev+bounces-7621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B22C369A1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Apr 2025 04:31:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZZLGf12bqz300B;
	Sat, 12 Apr 2025 14:31:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ef0:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744432282;
	cv=none; b=diCtAjN8qCi7aUTtNTpEH4H8H7Op+l6BKbJpjyY9TFS6ML+2EfEiCsQHKpHTFTAhavmtgtj4gzdvEhznOrppX4N3ntNcZJITBXVNPcb7b5fG2YsBCDoB/zRP2k0OV2EJGr9pbmSLbXWyZ5T4pQIed6TXztGo0F7Gt4ZIks2GNi4mpqcRWyKsGzmIyX6H87M6leNnmihA5W3U4x0EnNXMnDZGjOwCEMh+/kpml8zzXF3qKtmhlDSLvc+dYtA2Kh6mOWtaLtgo13/kB/aOLToszwX+AZ7RBjK5fkwZdzNfTvRMzOuLENVYBjukuFk0g77jAemhuRR4K0+NCJN7NlEO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744432282; c=relaxed/relaxed;
	bh=aX/1GbODemCvG/copqtrcOROnun7d5bwtpylNIN2g9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arQTqNC1C2x7CAMlN6xXgVUlcQU+d7Nw1dxFeISl7NYEIDE2es7eSmLwVlqa1bHp49GvFcFtd4Q7l1OjC1Gof9QMSqyyf1sWTvo613V31W0oqJ4bO0iA/NZ8XhvPNfAJeeJDYEhZ24zqXDDaMRs6SSTQPYSJc1TkfsQzYE8UBeKhjWoGCo348tL1ToXVfx59QZGdoU430mEoYZR4MZQOPoJh9PlmbZQK5wK6HzHIe5pNvGrsDw61OtJSQ2w10PY1y91uXXy4uo5vIZOZuyp4mdg3vZBngmCTyJn0kGP1T2KlCiEjcx9OfELqNmrT7kVl7JvSX/JJfrT7tx8yeU0BXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ef0:0; helo=bmailout2.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout2.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout2.hostsharing.net (client-ip=2a01:37:3000::53df:4ef0:0; helo=bmailout2.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZZLGc5XJtz2yrQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Apr 2025 14:31:18 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6D562200A2A7;
	Sat, 12 Apr 2025 06:30:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E168310720; Sat, 12 Apr 2025 06:31:12 +0200 (CEST)
Date: Sat, 12 Apr 2025 06:31:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, tpearson@raptorengineering.com,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] pci/hotplug/pnv_php: Work around switches with
 broken presence detection
Message-ID: <Z_nskClPmT4A_5Cf@wunner.de>
References: <20250404041810.245984-1-sanastasio@raptorengineering.com>
 <20250404041810.245984-3-sanastasio@raptorengineering.com>
 <Z-9jOFiPaxYAJwdm@wunner.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-9jOFiPaxYAJwdm@wunner.de>

On Fri, Apr 04, 2025 at 06:42:32AM +0200, Lukas Wunner wrote:
> On Thu, Apr 03, 2025 at 11:18:09PM -0500, Shawn Anastasio wrote:
> > The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
> > was observed to incorrectly assert the Presence Detect Set bit in its
> > capabilities when tested on a Raptor Computing Systems Blackbird system,
> > resulting in the hot insert path never attempting a rescan of the bus
> > and any downstream devices not being re-detected.
> > 
> > Work around this by additionally checking whether the PCIe data link is
> > active or not when performing presence detection on downstream switches'
> > ports, similar to the pciehp_hpc.c driver.
> [...]
> > --- a/drivers/pci/hotplug/pnv_php.c
> > +++ b/drivers/pci/hotplug/pnv_php.c
> > @@ -390,6 +390,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
> >  	return 0;
> >  }
> >  
> > +static int pcie_check_link_active(struct pci_dev *pdev)
> > +{
> > +	u16 lnk_status;
> > +	int ret;
> > +
> > +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> > +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> > +		return -ENODEV;
> > +
> > +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> > +
> > +	return ret;
> > +}
> > +
> 
> This appears to be a 1:1 copy of pciehp_check_link_active(),
> save for the ctrl_dbg() call.
> 
> For the sake of code-reuse, please move the function into the
> PCI library drivers/pci/pci.c so that it can be used everywhere.
> 
> Note that there's another patch pending which does exactly that:
> 
> https://lore.kernel.org/r/20250225-qps615_v4_1-v4-7-e08633a7bdf8@oss.qualcomm.com/
> 
> So either include that patch in your series (addressing the review
> feedback I sent for it and cc'ing the original submitter) or wait
> for it to be respun by the original submitter.

Update -- Krishna respun the patch:

https://lore.kernel.org/r/20250412-qps615_v4_1-v5-7-5b6a06132fec@oss.qualcomm.com/

