Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B80606A333
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0hfoM5a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRV1Y2tW8z2yql;
	Sat, 14 Nov 2026 20:58:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794650289;
	cv=none; b=mH+lWe60uIvlPZOqjbJUEUgVBkSlDeBc5dcKYTl4t0ONGqVokG7mNkINh0AS70paVrKOjyWpfuMZKsr9jQeRwThYhWso9DvDAAUswgQiPmtx8YS0LMxMMgVrnxHuBcIVozIOVYueBN6ovVo3KdE3uGUZiWFVKqjUG4InI+W/qhlIs204Mvy5OHVP2bgl7DQuAR241ugog+zO0WNbajhmIqr0JxtDz4W0p2+86XZ8ZNzVStKW3RCjDnfuS60p0sOl8wUU7hqGmf9BZtSPEA5VzWFmniXP7fs7vWCqLb3p8lKRkzPiphP8ojxhT//fV31RgiYSxlBH7Wv7QpJIUqB+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794650289; c=relaxed/relaxed;
	bh=1aAu2p5q+46k4xT0nfJKDCSVnUNtpAw2+j4NQOXi/aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a73fJpQ5Ztw9i5h3FwhBKy9cmsO+HJy7peh2DqGSUhbjNxNJiPwOufEzfRIKkOEiX0OZQ4aCkB2eQ6OewZuPe2WWlTDgm3Pm49OtcPn7N0OQ3MJYK6yWlCE3w0onFAkrR7VygfPbjmouddCaRgcul06zVB1GknJCbxQz0xV7dkSSCiwDrUEQ9ezuuv5HapEBxgPtGBylubgkjMD0dIqGg0s+DW6NSSY7z+om5U5zp08TsOEXOxFmhWhoVnWH0vnDPb0qpgqwe5icr0539eQ2OlfEvBECOvKSZpqZKdMEJxKT70ibQMWvWZjlRuHtXtFlTwW1lR8kERJwbdZHsC2ijg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0hfoM5a; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0hfoM5a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRV1X2G57z2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 20:58:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9877660236;
	Sat, 14 Nov 2026 09:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09DB1F000C4;
	Sat, 14 Nov 2026 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794650285;
	bh=1aAu2p5q+46k4xT0nfJKDCSVnUNtpAw2+j4NQOXi/aU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q0hfoM5aikZN44ro7I4hnoYExts32CDZbuGMBnIhCaHhrl990JWcBKEh9QFaxRyf5
	 yjiMrWzO7sz9jEgbFIwNHvrhA7JUFXV3nMl9yu+nK5D9We6jpY+EEBqTyWtIetEA6T
	 kx0XghcDNQ3Ft1dgE8yrxi2z3W+Wnf6ZDVME6BSiWmYcl63CJfq2aTcbFJY/SCI4hU
	 JpwonnmWW9/d22xtCdbe+oG2u7LheAXYxZQr4nr8eIEfSCqRevKU6Wi9BGmuoSnD/O
	 w/xlbNWWUGIOKKwOejCBmgbC1SkEz+4hXpqt7Dc8brSGT3wi0qSsnt7vkrEKKXPTxk
	 zk0mZX5OkUfmw==
Message-ID: <d0f781bf-a325-4eee-9431-7eb387279934@kernel.org>
Date: Sat, 14 Nov 2026 10:57:55 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] soc: fsl: guts: add the RCW override of any RCWSR
To: vjardin@free.fr, Dong Aisheng <aisheng.dong@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>,
 Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
 <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-3-eefcea066a55@free.fr>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-3-eefcea066a55@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 14/11/2026 à 10:12, Vincent Jardin via B4 Relay a écrit :
