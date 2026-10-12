Return-Path: <linuxppc-dev+bounces-29240-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A3BCA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:51:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CQW5fDKz2yPR;
	Mon, 12 Oct 2026 20:50:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791798659;
	cv=none; b=l5guLz7EQymDKnUj9pb1Fp2XW36vx6dletmVn6D/qSKuIpkUlw6By+j91NM1sM5Dfy86otFIb7CO9mw4LrqeVYLdd6EfUlUf5rBK8jWB/y+P1Nqa9B+M15kBp7uv9JkodqhcK8Icnboxv5ux+oFELaDW1n4nnIAXM+4hO2nj1qOGRrmOBZU3wszvLTvJamhJFMkt50G34cvrMaPKV1zcyw6mkCcF81z42Vj2Be8LSM6pp0i3fprYfurFhjA03n88pPsbUlPS4eQwz5SA2hg0YKK51+7M0Lih8EvaSP9reAF9mq6NF7OxhDEqu2zEsa53Z5RELR2iuYeXxA3ZWIrGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791798659; c=relaxed/relaxed;
	bh=mtp1EGHAfNWkCgpoDgidzM3ipP/8kfdDhQyh7QgIsls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDSXz4uY72j1bhsT2nWPT7WIzltlLk8suKjcv74JrZdEtdm62DZHBGRop3t/I9viaDoYNumGfdyjOBtaf1myU+fRsKROI2j8Ik29UT1qyGhnyVKEey3lVBmDymgVPKu/IYJ1OY35qKsngmXq0WGzQWkQhtRlKlLtLT8GM/yIFeU9ATWqz3EC2cbPsY1Si0iQwMbHgohnZNM9WsijM9hJ8YxHJm101V5h6f5kfSyCdU6E63f8BxR/Y95gLLLcm0ShD9z3aZTYZcaDZNQHcYBfi6qr31uX25imRGGFcn7CxJpinq397Qwo3Ddr940+nHzRXIoxML2WTK36Gy5TXsxcog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zaw652Vo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zaw652Vo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CQV6NhQz2xwZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:50:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 42DE543AF7;
	Mon, 12 Oct 2026 09:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBB61F0089B;
	Mon, 12 Oct 2026 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791798656;
	bh=mtp1EGHAfNWkCgpoDgidzM3ipP/8kfdDhQyh7QgIsls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zaw652VoTUaN6K8mZnOCwQawPhCNG2cDBRhGMKbL/O569B3e5eJ3dIRUTXSWJljk7
	 6+1imYqawsGZlQWRlTdVD/xuhevFiUh/bkCqEYmNfsw05LmL7VASJaokxAQrwgk6bl
	 vEThj8V9xfLQ/FDIntbdgciITt+VUYhMZiJYJCosmWgwG6dxCE+7+NNrRE7m74+DhD
	 VeMxhz7lnn+dxktFsmTVMMeyaw+zza12nj2fmYNuXNuJh3jIrMjTmP6Ubcp2N95o6e
	 i1W00VV9MA9huCtZTqrpfEGD1TEGwmJ3uNnDdfvGTen/sx7Yku2kfPeEFyW0j8NS5D
	 GNAxFq/BXnYmA==
Message-ID: <3408fb1a-b957-4591-bf75-1eb44af73584@kernel.org>
Date: Mon, 12 Oct 2026 11:50:50 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: cpm1: tsa: fix wrong clocks released on cleanup
To: Haotian Zhang <vulab@iscas.ac.cn>, Herve Codina
 <herve.codina@bootlin.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261009053720.3146117-1-vulab@iscas.ac.cn>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261009053720.3146117-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/10/2026 à 07:37, Haotian Zhang a écrit :
> tsa_of_parse_tdms() gets and enables tdm->l1tsync_clk and
> tdm->l1tclk_clk in addition to l1rsync_clk and l1rclk_clk, but the
> error cleanup path releases l1rsync_clk/l1rclk_clk again in the
> l1tsync_clk/l1tclk_clk branches. The tsync/tclk clocks are leaked --
> never disabled nor clk_put() -- while rsync/rclk are clk_put() twice,
> underflowing their reference counts. tsa_remove() has the same
> copy-paste bug.
> 
> Release the clock actually held in each cleanup branch.
> 
> Fixes: 1d4ba0b81c1c ("soc: fsl: cpm1: Add support for TSA")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>


A similar patch is already in linux-next, discarding this one.

See 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/soc/fsl?id=46201d760c48e771fa2febfcb0787f22c3b71387


