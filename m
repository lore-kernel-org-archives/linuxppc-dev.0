Return-Path: <linuxppc-dev+bounces-25791-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48F5C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:11:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLFP40GN1z2y1Y;
	Thu, 13 Aug 2026 16:11:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786601495;
	cv=none; b=PimZWA5ookZl3gvI+fw1fLUNEGpFBxJLH+oYeRBB3aEdlOFe0ML+hRmqDuEps6DQgCFIAJtdP4hze9Yl/DSN/WvjkJ8tprsDzFq2ToIsu9tGLPuapRcALmRPvhGYmNdgbmyWhbtncR96OrMHggBAh9DdZNab9uFpRgcHGK0DvkqHolvEhWbX+NauGMC1Ged4rwmmVvK3A4Yk+k7XEM4s5owoh6qN4znYpYxq/AKNrd/KZpm/GYfLD6UHQIngCmveY4pk0dkZ+sTU3Is0kKk8u/riB4SCt/O5NLZ7PlvLFp+sphN6ctMZMAieguEM3d3KjRnmYAImXetjoFACm2Y3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786601495; c=relaxed/relaxed;
	bh=DiMpXMq2kKaP+/B/szyplC/vH/8xNTofLUmS8swihFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKAzxbD6MBpHDHx8e83ylZP4q0RYo6BoIG2kbwE9LMsepiQhsoP19VIPkzEWIFMhPGH43VhjDnGpdNm27at5ShCjZfW0Wem5NjNNoYLzroD/d0mMxgo6A1BQvJnLVSiz1ApTNaQJkYqAj0AzB/f2o6yhKGA20p6EyesFQsJnGsMJoR7Huu1kLlRjb7nmCJ/03tJ6+n/YOmO3XwlqiYl4fuFr2efHBF/Kdo9IKgOCl8xBX36pNsoj/fV7V2L12UEBTXy9uw0kJ9Z1xfR4jHFZ2iaQs2te726yYzlKsZlkUrAGHXwZeCogL7rkgedFH2Sxf7BcoTwMo9YRKRnhYEFz0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyWc0Tmo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyWc0Tmo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLFP31RF9z2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:11:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D30CF40E0B;
	Thu, 13 Aug 2026 06:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E7E1F000E9;
	Thu, 13 Aug 2026 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786601492;
	bh=DiMpXMq2kKaP+/B/szyplC/vH/8xNTofLUmS8swihFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VyWc0Tmo9Wv+fxLqcqJfoaVGgyIFTg8mA9I2WCIdrV1QhOhk/pHP7vS7rvv1ltU6I
	 VosNxR+wFEEK9LvsGX49PU51B+sEQ4fbwP6kf8MrSBccfoIYW2noKBrq8KDv1C/0nm
	 LAAwNqC5ItPAwGRtaOovKD88dwL0TNKWPeM5UuZP46QVB5pwvsoJHFVYKL4nKa35um
	 TOPlt8xTz0pZ4//OsCUp50dskPk24OJ72Fy4lRbUd+Cz3GxM1hY5LxUaEyZTGrpj9A
	 88VqnFOkXHpvQJfCCjACPAdQkYAi3sqUEkaTrZocWqwNP3lICrVOPt3YSi7/DFSzXb
	 Vyys3XXQQL7Sw==
Date: Thu, 13 Aug 2026 08:11:20 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Keng-Yu Lin <keng-yu.lin@hpe.com>, "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Alexander Usyskin <alexander.usyskin@intel.com>, 
	Vamsi Attunuru <vattunuru@marvell.com>, Alexander Graf <graf@amazon.com>, 
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Andrew Donnellan <andrew+kernel@donnellan.id.au>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <Akshay.Gupta@amd.com>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 12/12] misc: Unify code style for various *_device_id
 arrays
Message-ID: <oydzthptc2dbmpj3t3oubi47xsacf6ulqv42vcjzhk3sojvyxd@j52tf7obevx7>
References: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
 <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>

On Fri, Jul 17, 2026 at 04:50:58PM +0200, Uwe Kleine-König (The Capable Hub) wrote:

[...]

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3635741c3e7a..a10fce77e0b4 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1416,18 +1416,18 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
> -	  .driver_data = (kernel_ulong_t)&am654_data
> +	  .driver_data = (kernel_ulong_t)&am654_data,
>  	},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
> @@ -1446,8 +1446,8 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
>  	  .driver_data = (kernel_ulong_t)&rk3588_data,
>  	},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP),},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

