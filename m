Return-Path: <linuxppc-dev+bounces-16807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C057EE9E300
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Feb 2026 12:34:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9yYS4rX5z2xlk;
	Wed, 11 Feb 2026 23:34:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770813276;
	cv=none; b=W1wQy9xJ+Uvzyg31/MRzcWnBS+HF9v4pNPZXqVxOEWTv6j+TbOn5P5ObznDzpQMjBYomimlKHeND8WyKmgJYnSrhMmCJ4ADyUJwbMXUfbT915+A206wN5KnkeecP24/S+WjcKRK3vqn6VtAORU4rs+4UG5Y83xTY+rRhhd7JYY7zFWTXmHs3oReOJBrZRw0ERTNZBO/RZCKlazsRDtsDFM/1XKgoUydq0lMH1ZTmHzSmjl9YRWgzMmlmTgJtGS1ZuhhPl0sBx1z9EHb0g1R+TD9k4l92gGGMMDEIGWi+MvU+yEfJtU6RuULYYm7LWn5nUEH1LV4+bNM4WTN5QndAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770813276; c=relaxed/relaxed;
	bh=vMYD5jW1yx4s1ZhXBdhWXzeo+gfEHApEmTbGTfCKaMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmeZN8LQsJsE7OxeAioNVc1eeULGtbVDsqAyIl71fzVWVeoCjClE5OgOty0Ze1XsIkWMz19a0IYr1rzVO79iXmGzuIBkD+iAcjcbGKpku+zOm9hkH4Db+FaAozvSOkq5D6kFHwGf/OOL8U7nMGZ473wbzg6nbfuS8nFCkzW7sqnUAnIZQQZLdq4EaODgtHOoNGTa3O4hEaPdTewN+73a3TjigsLMC4+nLwTqIV0QlflQ+hlwYNyIYtBpGmV1caWMZp//xed6+StwSiVWsvtXcEOl8r6mVXHuwuWlBzq9lAv+cHp35Mozdj9bVFHKzRVy6E0sQkFQpbWTgfiidKiLPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout3.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout3.hostsharing.net (client-ip=144.76.133.112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9yYQ61Gxz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 23:34:32 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AA9252C05FEA;
	Wed, 11 Feb 2026 13:34:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 874C732273; Wed, 11 Feb 2026 13:34:27 +0100 (CET)
Date: Wed, 11 Feb 2026 13:34:27 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com,
	zhuo.song@linux.alibaba.com, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v2] PCI/AER: Only clear error bits in PCIe Device Status
 register
Message-ID: <aYx3Uy7rE6GM9xq-@wunner.de>
References: <20260211054816.22758-1-xueshuai@linux.alibaba.com>
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
In-Reply-To: <20260211054816.22758-1-xueshuai@linux.alibaba.com>

On Wed, Feb 11, 2026 at 01:48:16PM +0800, Shuai Xue wrote:
> +++ b/drivers/pci/pci.c
> @@ -2243,10 +2243,11 @@ EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
>  #ifdef CONFIG_PCIEAER
>  void pcie_clear_device_status(struct pci_dev *dev)
>  {
> -	u16 sta;
> -
> -	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
> +				    PCI_EXP_DEVSTA_CED |
> +				    PCI_EXP_DEVSTA_NFED |
> +				    PCI_EXP_DEVSTA_FED |
> +				    PCI_EXP_DEVSTA_URD);

Isn't there one too many blanks before each of the PCI_EXP_DEVSTA_* macros?

The available space would be sufficient to accommodate two macros per line,
so just 2 instead of 4 lines for the macros.

Otherwise this is:
Reviewed-by: Lukas Wunner <lukas@wunner.de>

