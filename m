Return-Path: <linuxppc-dev+bounces-18332-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D41CFF6E84
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 21:20:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb4d35hjcz2xdV;
	Wed, 18 Mar 2026 08:20:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773782455;
	cv=none; b=mMdJRAfMy010MYWygXit9j1lvwyaOm7UFnFjUjMKysGmdyCUvftM7uZp+2THxlpNyeM1o2pL1JNnTs9Nj9kiMxKr2j7zr5pndAmanejxRovgORXpc9CFjWZ6lavZ2c2qOc61A0yB4llyoXR4b7d6R1B5QySHMN1Bsp0YNbQ2eSbCxGsbkoc8TqOHnqpLr3ma2lEK7tUZG65siTClo4sIKixFM7HOJHxhpzzzy/eWFd0UPstLlD/SHqqDXhEle28PjKhLumvqdrrxCWObN1brSrFkiZN3jRh1uQyYwXbgQFumNYJ7IfHdjIaaRY4hIRryT3T+QptLBr6xBa889qBJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773782455; c=relaxed/relaxed;
	bh=+zDOo7rF2svLONbcePg3JdNrKG6WS8SVJGbglt3nfMA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c4FZb1fv8l5X/vcUcbrxNif21TiuyE7LPeAkiG7+b/+5KgQ7dXRDVETbXh/tXGbzmUhPqCnx+IkaVWgYI5nqYDrOd3spWBMHXrA0NdJfsHf8qb6jMfUdgSpXVBY4zxd5UraEt8pnOkOd5iCfVZ0w2caZmTZT5WnOc3jv6nTvvitOO4cEdmmTVVJ8hzPU64dVz8Uh3mTsoR+PjTZAEqg0T/xbZkot+2WcLpduf45xWkLVR/fGJiSpEvke/h+wUnw8qn4VA61YYjWZwZLCRcVHkMr3ooSk8vTh12CWnRBgB3gjAZX8WgzInnGJCrzgMpqSMHT+EkRLEs6F1crrkJ7ZBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q5odKayz; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q5odKayz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb4d26V3Yz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 08:20:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5CB3F6057A;
	Tue, 17 Mar 2026 21:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51F5C4CEF7;
	Tue, 17 Mar 2026 21:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773782451;
	bh=oFrY9te7uqPD8r7EoBSwCYXSO4S7zmyO1OhSMocepjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q5odKayzjo5syOlp9BN34RbHpBgiFjSAmPmi7ffpUCMXDlxP2tw/egyM+KoebDMuP
	 zQa1x/HY+VyZ5qo5ahCQB6rsLfOWNPEuQrQu5njxWVZPf/4JNE56ObG427+K72Bb4D
	 HOwIbNaO6n1wfMTX/RqQXQZr8/5Outs8FB+6e6dvOTVCTkzoMbE2l6BRQpJUBHvHoz
	 U0rJDSKdcEwnBW2RWJyTi2K8YvLXeD44RT5XXUrf9t0e+Eq/qXLBQ/Ocuxato+CRkd
	 ka2ZEvdOgckG/8HxFwcA/h8nm7egRakuJyIxc/Gbh7+IiYCHpI3DtbxKNRwlg8SpTz
	 q01W7SmxZ83AA==
Date: Tue, 17 Mar 2026 16:20:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 3/4] PCI: pnv_php: Simplify with scoped for each OF
 child loop
Message-ID: <20260317212049.GA108913@bhelgaas>
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
In-Reply-To: <20260317133322.266102-7-krzysztof.kozlowski@oss.qualcomm.com>

On Tue, Mar 17, 2026 at 02:33:25PM +0100, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied patches 3 and 4 to pci/hotplug for v7.1, thanks!

Mani will take care of patches 1 and 2.

> ---
> 
> Changes in v2:
> Tags
> ---
>  drivers/pci/hotplug/pnv_php.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 5c020831e318..ff92a5c301b8 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -215,24 +215,19 @@ static void pnv_php_reverse_nodes(struct device_node *parent)
>  static int pnv_php_populate_changeset(struct of_changeset *ocs,
>  				      struct device_node *dn)
>  {
> -	struct device_node *child;
> -	int ret = 0;
> +	int ret;
>  
> -	for_each_child_of_node(dn, child) {
> +	for_each_child_of_node_scoped(dn, child) {
>  		ret = of_changeset_attach_node(ocs, child);
> -		if (ret) {
> -			of_node_put(child);
> -			break;
> -		}
> +		if (ret)
> +			return ret;
>  
>  		ret = pnv_php_populate_changeset(ocs, child);
> -		if (ret) {
> -			of_node_put(child);
> -			break;
> -		}
> +		if (ret)
> +			return ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
> -- 
> 2.51.0
> 

