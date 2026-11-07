Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB81606A326
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUpMjpsv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMKzz3R92z2xrC;
	Sun, 08 Nov 2026 02:42:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794066143;
	cv=none; b=dLGdQhBY+6MSLJ8ponPlen92d54rzquqeOeHttTKsBf+g1Q5dxR0X665a1IAsNmMKTAoEQjO3KUHyJJtGSKS4LyVOysW0UtouyV0tp07AWVYTDgcXmho4MqWvGoo1yu6Fq+Z39LtNmyZJ3H0WYb9ktCuE/J5/cM/Okab49n3gJ0KcwB62QfDusvfGevTonrBJBZl8kLun3UYbpD+L2dSlyuRnVgcTBkMGBOI1wy3Sk8u3cICPNwZeE7rlbkk4L8QqaZ6KUnRreLbiQHBBp9t2nGPFPQmpQGMG7DgTrFn0nx/EjkBmRG0Ni4PjKkmhvvw/P4l0pAALfUexhtRzz58Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794066143; c=relaxed/relaxed;
	bh=02RmMrYDuqe1ZwKJfkDpL+ozKnlBKLAvKi1f/ZPO+eM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=l6jro0B3nrTK48cs8ObMzkSjTYIIP6LAN93Wp8SVFYPAUF3ClnXim8ZrMNNxJoA4/hFxZn4OQ30FXwOl98SnnQ7rsZnP4mHL6qHb7L7lnrbqhWWq8YX4thZ1k1R7XVlluytUxzSxUFOxq466nvK7ac7EQe7w9NMbjBxPaxPw6sf/6rmGX71VsuAZUGt1HnGwPEVpQzew3EPMyYO7SFaYpOxBI+iexVYi9LaFbT8mZ/8VAyPHryAmy7SRzjvJXktwMmHCYZLr7nVJ7Gl89FwCAwKp9HEhcroGWRpK01mIp8dVhQXiwV/+4TlM+j/f6nXL5kwiLVLJ20gvToOI69cbLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUpMjpsv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUpMjpsv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMKzx1pDCz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 02:42:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1D77941711;
	Sat,  7 Nov 2026 15:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45D91F0089F;
	Sat,  7 Nov 2026 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794066137;
	bh=02RmMrYDuqe1ZwKJfkDpL+ozKnlBKLAvKi1f/ZPO+eM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bUpMjpsvKy6zoWTeJK5ROw+PaPQev2GFzhG3yHzZ+c+NRw5wn4jz8dbWU0DOI7YkU
	 vkDgeuO0hqY9h0Dn7fqZcEwDNmjRHvhRzA8de5jar+Sxa1cpRMt7oQzxRLqJDedr7p
	 yeIvwL56z2nNP8Hu/WREF5NnHya6lMTWjVHF7GO2nGjIfH6IdUrg63Uye6iJdryNVC
	 DbSTG3j6gKfD219c5PM1rTLkm7MeOlouNdbpd72L4o45WTRDx/ptmcDMaeSGqKgevF
	 QnaRIEJWQ+DRS9b2EuHgV+oHHkwORNT7hAi0FXiuYFS+xMABbHvXwdhAZm5/9ksQqy
	 A5la3nD6zn/WQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D59B02AB3711;
	Sat, 07 Nov 2026 15:42:13 +0000 (GMT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ASoC: fsl: imx-card: fix DT node reference leak on
 unbind
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20261104024057.1508822-1-vulab@iscas.ac.cn>
References: <20261104024057.1508822-1-vulab@iscas.ac.cn>
Date: Sat, 07 Nov 2026 15:42:12 +0000
Message-Id: <179406613243.3424803.16218252867759690236.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1l5Z1GoGtVhro8Tj5KzjbjIg1LqSe7tU5rSYeviWp0k=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeu139dPVW4MyTcxTnNCwTn2b6qPHrnsR6VStB060lr
 8+JZ65L7ihlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBE8rQZGQ7/SZw2MeB/+t6u
 L0WmJ/pUZy9p1SuSdLxjdmrxZWHfx48Y/peZdad6n+6fez9KZz6b1eXj626Zv74UmVS0apHC1zK
 DuwwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> imx_card_parse_of() takes references on the CPU and codec device nodes
> with snd_soc_of_get_dlc() and snd_soc_of_get_dai_link_codecs() and
> stores them in the link's component arrays. The driver has no remove
> callback and the ASoC core does not drop these references when the card
> is unregistered, so unbinding the platform device or unloading the
> module leaks one device node reference per CPU and codec.

> +static void imx_card_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
> +	struct snd_soc_dai_link *link;
> +	int i;
> +
> +	for_each_card_prelinks(card, i, link) {
> +		snd_soc_of_put_dai_link_cpus(link);
> +		snd_soc_of_put_dai_link_codecs(link);
> +	}
> +}
> +
>  static const struct of_device_id imx_card_dt_ids[] = {
>  	{ .compatible = "fsl,imx-audio-card", },
>  	{ },
> @@ -940,6 +952,7 @@ static struct platform_driver imx_card_driver = {
>  		.of_match_table = imx_card_dt_ids,
>  	},
>  	.probe = imx_card_probe,
> +	.remove = imx_card_remove,
>  };

This only runs on remove so we've got the same issue if anything goes
wrong during probe (eg, deferral).

-- 
Mark Brown <broonie@kernel.org>

