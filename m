Return-Path: <linuxppc-dev+bounces-16538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFC4E8305C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 07:53:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4wj335hlz30FF;
	Tue, 03 Feb 2026 18:53:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:fff3:b8::112"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770105223;
	cv=none; b=MC7/+OG8tL1Xg4BM6RhmKma2SsUcj5t1fIH/K4fXB/gIwcG4FZ4bmeJedtO1fYnf4mq7GhvG14kkaU92rOzEt3QMoLbLFygaikQ7In1H3kN/PEk5W1RJPVyqAoMkeJD0GxqwK6owwAHMZi88ZSy5RYmDCbds545MjD3BbobPSJMjmELkYjNJ+F9/x63oZdCLTLey3k9Q0MjY+AMlAOHK2i4G9fKezl0qn2DYfocMstGzmTT4TqCi6yaSrB4e9CpmHXYKaD06e0fLOJa/XYGd5adc4soHAzt5nblYnAia6vQtkwoHYsUaqhMZ+TnQHE97XbckigRdXDVma9lmYWb30w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770105223; c=relaxed/relaxed;
	bh=jI5LcoYBZdWXxS8YoKjjfNSuHkf8Zg75Kdji8LYGQ54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9r+0xngu5wqk8qGnHBbMazB6Rl+yC9LGgWi711tG8kmmL72HOdnC5HzU0G0u/hWF0pjkkgFci+ofB2eFneFLn6z/bZb3aWjaerG22pK6ZtlxwClYb9DTQ2ExrFv4vRPdXtCNUoqYl9sdSEeSTYkhbLKTGB/fQhB1dIZoYH32+iJqMXUHM0BUr28X9fkVO+d53stI+E0EnCT2IbGFzmDNTudXam4bHQDSodB/y4RI2qUYX/0jxBWvDd87DG5gCVUNPUL0gFMdMmyVrhpcHvd6/VKMHIHCyxDksDGqmOq1Lx9qR6cXV0Z2nTZ2+/FJk/HkgZps0+WX3JyieyHxgqKnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:4f8:fff3:b8::112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout3.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout3.hostsharing.net (client-ip=2a01:4f8:fff3:b8::112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:fff3:b8::112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4wj227Dkz2xjb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 18:53:41 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7CD8A2C01622;
	Tue,  3 Feb 2026 08:53:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 646541DEA0; Tue,  3 Feb 2026 08:53:37 +0100 (CET)
Date: Tue, 3 Feb 2026 08:53:37 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
Message-ID: <aYGpgSztxNMZO-oC@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
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
In-Reply-To: <20260124074557.73961-6-xueshuai@linux.alibaba.com>

On Sat, Jan 24, 2026 at 03:45:57PM +0800, Shuai Xue wrote:
> +++ b/drivers/pci/pci.c
> @@ -2246,7 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	u16 sta;
>  
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & PCI_EXP_DEVSTA_ERR);
>  }

I don't think there's any harm to write error bits which are currently 0,
so I'd just get rid of the pcie_capability_read_word() and directly write
the error bits.

> +++ b/include/uapi/linux/pci_regs.h
> @@ -534,6 +534,7 @@
>  #define  PCI_EXP_DEVSTA_NFED	0x0002	/* Non-Fatal Error Detected */
>  #define  PCI_EXP_DEVSTA_FED	0x0004	/* Fatal Error Detected */
>  #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
> +#define  PCI_EXP_DEVSTA_ERR	0xf	/* Error bits */

There's only one user of PCI_EXP_DEVSTA_ERR and it feels a little
awkward to define a macro in a uapi header which does not correspond
to an "official" bit definition but is just there for convenience.

So maybe it's better to simply use the macros for the four bits in
pcie_clear_device_status()?  Might also be slightly clearer.

This patch could be submitted individually instead of being part
of this series.

Thanks,

Lukas

