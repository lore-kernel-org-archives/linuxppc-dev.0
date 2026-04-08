Return-Path: <linuxppc-dev+bounces-19508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330ED1073CBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 13:40:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frPMz5wJHz2yDk;
	Wed, 08 Apr 2026 23:40:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775655647;
	cv=none; b=ifxTQFME/XGttFI+Nf3e/+EejbGJFJsTGeFmYV9YLSAS+zRJGPllsju3dCcH/C/RsbRt3XiF0dcg1PZeGUznXDIYdiiZTqJqWNP2bRFxghhABZFuZHobaFN62mBmg/g9hKiFrtgN9wCuJHm3q+OLGTamYKdEdFS8Sc5I/hrzqus2AhoyGcYWnfMSCXkHsG9ETOn/YBobyPLIlKPLpcpcz70e+P8e89y+pfLrxMRVx3VMuhosq2yM3tq8VOmigEWj+qXFfyENPXIKjAqQVn64yhvmMxoqTsIqwGv74pKzwXUWxu0bnQb+1FXCGs0cfupkRX0qBhrLpSzi2DRUf9gzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775655647; c=relaxed/relaxed;
	bh=wblkre6NjkT6i+4xhKGhUp+Fd+gZKQiKgPiEMlBS0Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITm4j/g3A6fh51FUW5NMlhM8iPy20Z3BxlZLPgeGMKr344olOUCLzEVq0fHKYqlpYj9/6U7iQ4wWD4t95eA89g8brhnWouI2zO4zD5J8a5QYTrO/+E5hzsXU3m3z+vqjVK+mdD58BZipeIoqm2pTb0aQRmq9xxWX7CRUtgzMvGqXzX+OM6DXPYJ9Iqz31MjBliGHzNeifgdHXhRCKKgU1IwdA2b9vDX3DF1dSRxtzmBKuR5+WAmR2Wfzph0anKEpkimANVFgLeyVq2padMNOuOB8thD7RqOwiZj1K7M9Mcz0ZRO8M6f11eQaosCQrf1/AzXHmwsOyhtMDL9K/td2Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aohr4wmM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aohr4wmM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frPMy5Z8rz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 23:40:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 79E0D6012A;
	Wed,  8 Apr 2026 13:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFAAC19421;
	Wed,  8 Apr 2026 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775655644;
	bh=+0oydsix3eqfdw2Aq3Jilu/jZTS1qQw8+lp0nii5wyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aohr4wmM+rkXMNtTgbWcQxOdPABsfIvSLaiIxSuvA/Fa8w9jq4e8zeL57njW4E/Zn
	 1WmGBU1a5jmW5+6caOUtHvg5bYtc+mflLu56N2stGp6vaOUTOzZRdMoI/mbpkHA1p5
	 nmJeRbq+sjtnoNIyAC1LPL99XGKtLIJoSrdODO68A6rM6UZjHROd3q0ujEOGRh0h7s
	 bA6TZb9Uoc6BJqyuwlIlc8juqpaH9G1nzEkHvzWujtWq2we0nAAfepTL22yIhKmUOc
	 /oeV9xf98fewJR0OCIknbua+MEcBDQSk8uoy215juMx8bqtDRxHtG74XC7kn2EPLUq
	 h943YSSVcZFIQ==
Date: Wed, 8 Apr 2026 08:40:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, kuba@kernel.org, andrew@lunn.ch,
	linux@armlinux.org.uk, davem@davemloft.net, frank.li@nxp.com,
	edumazet@google.com, imx@lists.linux.dev, pabeni@redhat.com,
	devicetree@vger.kernel.org, horms@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch, f.fainelli@gmail.com,
	linux-kernel@vger.kernel.org, xiaoning.wang@nxp.com,
	krzk+dt@kernel.org, vladimir.oltean@nxp.com,
	linux-arm-kernel@lists.infradead.org, chleroy@kernel.org
Subject: Re: [PATCH v4 net-next 01/14] dt-bindings: net: dsa: update the
 description of 'dsa,member' property
Message-ID: <177565564199.1953964.14327421234664978113.robh@kernel.org>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
 <20260331113025.1566878-2-wei.fang@nxp.com>
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
In-Reply-To: <20260331113025.1566878-2-wei.fang@nxp.com>


On Tue, 31 Mar 2026 19:30:12 +0800, Wei Fang wrote:
> The current description indicates that the 'dsa,member' property cannot
> be set for a switch that is not part of any cluster. Vladimir thinks
> that this is a case where the actual technical limitation was poorly
> transposed into words when this restriction was first documented, in
> commit 8c5ad1d6179d ("net: dsa: Document new binding").
> 
> The true technical limitation is that many DSA tagging protocols are
> topology-unaware, and always call dsa_conduit_find_user() with a
> switch_id of 0. Specifying a custom "dsa,member" property with a
> non-zero switch_id would break them.
> 
> Therefore, for topology-aware switches, it is fine to specify this
> property for them, even if they are not part of any cluster. Our NETC
> switch is a good example which is topology-aware, the switch_id is
> carried in the switch tag, but the switch_id 0 is reserved for VEPA
> switch and cannot be used, so we need to use this property to assign
> a non-zero switch_id for it.
> 
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