> From: Vincent Jardin <vjardin@free.fr>
> 
> fsl_guts_rcw_rmw() only serves the SerDes lane modes. Export it for
> other fields of the RCW:
>   - fsl_guts_rcw_read() reads a status register
>   - fsl_guts_rcw_override() changes fields of one under rcwcr_lock and
>     waits for the status register to follow
>   - fsl_guts_rcw_override_supported() tells whether the DCSR view of DCFG,
>     which holds the override registers, is mapped
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Frank Li <Frank.li@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>


Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> ---
>   drivers/soc/fsl/guts.c   | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/fsl/guts.h |  3 ++
>   2 files changed, 76 insertions(+)
> 
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 28361c63e26c..d2e3f66d0da4 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -369,6 +369,79 @@ int fsl_guts_lane_set_mode(int serdes_idx, int lane, enum lynx_lane_mode lane_mo
>   }
>   EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_set_mode, "FSL_GUTS");
>   
> +/**
> + * fsl_guts_rcw_read() - read a RCW status register
> + * @index: one-based index, RCWSR1 to RCWSR32
> + * @val: the value read
> + *
> + * Return: 0 on success, -ENODEV before the DCFG block is mapped,
> + * -EINVAL when @index is not 1 to 32
> + */
> +int fsl_guts_rcw_read(unsigned int index, u32 *val)
> +{
> +	if (!soc.dcfg_ccsr)
> +		return -ENODEV;
> +	if (index < 1 || index > ARRAY_SIZE(soc.dcfg_ccsr->rcwsr))
> +		return -EINVAL;
> +
> +	*val = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[index - 1]);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_rcw_read, "FSL_GUTS");
> +
> +/**
> + * fsl_guts_rcw_override() - override fields of a RCW
> + * @index: one-based index of the RCWSR and RCWCR pair
> + * @val: the new value of the fields, in place
> + * @mask: the fields to change
> + *
> + * The fields outside @mask keep the value the status register shows. The
> + * override register is written and the status register polled until it
> + * shows the result, as fsl_guts_lane_set_mode() does for a SerDes lane.
> + *
> + * Context: takes rcwcr_lock, shared with fsl_guts_lane_set_mode(), and
> + * busy-polls the status register for up to RCW_TIMEOUT_US. Does not
> + * sleep; must not be called from interrupt context.
> + *
> + * Return: 0 on success, -EOPNOTSUPP without a DCSR mapping of DCFG,
> + * negative error otherwise
> + */
> +int fsl_guts_rcw_override(unsigned int index, u32 val, u32 mask)
> +{
> +	int err;
> +
> +	if (!soc.dcfg_ccsr)
> +		return -ENODEV;
> +	if (!soc.dcfg_dcsr)
> +		return -EOPNOTSUPP;
> +	if (index < 1 || index > ARRAY_SIZE(soc.dcfg_ccsr->rcwsr))
> +		return -EINVAL;
> +
> +	spin_lock(&soc.rcwcr_lock);
> +	err = fsl_guts_rcw_rmw(index - 1, val & mask, mask);
> +	spin_unlock(&soc.rcwcr_lock);
> +	if (err)
> +		pr_err("RCW override of RCWSR%u failed: %pe\n", index,
> +		       ERR_PTR(err));
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_rcw_override, "FSL_GUTS");
> +
> +/**
> + * fsl_guts_rcw_override_supported() - can a Reset Configuration Word be
> + *				       overridden?
> + *
> + * Return: true when the DCFG block is mapped with its DCSR view, the
> + * second reg of the dcfg node, which holds the override registers
> + */
> +bool fsl_guts_rcw_override_supported(void)
> +{
> +	return soc.dcfg_ccsr && soc.dcfg_dcsr;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_rcw_override_supported, "FSL_GUTS");
> +
>   static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
>   {
>   	struct device_node *np;
> diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
> index 8d5ffb985fee..7127de897c23 100644
> --- a/include/linux/fsl/guts.h
> +++ b/include/linux/fsl/guts.h
> @@ -142,6 +142,9 @@ int fsl_guts_lane_validate(int serdes_idx, int lane,
>   			   enum lynx_lane_mode lane_mode);
>   int fsl_guts_lane_set_mode(int serdes_idx, int lane,
>   			   enum lynx_lane_mode lane_mode);
> +int fsl_guts_rcw_read(unsigned int index, u32 *val);
> +int fsl_guts_rcw_override(unsigned int index, u32 val, u32 mask);
> +bool fsl_guts_rcw_override_supported(void);
>   
>   /* Alternate function signal multiplex control */
>   #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
> 


