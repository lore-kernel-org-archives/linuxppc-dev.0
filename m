Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 38F23B6FA4
 for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2012 23:18:25 +1000 (EST)
Date: Thu, 3 May 2012 13:40:29 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: Re: [PATCH v16 03/10]USB/ppc4xx: Add Synopsys DWC OTG Core
 Interface Layer (CIL)
Message-ID: <20120503134029.7195898d@pyramind.ukuu.org.uk>
In-Reply-To: <201205031228.q43CSw6k024808@amcc.com>
References: <201205031228.q43CSw6k024808@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, rsarmah@apm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

O> +void dwc_otg_flush_rx_fifo(struct core_if *core_if)
> +{
> +	ulong global_regs = core_if->core_global_regs;


These are all a bit odd. The register has a given size so they ought to
be u32 or u64 etc as appropriate for the register in question, ditto the
cache in the structure.



> +	for (i = 0; i < MAX_EPS_CHANNELS; i++) {
> +		offset = i * DWC_EP_REG_OFFSET;
> +
> +		dev_if->in_ep_regs[i] = (ulong)(reg_base +
> +					       DWC_DEV_IN_EP_REG_OFFSET +
> +					       offset);

And again some of the casting seems odd. If these are bus addresses they
should be typed as such.


> +static inline u32 dwc_reg_read(ulong reg , u32 offset)
> +{
> +
> +#ifdef CONFIG_DWC_OTG_REG_LE
> +	return in_le32((void __iomem *)(reg + offset));
> +#else
> +	return in_be32((void __iomem *)(reg + offset));

All this casting is a symptom of the same typing problems. They would all
go away if the types were right in the first place.

> +	u32 global_regs = (u32) core_if->core_global_regs;

And again we keep finding these casts caused by wrong types
