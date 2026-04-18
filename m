Return-Path: <linuxppc-dev+bounces-19841-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B08BF99C88
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2026 17:55:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fyfXk2X1Zz2ygG;
	Sun, 19 Apr 2026 03:55:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776534902;
	cv=none; b=WwgFIs88eGKYRgmSYS2wt+YwhfA+vS9Mo8Sqq/DJmX7hOWEv8e6SxrD6yOfqmIGYglzezTL9tO8dbQG/Si+D+09Y9e+tdPdxcbsbHJIOASvQaEXG4TyqnCv/tMB2SpsrM+2BwlZtuIPgQn1cq3OGsAfu0pneErqg6S2xf+zcJfNo9sh7fBrykyRGvmXw97J9VExTYpyvmR/rCZvgmdhJp71unj00I5poaWxULamnsKa8usBw3AHcLqlskbflo8iRdAWzLm6dn6yi+eLAU2qvEnbngIyO0b2gH9Tnm0BrgquiyeDWyHoTN+2HG4sirfTqJDGZcV0SDxATtJnz8dT2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776534902; c=relaxed/relaxed;
	bh=h2xIEuBXOTjV6hITr5aINmbPn8GSgP3ll+4IMrVD8F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXklagh1W9kgEbicRBBLlpw21yvmpZcu6j3Yu0ojcfnBF3rZK3h91BKh3b06Lb1b5s0+lOgbam4a0V3V3XZi8n9lUFkKKlzBirswmzrjJMTV73mfgtkSUmX596eALP9rYgG4C5KgWLcgYQZJhiKUJIez1KLUehlPWA6ubR6oIC0KNdprESpA+OKb0paNJTfaGNOx0gWf93GooZIdcWVHGGfgRfpK5w8x/grFyUGhE4MAMLnii4H3nbZ1dom5OqELUkt+h5YNSt+HcUCgKwkqGubotR+6IV58aOd82CXn6FkiKIIGlcABoIuR2DiT0UELjmfWKW4tJLfHy4G6pkg3Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=byRpm4Lh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=byRpm4Lh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fyfXj4NHhz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2026 03:55:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D277560138;
	Sat, 18 Apr 2026 17:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C4EC19424;
	Sat, 18 Apr 2026 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776534893;
	bh=JdtPqroOunoZJu87mhf+doIJHBz2KVjK3UTYJVQ+Dx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byRpm4LhvpTnr4z1ujO4rvTYg14RRwjOPCtVBK2ePT6tNfd2XetfFVMOqVNpdyo3k
	 85Zn4Rn/GxNywlyeYkZ23LgYxOnemg8Ao32+2+/WiLNgRg9tIE+RFepAjTsVo1u4e8
	 MkG9hxLzN8eRSS2exa1EdrQRHMw3N7AbY58HSoFLy6vl4JfuGVQkJTNzr6a2PkFrpz
	 IaznN6CWkWej/KhEjU4SemcsL476+UpkhGzJYPFDeVtmjUXMZP8TzZvVCNy+1kQ6tP
	 nYCa07ePIXyNIAKvnIRGV7PLkZTf+Js9zFnFU11IBmLN7T8SpKmR1RQACLrAXhShnt
	 OPxq38yEmLbXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	shaik.abdulla1@ibm.com,
	naveedaus@in.ibm.com
Subject: Re: [PATCH net v2] ibmveth: Disable GSO for packets with small MSS
Date: Sat, 18 Apr 2026 10:54:51 -0700
Message-ID: <20260418175451.122193-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417172910.81433-1-mmc@linux.ibm.com>
References: <20260417172910.81433-1-mmc@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ibmveth: Disable GSO for packets with small MSS

This commit adds an ndo_features_check callback to the ibmveth driver to
disable segmentation offload when the MSS is less than 224 bytes. This
prevents physical adapters in SEA configurations from freezing when given
small MSS packets.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1756,6 +1756,25 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
>  	return 0;
>  }
>  
> +static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
> +						struct net_device *dev,
> +						netdev_features_t features)
> +{
> +	/* Some physical adapters do not support segmentation offload with
> +	 * MSS < 224. Disable GSO for such packets to avoid adapter freeze.
> +	 */
> +	if (skb_is_gso(skb)) {

The commit message mentions this matches the ibmvnic hardware errata from
commit f10b09ef687f. That commit disabled GSO for both gso_size < 224 and
gso_segs == 1.

By omitting the check for skb_shinfo(skb)->gso_segs == 1, could a
single-segment GSO packet still cause the adapter to freeze?

> +		if (skb_shinfo(skb)->gso_size < IBMVETH_MIN_LSO_MSS) {
> +			netdev_warn_once(dev,
> +					 "MSS %u too small for LSO, disabling GSO\n",
> +					 skb_shinfo(skb)->gso_size);
> +			features &= ~NETIF_F_GSO_MASK;
> +		}
> +	}
> +
> +	return features;

When implementing a custom ndo_features_check callback, netif_skb_features()
will bypass the standard dflt_features_check() function. Does this mean
vlan_features_check() is no longer called for this driver?

If vlan_features_check() is skipped, multi-tagged (QinQ) VLAN packets
might retain GSO and protocol-specific checksum offloads that the hardware
parser cannot handle.

Should this return vlan_features_check(skb, features) instead?

> +}
-- 
pw-bot: cr

