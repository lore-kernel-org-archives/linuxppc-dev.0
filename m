Return-Path: <linuxppc-dev+bounces-11699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F22CA1012
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Sep 2025 06:16:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHTlC4MqSz2xns;
	Thu,  4 Sep 2025 16:16:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ef0:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756966599;
	cv=none; b=cN1Rbq6gxo6C5UG2VaVnvpKXKoNuSkD+naGkGlHKq8C3Gdy8zKIUD866zPi9xqD/d/3lUK/9Iydu7A55Mjo4pEdRSry/EU6mX13pvpeqElF6S+7zIaX/AIfyPcbtIUO2ZZuDV/JX4ilhcLNcNOiGaTj8DIRS5PPD+HftwpF6Wj3Jq1oeNa0zUCDv8Kr6Pg0Zd2812rMw27Ak2M940l20O81+fJhKS6G7cpL1qfIDt1vTLuSkXGh0vlCVA+mecO3MFovd0RGAsJCCsv8icvXp430ub2HW/oTNjLyycWVhYcmN7bD6BVLQli0yJAkIRhTm0oE9pD7+Ruwwij5eH+zxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756966599; c=relaxed/relaxed;
	bh=tJYePSrq4xcH5cgpX8KnE3zjEOZ7MUZZEc47HFMew9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDs6YesTnlOsm6El1ViIBbexnzkSmZuEPdCQ9Atj3+5iEbR929xDEQyq6VepxZ6N4oFqoUMiz6Ekl2eZMryeorT7WrFkC+1VAdooMeHYiKMFg2/im1xF81lmKVG+7ZLSBeLbrQ6XQbxKtxOziLDEUwHkdtSMvvvWM6UZbLSI3cfyGWm+s3yvlBL/zm8UDCSWw9wMhfDXa/pZYBp4stZRQ7Po73wNzjug2BDHIfSesgqNvwUKZm0B/E/InY9ynb9s2ApSsMrjUZ9+1vUVynYreGskH+6MMqOJW07F7MEz3aHZ8pqX7FC4xZw7ylTEK4ozPAUax6gDwLzm/aQehbd5yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ef0:0; helo=bmailout2.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout2.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout2.hostsharing.net (client-ip=2a01:37:3000::53df:4ef0:0; helo=bmailout2.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHTlB2tFNz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2025 16:16:35 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 354A320091B5;
	Thu,  4 Sep 2025 08:16:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1C33F402D8B; Thu,  4 Sep 2025 08:16:29 +0200 (CEST)
Date: Thu, 4 Sep 2025 08:16:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>,
	Terry Bowman <terry.bowman@amd.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH] PCI/AER: Print TLP Log for errors introduced since PCIe
 r1.1
Message-ID: <aLkuvb5v4LuVJuyU@wunner.de>
References: <5f707caf1260bd8f15012bb032f7da9a9b898aba.1756712066.git.lukas@wunner.de>
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
In-Reply-To: <5f707caf1260bd8f15012bb032f7da9a9b898aba.1756712066.git.lukas@wunner.de>

On Mon, Sep 01, 2025 at 09:44:52AM +0200, Lukas Wunner wrote:
> +++ b/include/uapi/linux/pci_regs.h
> @@ -776,6 +776,13 @@
>  #define  PCI_ERR_UNC_MCBTLP	0x00800000	/* MC blocked TLP */
>  #define  PCI_ERR_UNC_ATOMEG	0x01000000	/* Atomic egress blocked */
>  #define  PCI_ERR_UNC_TLPPRE	0x02000000	/* TLP prefix blocked */
> +#define  PCI_ERR_UNC_POISON_BLK	0x04000000	/* Poisoned TLP Egress Blocked */
> +#define  PCI_ERR_UNC_DMWR_BLK	0x08000000	/* DMWr Request Egress Blocked */
> +#define  PCI_ERR_UNC_IDE_CHECK	0x10000000	/* IDE Check Failed */
> +#define  PCI_ERR_UNC_MISR_IDE	0x20000000	/* Misrouted IDE TLP */
> +#define  PCI_ERR_UNC_PCRC_CHECK	0x40000000	/* PCRC Check Failed */
> +#define  PCI_ERR_UNC_XLAT_BLK	0x80000000	/* TLP Translation Egress Blocked */
> +
>  #define PCI_ERR_UNCOR_MASK	0x08	/* Uncorrectable Error Mask */
>  	/* Same bits as above */

I've realized that I inadvertently introduced a gratuitous blank line here.
Bjorn, you may want to remove that from commit dab104c81cba on pci/aer.
My apologies for the inconvenience!

Thanks,

Lukas

